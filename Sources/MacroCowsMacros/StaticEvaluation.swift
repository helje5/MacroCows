//  Created by Helge Heß on 12.06.23.

import SwiftSyntax

protocol StaticStringEvaluation {
  
  func evaluateAsString() throws -> String
}

extension ExprSyntax: StaticStringEvaluation {
  
  func evaluateAsString() throws -> String {
    // TBD: Is there a better way to do this matching? Using a visitor maybe?
    if let typed = self.as(StringLiteralExprSyntax.self) {
      return try typed.evaluateAsString()
    }
    if let typed = self.as(IntegerLiteralExprSyntax.self) {
      return try typed.evaluateAsString()
    }
    if let typed = self.as(SequenceExprSyntax.self) {
      return try typed.evaluateAsString()
    }
    if let typed = self.as(ExprListSyntax.self) {
      return try typed.evaluateAsString()
    }
    if let typed = self.as(TupleExprSyntax.self) {
      return try typed.evaluateAsString()
    }

    throw MacroDiagnostic.unsupportedExpression
  }
}

extension StringLiteralExprSyntax: StaticStringEvaluation {
  
  func evaluateAsString() throws -> String {
    guard let value = representedLiteralValue else {
      throw MacroDiagnostic.couldNotGetStringValue
    }
    return value
  }
}

extension IntegerLiteralExprSyntax: StaticStringEvaluation {
  
  func evaluateAsString() throws -> String { digits.text }
}

extension SequenceExprSyntax: StaticStringEvaluation {
  
  func evaluateAsString() throws -> String { try elements.evaluateAsString() }
}

extension ExprListSyntax: StaticStringEvaluation {
  
  func evaluateAsString() throws -> String {
    guard let firstExpr = first else { // empty
      throw MacroDiagnostic.couldNotGetStringValue
    }
    
    // It must start w/ something that can result in a String
    var string = try firstExpr.evaluateAsString()
    
    for expr in dropFirst() {
      if let op = expr.as(BinaryOperatorExprSyntax.self) {
        guard case .binaryOperator(let op) = op.operatorToken.tokenKind else {
          throw MacroDiagnostic.unsupportedExpression
        }
        guard op == "+" else {
          throw MacroDiagnostic.unsupportedExpression
        }
      }
      else {
        // This allows `"19" "89"`, w/o an operator :-)
        string += try expr.evaluateAsString()
      }
    }
    
    return string
  }
}

extension TupleExprSyntax: StaticStringEvaluation {
  
  func evaluateAsString() throws -> String {
    try elementList.evaluateAsString()
  }
}

extension TupleExprElementListSyntax: StaticStringEvaluation {

  func evaluateAsString() throws -> String {
    try reduce("") { last, element in
      last + (try element.expression.evaluateAsString())
    }
  }
}
