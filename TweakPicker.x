#import <UIKit/UIKit.h>

#define PREFS_ID @"com.secretalbum.hidehiddenalbum"

typedef NS_ENUM(NSInteger, PHAssetCollectionSubtype) {
    PHAssetCollectionSubtypeSmartAlbumAllHidden = 1000000201
};

@interface PHFetchOptions : NSObject
- (BOOL)includeHiddenAssets;
- (void)setIncludeHiddenAssets:(BOOL)include;
@end

@interface PHAssetCollection : NSObject
+ (id)fetchAssetCollectionsWithType:(NSInteger)type
                            subtype:(PHAssetCollectionSubtype)subtype
                            options:(PHFetchOptions *)options;
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
    return (unlockOne && unlockTwo &&
            !switchOne && !switchTwo &&
            !switchThree && !switchFour);
}

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
