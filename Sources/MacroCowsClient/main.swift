import MacroCows

let cow1989     = #🐮("1989")
let compilerCow = #🐮("compiler")

#if false // will produce a static error, because no tasty cow exists
let missingCow  = #🐮("Tasty Cow")
#endif

//           (__)
//         /  .\/.     ______
//        |  /\_|     |      \
//        |  |___     |       |
//        |   ---@    |_______|
//     *  |  |   ----   |    |
//      \ |  |_____
//       \|________|
// CompuCow Discovers Bug in Compiler
print(compilerCow)
