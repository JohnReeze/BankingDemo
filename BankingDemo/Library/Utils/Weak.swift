//
//  Weak.swift
//  BankingDemo
//

/**
 Provides weak reference for passed object, and used as non-optional object in 'method' block
 ```
 // Classic version
 adapter?.onCardOpen = { [weak self] in
     guard let self = self else {
        return
     }
     self.output?.openCard()
 }
 // Using weak func
 adapter?.onCardOpen = weak(self) { $0.output?.openCard() }
 ```
 */
@inline(__always)
public func weak<O: AnyObject>(_ object: O, _ method: @escaping (O) -> Void) -> () -> Void {
    return { [weak object] in
        if let object = object {
            method(object)
        }
    }
}
/**
  Extends 'weak' function without parameter
  ```
  // Classic version
  viewModel.onValueChanged = { [weak self] value in
      guard let self = self else {
          return
      }
      self.handleValueChanged(value)
  }
  // Using weak func
  viewModel.onValueChanged = weak(self) { $0.handleValueChanged($1) }
  ```
*/
@inline(__always)
public func weak<O: AnyObject, T: Any>(_ object: O, _ method: @escaping (O, T) -> Void) -> (T) -> Void {
    return { [weak object] t in
        if let object = object {
            method(object, t)
        }
    }
}
