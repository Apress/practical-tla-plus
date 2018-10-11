------------------------------ MODULE recycler ------------------------------

EXTENDS Sequences, Integers, TLC, FiniteSets

(*--algorithm recycler
variables
    capacity \in [trash: 1..10, recycle: 1..10],
    bins = [trash |-> <<>>, recycle |-> <<>>],
    count = [trash |-> 0, recycle |-> 0],
    item = [type: {"trash", "recycle"}, size: 1..6],
    items \in item \X item \X item \X item,
    curr = ""; \* helper: current item

macro add_item(type) begin
  bins[type] := Append(bins[type], curr);
  capacity[type] := capacity[type] - curr.size;
  count[type] := count[type] + 1;
end macro;
    
begin
    while items /= <<>> do
        curr := Head(items);
        items := Tail(items);
        if curr.type = "recycle" /\ curr.size < capacity.recycle then
            add_item("recycle");
        elsif curr.size < capacity.trash then
            add_item("trash");
        end if;
     end while;
     
     assert capacity.trash >= 0 /\ capacity.recycle >= 0;
     assert Len(bins.trash) = count.trash;
     assert Len(bins.recycle) = count.recycle;
end algorithm; *)

=============================================================================
