#import "MBCheck.h"


@implementation MBCheck

+ (BOOL)isValidEmail:(NSString*)email
{
    if (email.length == 0) {
        return NO;
    }
    
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isEmpty:(NSString *)text
{
    if (text.length == 0) {
        return YES;
    }
    
    NSString *makeSureString = [NSString stringWithFormat:@"%@",text];
    NSString *trimTxt = [makeSureString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimTxt.length == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isFirstTimeAppLaunch
{
    BOOL result = NO;
    NSString *lastOpenedVersion = [self lastOpenedAppVersion];
    if (lastOpenedVersion == nil) {
        result = YES;
    }
    return result;
}

+ (NSString *)lastOpenedAppVersion
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_APP_LAST_OPENED_VERSION];
}

+ (void)storeLastOpenedAppVersion
{
    NSString *version = [self currentAppVersion];
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:KEY_APP_LAST_OPENED_VERSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)currentAppVersion
{
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [appInfo objectForKey:@"CFBundleVersion"];
    return version;
}

@end
