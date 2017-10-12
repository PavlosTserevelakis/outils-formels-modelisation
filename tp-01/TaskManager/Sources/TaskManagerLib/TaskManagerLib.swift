import PetriKit

public func createTaskManager() -> PTNet {
    // Places
    let taskPool    = PTPlace(named: "taskPool")
    let processPool = PTPlace(named: "processPool")
    let inProgress  = PTPlace(named: "inProgress")

    // Transitions
    let create      = PTTransition(
        named          : "create",
        preconditions  : [],
        postconditions : [PTArc(place: taskPool)])
    let spawn       = PTTransition(
        named          : "spawn",
        preconditions  : [],
        postconditions : [PTArc(place: processPool)])
    let success     = PTTransition(
        named          : "success",
        preconditions  : [PTArc(place: taskPool), PTArc(place: inProgress)],
        postconditions : [])
    let exec       = PTTransition(
        named          : "exec",
        preconditions  : [PTArc(place: taskPool), PTArc(place: processPool)],
        postconditions : [PTArc(place: taskPool), PTArc(place: inProgress)])
    let fail        = PTTransition(
        named          : "fail",
        preconditions  : [PTArc(place: inProgress)],
        postconditions : [])

    // P/T-net
    return PTNet(
        places: [taskPool, processPool, inProgress],
        transitions: [create, spawn, success, exec, fail])
}

// L'idée pour corriger le problème est de rajouter une place qui servira à
// empêcher le gestionnaire d'exécuter un deuxième processus pendant qu'il y a
// une tâche "in progress".

// Cette place sera donc précondition de exec et post condition de success et
// de fail.

// De plus, cette place devra avoir initialement un unique jeton.

public func createCorrectTaskManager() -> PTNet {


    // Places
    let taskPool    = PTPlace(named: "taskPool")
    let processPool = PTPlace(named: "processPool")
    let inProgress  = PTPlace(named: "inProgress")

        // On ajoute la nouvelle place:
    let condExec   = PTPlace(named: "condExec")


    // Transitions
    let create      = PTTransition(
        named          : "create",
        preconditions  : [],
        postconditions : [PTArc(place: taskPool)])

    let spawn       = PTTransition(
        named          : "spawn",
        preconditions  : [],
        postconditions : [PTArc(place: processPool)])

    // On ajoute la nouvelle place en postcondition de success:
    let success     = PTTransition(
        named          : "success",
        preconditions  : [PTArc(place: taskPool), PTArc(place: inProgress)],
        postconditions : [PTArc(place: condExec)])

    // On ajoute la nouvelle place en précondition de exec:
    let exec       = PTTransition(
        named          : "exec",
        preconditions  : [PTArc(place: taskPool), PTArc(place: processPool), PTArc(place: condExec)],
        postconditions : [PTArc(place: taskPool), PTArc(place: inProgress)])

    // On ajoute la nouvelle place en postcondition de fail:
    let fail        = PTTransition(
        named          : "fail",
        preconditions  : [PTArc(place: inProgress)],
        postconditions : [PTArc(place: condExec)])

    // P/T-net
    return PTNet(
        places: [taskPool, processPool, inProgress, condExec],
        transitions: [create, spawn, success, exec, fail])
}
