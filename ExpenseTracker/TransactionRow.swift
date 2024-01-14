//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Bethany Liu on 2023-12-25.
//

import SwiftUI
import SwiftUIFontIcon

// A SwiftUI view representing a single row for displaying transaction information.
struct TransactionRow: View {
    var transaction: Transaction  // The transaction model to display
    var body: some View {
        // Horizontal stack containing the content of a transaction row with spacing between elements.
        HStack(spacing: 20) {
            // Vertical stack for the details of the transaction (merchant, category, date).
            
            //MARK: Transaction Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.iconColor.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transaction Merchant
                // Display the merchant's name with a bold subheadline font.
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)  // Limit the number of lines to 1 to prevent excessive height.

                // MARK: Transaction Category
                // Display the transaction category with a footnote font and reduced opacity.
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)  // Limit the number of lines to 1.

                // MARK: Transaction Date
                // Display the transaction date with a footnote font, secondary color, and formatted date.
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // MARK: Transaction Amount
            // Display the transaction amount
            Text(transaction.signedAmount, format: .currency(code: "CAD"))
                .bold()
            // if the type is credit, display primary if debit, display other
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)  // Add padding to the top and bottom of the row.
    }
}

// A preview provider for the TransactionRow view.
struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        // Group of preview examples for TransactionRow, one with the default color scheme
        // and another with the dark color scheme.
        Group {
            TransactionRow(transaction: transactionPreviewData)
            TransactionRow(transaction: transactionPreviewData).preferredColorScheme(.dark)
        }
    }
}

