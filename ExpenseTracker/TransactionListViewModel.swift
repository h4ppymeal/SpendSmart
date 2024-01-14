//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Bethany Liu on 2023-12-25.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

// A final class representing the view model for managing a list of transactions.
// Conforms to the ObservableObject protocol, allowing it to be observed for changes.
final class TransactionListViewModel: ObservableObject {
    // Published property representing the array of transactions.
    @Published var transactions: [Transaction] = []

    // Set to keep track of cancellables (subscriptions) to avoid retain cycles.
    private var cancellables = Set<AnyCancellable>()

    // Initializer for the view model.
    init() {
        // Call the method to fetch transactions upon initialization.
        getTransactions()
    }

    // Method to fetch transactions from a remote JSON endpoint.
    func getTransactions() {
        // Check if the URL is valid.
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }

        // Use URLSession's dataTaskPublisher to fetch data from the specified URL.
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                // Check if the HTTP response status code is 200 (OK).
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    // Dump the response for debugging and throw a badServerResponse error.
                    dump(response)
                    throw URLError(.badServerResponse)
                }

                // Return the data if the response is valid.
                return data
            }
            // Decode the received data into an array of Transaction objects using JSONDecoder.
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            // Receive the result on the main thread.
            .receive(on: DispatchQueue.main)
            // Sink to handle completion and received values.
            .sink { completion in
                // Handle completion events (either failure or finished).
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                // Update the transactions array with the received result.
                self?.transactions = result

            }
            // Store the cancellable (subscription) in the cancellables set to avoid retain cycles.
            .store(in: &cancellables)
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
        print("accumulateTransactions")
        let today = "02/17/2022".dateParsed() // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        
        return cumulativeSum
    }
}

