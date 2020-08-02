//: [Previous](@previous)
import Foundation
/*:
 # Compatibility
 */
/*
 (O) @noescaping -> @noescaping
 (X) @noescaping -> @escaping
 (O) @escaping   -> @noescaping, @escaping
 */

class Test {
  var storedProperty: (() -> ())?
  
  func someFunction(_ param: @escaping () -> ()) {
    noEscapingClosure(param)    // (O) NoEscaping -> NoEscaping
    
//    self.storedProperty = param    // (X) required @escaping
//    escapingClosure(param)   // (X) NoEscaping -> Escaping
  }
  
  func noEscapingClosure(_ param: @escaping () -> ()) {
//    param()
    self.storedProperty = param   // (X)
  }
  
  func escapingClosure(_ param: @escaping () -> ()) {
    self.storedProperty = param
  }
}



//: [Next](@next)
