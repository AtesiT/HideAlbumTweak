#import <UIKit/UIKit.h>

#define PREFS_ID @"com.secretalbum.hidehiddenalbum"

@interface PXNavigationListDataSectionConfiguration : NSObject
- (BOOL)hideHiddenAlbum;
- (void)setHideHiddenAlbum:(BOOL)hide;
@end

@interface PXNavigationListGadgetProvider : NSObject
- (BOOL)_shouldHiddenAlbumBeVisible;
@end

@interface PXPhotosDataSourceConfiguration : NSObject
- (BOOL)hideHiddenAssets;
- (void)setHideHiddenAssets:(BOOL)hide;
@end

@interface PHFetchOptions : NSObject
- (BOOL)includeHiddenAssets;
- (void)setIncludeHiddenAssets:(BOOL)include;
@end

static BOOL shouldShowHiddenAlbum() {
    NSDictionary *prefs = [[NSUserDefaults standardUserDefaults]
                           persistentDomainForName:PREFS_ID];
    if (!prefs) return NO;

    BOOL unlockOne   = [prefs[@"unlock_one"] boolValue];
    BOOL unlockTwo   = [prefs[@"unlock_two"] boolValue];
    BOOL switchOne   = prefs[@"switch_one"]   ? [prefs[@"switch_one"] boolValue]   : NO;
    BOOL switchTwo   = prefs[@"switch_two"]   ? [prefs[@"switch_two"] boolValue]   : NO;
    BOOL switchThree = prefs[@"switch_three"] ? [prefs[@"switch_three"] boolValue] : NO;
    BOOL switchFour  = prefs[@"switch_four"]  ? [prefs[@"switch_four"] boolValue]  : NO;

    return (
        unlockOne   == YES &&
        unlockTwo   == YES &&
        switchOne   == NO  &&
        switchTwo   == NO  &&
        switchThree == NO  &&
        switchFour  == NO
    );
}

%hook PXNavigationListDataSectionConfiguration
- (BOOL)hideHiddenAlbum {
    return !shouldShowHiddenAlbum();
}
%end

%hook PXNavigationListGadgetProvider
- (BOOL)_shouldHiddenAlbumBeVisible {
    return shouldShowHiddenAlbum();
}
%end

%hook PXPhotosDataSourceConfiguration
- (BOOL)hideHiddenAssets {
    return !shouldShowHiddenAlbum();
}
- (void)setHideHiddenAssets:(BOOL)hide {
    %orig(!shouldShowHiddenAlbum());
}
%end

%hook PHFetchOptions
- (BOOL)includeHiddenAssets {
    if (!shouldShowHiddenAlbum()) return NO;
    return %orig;
}
- (void)setIncludeHiddenAssets:(BOOL)include {
    if (!shouldShowHiddenAlbum()) {
        %orig(NO);
        return;
    }
    %orig(include);
}
%end

%hook NSUserDefaults
- (BOOL)boolForKey:(NSString *)key {
    if ([key containsString:@"HiddenAlbum"] ||
        [key containsString:@"hiddenAlbum"]) {
        return shouldShowHiddenAlbum();
    }
    return %orig;
}
- (id)objectForKey:(NSString *)key {
    if ([key containsString:@"HiddenAlbumVisible"] ||
        [key containsString:@"HiddenAlbumEnabled"]) {
        return shouldShowHiddenAlbum() ? @YES : @NO;
    }
    return %orig;
}
%end
