import { WebPlugin } from '@capacitor/core';

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
    _request: IdentityVerificationRequest,
  ): Promise<IdentityVerificationResponse> {
    console.warn(
      'requestIdentityVerification is not available on web.',
      'Please use the PortOne JavaScript SDK directly for web implementations.',
      'See: https://developers.portone.io/'
    );

    throw new Error(
      'Identity verification is not supported on web platform. Use the PortOne JavaScript SDK directly. ' + _request
    );
  }
}
