#import <Foundation/Foundation.h>

#define KEY_APP_LAST_OPENED_VERSION @"last_opened_version"

@interface MBCheck : NSObject

+ (BOOL)isEmpty:(NSString *)text;
+ (BOOL)isValidEmail:(NSString*)email;

+ (BOOL)isFirstTimeAppLaunch;
+ (NSString *)lastOpenedAppVersion;
+ (void)storeLastOpenedAppVersion;
+ (NSString *)currentAppVersion;

@end
