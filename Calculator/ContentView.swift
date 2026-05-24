//
//  ContentView.swift
//  Calculator
//
//  Created by Evgeny on 16.05.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = CalculatorViewModel()
    
    var body: some View {
        ZStack {
            // Глубокий темный фон
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 2) {
                Spacer()
                
                // Дисплей калькулятора
                HStack {
                    Spacer()
                    Text(viewModel.displayText)
                        .font(.system(size: 70, weight: .light))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }
                
                // Жесткая сетка кнопок
                Grid(horizontalSpacing: 2, verticalSpacing: 2) {
                    
                    // Ряд 1: "С" (3 колонки) и "/" (1 колонка)
                    GridRow {
                        createButton(label: "C")
                            .gridCellColumns(3) // Занимает 3 ячейки
                        createButton(label: "/")
                    }
                    
                    // Ряд 2: "7", "8", "9", "x"
                    GridRow {
                        createButton(label: "7")
                        createButton(label: "8")
                        createButton(label: "9")
                        createButton(label: "x")
                    }
                    
                    // Ряд 3: "4", "5", "6", "—"
                    GridRow {
                        createButton(label: "4")
                        createButton(label: "5")
                        createButton(label: "6")
                        createButton(label: "—")
                    }
                    
                    // Ряд "4": "1", "2", "3", "+"
                    GridRow {
                        createButton(label: "1")
                        createButton(label: "2")
                        createButton(label: "3")
                        createButton(label: "+")
                    }
                    
                    // Ряд 5: "," (1 колонка), "0" (2 колонки), "=" (1 колонка)
                    GridRow {
                        createButton(label: ",")
                        createButton(label: "0")
                            .gridCellColumns(2) // Занимает 2 ячейки
                        createButton(label: "=")
                    }
                }
                .padding(2)
            }
        }
    }
    
    // Создание кнопки
    @ViewBuilder
    private func createButton(label: String) -> some View {
        Button(action:{viewModel.receiveInput(label)})
        {
            Text(label)
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(height: 90) // Фиксированная высота для сохранения геометрии
                .background(Color.gray)
        }
    }
}

#Preview {
    ContentView()
}
