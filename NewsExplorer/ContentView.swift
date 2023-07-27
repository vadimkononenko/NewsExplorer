//
//  ContentView.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Text("Count: \(viewModel.articles.last?.title ?? "")")
        }
        .task {
            await viewModel.searchForPeriod()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
