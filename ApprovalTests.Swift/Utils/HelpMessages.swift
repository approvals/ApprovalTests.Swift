import Foundation

public class HelpMessages {
    static let lineSeparator = "*********************************************************"

    public static func displayIOSWatcherMessage() {
        print(lineSeparator)
        print("You are running tests from iOS. You will need to turn on the watcher to launch reporters.")
        print("./iOSApprovalsWatcher.py [path_to_tests]")
        print(lineSeparator)
    }
}
