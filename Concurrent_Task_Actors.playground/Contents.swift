import UIKit

class BankAccount{
    var balanceAmount: Double
    
//    MARK: By using Lock method to avoid race condition, if we are using lock from background we need to unlock from the background. if we are lock from main thread we need to unlock from main thread
//    private let lock = NSLock()
    
//    MARK: here we need to provide value based on that it allow task, here we are given 1 it allow one thread to perform value, other one is waiting until it is finish the task
//    let semapHores = DispatchSemaphore(value: 1)

    init(balanceAmount: Double) {
        self.balanceAmount = balanceAmount
    }
    
    
    func withDrawAmount(withDrawAmount: Double){
//        lock.lock()
//        semapHores.wait()
        if(balanceAmount > withDrawAmount){
            
            let withDrawProcessingTime = UInt32.random(in: 0...5)
            print("With draw start processing processing Time Taken as: \(withDrawProcessingTime) with draw amount:: \(withDrawAmount)")
            sleep(withDrawProcessingTime)
            print("withdrawal amount is::: \(withDrawAmount)")
            balanceAmount -= withDrawAmount
            print("total balance is::: \(balanceAmount)")
            
        }
        else{
            print("insufficient balance in your account")
        }
//        semapHores.signal()
//        lock.unlock()
    }
    
}


let bankBalance = BankAccount(balanceAmount: 500)

//MARK: using Concurrent Queue

let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

concurrentQueue.async {
    bankBalance.withDrawAmount(withDrawAmount: 350)

}
concurrentQueue.async {
    bankBalance.withDrawAmount(withDrawAmount: 450)

}


//MARK: Using Serial Queue To Avoid Race Condition
//let serialQueue = DispatchQueue(label: "concurrentQueue")
//
//serialQueue.async {
//    bankBalance.withDrawAmount(withDrawAmount: 350)
//
//}
//serialQueue.async {
//    bankBalance.withDrawAmount(withDrawAmount: 450)
//
//}
