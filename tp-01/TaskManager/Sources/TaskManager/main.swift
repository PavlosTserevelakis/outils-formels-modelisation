import Foundation
import PetriKit
import TaskManagerLib

let taskManager = createTaskManager()

let taskPool    = taskManager.places.first { $0.name == "taskPool" }!
let processPool = taskManager.places.first { $0.name == "processPool" }!
let inProgress  = taskManager.places.first { $0.name == "inProgress" }!

let create    = taskManager.transitions.first { $0.name == "create" }!
let success   = taskManager.transitions.first { $0.name == "success" }!
let spawn     = taskManager.transitions.first { $0.name == "spawn" }!
let exec      = taskManager.transitions.first { $0.name == "exec" }!
let fail      = taskManager.transitions.first { $0.name == "fail" }!

// Pour créer un fichier dot correspondant au RdP corrigé:
try! taskManager.saveAsDot(to: URL(fileURLWithPath: "original.dot"), withMarking: [taskPool: 1,  processPool: 2, inProgress: 3])


// On crée une tâche:
let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
print(m1!)
// On crée deux processus.
let m2 = spawn.fire(from: m1!)
let m3 = spawn.fire(from: m2!)
print(m2!)
print(m3!)
// On exécute une fois la tâche avec un processus:
let m4 = exec.fire(from: m3!)
print(m4!)
// On exécute une deuxième fois la tâche avec le deuxième processus.
let m5 = exec.fire(from: m4!)
print(m5!)
// Avec l'un des processus, la tâche réussit.
let m6 = success.fire(from: m5!)
print(m6!)
// Maintenant, il n'est plus possible de réussir une deuxième fois cette tâche
// avec le deuxième processus et ce dernier ne peut donc plus être détruit.



let correctTaskManager = createCorrectTaskManager()

let taskPool2    = correctTaskManager.places.first { $0.name == "taskPool" }!
let processPool2 = correctTaskManager.places.first { $0.name == "processPool" }!
let inProgress2  = correctTaskManager.places.first { $0.name == "inProgress" }!
let condExec2   = correctTaskManager.places.first { $0.name == "condExec" }!

let create2    = correctTaskManager.transitions.first { $0.name == "create" }!
let success2   = correctTaskManager.transitions.first { $0.name == "success" }!
let spawn2     = correctTaskManager.transitions.first { $0.name == "spawn" }!
let exec2      = correctTaskManager.transitions.first { $0.name == "exec" }!
let fail2      = correctTaskManager.transitions.first { $0.name == "fail" }!

// Pour corriger le problème, on peut par exemple forcer le gestionnaire des
// tâches à n'exécuter qu'une tâche à la fois.


// On crée une tâche:
let m12 = create2.fire(from: [taskPool2: 0, processPool2: 0, inProgress2: 0, condExec2: 1])
print(m12!)

// On crée deux processus.
let m22 = spawn2.fire(from: m12!)
print(m22!)
let m32 = spawn2.fire(from: m22!)
print(m32!)

// On exécute une fois la tâche avec un processus:
let m42 = exec2.fire(from: m32!)
print(m42!)

// On ne peut plus exécuter une deuxième fois la même tâche.
// La nouvelle place empêche bien plusieurs exécutions de se faire simultanément.
// let m52 = exec2.fire(from: m42!)


// Pour créer un fichier dot correspondant au RdP corrigé:
try! correctTaskManager.saveAsDot(to: URL(fileURLWithPath: "modif.dot"), withMarking: [taskPool2: 1,  processPool2: 2, inProgress2: 3, condExec2: 4])
