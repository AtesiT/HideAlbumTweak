#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>

@interface HHAPrefsController : PSListController
@end

@implementation HHAPrefsController

- (NSString *)title {
    return @"Clock";
}

- (NSArray *)specifiers {
    if (!_specifiers) {
        NSMutableArray *specs = [NSMutableArray array];
        PSSpecifier *spec;

        spec = [PSSpecifier emptyGroupSpecifier];
        [spec setProperty:@"" forKey:@"label"];
        [specs addObject:spec];

        spec = [PSSpecifier preferenceSpecifierNamed:@"24-Hour Time"
                target:self set:@selector(setPreferenceValue:specifier:)
                get:@selector(readPreferenceValue:) detail:nil
                cell:PSSwitchCell edit:nil];
        [spec setProperty:@"switch_one" forKey:@"key"];
        [spec setProperty:@"com.secretalbum.hidehiddenalbum" forKey:@"defaults"];
        [spec setProperty:@NO forKey:@"default"];
        [specs addObject:spec];

        spec = [PSSpecifier preferenceSpecifierNamed:@"Show Seconds"
                target:self set:@selector(setPreferenceValue:specifier:)
                get:@selector(readPreferenceValue:) detail:nil
                cell:PSSwitchCell edit:nil];
        [spec setProperty:@"switch_two" forKey:@"key"];
        [spec setProperty:@"com.secretalbum.hidehiddenalbum" forKey:@"defaults"];
        [spec setProperty:@NO forKey:@"default"];
        [specs addObject:spec];

        spec = [PSSpecifier emptyGroupSpecifier];
        [spec setProperty:@"Setting the clock to 24-hour format will override the regional setting."
                   forKey:@"footerText"];
        [specs addObject:spec];

        spec = [PSSpecifier emptyGroupSpecifier];
        [spec setProperty:@"ALARMS" forKey:@"label"];
        [specs addObject:spec];

        spec = [PSSpecifier preferenceSpecifierNamed:@"Snooze"
                target:self set:@selector(setPreferenceValue:specifier:)
                get:@selector(readPreferenceValue:) detail:nil
                cell:PSSwitchCell edit:nil];
        [spec setProperty:@"switch_three" forKey:@"key"];
        [spec setProperty:@"com.secretalbum.hidehiddenalbum" forKey:@"defaults"];
        [spec setProperty:@NO forKey:@"default"];
        [specs addObject:spec];

        spec = [PSSpecifier preferenceSpecifierNamed:@"Alarm Tone"
                target:self set:nil get:nil detail:nil
                cell:PSLinkCell edit:nil];
        [spec setProperty:@"Radar" forKey:@"value"];
        [specs addObject:spec];

        spec = [PSSpecifier emptyGroupSpecifier];
        [spec setProperty:@"Alarm tone and volume can be changed in Sounds & Haptics."
                   forKey:@"footerText"];
        [specs addObject:spec];

        spec = [PSSpecifier emptyGroupSpecifier];
        [spec setProperty:@"DISPLAY" forKey:@"label"];
        [specs addObject:spec];

        spec = [PSSpecifier preferenceSpecifierNamed:@"Show Date"
                target:self set:@selector(setPreferenceValue:specifier:)
                get:@selector(readPreferenceValue:) detail:nil
                cell:PSSwitchCell edit:nil];
        [spec setProperty:@"unlock_one" forKey:@"key"];
        [spec setProperty:@"com.secretalbum.hidehiddenalbum" forKey:@"defaults"];
        [spec setProperty:@NO forKey:@"default"];
        [specs addObject:spec];

        spec = [PSSpecifier preferenceSpecifierNamed:@"Show AM/PM"
                target:self set:@selector(setPreferenceValue:specifier:)
                get:@selector(readPreferenceValue:) detail:nil
                cell:PSSwitchCell edit:nil];
        [spec setProperty:@"unlock_two" forKey:@"key"];
        [spec setProperty:@"com.secretalbum.hidehiddenalbum" forKey:@"defaults"];
        [spec setProperty:@NO forKey:@"default"];
        [specs addObject:spec];

        spec = [PSSpecifier preferenceSpecifierNamed:@"Analog Style"
                target:self set:@selector(setPreferenceValue:specifier:)
                get:@selector(readPreferenceValue:) detail:nil
                cell:PSSwitchCell edit:nil];
        [spec setProperty:@"switch_four" forKey:@"key"];
        [spec setProperty:@"com.secretalbum.hidehiddenalbum" forKey:@"defaults"];
        [spec setProperty:@NO forKey:@"default"];
        [specs addObject:spec];

        spec = [PSSpecifier emptyGroupSpecifier];
        [spec setProperty:@"WORLD CLOCK" forKey:@"label"];
        [specs addObject:spec];

        spec = [PSSpecifier preferenceSpecifierNamed:@"Time Zone Override"
                target:self set:nil get:nil detail:nil
                cell:PSLinkCell edit:nil];
        [spec setProperty:@"Off" forKey:@"value"];
        [specs addObject:spec];

        spec = [PSSpecifier emptyGroupSpecifier];
        [spec setProperty:@"Override the time zone used by Clock for display purposes."
                   forKey:@"footerText"];
        [specs addObject:spec];

        _specifiers = specs;
    }
    return _specifiers;
}

@end
