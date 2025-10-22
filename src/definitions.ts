export interface IdentityVerificationRequest {
  storeId: string;
  identityVerificationId: string;
  channelKey: string;
  redirectUrl?: string;
}

export interface IdentityVerificationSuccessResponse {
  success: true;
  identityVerificationId: string;
  // Additional fields from PortOne SDK response
  [key: string]: any;
}

export interface IdentityVerificationFailResponse {
  success: false;
  code?: string;
  message?: string;
  // Additional error details from PortOne SDK
  [key: string]: any;
}

export type IdentityVerificationResponse =
  | IdentityVerificationSuccessResponse
  | IdentityVerificationFailResponse;

export interface CapacitorPortOnePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;

  /**
   * Request identity verification using PortOne
   * @param request - Identity verification request parameters
   * @returns Promise with verification result
   */
  requestIdentityVerification(
    request: IdentityVerificationRequest,
  ): Promise<IdentityVerificationResponse>;
}
