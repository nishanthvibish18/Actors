//
//  ContentView.swift
//  ActorsSwiftUIBasic
//
//  Created by Nishanth on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center, content: {
            Button {
                
                let firstAccount = BankAccount(accountNumber: 123, balance: 600)
                let secondAccount = BankAccount(accountNumber: 456, balance: 50)
                
                print("current account number is::: \(firstAccount.currentaccountNumber())")
                
                DispatchQueue.concurrentPerform(iterations: 100) { _ in
                    Task{
                        try await firstAccount.transferAmount(amountTransfer: 400, newAccount: secondAccount)
                    }
                }
                
            } label: {
                Text("transfer amount")
            }
        })
        .padding()
    }
}

#Preview {
    ContentView()
}



actor BankAccount{
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func depositAmount(amount: Double){
        self.balance += amount
    }
    
//    MARK: when we make it as nonisolated, we don't require await method to call this function, here we are not changing the value so in this scenario we can use the nonisolated method.
//    MARK: making as nonisolated it is not thread safe, actor remove thread safety for this account
    nonisolated func currentaccountNumber() -> Int{
        return accountNumber
    }
    
    //    MARK: default all func is isolated it provide thread safety by async await
    func transferAmount(amountTransfer: Double, newAccount: BankAccount) async throws {
        
        if(balance > amountTransfer){
            
            print("transactionn has been started:::")
            balance -= amountTransfer
            await newAccount.depositAmount(amount: amountTransfer)
            
            print("amount transfer from :\(self.accountNumber) to \(newAccount.accountNumber), firstAccount balance is: \(balance), transferred account balance is:: \(await newAccount.balance) ")
            
        }
        else{
            throw BankTransactionError.InsuficientBalance(balance)
        }
        
    }
    
}


enum BankTransactionError: Error{
    
    case InsuficientBalance(Double)
}
