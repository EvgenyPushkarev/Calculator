import Foundation

@Observable
class CalculatorViewModel {
    var displayText: String = "0"
    
    // Внутренние переменные для вычислений
    var storedValue: Double? = nil
    var currentOperation: CalcOperation? = nil
    var isUserTyping: Bool = false
    
    enum CalcOperation {
        case add, subtract, multiply, divide
    }
    
    func receiveInput(_ button: String) {
        switch button {
        case "0"..."9":
            handleNumber(button)
        case ",":
            handleComma()
        case "C":
            clearAll()
        default:
            break
        }
    }
    
    private func handleNumber(_ number: String) {
        if displayText == "0" || !isUserTyping {
            displayText = number
            isUserTyping = true
        } else {
            // Ограничим ввод, например, 9 цифрами, чтобы текст не вылезал за экран
            if displayText.count < 9 {
                displayText += number
            }
        }
    }
    
    private func handleComma() {
        if !isUserTyping {
            displayText = "0,"
            isUserTyping = true
        } else if !displayText.contains(",") {
            displayText += ","
        }
    }
    
    func clearAll() {
        displayText = "0"
        storedValue = nil
        currentOperation = nil
        isUserTyping = false
    }
}
