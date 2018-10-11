-------------------------------- MODULE add --------------------------------
EXTENDS Integers, TLC

Expected(a, b) == a + b

(*--algorithm add
variables 
  in_a \in -5..5,
  in_b \in -5..5,
  output;
begin
  output := in_a + in_b;
  assert output = Expected(in_a, in_b);
end algorithm; *)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES in_a, in_b, output, pc

vars == << in_a, in_b, output, pc >>

Init == (* Global variables *)
        /\ in_a \in -5..5
        /\ in_b \in -5..5
        /\ output = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ output' = in_a + in_b
         /\ Assert(output' = Expected(in_a, in_b), 
                   "Failure of assertion at line 13, column 3.")
         /\ pc' = "Done"
         /\ UNCHANGED << in_a, in_b >>

Next == Lbl_1
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION


=============================================================================
