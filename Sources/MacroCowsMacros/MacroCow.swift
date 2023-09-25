import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import cows
import Foundation

/// Implementation of the `cow` macro, which takes a String expression
/// and produces a String containing an ASCII matching the query
/// and the source code that produced the value. For example
///
///     #🐮("1989")
///
///  will expand to
///  ```
///                (__)                         (__)
///                (oo)                         (oo)
///   ______________\/______     ____    /-------\/  __
///  /___/___/___/___/___/_/|   /___/|  / |     || _/_/|
///  |___|___|___|___|___|_||   |__||/|* //-----|||_|_||
///  |_|___|___|___|___|___||   |_|__|/|^^      ^/|___||
///  |___|___|___|___|___|_|/   |___|_|/        |___|_|/
///  Cow in the GDR before...   ...and after 9-Nov-1989
///  ```
public struct MacroCow: ExpressionMacro {
  
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) -> ExprSyntax 
  {
    guard let argument = node.argumentList.first?.expression else {
      let message = MacroDiagnostic.missingArgument
      context.diagnose(Diagnostic(node: Syntax(node), message: message))
      return "\(literal: "")"
    }
    
    let needle : String
    do {
      needle = try argument.evaluateAsString()
    }
    catch {
      let message = (error as? MacroDiagnostic) ?? .missingArgument
      context.diagnose(Diagnostic(node: Syntax(node), message: message))
      return "\(literal: "")"
    }
    
    guard let cow = lookupCow(needle) else {
      context.diagnose(Diagnostic(node: Syntax(node),
                                  message: MacroDiagnostic.foundNoMatchingCow))
      return "\(literal: vaca())"
    }
    
    return "\(literal: cow)"
  }
  
  private static func lookupCow(_ needle: String) -> String? {
    let lower = needle.lowercased()
    return cows.allCows.first(where: { $0.range(of: needle) != nil })
        ?? cows.allCows.first(where: { $0.lowercased().range(of:lower) != nil })
  }
}

@main
struct MacroCowsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [ MacroCow.self ]
}
