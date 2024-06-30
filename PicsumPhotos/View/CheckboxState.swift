//
//  CheckboxState.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import Foundation

/// A property wrapper to manage the state of a checkbox.
@propertyWrapper
struct CheckboxState {
    /// The internal state of the checkbox.
    private var isSelected: Bool = false
    /// The wrapped value that the property wrapper manages.
    var wrappedValue: Bool {
        get { isSelected }
        set { isSelected = newValue }
    }
    
    /// Initializer to set the initial state of the checkbox.
    ///
    /// - Parameter wrappedValue: The initial state of the checkbox.
    init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
}
