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

Seguir as instruções do link: https://firebase.flutter.dev/docs/messaging/apple-integration/#1-registering-a-key

## Outros

Não esquecer de colocar o ensureInitialized na main.dart

```dart
WidgetsFlutterBinding.ensureInitialized();
```
