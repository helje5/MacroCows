/// A Macro which takes a String expression
/// and produces a String containing an ASCII cow matching 
/// the query. For example
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
@freestanding(expression)
public macro 🐮(_ value: String) -> String =
  #externalMacro(module: "MacroCowsMacros", type: "MacroCow")
