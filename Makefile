ARCHS = arm64
TARGET = iphone:clang:15.6:13.0
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HideHiddenAlbum HideHiddenAlbumGlobal

HideHiddenAlbum_FILES = Tweak.x
HideHiddenAlbum_CFLAGS = -fobjc-arc

HideHiddenAlbumGlobal_FILES = TweakPicker.x
HideHiddenAlbumGlobal_CFLAGS = -fobjc-arc

BUNDLE_NAME = HHAPrefs
HHAPrefs_FILES = Prefs/HHAPrefsController.m
HHAPrefs_INSTALL_PATH = /Library/PreferenceBundles
HHAPrefs_CFLAGS = -fobjc-arc
HHAPrefs_FRAMEWORKS = UIKit Foundation
HHAPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS)/makefiles/tweak.mk
include $(THEOS)/makefiles/bundle.mk
