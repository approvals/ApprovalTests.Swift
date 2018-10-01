//
// Created by Industrial Logic on 9/29/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

class ReporterFactory {
    let FRONTLOADED_REPORTER = "FrontloadedReporter"
    let USE_REPORTER         = "UseReporter";

    public static func get() -> ApprovalFailureReporter {
        let returned = DiffReporter()
        return returned
    }
}
