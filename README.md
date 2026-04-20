# Clock Tweak

A tweak that hides the Hidden album from Photos app and photo pickers system-wide. Settings page is disguised as a Clock settings so nobody suspects anything.

## Features

- Hides the **Hidden album** from **Photos** app
- Hides the **Hidden album** from photo pickers in all apps
- Secret combination to reveal the album when needed
- Settings page looks like a native Clock settings

## Requirements

- iOS 15+
- Sileo or Zebra

## How to reveal the Hidden album

1. Go to **Settings** -> **Clock**
2. Turn on **Show Date** and **Show AM/PM**
3. Make sure everything else is turned off
4. Open **Photos** -> the Hidden album is now visible

To hide it again just turn off any of those toggles.

## Internals

Hooks into:
- `PXNavigationListDataSectionConfiguration` - hides the album section
- `PXNavigationListGadgetProvider` - controls album visibility
- `PXPhotosDataSourceConfiguration` - hides hidden assets
- `PHFetchOptions` - prevents hidden assets from showing in pickers

For building: Requires Theos and iOS 15 SDK.

