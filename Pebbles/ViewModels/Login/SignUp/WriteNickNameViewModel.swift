import RxSwift
import RxCocoa
import UIKit

class WriteNickNameViewModel {
    
    let name = BehaviorSubject<String>(value: "")
    let nameCount = BehaviorSubject<Int>(value: 0)
    
    init(){
        
    }
}
