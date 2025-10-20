import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorPortOnePlugin)
public class CapacitorPortOnePlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CapacitorPortOnePlugin"
    public let jsName = "CapacitorPortOne"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "requestIdentityVerification", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = CapacitorPortOne()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func requestIdentityVerification(_ call: CAPPluginCall) {
        guard let storeId = call.getString("storeId"), !storeId.isEmpty else {
            call.reject("storeId is required")
            return
        }

        guard let identityVerificationId = call.getString("identityVerificationId"), !identityVerificationId.isEmpty else {
            call.reject("identityVerificationId is required")
            return
        }

        guard let channelKey = call.getString("channelKey"), !channelKey.isEmpty else {
            call.reject("channelKey is required")
            return
        }

        // Get the view controller to present from
        guard let viewController = self.bridge?.viewController else {
            call.reject("Unable to access view controller")
            return
        }

        // Call the implementation
        implementation.requestIdentityVerification(
            storeId: storeId,
            identityVerificationId: identityVerificationId,
            channelKey: channelKey,
            fromViewController: viewController
        ) { result in
            switch result {
            case .success(let data):
                call.resolve(data)
            case .failure(let error):
                call.reject("Identity verification failed: \(error.localizedDescription)")
            }
        }
    }
}
