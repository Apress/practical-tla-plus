----------------------------- MODULE threads -----------------------------
EXTENDS TLC, Integers
CONSTANT Threads
(*--algorithm dekker
variables flag = [t \in Threads |-> FALSE]

process thread \in Threads
begin
  P1: flag[self] := TRUE;
  P2: await \A t \in Threads \ {self}: flag[t] = FALSE;
  CS: skip;
  P3: flag[self] := FALSE;
end process;

end algorithm; *)


=============================================================================
