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
variables low = 1,
          seq \in OrderedSeqOf(1..MaxInt, MaxInt),
          high = Len(seq),  
          target \in 1..MaxInt,
          counter = 0,
          found_index = 0;
begin
Search:
while low <= high do
    counter := counter + 1;
    with
      lh = high + low,
      m = (lh \div 2)
    do
        if seq[m] = target then
            found_index := m;
            goto Result;
        elsif seq[m] < target then
            low := m + 1;
        else
            high := m - 1;
        end if;
    end with;
end while;
Result:
    if Len(seq) > 0 then
      assert Pow2(counter-1) <= Len(seq);
    end if;
    if target \in Range(seq) then
        assert seq[found_index] = target;
    else
        assert found_index = 0;
    end if;

end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES low, seq, high, target, counter, found_index, pc

vars == << low, seq, high, target, counter, found_index, pc >>

Init == (* Global variables *)
        /\ low = 1
        /\ seq \in OrderedSeqOf(1..MaxInt, MaxInt)
        /\ high = Len(seq)
        /\ target \in 1..MaxInt
        /\ counter = 0
        /\ found_index = 0
        /\ pc = "Search"

Search == /\ pc = "Search"
          /\ IF low <= high
                THEN /\ counter' = counter + 1
                     /\ LET lh == high + low IN
                          LET m == (lh \div 2) IN
                            IF seq[m] = target
                               THEN /\ found_index' = m
                                    /\ pc' = "Result"
                                    /\ UNCHANGED << low, high >>
                               ELSE /\ IF seq[m] < target
                                          THEN /\ low' = m + 1
                                               /\ high' = high
                                          ELSE /\ high' = m - 1
                                               /\ low' = low
                                    /\ pc' = "Search"
                                    /\ UNCHANGED found_index
                ELSE /\ pc' = "Result"
                     /\ UNCHANGED << low, high, counter, found_index >>
          /\ UNCHANGED << seq, target >>

Result == /\ pc = "Result"
          /\ IF Len(seq) > 0
                THEN /\ Assert(Pow2(counter-1) <= Len(seq), 
                               "Failure of assertion at line 51, column 7.")
                ELSE /\ TRUE
          /\ IF target \in Range(seq)
                THEN /\ Assert(seq[found_index] = target, 
                               "Failure of assertion at line 54, column 9.")
                ELSE /\ Assert(found_index = 0, 
                               "Failure of assertion at line 56, column 9.")
          /\ pc' = "Done"
          /\ UNCHANGED << low, seq, high, target, counter, found_index >>

Next == Search \/ Result
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

====
