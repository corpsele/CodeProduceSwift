//
//  Command.swift
//  ColorSetKit
//
//  Created by Takehito Koshimizu on 2019/02/10.
//

import Foundation

public struct Command: Hashable {

    public let command: String

    public init(command: String) {
        self.command = command
    }

}

extension Command {

    public var lines: AnySequence<String> {
        let task = self.task()
        task.process.launch()
        return StreamReader.read(task.pipe.fileHandleForReading)
    }

    public var text: String {
        let task = self.task()
        task.process.launch()
        let data = task.pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)!
    }

    private func task() -> (process: Process, pipe: Pipe) {
        let (process, pipe) = (Process(), Pipe())
        process.launchPath = "/bin/sh"
        process.arguments = ["-c", command]
        process.standardOutput = pipe
        return (process, pipe)
    }
}

extension Command: ExpressibleByStringLiteral {

    public init(unicodeScalarLiteral value: String) {
        self.init(command: value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(command: value)
    }

    public init(stringLiteral value: String) {
        self.init(command: value)
    }

}
