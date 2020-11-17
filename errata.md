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


On **page 30** [Typo]:
 
**skip**

A no-op. We can use this to ~~fill~~ represent parts of the spec that we haven't filled out yet or conditionals that don't update anything.

On **page 33** [Formatting]:

The entire `add_item` macro should be in bold.

---

On **page 34** [Addition]:

The sentence "there are three basic ways to do this" should be followed by "two we'll cover now and one that makes up chapter 5."

***

On **page 35** [Wrong expression]:

The `UNION` operator expression is missing a closing brace. The correct expression should be **`>> {{"a"}, {"b"}, {"b", "c"}}`**.

***

On **page 37** [Wrong Operator]:

The text says "Since we'd be using `Append` instead of `Cardinality`. It should instead say "Since we'd be using `Len`".

---


On **page 43** [Formatting]:
 
The first three lines of the spec should be bolded.

***

On **page 45** [Wrong expression]:
 
The last expression on the page `>> {1, 2} - 2`, is an em-dash instead of a double minus. The correct expression is **`>> {1, 2} -- 2`**.

***

On **page 52** [Deprecation]:
 
The line `CHOOSE <<x, y>> IN (-10..10) \X (-10..10)` uses the `CHOOSE <<a, b>>` syntax, which is now deprecated. The reader should instead do

```
>> CHOOSE x \in (-10..10) \X (-10..10):
>>  /\ 2*x[1] + x[2] = -2
>>  /\ 3*x[1] - 2*x[2] = 11
```

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

On **page 90** [Correction to Spec]:

The spec at the start of the page should have `UseResources` as its only label, not `WaitForResources`. The spec at the end of the page should have `WaitForResources` in bold, being a renaming.

---

On **page 93** [Constant assignment mismatch]:
 
If you follow the instructions in the `Symmetry Sets` box, you will have 3 symmetric actors in your model. The rest of the main text assumes you have 2 nonsymmetric actors.

***

On **page 101** [Incorrect Statement]:

The tip says "for label `A:` in an unfair process, writing `A:+` will make it weakly fair." This is false. `A:+` will make a weakly fair label strongly fair, but not an unfair label weakly fair.

---

On **page 115** [Missing import]:
 
The spec for `max` says `EXTENDS Sequences`. It should be `EXTENDS Sequences,` **`Integers`**.

---

On **page 121** [Simplification]:

Defining `Pow2(n)` is unnecessary, as you can instead write `2^n`.

---

On **page 125** [Addition]:

Adding the `NoOverflows` invariant will make the spec fail, as it's possible for `low` to overflow. See https://github.com/Apress/practical-tla-plus/issues/6.

---
