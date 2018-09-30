//
// Created by Industrial Logic on 9/29/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

protocol ApprovalFailureReporter {
    func report(received: String, approved: String)
}