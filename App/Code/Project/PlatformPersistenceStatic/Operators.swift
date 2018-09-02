import Foundation

precedencegroup Apply {
    associativity: left
    higherThan: AdditionPrecedence
}
infix operator |>: Apply

func |> <A, B>(x: A, f: (A) -> B) -> B {
    return f(x)
}
