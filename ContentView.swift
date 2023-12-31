import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100, id:\.self) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage ){
                        ForEach(0..<101, id:\.self){
                            Text($0, format:.percent)
                        }
                    } 
                } header: {
                    Text("How much would you like to tip?")
                }
                Section {
                    Text(totalPerPerson, format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per Person")
                }
                Section {
                    Text(totalPerPerson * Double(numberOfPeople), format:.currency(code:Locale.current.currency?.identifier ?? "USD" ))
                    .foregroundColor(tipPercentage == 0 ? Color.red : Color.black)
                } header: {
                    Text("Total Amount")
                } 
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
