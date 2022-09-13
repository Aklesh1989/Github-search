//
//  File.swift
//  GitUsers
//
//  Created by Aklesh on 13/09/22.
//

import Foundation

public final class Notifier<T> {
  
    public typealias Listener = (T) -> Void
    
    private var listener: Listener?
  
    public var value: T {
      didSet {
          listener?(value)
        }
    }
  
    public init(_ value: T) {
        self.value = value
    }
  
    public func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    public func setValue(to: T) {
        listener?(to)
    }
}


