//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Soumyattam Dey on 26/07/21.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order : Order
    
    @State private var alertMessage="Thank You!"
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader{geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width:geo.size.width)
                    Text("Your total is ₹\(order.cost,specifier:"%.2f")")
                    
                    Button("Place Order"){
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Checkout",displayMode: .inline)
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text(alertMessage), message: Text(confirmationMessage), dismissButton: .default(Text("Ok")))
        })
    }
    func placeOrder(){
        guard let encoded=try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url=URL(string: "https://reqres.in/api/cupcakes")!
        var request=URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){ data,respomse,error in
            guard let data = data else {
                
                self.alertMessage="Request Failed"
                self.confirmationMessage="Check your internet connection"
                self.showingConfirmation=true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)  \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
