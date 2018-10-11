-------------------------------- MODULE door --------------------------------
EXTENDS TLC

(*--algorithm door
variables
  open = FALSE,
  locked = FALSE,
  key \in BOOLEAN;
  
process open_door = "Open Door"
begin 
  OpenDoor:
    await open;
    either \* un/lock
      locked := ~locked;
    or \* close
      await ~locked;
      open := FALSE;
    end either;
    goto OpenDoor;
end process;

process closed_door = "Closed Door"
begin 
  ClosedDoor:
    await ~open;
    either \* un/lock
      await key;
      locked := ~locked;
    or
      await ~locked;
      open := TRUE;
    end either;
    goto ClosedDoor;
end process;
end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES open, locked, key, pc

vars == << open, locked, key, pc >>

ProcSet == {"Open Door"} \cup {"Closed Door"}

Init == (* Global variables *)
        /\ open = FALSE
        /\ locked = FALSE
        /\ key \in BOOLEAN
        /\ pc = [self \in ProcSet |-> CASE self = "Open Door" -> "OpenDoor"
                                        [] self = "Closed Door" -> "ClosedDoor"]

OpenDoor == /\ pc["Open Door"] = "OpenDoor"
            /\ open
            /\ \/ /\ locked' = ~locked
                  /\ open' = open
               \/ /\ ~locked
                  /\ open' = FALSE
                  /\ UNCHANGED locked
            /\ pc' = [pc EXCEPT !["Open Door"] = "OpenDoor"]
            /\ key' = key

open_door == OpenDoor

ClosedDoor == /\ pc["Closed Door"] = "ClosedDoor"
              /\ ~open
              /\ \/ /\ key
                    /\ locked' = ~locked
                    /\ open' = open
                 \/ /\ ~locked
                    /\ open' = TRUE
                    /\ UNCHANGED locked
              /\ pc' = [pc EXCEPT !["Closed Door"] = "ClosedDoor"]
              /\ key' = key

closed_door == ClosedDoor

Next == open_door \/ closed_door
           \/ (* Disjunct to prevent deadlock on termination *)
              ((\A self \in ProcSet: pc[self] = "Done") /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION

=============================================================================
