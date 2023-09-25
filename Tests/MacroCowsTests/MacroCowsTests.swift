import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
@testable import MacroCowsMacros
import cows
import Foundation

let testMacros: [String: Macro.Type] = [
    "🐮": MacroCow.self
]

final class MacroCowsTests: XCTestCase {
  
  func testStringLiteral() {
    assertMacroExpansion(
      """
      #🐮("1989")
      """,
      expandedSource:
        "#\"               (__)                         (__)\\#n               (oo)                         (oo)\\#n  ______________\\/______     ____    /-------\\/  __\\#n /___/___/___/___/___/_/|   /___/|  / |     || _/_/|\\#n |___|___|___|___|___|_||   |__||/|* //-----|||_|_||\\#n |_|___|___|___|___|___||   |_|__|/|^^      ^/|___||\\#n |___|___|___|___|___|_|/   |___|_|/        |___|_|/\\#n Cow in the GDR before...   ...and after 9-Nov-1989\"#",
      macros: testMacros
    )
  }

  func testIntegerArgument() {
    assertMacroExpansion(
      """
      #🐮(1989)
      """,
      expandedSource:
        "#\"               (__)                         (__)\\#n               (oo)                         (oo)\\#n  ______________\\/______     ____    /-------\\/  __\\#n /___/___/___/___/___/_/|   /___/|  / |     || _/_/|\\#n |___|___|___|___|___|_||   |__||/|* //-----|||_|_||\\#n |_|___|___|___|___|___||   |_|__|/|^^      ^/|___||\\#n |___|___|___|___|___|_|/   |___|_|/        |___|_|/\\#n Cow in the GDR before...   ...and after 9-Nov-1989\"#",
      macros: testMacros
    )
  }
  
  func testBoolArgument() {
    assertMacroExpansion(
      """
      #🐮(false)
      """,
      expandedSource: "\"\"",
      diagnostics: [
        .init(message: "Not a supported expression type, use literal Strings.",
              line: 1, column: 1,
              severity: .error)
      ],
      macros: testMacros
    )
  }

  func testStaticStringAddition() {
    assertMacroExpansion(
      """
      #🐮(("19" + ("89")))
      """,
      expandedSource:
        "#\"               (__)                         (__)\\#n               (oo)                         (oo)\\#n  ______________\\/______     ____    /-------\\/  __\\#n /___/___/___/___/___/_/|   /___/|  / |     || _/_/|\\#n |___|___|___|___|___|_||   |__||/|* //-----|||_|_||\\#n |_|___|___|___|___|___||   |_|__|/|^^      ^/|___||\\#n |___|___|___|___|___|_|/   |___|_|/        |___|_|/\\#n Cow in the GDR before...   ...and after 9-Nov-1989\"#",
      macros: testMacros
    )
  }
}
