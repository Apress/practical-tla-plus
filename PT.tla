This is the PT module, which contains useful support operators to help people reading Practical TLA+.
Normally we would break the operators up by domain, but we lump them all here to make it easier on beginners.
All operators have a description of how they work.

---- MODULE PT ----

\* LOCAL means it doesn't get included when you instantiate the module itself.
LOCAL INSTANCE FiniteSets
LOCAL INSTANCE Sequences
LOCAL INSTANCE Integers

Max(x, y) == IF x > y THEN x ELSE y
Min(x, y) == IF x < y THEN x ELSE y

(* SET STUFF *)

(* Fairly simple one, uses a set comprehension to filter subsets by their cardinality (number of elements) *)
SubsetsOfSize(set, n) == { set1 \in SUBSET set : Cardinality(set1) = n} 

(*
TLA+ forbids recursive higher-order operators, but it is fine with recursive functions.
ReduceSet generates a recursive function over the subsets of a set, which can be used to
recursively run a defined operator. This can then be used to define other recursive operators.
*)
ReduceSet(op(_, _), set, acc) ==
  LET f[s \in SUBSET set] == \* here's where the magic is
    IF s = {} THEN acc
    ELSE LET x == CHOOSE x \in s: TRUE
         IN op(x, f[s \ {x}])
  IN f[set]




(* FUNCTION STUFF *)

(* 
Gets the set of all possible values that f maps to.
essential the "opposite" of DOMAIN. Uses a set comprehension-map.
*)
Range(f) == { f[x] : x \in DOMAIN f }

(*
Places an ARBITRARY ordering on the set. Which ordering you get is implementation-dependent
but you are guaranteed to always receive the same ordering.
*)
OrderSet(set) == CHOOSE seq \in [1..Cardinality(set) -> set]: Range(seq) = set

\* Get all inputs to a function that map to a given output
Matching(f, val) == {x \in DOMAIN f: f[x] = val}

(* SEQUENCE STUFF *)
\* TupleOf(s, 3) = s \X s \X s
TupleOf(set, n) == [1..n -> set]

\* All sequences up to length n with all elements in set.
\* Equivalent to TupleOf(set, 0) \union TupleOf(set, 1) \union ...
\* Includes empty sequence
SeqOf(set, n) == UNION {TupleOf(set, m) : m \in 0..n}

ReduceSeq(op(_, _), seq, acc) == 
  ReduceSet(LAMBDA i, a: op(seq[i], a), DOMAIN seq, acc)

(*
  SelectSeq lets you filter a sequence based on a test operator. It acts on the values.
  SelectSeqByIndex does the exact same, except the operator tests the indices.
  This is useful if you need to round-robin a thing.
*)
SelectSeqByIndex(seq, T(_)) ==
  ReduceSet(LAMBDA i, selected: 
              IF T(i) THEN Append(selected, seq[i]) 
              ELSE selected, 
            DOMAIN seq, <<>>)

\* Pulls an indice of the sequence for elem.
Index(seq, elem) == CHOOSE i \in 1..Len(seq): seq[i] = elem

(*
  % is 0-based, but sequences are 1-based. This means S[x % Len(S)] might be an error,
  as it could evaluate to S[0], which is not an element of the sequence.
  This is a binary operator. See [cheat sheet] to see the defineable boolean operators.
*)
LOCAL a %% b == IF a % b = 0 THEN b ELSE a % b
SeqMod(a, b) == a %% b

=====
