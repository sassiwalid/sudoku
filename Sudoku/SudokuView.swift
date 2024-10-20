//
//  ContentView.swift
//  Sudoku
//
//  Created by Walid SASSI on 20/10/2024.
//

import SwiftUI

struct SudokuView: View {
    @State var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)

    @State private var invalidCell: (Int, Int)? = nil

    var body: some View {
        VStack {
            ForEach(0..<9, id: \.self) { row in
                HStack {
                    ForEach(0..<9, id: \.self) { column in
                        TextField("", value: $grid[row][column], formatter: NumberFormatter())
                            .frame(width: 40, height: 40)
                            .multilineTextAlignment(.center)
                            .border(isInvalidCell(row: row, column: column) ? Color.red : Color.black, width: 2)
                            .background(Color.white)
                            .scaleEffect(isInvalidCell(row: row, column: column) ? 1.2 : 1.0)
                            .onChange(of:grid[row][column]) { _ in
                                if !isValidMove(row: row, col: column, num: grid[row][column]) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        invalidCell = (row, column)
                                    }
                                } else {
                                    invalidCell = nil
                                }
                            }
                        
                    }
                    
                }
            }
        }
    }
    
    func isInvalidCell(row: Int, column: Int) -> Bool {

        if let invalidCell = invalidCell {
            return invalidCell == (row, column)
        }
        return false
    }

    func isValidMove(row: Int, col: Int, num: Int) -> Bool {

        for i in 0..<9 {
            if grid[row][i] == num {
                return false
            }
        }

        // Vérifie la colonne (pas de doublon dans la colonne)
        for i in 0..<9 {
            if grid[i][col] == num {
                return false
            }
        }

        // Vérifie le bloc 3x3 (pas de doublon dans le bloc)
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        for i in 0..<3 {
            for j in 0..<3 {
                if grid[startRow + i][startCol + j] == num {
                    return false
                }
            }
        }

        // Si toutes les vérifications sont passées, le mouvement est valide
        return true

    }

}

#Preview {
    SudokuView()
}
