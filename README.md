# capacitor-portone

Capacitor plugin for PortOne (formerly iamport) identity verification on Android.

## Install

```bash
npm install capacitor-portone
npx cap sync
```

## Configuration

### Android

Make sure your app's `MainActivity` extends `ComponentActivity` (which it should by default in Capacitor apps).

The plugin automatically includes the PortOne Android SDK. No additional configuration needed.

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
- ❌ iOS (not yet implemented)
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
