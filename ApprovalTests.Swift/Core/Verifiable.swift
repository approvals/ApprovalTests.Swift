import Foundation

public protocol Verifiable {
    func getVerifyParameters(_ options: Options) -> VerifyParameters
}
