------------------------------ MODULE leftpad ------------------------------
EXTENDS TLC, Integers, Sequences
PT == INSTANCE PT
Leftpad(c, n, str) ==
  LET
    outlength == PT!Max(Len(str), n)
    padding == 
      CHOOSE padding \in 0..n:
        padding + Len(str) = outlength
  IN
    [x \in 1..padding |-> c] \o str

Characters == {"a", "b", "c"}

(*--algorithm leftpad
variables 
  in_c \in Characters \union {" "},
  in_n \in 0..6,
  in_str \in PT!SeqOf(Characters, 6),
  output;
begin
  output := in_str;
  while Len(output) < in_n do
    output := <<in_c>> \o output;
  end while;
  assert output = Leftpad(in_c, in_n, in_str);
end algorithm; *)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES in_c, in_n, in_str, output, pc

vars == << in_c, in_n, in_str, output, pc >>

Init == (* Global variables *)
        /\ in_c \in (Characters \union {" "})
        /\ in_n \in 0..6
        /\ in_str \in PT!SeqOf(Characters, 6)
        /\ output = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ output' = in_str
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << in_c, in_n, in_str >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF Len(output) < in_n
               THEN /\ output' = <<in_c>> \o output
                    /\ pc' = "Lbl_2"
               ELSE /\ Assert(output = Leftpad(in_c, in_n, in_str), 
                              "Failure of assertion at line 26, column 3.")
                    /\ pc' = "Done"
                    /\ UNCHANGED output
         /\ UNCHANGED << in_c, in_n, in_str >>

Next == Lbl_1 \/ Lbl_2
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Wed May 09 16:12:50 CDT 2018 by hwayn
\* Created Fri May 04 21:12:06 CDT 2018 by hwayn
  
  output := in_str;
  if in_n < 0 then
    assert output = Leftpad(in_c, 0, in_str);
    goto Done;
  end if;
  while Len(output) < in_n do
    output := <<in_c>> \o output;
  end while;
  assert output = Leftpad(in_c, in_n, in_str);
end algorithm; *)
