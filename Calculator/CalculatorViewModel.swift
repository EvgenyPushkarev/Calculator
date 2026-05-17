import Foundation

@Observable
class CalculatorViewModel {
    var displayText: String = "0"
    
    // Внутренние переменные для вычислений
    var storedValue: Double? = nil
    var currentOperation: CalcOperation? = nil
    var isUserTyping: Bool = false
// Вспомогательный метод для конвертации текста в Double
    private var currentDoubleValue: Double {
        let dotFormatted = displayText.replacingOccurrences(of: ",", with: ".")
        return Double(dotFormatted) ?? 0.0
    }

    
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
        case "+", "—", "x", "/", "=":
            handleOperation(button)
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

    func handleOperation(_ symbol: String) {
        if symbol == "=" {
            executeOperation()
        } else {
            storedValue = currentDoubleValue
            isUserTyping = false
            
            switch symbol {
            case "+": currentOperation = .add
            case "—": currentOperation = .subtract
            case "x": currentOperation = .multiply
            case "/": currentOperation = .divide
            default: break
            }
        }
    }
    
    private func executeOperation() {
        guard let operation = currentOperation, let oldValue = storedValue else { return }
        let currentValue = currentDoubleValue
        var result: Double = 0.0
        
        switch operation {
        case .add: result = oldValue + currentValue
        case .subtract: result = oldValue - currentValue
        case .multiply: result = oldValue * currentValue
        case .divide: result = oldValue / currentValue
        }
        
        formatAndDisplay(result)
        isUserTyping = false
        currentOperation = nil
    }
    
    private func formatAndDisplay(_ value: Double) {
        // Если число целое, отсекаем плавающую точку
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            displayText = String(format: "%.0f", value)
        } else {
            // Ограничиваем дробную часть для красоты
            let stringValue = String(value).replacingOccurrences(of: ".", with: ",")
            if stringValue.count > 9 {
                displayText = String(stringValue.prefix(9))
            } else {
                displayText = stringValue
            }
        }
    }
}
