//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Soumyattam Dey on 26/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type",selection: $order.type){
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 3...20){
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                Section{
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled{
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink(
                        destination: AddressView(order: order),
                        label: {
                            Text("Delivery Details")
                        })
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
