------------------------------ MODULE server ------------------------------

EXTENDS TLC, Integers, Sequences
CONSTANTS MaxQueueSize

(*--algorithm message_queue

variable queue = <<>>;

define
  BoundedQueue == Len(queue) <= MaxQueueSize 
end define;

macro add_to_queue(val) begin
  await Len(queue) < MaxQueueSize;
  queue := Append(queue, val);
end macro;

process writer = "writer"
begin Write:
  while TRUE do
    add_to_queue("msg");
  end while;
end process;

process reader \in {"r1", "r2"}
variable current_message = "none";
begin Read:
  while TRUE do
    await queue /= <<>>;
    current_message := Head(queue);
    queue := Tail(queue);
    either 
      skip;
    or
      NotifyFailure:
        current_message := "none";
        add_to_queue(self);
    end either; 
  end while;
end process;
end algorithm;*)

=============================================================================
