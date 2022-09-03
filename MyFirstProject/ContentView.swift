//
//  ContentView.swift
//  MyFirstProject
//
//  Created by Semen Simanov on 03.09.2022.
//

import SwiftUI

struct ExpanseItem : Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expnases: ObservableObject{
    @Published var items = [ExpanseItem]() {
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init () {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpanseItem].self, from: items){
                self.items = decoded
                return
            }
        }
    }
}


struct ContentView: View {
    
    @State private var showingAddExpanse = false
    @ObservedObject var expenses = Expnases()
    
    var body: some View {
        Text(" ")
        NavigationView{
            List{
                ForEach(expenses.items){item in
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Мои расходы")
            .navigationBarItems(trailing:
            Button(action: {
                self.showingAddExpanse = true
            }){
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddExpanse){
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(as offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
        
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
