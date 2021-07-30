//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Soumyattam Dey on 26/07/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order : Order
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section{
                NavigationLink("Checkout", destination: CheckoutView(order: order))
            }
            .disabled(order.isValid==false)
            
        }
        .navigationBarTitle("Delivery",displayMode: .inline)
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
