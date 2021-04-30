import Foundation

public class ScrubDates: ScrubWithRegExWithReplacementAliasing {
    public init() {
        super.init(pattern: "\\d{4}-\\d{1,2}-\\d{1,2}T\\d{1,2}:\\d{2}:\\d{2}Z", aliaser: { index in
            "<date\(index)>"
        })
    }
}
