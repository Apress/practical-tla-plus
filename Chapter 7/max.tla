---- MODULE max ----
EXTENDS Integers, Sequences, TLC
CONSTANTS IntSet, MaxSetLen
ASSUME IntSet \subseteq Int
ASSUME MaxSetLen > 0

PT == INSTANCE PT

Max(seq) == 
  LET indice == CHOOSE x \in 1..Len(seq): \A y \in 1..Len(seq): seq[y] <= seq[x]
  IN seq[indice]

AllInputs == PT!SeqOf(IntSet, MaxSetLen) \ {<<>>}
(*--algorithm max
variables seq \in AllInputs, i = 1, max;
begin
  assert Len(seq) > 0;
  max := seq[1];
  while i <= Len(seq) do
    if max < seq[i] then
      max := seq[i];
    end if;
    i := i + 1;
  end while;
  assert max = Max(seq);
end algorithm; *)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES seq, i, max, pc

vars == << seq, i, max, pc >>

Init == (* Global variables *)
        /\ seq \in AllInputs
        /\ i = 1
        /\ max = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ Assert(Len(seq) > 0, 
                   "Failure of assertion at line 17, column 3.")
         /\ max' = seq[1]
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << seq, i >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF i <= Len(seq)
               THEN /\ IF max < seq[i]
                          THEN /\ max' = seq[i]
                          ELSE /\ TRUE
                               /\ max' = max
                    /\ i' = i + 1
                    /\ pc' = "Lbl_2"
               ELSE /\ Assert(max = Max(seq), 
                              "Failure of assertion at line 25, column 3.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << i, max >>
         /\ seq' = seq

Next == Lbl_1 \/ Lbl_2
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

====
