# Flutter-specific rules
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }

# Firebase Realtime Database rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep Parcelable classes
-keepclassmembers class * implements android.os.Parcelable {
    static ** CREATOR;
}

# Optional: Keep all your app's data models
-keep class com.example.grati_mate.** { *; }
