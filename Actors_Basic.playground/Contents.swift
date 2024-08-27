import UIKit


actor SampleClass{
    var number: Int = 0
    
    func updatedValue() -> Int{
        number += 1
        
        return number
    }
}



    let numberIncrement = SampleClass()
    
    DispatchQueue.concurrentPerform(iterations: 150) { _ in
        Task {
        print("updated number is::: \(await numberIncrement.updatedValue())")
    }
}
