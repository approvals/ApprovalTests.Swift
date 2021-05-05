#if os(iOS)

    class XCTReporter: EquatableFailureReporter {

        override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
            guard other is XCTReporter else { return false }
            return true
        }

        override func report(received: String, approved: String) -> Bool {
            // read the files into strings
            let approvedUrl = URL(fileURLWithPath: approved)
            let receivedUrl = URL(fileURLWithPath: received)

            var aText = ""
            var rText = ""
            do {
                aText = try String(contentsOf: approvedUrl)
                rText = try String(contentsOf: receivedUrl)
            } catch {
                print("Error in \(#function) for received \"\(received)\", approved \"\(approved)\": \(error)")
            }
            let command = ClipboardReporter.getCommandLineMove(received: received, approved: approved)

            // copy to pasteboard
            SystemUtils.pasteToClipboard(command)

            // send command to system out
            let approveCommand = "To approve run : " + command
            print(approveCommand)
            XCTAssertEqual(aText, rText)

            return true
        }
    }

#endif
