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

        // Create the identity verification view controller
        let identityVC = IdentityVerificationViewController(
            data: verificationData,
            onCompletion: { result in
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
        )

        // Present the identity verification view controller
        DispatchQueue.main.async {
            fromViewController.present(identityVC, animated: true)
        }
    }
}
