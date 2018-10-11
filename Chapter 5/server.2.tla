------------------------------ MODULE server ------------------------------
EXTENDS TLC, Integers, Sequences
CONSTANTS MaxQueueSize

(*--algorithm message_queue

variable queue = <<>>;

define
  BoundedQueue == Len(queue) <= MaxQueueSize 
end define;

process writer = "writer"
begin Write:
  while TRUE do
    await Len(queue) < MaxQueueSize;
    queue := Append(queue, "msg");
  end while;
end process;

process reader = "reader"
variable current_message = "none";
begin Read:
  while TRUE do
    await queue /= <<>>;
    current_message := Head(queue);
    queue := Tail(queue);
  end while;
end process;
end algorithm;*)

=============================================================================
