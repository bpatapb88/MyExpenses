//
//  AddView.swift
//  MyFirstProject
//
//  Created by Semen Simanov on 03.09.2022.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expnases
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    let types = ["Bussines", "Personal"]
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Название", text: $name)
                Picker("Тип", selection: $type){
                    ForEach(self.types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Стоимость", text: $amount)
                .keyboardType(.numberPad)            }
            .navigationBarTitle("Добавить")
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = Int(self.amount) {
                    expenses.items.append(ExpanseItem(name: self.name, type: self.type, amount: actualAmount))
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expnases())
    }
}
