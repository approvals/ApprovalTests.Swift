#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class SimpleLoggerTests: XCTestCase {
    func test() throws {
        let output = SimpleLogger.logToString()
        do {
            let m = SimpleLogger.useMarkers()
            SimpleLogger.printLineNumber()
            do {
                let m2 = SimpleLogger.useMarkers()
                let name = "llewellyn"
                SimpleLogger.variable("name", name)
                for _ in 0 ..< 42 {
                    SimpleLogger.hourGlass()
                }
            }
        }
        try Approvals.verify(output)
    }
}

/*
 public void test()
 {
     StringBuffer output = SimpleLogger.logToString();
     try (Markers m = SimpleLogger.useMarkers();)
     {
         try (Markers m2 = SimpleLogger.useMarkers();)
         {
             SimpleLogger.event("Starting Logging");
             String name = "llewellyn";
             SimpleLogger.variable("name", name);
             SimpleLogger.query("Select * from people");
             for (int i = 0; i < 42; i++)
             {
                 SimpleLogger.hourGlass();
             }
             SimpleLogger.variable("Numbers", new Integer[]{1, 2, 3, 4, 5});
             SimpleLogger.warning(new Error());
         }
     }
     Approvals.verify(output);
 }
 */
