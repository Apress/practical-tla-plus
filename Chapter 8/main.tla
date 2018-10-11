-------------------------------- MODULE main --------------------------------
EXTENDS LinkedLists, TLC, Integers, FiniteSets, Sequences
CONSTANTS Nodes

AssertNo(set, claim) ==
  IF set = {} THEN TRUE
  ELSE Assert(FALSE, <<claim, CHOOSE g \in set: TRUE>>)

AssertSome(set, claim) ==
  IF set /= {} THEN TRUE
  ELSE Assert(FALSE, "todo")

IsRing(ll) ==
  \A n \in DOMAIN ll:
    \E n2 \in DOMAIN ll:
      ll[n2] = n
      
WeCanFindARing(subn) ==
 \E ll \in LinkedLists(Nodes):
    /\ subn = DOMAIN ll
    /\ IsRing(ll)

AtMostOneOrphan(ll) ==
  LET 
    Parents(n) == {p \in DOMAIN ll: ll[p] = n}
    Orphans == {o \in DOMAIN ll: Parents(o) = {}}
  IN
    Cardinality(Orphans) <= 1
  

Spec ==
  /\ \A subn \in SUBSET Nodes \ {{}}:
      /\ Assert(WeCanFindARing(subn), <<subn, "should have a ring">>)
  /\ \A ll \in LinkedLists(Nodes):
      /\ Assert(AtMostOneOrphan(ll), <<ll, "has 2+ orphans">>)


=============================================================================
