package io.phloxcorp.capacitor_portone;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "CapacitorPortOne")
public class CapacitorPortOnePlugin extends Plugin {

    private CapacitorPortOne implementation = new CapacitorPortOne();

    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", implementation.echo(value));
        call.resolve(ret);
    }

    @PluginMethod
    public void requestIdentityVerification(PluginCall call) {
        String storeId = call.getString("storeId");
        String identityVerificationId = call.getString("identityVerificationId");
        String channelKey = call.getString("channelKey");

        if (storeId == null || storeId.isEmpty()) {
            call.reject("storeId is required");
            return;
        }

        if (identityVerificationId == null || identityVerificationId.isEmpty()) {
            call.reject("identityVerificationId is required");
            return;
        }

        if (channelKey == null || channelKey.isEmpty()) {
            call.reject("channelKey is required");
            return;
        }

        implementation.requestIdentityVerification(
            getActivity(),
            storeId,
            identityVerificationId,
            channelKey,
            call
        );
    }
}
