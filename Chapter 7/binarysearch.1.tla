---- MODULE binarysearch ----
EXTENDS Integers, Sequences, TLC
PT == INSTANCE PT

Pow2(n) ==
  LET f[x \in 0..n] ==
    IF x = 0
    THEN 1
    ELSE 2*f[x-1]
  IN f[n]


MaxInt == 4
Range(f) == {f[x]: x \in DOMAIN f}

OrderedSeqOf(set, n) == 
  { seq \in PT!SeqOf(set, n):
    \A x \in 2..Len(seq):
      seq[x] >= seq[x-1]
  }

(* --algorithm definitely_binary_search
variables i = 1,
          seq \in OrderedSeqOf(1..MaxInt, 4),
          target \in 1..MaxInt,
          found_index = 0,
          counter = 0;
begin
Search:
while i <= Len(seq) do
   counter := counter + 1;

  if seq[i] = target then
    found_index := i;
    goto Result;
  else
    i := i + 1
  end if;
end while;
Result:
  if Len(seq) > 0 then
    assert Pow2(counter-1) <= Len(seq);
  end if;

  if target \in Range(seq) then
      assert seq[found_index] = target;
  else
      \* 0 is out of DOMAIN seq, so can represent "not found"
      assert found_index = 0;
  end if;
end algorithm; *)

\* BEGIN TRANSLATION
VARIABLES i, seq, target, found_index, counter, pc

vars == << i, seq, target, found_index, counter, pc >>

Init == (* Global variables *)
        /\ i = 1
        /\ seq \in OrderedSeqOf(1..MaxInt, 4)
        /\ target \in 1..MaxInt
        /\ found_index = 0
        /\ counter = 0
        /\ pc = "Search"

Search == /\ pc = "Search"
          /\ IF i <= Len(seq)
                THEN /\ counter' = counter + 1
                     /\ IF seq[i] = target
                           THEN /\ found_index' = i
                                /\ pc' = "Result"
                                /\ i' = i
                           ELSE /\ i' = i + 1
                                /\ pc' = "Search"
                                /\ UNCHANGED found_index
                ELSE /\ pc' = "Result"
                     /\ UNCHANGED << i, found_index, counter >>
          /\ UNCHANGED << seq, target >>

Result == /\ pc = "Result"
          /\ IF Len(seq) > 0
                THEN /\ Assert(Pow2(counter-1) <= Len(seq), 
                               "Failure of assertion at line 41, column 5.")
                ELSE /\ TRUE
          /\ IF target \in Range(seq)
                THEN /\ Assert(seq[found_index] = target, 
                               "Failure of assertion at line 45, column 9.")
                ELSE /\ Assert(found_index = 0, 
                               "Failure of assertion at line 48, column 9.")
          /\ pc' = "Done"
          /\ UNCHANGED << i, seq, target, found_index, counter >>

Next == Search \/ Result
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

====
