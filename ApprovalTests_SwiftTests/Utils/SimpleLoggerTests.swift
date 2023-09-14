#if os(iOS)
  import ApprovalTests_iOS
#else
  import ApprovalTests_Swift
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
                for _ in 0 ..< 142 {
                    SimpleLogger.hourGlass()
                }
            }
        }
        try Approvals.verify(output)
    }

    func test_timestamps() throws {
        let output = SimpleLogger.logToString()
        SimpleLogger.timestamp = true
        var dates: [Date] = [
            Date(timeIntervalSince1970: 0),
            Date(timeIntervalSince1970: 0.5),
        ] 
        SimpleLogger.timer = {
            let first = dates.first
            dates = Array(dates.dropFirst())
            return first!
        }
        SimpleLogger.event("1")
        SimpleLogger.event("2")
        try Approvals.verify(output)
    }

    func test_markers() throws {
        let output = SimpleLogger.logToString()
        add(1, 2)
        try Approvals.verify(output)
    }

    func test_variable() throws {
        let output = SimpleLogger.logToString()
        SimpleLogger.variable("name", "Jon")
        SimpleLogger.variable("name", "Jon", showTypes: true)
        let subclasses = [ExtendA(), ExtendB()]
        SimpleLogger.variable("subclasses", subclasses)
        SimpleLogger.variable("subclasses", subclasses, showTypes: true)
        let mix: [Any] = [1, false, "fred"]
        SimpleLogger.variable("mix", mix, showTypes: true)
        try Approvals.verify(output)
    }

    private func add(_ a: Int, _ b: Int) {
        do {
            let m = SimpleLogger.useMarkers("\(a), \(b)")
        }
    }
}

class Base {}
class ExtendA: Base, CustomStringConvertible {
    private(set) var description: String = "ExtendA"
}
class ExtendB: Base, CustomStringConvertible {
    private(set) var description: String = "ExtendB"
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
