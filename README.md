# capacitor-portone

Capacitor plugin for PortOne (formerly iamport) identity verification on Android, iOS, and Web.

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

No additional setup required. The PortOne SDK is bundled with the plugin.

## Usage

```typescript
import { CapacitorPortOne } from 'capacitor-portone';

async function verifyIdentity() {
  try {
    const result = await CapacitorPortOne.requestIdentityVerification({
      storeId: 'your-store-id',
      identityVerificationId: 'unique-verification-id',
      channelKey: 'your-channel-key',
      // Optional: redirectUrl is recommended for web platform
      redirectUrl: `${window.location.origin}/verification-complete`
    });

    if (result.success) {
      console.log('Verification successful:', result.identityVerificationId);
      // Send identityVerificationId to your server for verification
    } else {
      console.error('Verification failed:', result.code, result.message);
    }
  } catch (error) {
    console.error('Error during verification:', error);
  }
}
```

### Web Platform Notes

The plugin uses `@portone/browser-sdk` for web platform support. The SDK is automatically installed as a dependency.

- **redirectUrl**: While optional in the API, it's recommended for web platforms, especially on mobile browsers where redirect mode is commonly used.
- **Server-side verification**: After successful verification, send the `identityVerificationId` to your server to verify the authentication status using PortOne's REST API.

## Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web

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
| **`redirectUrl`**            | <code>string</code> |


### Type Aliases


#### IdentityVerificationResponse

<code><a href="#identityverificationsuccessresponse">IdentityVerificationSuccessResponse</a> | <a href="#identityverificationfailresponse">IdentityVerificationFailResponse</a></code>


#### IdentityVerificationRequest

<code>{ storeId: string; identityVerificationId: string; channelKey?: string; pgProvider?: Entity.PgProvider; isTestChannel?: boolean; customer?: Entity.Customer; windowType?: Entity.WindowTypes; redirectUrl?: string; customData?: string; bypass?: Entity.IdentityVerificationBypass; popup?: Entity.Popup; iframe?: Entity.Iframe; }</code>

</docgen-api>
