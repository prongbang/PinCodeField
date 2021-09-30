//
//  PinCodeField.swift
//
//  Created by prongbang on 28/9/2564 BE.
//

import SwiftUI

public struct PinCodeField: View {
    
    var max: Int = 6
    var boxSize = 50.0
    var backgroundColor: Color = Color(#colorLiteral(red: 0.9176470588, green: 0.9058823529, blue: 0.9254901961, alpha: 1))
    var cornerRadius = 6.0
    var borderColor: Color = Color(#colorLiteral(red: 0.9176470588, green: 0.9058823529, blue: 0.9254901961, alpha: 1))
    var borderWidth = 2.0
    var textColor: Color = Color(#colorLiteral(red: 0.4823529412, green: 0.4823529412, blue: 0.4823529412, alpha: 1))
    
    @State var pin: String = ""
    @State var isDisabled = false
    
    var handler: (String, (Bool) -> Void) -> Void
    
    public init() {}
    
    public var body: some View {
        VStack {
            ZStack {
                PinBox
                BackgroundField
            }
        }
        
    }
    
    private var PinBox: some View {
        HStack {
            Spacer()
            ForEach(0..<self.max) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .fill(self.backgroundColor)
                        .frame(width: self.boxSize, height: self.boxSize)
                        .overlay(
                            RoundedRectangle(cornerRadius: self.cornerRadius)
                                .stroke(self.borderColor, lineWidth: self.borderWidth)
                        )
                    if !(index >= self.pin.count) {
                        Text(self.pin.digits[index].numberString)
                            .fontWeight(.bold)
                            .foregroundColor(self.textColor)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            Spacer()
        }
    }
    
    private var BackgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        
        return TextField("", text: boundPin, onCommit: self.submitPin)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .disabled(self.isDisabled)
            .frame(height: self.boxSize)
            .modifier(KeyboardModifier(isDecimal: false))
    }
    
    private func submitPin() {
        if self.pin.count == self.max {
            self.isDisabled = true
            
            handler(pin) { _ in
                pin = ""
                isDisabled = false
            }
        }
        
        if self.pin.count > self.max {
            self.pin = String(self.pin.prefix(self.max))
            self.submitPin()
        }
    }
    
}

private struct KeyboardModifier: ViewModifier {
    let isDecimal: Bool
    func body(content: Content) -> some View {
        #if os(iOS)
            return content
            .keyboardType(self.isDecimal ? .decimalPad : .numberPad)
        #else
            return content
        #endif
    }
}

extension String {
    var digits: [Int] {
        var result = [Int]()
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        return result
    }
}

extension Int {
    var numberString: String {
        guard self < 10 else { return "0" }
        return String(self)
    }
}

struct PinCodeField_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeField { code, completion in
        }
    }
}
