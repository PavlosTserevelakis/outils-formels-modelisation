import PetriKit
import Foundation

public func createModel() -> PTNet {
    // Write here the encoding of the smokers' model.

    // Toutes les plades:
    let r = PTPlace(named: "r")
    let p = PTPlace(named: "p")
    let t = PTPlace(named: "t")
    let m = PTPlace(named: "m")
    let s1 = PTPlace(named: "s1")
    let w1 = PTPlace(named: "w1")
    let s2 = PTPlace(named: "s2")
    let w2 = PTPlace(named: "w2")
    let s3 = PTPlace(named: "s3")
    let w3 = PTPlace(named: "w3")


    // Transitions tpt, tpm et ttm:
    let tpt = PTTransition(
      named: "tpt",
      preconditions: [PTArc(place: r)],
      postconditions: [PTArc(place: p), PTArc(place: t)]
    )
    let tpm = PTTransition(
      named: "tpm",
      preconditions: [PTArc(place: r)],
      postconditions: [PTArc(place: p), PTArc(place: m)]
    )
    let ttm = PTTransition(
      named: "ttm",
      preconditions: [PTArc(place: r)],
      postconditions: [PTArc(place: t), PTArc(place: m)]
    )

    // Transitions ts1, ts2 et ts3:
    let ts1 = PTTransition(
      named: "ts1",
      preconditions: [PTArc(place: p), PTArc(place: t), PTArc(place: w1)],
      postconditions: [PTArc(place: s1), PTArc(place: r)]
    )
    let ts2 = PTTransition(
      named: "ts2",
      preconditions: [PTArc(place: p), PTArc(place: m), PTArc(place: w2)],
      postconditions: [PTArc(place: s2), PTArc(place: r)]
    )
    let ts3 = PTTransition(
      named: "ts3",
      preconditions: [PTArc(place: t), PTArc(place: m), PTArc(place: w3)],
      postconditions: [PTArc(place: s3), PTArc(place: r)]
    )

    // Transitions tw1, tw2 et tw3:
    let tw1 = PTTransition(
      named: "tw1",
      preconditions: [PTArc(place: s1)],
      postconditions: [PTArc(place: w1)]
    )
    let tw2 = PTTransition(
      named: "tw2",
      preconditions: [PTArc(place: s2)],
      postconditions: [PTArc(place: w2)]
    )
    let tw3 = PTTransition(
      named: "tw3",
      preconditions: [PTArc(place: s3)],
      postconditions: [PTArc(place: w3)]
    )



    return PTNet(
        places: [r, p, t, m, s1, w1, s2, w2, s3, w3],
        transitions: [tpt, tpm, ttm, ts1, ts2, ts3, tw1, tw2, tw3]
    )
}
