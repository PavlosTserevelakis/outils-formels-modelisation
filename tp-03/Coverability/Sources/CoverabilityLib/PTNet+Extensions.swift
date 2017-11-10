import PetriKit

public extension PTNet {

    public func coverabilityGraph(from marking: CoverabilityMarking) -> CoverabilityGraph {

      // On initialise une constante
      let Noeud = CoverabilityGraph(marking : marking)
      var Vus = [CoverabilityGraph]()
      var Suivants = [Noeud]

      while let Courant = Suivants.popLast()
      {
        Vus.append(Courant)
        for Transition in self.transitions
        {
          if var Marquage = Transition.fireCoverability(from: Courant.marking)
          {
            for CovGraph in Vus
            {
              var NouveauMarquage = Marquage

              if Marquage > CovGraph.marking
              {
                for Laplace in self.places
                {
                  if Marquage[Laplace]! > CovGraph.marking[Laplace]!
                  {
                    NouveauMarquage[Laplace] = .omega
                  }
                }
                Marquage = NouveauMarquage
              }
              else if Marquage == CovGraph.marking
              {
                NouveauMarquage = CovGraph.marking
                Marquage = NouveauMarquage
              }
            }

            if Vus.contains(where: {$0.marking == Marquage})
            {
              Courant.successors[Transition] = Vus.first(where: {$0.marking == Marquage})
            }
            else  if Suivants.contains(where: {$0.marking == Marquage})
            {
              Courant.successors[Transition] = Suivants.first(where: {$0.marking == Marquage})
            }
            else
            {
              let Nouveau = CoverabilityGraph(marking: Marquage)
              Suivants.append(Nouveau)
              Courant.successors[Transition] = Nouveau
            }
          }
        }
      }
        // Write here the implementation of the coverability graph generation.

        // Note that CoverabilityMarking implements both `==` and `>` operators, meaning that you
        // may write `M > N` (with M and N instances of CoverabilityMarking) to check whether `M`
        // is a greater marking than `N`.

        // IMPORTANT: Your function MUST return a valid instance of CoverabilityGraph! The optional
        // print debug information you'll write in that function will NOT be taken into account to
        // evaluate your homework.

        return Noeud
    }

}

// On crée des fonctions adaptées à CoverabilityMarking pour le tirage de transitions.
// Inspirées du code pour isFireable et fire déjà fournies.

public extension PTTransition {
  public func isFireableCoverability(from marking: CoverabilityMarking) -> Bool
  {
    for arc in self.preconditions
    {
      if marking[arc.place]! < Token.some(arc.tokens)
      {
            return false
        }
      }
    return true
  }

  public func fireCoverability(from marking: CoverabilityMarking) -> CoverabilityMarking? {
      guard self.isFireableCoverability(from: marking)
      else
      {
          return nil
      }

      var result = marking
      for arc in self.preconditions
      {
        switch result[arc.place]
        {
        case let .some(.some(x)):
          result[arc.place]! = .some(x - arc.tokens)
        default:
          break
        }
      }
      for arc in self.postconditions
      {
        switch result[arc.place]
        {
        case let .some(.some(x)):
          result[arc.place]! = .some(x + arc.tokens)
        default:
          break

        }
      }

      return result
  }
}
