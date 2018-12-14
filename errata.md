# Errata for *Practical TLA+*

On **page 26** [Wrong result for expression]:
 
Row five of the operator table says that `TRUE \/ FALSE` is **`FALSE`**. It should be **`TRUE`**.

***

On **page 27** [Wrong result for expression]:
 
The range operator expression says that evaluating `1..3` will output **`{1, 2, 3}`**. TLC will instead represent it as `1..3`. A more correct expression would be **`>> 1..3 = {1, 2, 3}`**, which would have value `TRUE`.

***


On **page 28** [Wrong expression]:
 
Row five of the operator table says that **`>> <<1, 1, 1, 1>>`** will output `4`. The expression is missing the `Len` operator. The correct expression should be **`>> Len(<<1, 1, 1, 1>>)`**

***


On **page 43** [Unmarked change]:
 
The first three lines of the spec should be bolded.

***

On **page 45** [Wrong expression]:
 
The last expression on the page `>> {1, 2} - 2`, is an em-dash instead of a double minus. The correct expression is **`>> {1, 2} -- 2`**.

***

On **page 66** [Missing step, operator]:
 
The book adds constants to the knapsack spec but **does not** explicitly say to remove the corresponding operators. Additionally, we need to **update `ItemParams`**. The new definition is

```tla
ItemParams == [size: SizeRange, value: ValueRange]
```

This operator can also be found on page 68.

***

On **page 74-75** [Text change]:
 
On some computers the path might be **Properties**, not **Preferences**.

[I believe this is OS specific, but haven't yet confirmed.]

***

On **page 76** [Missing step]:
 
Do not instantiate instances of `Point` in the `Point` model itself.

***

On **page 93** [Constant assignment mismatch]:
 
If you follow the instructions in the `Symmetry Sets` box, you will have 3 symmetric actors in your model. The rest of the main text assumes you have 2 nonsymmetric actors.

***

On **page 115** [Missing import]:
 
The spec for `max` says `EXTENDS Sequences`. It should be `EXTENDS Sequences,` **`Integers`**.
