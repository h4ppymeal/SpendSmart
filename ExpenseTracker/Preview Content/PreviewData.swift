//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Bethany Liu on 2023-12-25.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "12/25/2023", institution: "Tangerine", account: "Tangerine Mastercard", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

// repeat the transactionPreviewData 10 times
var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
