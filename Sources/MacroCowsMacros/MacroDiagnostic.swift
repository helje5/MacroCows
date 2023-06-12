//  Created by Helge Heß on 12.06.23.

import SwiftDiagnostics

enum MacroDiagnostic: String, DiagnosticMessage, Swift.Error {

  case missingArgument
  case unsupportedExpression
  case couldNotGetStringValue
  case foundNoMatchingCow
  
  var message: String {
    switch self {
      case .missingArgument:
        "Missing Argument"
      case .unsupportedExpression:
        "Not a supported expression type, use literal Strings."
      case .couldNotGetStringValue:
        "Could not extract string value from expression."
      case .foundNoMatchingCow:
        "There is no cow which matches the provided string!"
    }
  }
  
  var diagnosticID: SwiftDiagnostics.MessageID {
    .init(domain: "MacroCows", id: rawValue)
  }
  
  var severity: SwiftDiagnostics.DiagnosticSeverity {
    .error
  }
}
