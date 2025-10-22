import { WebPlugin } from '@capacitor/core';
import * as PortOne from '@portone/browser-sdk/v2';

import type {
  CapacitorPortOnePlugin,
  IdentityVerificationRequest,
  IdentityVerificationResponse,
} from './definitions';

export class CapacitorPortOneWeb
  extends WebPlugin
  implements CapacitorPortOnePlugin
{
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async requestIdentityVerification(
    request: IdentityVerificationRequest,
  ): Promise<IdentityVerificationResponse> {
    try {
      const response = await PortOne.requestIdentityVerification({
        storeId: request.storeId,
        identityVerificationId: request.identityVerificationId,
        channelKey: request.channelKey,
        redirectUrl: request.redirectUrl,
      });

      // Check if response is null or undefined
      if (!response) {
        return {
          success: false,
          code: 'VERIFICATION_CANCELLED',
          message: 'Identity verification was cancelled by user',
        };
      }

      // Check if there's an error code in the response
      if (response.code !== undefined) {
        return {
          success: false,
          code: response.code,
          message: response.message || 'Identity verification failed',
          ...response,
        };
      }

      // Success case
      return {
        success: true,
        ...response,
        identityVerificationId: request.identityVerificationId,
      };
    } catch (error: any) {
      return {
        success: false,
        code: 'VERIFICATION_ERROR',
        message: error?.message || 'An unexpected error occurred during identity verification',
      };
    }
  }
}
