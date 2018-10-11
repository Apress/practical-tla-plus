----------------------------- MODULE threads_3 -----------------------------
(*--algorithm dekker
variables 
  flag = [t \in Threads |-> FALSE],
  next_thread \in Threads;

fair process thread \in Threads
begin
  P1: flag[self] := TRUE;
  P2: 
    while \E t \in Threads \ {self}: flag[t] do
      P2_1:
        if next_thread /= self then
          P2_1_1: flag[self] := FALSE;
          P2_1_2: await next_thread = self;
          P2_1_3: flag[self] := TRUE;
        end if;
    end while;
  CS: skip;
  P3: with t \in Threads \ {self} do
    next_thread := t;
  end with;
  P4: flag[self] := FALSE;
  P5: goto P1;
end process;

end algorithm; *)

\* BEGIN TRANSLATION
\* ...
\* END TRANSLATION
\*
OnlyOneCritical ==
  \A t1, t2 \in Threads: 
    /\ pc[t1] = "CS" 
    /\ pc[t2] = "CS"
    => t1 = t2
    
NoLiveLocks ==
  \A t \in Threads: <>(pc[t] = "CS")

=============================================================================
