//
//  LockView.h
//  XL解锁
//
//  Created by lanou3g on 15/10/25.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, passwordtype){
    ResetPassWordType = 1,
    UsePassWordType = 2,
};
@class LockView;
@protocol LockViewDelegate <NSObject>

- (BOOL)unlockView:(LockView *)unlockView withPassword:(NSString *)password;

- (void)setPassWordSuccess:(NSString *)tabelname;
@end

@interface LockView : UIView
@property (nonatomic, weak) id<LockViewDelegate> delegate;
@end
