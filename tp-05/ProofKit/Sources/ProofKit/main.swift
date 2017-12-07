import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let c: Formula = "c"
let d: Formula = "d"

print("-----------------------------")
let f = !( a && b ) || ( c && d )
print("Formule 1: ")
print(f)
print("NNF: ")
print(f.nnf)
print("DNF: ")
print(f.dnf)
print("CNF: ")
print(f.cnf)

print("-----------------------------")
let lol = ( a && b) || ( c && d )

print("Formule 2: ")
print(lol)
print("NNF: ")
print(lol.nnf)
print("DNF: ")
print(lol.dnf)
print("CNF: ")
print(lol.cnf)

print("-----------------------------")
let lolol = ( a || b) && ( c || d )
print("Formule 3: ")
print(lolol)
print("NNF: ")
print(lolol.nnf)
print("DNF: ")
print(lolol.dnf)
print("CNF: ")
print(lolol.cnf)

print("-----------------------------")
let lololol = a || (b && (c || d))
print("Formule 4: ")
print(lololol)
print("NNF: ")
print(lololol.nnf)
print("DNF: ")
print(lololol.dnf)
print("CNF: ")
print(lololol.cnf)

print("-----------------------------")

let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
