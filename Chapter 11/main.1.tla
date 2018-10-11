---- MODULE main ----

EXTENDS TLC, Sequences, Integers
PT == INSTANCE PT
CONSTANTS Workers, Reducer, NULL

PossibleInputs == PT!TupleOf(0..2, 4)
SumSeq(seq) == PT!ReduceSeq(LAMBDA x, y: x + y, seq, 0)

(*--algorithm mapreduce
variables 
  input \in PossibleInputs,
  result = [w \in Workers |-> NULL],
  queue = [w \in Workers |-> <<>>];


process reducer = Reducer
variables final = 0, consumed = [w \in Workers |-> FALSE];
begin
  Schedule:
    with worker_order = PT!OrderSet(Workers) do
      queue := [ w \in Workers |->
        LET offset == PT!Index(worker_order, w) - 1 \* sequences start at 1
        IN PT!SelectSeqByIndex(input, LAMBDA i: i % Len(worker_order) = offset)
      ];
    end with;
  ReduceResult:
    while \E w \in Workers: ~consumed[w] do
      with w \in {w \in Workers:  ~consumed[w] /\ result[w] /= NULL} do
        final := final + result[w];
        consumed[w] := TRUE;
      end with;
    end while;
  Finish:
    assert final = SumSeq(input);
end process;

process worker \in Workers
variables total = 0;
begin 
  WaitForQueue:
    await queue[self] /= <<>>;
  Process:
    while queue[self] /= <<>> do
      total := total + Head(queue[self]);
      queue[self] := Tail(queue[self]);
    end while;
  Result:
    result[self] := total;
end process;
end algorithm; *)

\* BEGIN TRANSLATION
\* ...
\* END TRANSLATION

====
