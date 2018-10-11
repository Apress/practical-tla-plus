---- MODULE main ----

EXTENDS TLC, Sequences, Integers, FiniteSets
PT == INSTANCE PT
CONSTANTS Workers, Reducer, NULL

PossibleInputs == PT!TupleOf(0..2, 4)
SumSeq(seq) == PT!ReduceSeq(LAMBDA x, y: x + y, seq, 0)
FairWorkers == CHOOSE set_w \in SUBSET Workers: Cardinality(set_w) = 1
UnfairWorkers == Workers \ FairWorkers

(*--algorithm mapreduce
variables 
  input \in PossibleInputs,
  result = [w \in Workers |-> [total |-> NULL, count |-> NULL]],
  queue = [w \in Workers |-> <<>>];

macro reduce() begin
  with 
    w \in {w \in Workers: 
      result[w].count = Len(assignments[w]) /\ ~consumed[w]} 
  do
    final[w] := result[w].total;
    consumed[w] := TRUE;
  end with;
end macro;

procedure work()
  variables total = 0, count = 0;
begin 
  WaitForQueue:
    await queue[self] /= <<>>;
  Process:
    while queue[self] /= <<>> do
      total := total + Head(queue[self]);
      queue[self] := Tail(queue[self]);
      count := count + 1;
    end while;
  Result:
    result[self] := [total |-> total, count |-> count];
    goto WaitForQueue;
end procedure;


fair process reducer = Reducer
variables final = [w \in Workers |-> 0], 
consumed = [w \in Workers |-> FALSE],
assignments = [w \in Workers |-> <<>>];
begin
  Schedule:
    with worker_order = PT!OrderSet(Workers) do
      queue := [ w \in Workers |->
        LET offset == PT!Index(worker_order, w) - 1 \* sequences start at 1
        IN PT!SelectSeqByIndex(input, LAMBDA i: i % Len(worker_order) = offset)
      ];
      assignments := queue;
    end with;
  ReduceResult:
    while \E w \in Workers: ~consumed[w] do
      either
        \* Reduce
        reduce();
      or
        \* Reassign
        with 
          from_worker \in {w \in UnfairWorkers: 
              result[w].count /= Len(assignments[w]) /\ ~consumed[w]
          },
          to_worker \in FairWorkers 
        do
          assignments[to_worker] := 
            assignments[to_worker] \o 
            assignments[from_worker];
          queue[to_worker] := 
            queue[to_worker] \o 
            assignments[from_worker];
          consumed[from_worker] := TRUE ||
          consumed[to_worker] := FALSE;
          final[to_worker] := 0;
        end with;
     end either;   
    end while;
  Finish:
    assert SumSeq(final) = SumSeq(input);
end process;

fair process fair_workers \in FairWorkers
begin FairWorker:
  call work();
end process;

process worker \in UnfairWorkers
begin RegularWorker:
  call work();
end process

end algorithm; *)

\* BEGIN TRANSLATION
\* ...
\* END TRANSLATION

Liveness == <>[](SumSeq(final) = SumSeq(input))

====
