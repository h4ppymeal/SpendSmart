//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Bethany Liu on 2023-12-25.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
