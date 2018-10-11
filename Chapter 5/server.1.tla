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
    queue := Append(queue, "msg");
  end while;
end process;

process reader = "reader"
variables current_message = "none";
begin Read:
  while TRUE do
    current_message := Head(queue);
    queue := Tail(queue);
  end while;
end process;
end algorithm;*)



=============================================================================
