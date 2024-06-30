//
//  CheckboxState.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import Foundation

@propertyWrapper
struct CheckboxState {
    private var isSelected: Bool = false
    var wrappedValue: Bool {
        get { isSelected }
        set { isSelected = newValue }
    }
    
    init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
}
