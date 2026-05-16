import Foundation

@Observable
class CalculatorViewModel {
    // Текст, который будет выводиться на табло
    var displayText: String = "0"
    
    // Перечисление доступных математических операций
    enum CalcOperation {
        case add, subtract, multiply, divide
    }
    
    // Главная точка входа для нажатий кнопок из интерфейса
    func receiveInput(_ button: String) {
        // Логику обработки напишем на следующих этапах
    }
}
