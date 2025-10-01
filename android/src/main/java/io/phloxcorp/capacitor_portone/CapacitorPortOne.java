package io.phloxcorp.capacitor_portone;

import android.app.Activity;
import android.content.Intent;
import androidx.activity.ComponentActivity;
import androidx.activity.result.ActivityResultLauncher;

import com.getcapacitor.JSObject;
import com.getcapacitor.Logger;
import com.getcapacitor.PluginCall;

import io.portone.sdk.android.PortOne;
import io.portone.sdk.android.identityverification.IdentityVerificationCallback;
import io.portone.sdk.android.identityverification.IdentityVerificationRequest;
import io.portone.sdk.android.identityverification.IdentityVerificationResponse;

import org.json.JSONObject;
import java.util.HashMap;
import java.util.Map;

public class CapacitorPortOne {

    private ActivityResultLauncher<Intent> identityVerificationLauncher;
    private PluginCall savedCall;

    public String echo(String value) {
        Logger.info("Echo", value);
        return value;
    }

    public void requestIdentityVerification(
        Activity activity,
        String storeId,
        String identityVerificationId,
        String channelKey,
        PluginCall call
    ) {
        try {
            // Ensure we have a ComponentActivity
            if (!(activity instanceof ComponentActivity)) {
                call.reject("Activity must be a ComponentActivity");
                return;
            }

            ComponentActivity componentActivity = (ComponentActivity) activity;
            savedCall = call;

            // Create callback for identity verification
            IdentityVerificationCallback callback = new IdentityVerificationCallback() {
                @Override
                public void onSuccess(IdentityVerificationResponse.Success response) {
                    try {
                        JSObject ret = new JSObject();
                        ret.put("success", true);
                        ret.put("identityVerificationId", response.getIdentityVerificationId());

                        // Add additional response data if available
                        String responseJson = response.toString();
                        ret.put("data", responseJson);

                        if (savedCall != null) {
                            savedCall.resolve(ret);
                            savedCall = null;
                        }
                    } catch (Exception e) {
                        Logger.error("CapacitorPortOne", "Error processing success response", e);
                        if (savedCall != null) {
                            savedCall.reject("Error processing response: " + e.getMessage());
                            savedCall = null;
                        }
                    }
                }

                @Override
                public void onFail(IdentityVerificationResponse.Fail response) {
                    try {
                        JSObject ret = new JSObject();
                        ret.put("success", false);
                        ret.put("code", response.getCode());
                        ret.put("message", response.getMessage());

                        // Add additional error data if available
                        String responseJson = response.toString();
                        ret.put("data", responseJson);

                        if (savedCall != null) {
                            savedCall.resolve(ret);
                            savedCall = null;
                        }
                    } catch (Exception e) {
                        Logger.error("CapacitorPortOne", "Error processing fail response", e);
                        if (savedCall != null) {
                            savedCall.reject("Error processing response: " + e.getMessage());
                            savedCall = null;
                        }
                    }
                }
            };

            // Register the activity result launcher
            identityVerificationLauncher = PortOne.INSTANCE.registerForIdentityVerificationActivity(
                componentActivity,
                callback
            );

            // Create the request with all parameters
            // Note: Using Java constructor with positional parameters
            IdentityVerificationRequest request = new IdentityVerificationRequest(
                storeId,
                identityVerificationId,
                channelKey,
                null,  // pgProvider
                null,  // isTestChannel
                null,  // customer
                null,  // windowType
                null,  // customData
                null   // bypass
            );

            // Launch identity verification
            PortOne.INSTANCE.requestIdentityVerification(
                componentActivity,
                request,
                identityVerificationLauncher
            );

        } catch (Exception e) {
            Logger.error("CapacitorPortOne", "Error requesting identity verification", e);
            call.reject("Failed to request identity verification: " + e.getMessage());
        }
    }
}
