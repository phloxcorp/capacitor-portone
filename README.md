# capacitor-portone

Capacitor plugin for PortOne (formerly iamport) identity verification on Android and iOS.

## Install

```bash
npm install capacitor-portone
npx cap sync
```

## Configuration

### Android

#### 1. Add JitPack Repository

Add JitPack repository to your project. Open `android/settings.gradle`:

```gradle
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }  // Add this line
    }
}
```

Or if using older Gradle setup, add to `android/build.gradle`:

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }  // Add this line
    }
}
```

#### 2. Enable Core Library Desugaring

Add to your app's `android/app/build.gradle`:

```gradle
android {
    // ... other configurations ...

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
        coreLibraryDesugaringEnabled true  // Add this line
    }
}

dependencies {
    // ... other dependencies ...

    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.1.4'  // Add this line
}
```

#### 3. MainActivity

Make sure your app's `MainActivity` extends `ComponentActivity` (which it should by default in Capacitor apps).

### iOS

#### Required: Add PortOne iOS SDK

This plugin depends on the PortOne iOS SDK, which must be added manually to your Xcode project:

1. Open your iOS app in Xcode
2. Go to **File → Add Package Dependencies**
3. Enter the package URL: `https://github.com/portone-io/ios-sdk.git`
4. Select version `0.0.10` or later
5. Click **Add Package**

> **Note:** The PortOne iOS SDK only supports Swift Package Manager. Even if your project uses CocoaPods, you can add individual Swift packages through Xcode.

## Usage

```typescript
import { CapacitorPortOne } from 'capacitor-portone';

async function verifyIdentity() {
  try {
    const result = await CapacitorPortOne.requestIdentityVerification({
      storeId: 'your-store-id',
      identityVerificationId: 'unique-verification-id',
      channelKey: 'your-channel-key'
    });

    if (result.success) {
      console.log('Verification successful:', result.identityVerificationId);
    } else {
      console.error('Verification failed:', result.code, result.message);
    }
  } catch (error) {
    console.error('Error during verification:', error);
  }
}
```

## Platform Support

- ✅ Android
- ✅ iOS
- ❌ Web (use PortOne JavaScript SDK directly)

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`requestIdentityVerification(...)`](#requestidentityverification)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### requestIdentityVerification(...)

```typescript
requestIdentityVerification(request: IdentityVerificationRequest) => Promise<IdentityVerificationResponse>
```

Request identity verification using PortOne

| Param         | Type                                                                                | Description                                |
| ------------- | ----------------------------------------------------------------------------------- | ------------------------------------------ |
| **`request`** | <code><a href="#identityverificationrequest">IdentityVerificationRequest</a></code> | - Identity verification request parameters |

**Returns:** <code>Promise&lt;<a href="#identityverificationresponse">IdentityVerificationResponse</a>&gt;</code>

--------------------


### Interfaces


#### IdentityVerificationSuccessResponse

| Prop                         | Type                |
| ---------------------------- | ------------------- |
| **`success`**                | <code>true</code>   |
| **`identityVerificationId`** | <code>string</code> |


#### IdentityVerificationFailResponse

| Prop          | Type                |
| ------------- | ------------------- |
| **`success`** | <code>false</code>  |
| **`code`**    | <code>string</code> |
| **`message`** | <code>string</code> |


#### IdentityVerificationRequest

| Prop                         | Type                |
| ---------------------------- | ------------------- |
| **`storeId`**                | <code>string</code> |
| **`identityVerificationId`** | <code>string</code> |
| **`channelKey`**             | <code>string</code> |


### Type Aliases


#### IdentityVerificationResponse

<code><a href="#identityverificationsuccessresponse">IdentityVerificationSuccessResponse</a> | <a href="#identityverificationfailresponse">IdentityVerificationFailResponse</a></code>

</docgen-api>
