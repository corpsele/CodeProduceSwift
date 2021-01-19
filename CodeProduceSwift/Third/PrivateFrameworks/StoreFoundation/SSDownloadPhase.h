//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@import Foundation;

@class SSOperationProgress;

NS_ASSUME_NONNULL_BEGIN

@interface SSDownloadPhase : NSObject <NSSecureCoding, NSCopying>
{
    SSOperationProgress *_operationProgress;
}

+ (BOOL)supportsSecureCoding;

//- (void).cxx_destruct;

@property(readonly) SSOperationProgress *operationProgress;
@property(readonly) long long totalProgressValue;
@property(readonly) long long progressValue;
@property(readonly) float progressChangeRate;
@property(readonly) long long progressUnits;
@property(readonly) long long phaseType;
@property(readonly) double estimatedSecondsRemaining;
- (id)copyWithZone:(nullable struct _NSZone *)arg1;
- (id)initWithCoder:(id)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithOperationProgress:(id)arg1;
- (id)init;

@end

NS_ASSUME_NONNULL_END
