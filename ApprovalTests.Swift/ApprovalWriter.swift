//
// Created by Industrial Logic on 9/29/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

protocol ApprovalWriter {
    func writeReceivedFile(received: String) -> String
    func getReceivedFilename(base: String) -> String
    func getApprovalFilename(base: String) -> String
}
