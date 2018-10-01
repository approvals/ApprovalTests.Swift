//
// Created by Industrial Logic on 9/29/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

protocol ApprovalApprover {
    func approve() -> Bool
    func cleanUpAfterSuccess(reporter: ApprovalFailureReporter)
    func fail() throws
    func reportFailure(reporter: ApprovalFailureReporter)
}
