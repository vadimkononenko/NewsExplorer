//
//  FiltersView.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import SwiftUI

struct FiltersView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: MainViewModel
    
    @State private var fromDate: Date = Date()
    @State private var toDate: Date = Date()
    @State private var showWarning: Bool = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack {
            DatePicker(selection: $fromDate, in: ...Date.now, displayedComponents: .date) {
                Text("Select from")
            }
            
            DatePicker(selection: $toDate, in: ...Date.now, displayedComponents: .date) {
                Text("Select to")
            }
            
            Button("Apply") {
                handleApply()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.top, 20)
            
            if showWarning {
                Text("Date from must be earlier then date to!")
                    .foregroundColor(Color.red.opacity(0.7))
                    .padding()
            }
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .task {
            fromDate = viewModel.fromDate
            toDate = viewModel.toDate
        }
    }
    
    private func handleApply() {
        if toDate == fromDate || toDate > fromDate {
            viewModel.fromDate = fromDate
            viewModel.toDate = toDate

            Task {
                await viewModel.search()
            }
            
            dismiss()
        } else {
            showWarning.toggle()
        }
    }
    
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(viewModel: MainViewModel())
    }
}
