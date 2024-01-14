//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Bethany Liu on 2023-12-25.
//

import Foundation
import SwiftUIFontIcon

// Define a struct named Transaction that conforms to the Identifiable protocol.
// Identifiable is a protocol that requires a type to have an 'id' property.
struct Transaction: Identifiable, Decodable, Hashable {
    // Properties of the Transaction struct
    let id: Int                 // Unique identifier for the transaction
    let date: String            // Date of the transaction
    let institution: String     // Financial institution associated with the transaction
    let account: String         // Account related to the transaction
    var merchant: String        // Merchant involved in the transaction
    let amount: Double          // Amount of the transaction
    let type: TransactionType.RawValue  // Type of the transaction (debit or credit)
    var categoryId: Int          // Category identifier for the transaction
    var category: String         // Category of the transaction
    let isPending: Bool          // Indicates whether the transaction is pending
    var isTransfer: Bool         // Indicates whether the transaction is a transfer
    var isExpense: Bool          // Indicates whether the transaction is an expense
    var isEdited: Bool           // Indicates whether the transaction has been edited
    
    var icon:FontAwesomeCode {
        if let category = Category.all.first(where: { $0.id == categoryId }) {
            return category.icon
        }
        return .question
    }
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    // if the type is credit, leave as positive, else negative
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
}

// Enum used to represent the type of a transaction.
// It conforms to the String raw value type.
enum TransactionType: String {
    case debit = "debit"         // Represents a debit transaction
    case credit = "credit"       // Represents a credit transaction
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
}

extension Category {
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertainment = Category(id: 3, name: "Entertainment", icon: .film)
    static let feesAndCharges = Category(id: 4, name: "Fees & Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = Category(id: 6, name: "Home", icon: .home)
    static let income = Category(id: 7, name: "Income", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: .shopping_cart)
    static let transfer = Category(id: 9, name: "Transfer", icon: .exchange_alt)
    
    static let publicTransportation = Category(id: 101, name: "Public Transportation", icon: .bus, mainCategoryId: 1)
    static let taxi = Category(id: 102, name: "Taxi", icon: .taxi, mainCategoryId: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .mobile_alt, mainCategoryId: 2)
    static let moviesAndDVDs = Category(id: 301, name: "Movies & DVDs", icon: .bus, mainCategoryId: 3)
    static let bankFee = Category(id: 401, name: "Bank Fee", icon: .hand_holding_usd, mainCategoryId: 4)
    static let financeCharge = Category(id: 402, name: "Finance Charge", icon: .hand_holding_usd, mainCategoryId: 4)
    static let groceries = Category(id: 501, name: "Groceries", icon: .shopping_basket, mainCategoryId: 5)
    static let restaurants = Category(id: 502, name: "Restaurants", icon: .utensils, mainCategoryId: 5)
    static let rent = Category(id: 601, name: "Rent", icon: .house_user, mainCategoryId: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", icon: .lightbulb, mainCategoryId: 6)
    static let paycheque = Category(id: 701, name: "Paycheque", icon: .dollar_sign, mainCategoryId: 7)
    static let software = Category(id: 801, name: "Software", icon: .icons, mainCategoryId: 8)
    static let creditCardPayment = Category(id: 901, name: "Credit Card Payment", icon: .exchange_alt, mainCategoryId: 9)
}

extension Category {
    static let categories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    static let subCategories: [Category] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .moviesAndDVDs,
        .bankFee,
        .financeCharge,
        .groceries,
        .restaurants,
        .rent,
        .homeSupplies,
        .paycheque,
        .software,
        .creditCardPayment]
    
    static let all: [Category] = categories + subCategories
}
