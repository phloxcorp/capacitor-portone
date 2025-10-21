import Foundation
import UIKit
import PortOneSdk

@objc public class CapacitorPortOne: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }

    public func requestIdentityVerification(
        storeId: String,
        identityVerificationId: String,
        channelKey: String,
        fromViewController: UIViewController,
        completion: @escaping (Result<[String: Any], Error>) -> Void
    ) {
        // Prepare identity verification data
        let verificationData: [String: Any] = [
            "storeId": storeId,
            "channelKey": channelKey,
            "identityVerificationId": identityVerificationId
        ]

        // Create and present the identity verification view controller on the main thread
        DispatchQueue.main.async {
            let identityVC = IdentityVerificationViewController(
                data: verificationData,
                onCompletion: { result in
                    // Dismiss the view controller first
                    DispatchQueue.main.async {
                        fromViewController.dismiss(animated: true) {
                            // After dismissal, handle the result
                            switch result {
                            case .success(let response):
                                // Parse successful response
                                var resultDict: [String: Any] = [
                                    "success": true,
                                    "identityVerificationId": identityVerificationId
                                ]

                                // Add all response data
                                if let responseDict = response as? [String: Any] {
                                    for (key, value) in responseDict {
                                        resultDict[key] = value
                                    }
                                }

                                completion(.success(resultDict))

                            case .failure(let error):
                                // Parse error response
                                var resultDict: [String: Any] = [
                                    "success": false
                                ]

                                // Extract error information
                                if let errorDict = error as? [String: Any] {
                                    resultDict["code"] = errorDict["code"] ?? ""
                                    resultDict["message"] = errorDict["message"] ?? error.localizedDescription

                                    // Add all error data
                                    for (key, value) in errorDict {
                                        resultDict[key] = value
                                    }
                                } else {
                                    resultDict["message"] = error.localizedDescription
                                }

                                completion(.success(resultDict))
                            }
                        }
                    }
                }
            )

            fromViewController.present(identityVC, animated: true)
        }
    }
}
