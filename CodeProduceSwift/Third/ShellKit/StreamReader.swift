//
//  StreamReader.swift
//  ShellKit
//
//  Created by Takehito Koshimizu on 2019/02/17.
//  Copyright © 2019 Takehito Koshimizu. All rights reserved.
//

import Foundation

extension StreamReader {

    enum Default {

        static let delimeter: String = "\n"

        static let encoding: String.Encoding = .utf8

        static let chunk: Int = 4096
    }
}

class StreamReader {

    private let handle: FileHandle

    private let delimeter: Data

    private let encoding: String.Encoding

    private let chunk: Int

    private lazy var buffer = Data(capacity: chunk)

    private lazy var hasNext = true

    init(_ handle: @autoclosure () -> FileHandle,
         delimeter: String = Default.delimeter,
         encoding: String.Encoding = Default.encoding,
         chunk: Int = Default.chunk) {
        self.handle = handle()
        self.delimeter = delimeter.data(using: encoding)!
        self.encoding = encoding
        self.chunk = chunk
    }

    deinit {
        handle.closeFile()
    }

    func rewind() {
        handle.seek(toFileOffset: 0)
        buffer.removeAll(keepingCapacity: true)
        hasNext = true
    }

    func next() -> String? {
        return next().flatMap{ String(data: $0, encoding: encoding) }
    }

    private func next() -> Data? {
        guard hasNext else { return nil }

        repeat {
            if let range = buffer.range(of: delimeter, options: [], in: buffer.startIndex..<buffer.endIndex) {
                defer { buffer.replaceSubrange(buffer.startIndex..<range.upperBound, with: []) }
                return buffer.subdata(in: buffer.startIndex..<range.lowerBound)
            } else {
                let data = handle.readData(ofLength: chunk)
                if data.count == 0 {
                    hasNext = false
                    return (buffer.count > 0) ? buffer : nil
                } else {
                    buffer.append(data)
                    continue
                }
            }
        } while true
    }
}

extension StreamReader {

    static func read(_ handle: @autoclosure () -> FileHandle) -> AnySequence<String> {
        return AnySequence<String> { [reader = StreamReader(handle())] in
            return AnyIterator<String> { reader.next() }
        }
    }
}
