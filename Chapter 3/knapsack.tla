------------------------------ MODULE knapsack ------------------------------
EXTENDS TLC, Integers, Sequences
PT == INSTANCE PT
Capacity == 7

Items == {"a", "b", "c"}

ItemParams == [size: 2..4, value: 0..5]
ItemSets == [Items -> ItemParams]

HardcodedItemSet == [
  a |-> [size |-> 1, value |-> 1],
  b |-> [size |-> 2, value |-> 3],
  c |-> [size |-> 3, value |-> 1]
]

KnapsackSize(sack, itemset) ==
  LET size_for(item) == itemset[item].size * sack[item]
  IN PT!ReduceSet(LAMBDA item, acc: size_for(item) + acc, Items, 0) 

ValidKnapsacks(itemset) ==
  {sack \in [Items -> 0..4]: KnapsackSize(sack, itemset) <= Capacity}

ValueOf(item) == HardcodedItemSet[item].value

\* Oh hey duplicate code
KnapsackValue(sack, itemset) ==
  LET value_for(item) == itemset[item].value * sack[item]
  IN PT!ReduceSet(LAMBDA item, acc: value_for(item) + acc, Items, 0) 

BestKnapsack(itemset) ==
  LET all == ValidKnapsacks(itemset)
  IN CHOOSE best \in all:
    \A worse \in all \ {best}:
      KnapsackValue(best, itemset) > KnapsackValue(worse, itemset)

BestKnapsacksOne(itemset) ==
  LET all == ValidKnapsacks(itemset)
  IN CHOOSE all_the_best \in SUBSET all:
    /\ \E good \in all_the_best:
         /\ \A other \in all_the_best:
              KnapsackValue(good, itemset) = KnapsackValue(other, itemset)
         /\ \A worse \in all \ all_the_best:
              KnapsackValue(good, itemset) > KnapsackValue(worse, itemset)


BestKnapsacksTwo(itemset) ==
  LET 
    all == ValidKnapsacks(itemset)
    best == CHOOSE best \in all:
      \A worse \in all \ {best}:
        KnapsackValue(best, itemset) >= KnapsackValue(worse, itemset)
    value_of_best == KnapsackValue(best, itemset)
  IN
    {k \in all: value_of_best = KnapsackValue(k, itemset)}


=============================================================================
