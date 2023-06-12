import MacroCows

let cow1989 = #cow("1989")
let compilerCow = #cow("compiler")

#if false // will produce a static error, because no tasty cow exists
let missingCow  = #cow("Tasty Cow")
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
