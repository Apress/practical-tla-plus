---- MODULE library ----
EXTENDS Integers, TLC, Sequences, FiniteSets
CONSTANTS Books, People, NumCopies
ASSUME NumCopies \subseteq Nat
PT == INSTANCE PT

set ++ x == set \union {x}
set -- x == set \ {x}

(*--algorithm library
variables
  library \in [Books -> NumCopies],
  reserves = [b \in Books |-> <<>>];

define
  AvailableBooks == {b \in Books: library[b] > 0}
    BorrowableBooks(p) == 
    {b \in AvailableBooks: 
      \/ reserves[b] = <<>> 
      \/ p = Head(reserves[b])}
end define;

  
fair process person \in People
variables
  books = {},
  wants \in SUBSET Books;
begin 
  Person:
    while TRUE do
      either
        \* Checkout:
        with b \in (BorrowableBooks(self) \intersect wants) \ books do
          library[b] := library[b] - 1;
          books := books ++ b;
          wants := wants -- b;
          if reserves[b] /= <<>> /\ self = Head(reserves[b]) then
            reserves[b] := Tail(reserves[b]);
          end if;
        end with;

      or
        \* Return:
        with b \in books do
          library[b] := library[b] + 1;
          books := books -- b;
        end with;
      or
        \* Reserve
        with b \in {b \in wants: self \notin PT!Range(reserves[b])} do
          reserves[b] := Append(reserves[b], self);
        end with;
      or
        \* Want
        await wants = {};
        with b \in SUBSET books do 
          wants := b; 
        end with;
      end either;
    end while;
end process;

fair process book_reservations \in Books
begin
  Expire:
    await reserves[self] /= <<>>;
    reserves[self] := Tail(reserves[self]);
    goto Expire;
end process;

end algorithm; *)

\* BEGIN TRANSLATION
\* ...
\* END TRANSLATION

NoDuplicateReservations ==
  \A b \in Books:
    \A i, j \in 1..Len(reserves[b]):
        i /= j => reserves[b][i] /= reserves[b][j] 

TypeInvariant ==
  /\ library \in [Books -> NumCopies ++ 0]
  /\ books \in [People -> SUBSET Books]
  /\ wants \in [People -> SUBSET Books]
  /\ reserves \in [Books -> Seq(People)]
  /\ NoDuplicateReservations

NextInLineFor(p, b) ==
  /\ reserves[b] /= <<>>
  /\ p = Head(reserves[b])
  
Liveness ==
  \A p \in People: 
    \A b \in Books:
        b \in wants[p] ~> 
          \/ b \notin wants[p]
          \/ NextInLineFor(p, b)

====
