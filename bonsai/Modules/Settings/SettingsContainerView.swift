//
//  SettingsContainerView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct SettingsContainerView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Important tasks")) {
                    TaskRow()
                    TaskRow()
                    TaskRow()
                }
                
                Section(header: Text("Other tasks")) {
                    TaskRow()
                    TaskRow()
                    TaskRow()
                }
            }
            .navigationTitle("Appearance")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TaskRow: View {
    var body: some View {
        Text("Task data goes here")
    }
}

struct SettingsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContainerView()
    }
}
