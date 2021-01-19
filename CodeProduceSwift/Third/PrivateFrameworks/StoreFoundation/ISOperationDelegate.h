//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@class ISOperation, NSError, SSOperationProgress;

NS_ASSUME_NONNULL_BEGIN

@protocol ISOperationDelegate <NSObject>

@optional
- (void)operationFinished:(ISOperation *)arg1;
- (void)operation:(ISOperation *)arg1 updatedProgress:(SSOperationProgress *)arg2;
- (void)operation:(ISOperation *)arg1 failedWithError:(NSError *)arg2;
@end

NS_ASSUME_NONNULL_END
