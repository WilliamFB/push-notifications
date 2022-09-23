## Android

android/app/build.gradle

```gradle
apply plugin: 'com.google.gms.google-services'
```

android/build.gradle

```gradle
classpath 'com.google.gms:google-services:4.3.8'
```

## iOS

AppDelegate.swift

```swift
if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
```