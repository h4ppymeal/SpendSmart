//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Bethany Liu on 2023-12-26.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            List {
                // MARK: Transaction Groups
                ForEach(Array(transactionListVM.groupTransactionByMonth()), id: \.key) { month, transactions in
                    Section {
                        // MARK: Transaction List
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        // MARK: Transaction MOnth
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// A preview provider for the TransactionRow view.
struct TransactionList_Preview: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        // Group of preview examples for TransactionRow, one with the default color scheme
        // and another with the dark color scheme.
        Group {
            NavigationView {
                TransactionList()
            }
            NavigationView {
                TransactionList().preferredColorScheme(.dark)
            }
        }
        .environmentObject(transactionListVM)
    }
}
