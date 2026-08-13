# What you write, per assignment

Empty files have been created for everything you must author from scratch. Files
that already had skeleton code are marked *fill in* — open them and replace the
`TODO`s. Nothing here contains implementation; the empty ones are 0 bytes.

Run anything with `./cs61b test <assignment>` or `./gradlew :<assignment>:test`.

## Coverage at a glance

All 7 homeworks and 7 projects from the course site are accounted for. "Ready"
means the skeleton already gave you every file — you fill in the TODOs, nothing
was missing.

| | Assignment | Files needed | Status |
|---|---|---|---|
| HW01 | Setup | `Arithmetic.java` | ready |
| HW02 | Java Intro | 4 files, all present | ready |
| HW03 | IntLists | 2 files, both present | ready |
| HW04 | CBTF Practice | — | no code; exam practice, no folder exists |
| HW06 | BSTMap | + `BSTMap.java` | created empty |
| HW08 | HashMap | `MyHashMap.java` | ready |
| HW09 | LLRBs | `RedBlackTree.java` | ready |
| P0 | Particle Simulator | 2 files, both present | ready |
| P0h | …hardmode | + 3 files | created empty |
| P1 | LinkedListDeque61B | + 1 file | created empty |
| P2 | ArrayDeque61B | + 2 files | created empty |
| P3 | Percolation | 2 files, both present | ready |
| P4a | NGrams | + `HistoryTextHandler.java` | created empty |
| P4cd | WordNet | 2 present + your own classes | you name those |

There is no HW05 or HW07 — the course skips those numbers.

## Files that look finished — and are meant to be

Checked every assignment for pre-filled answers. Nothing was stripped, because
each complete file below is deliberately given by the course, not a leaked solution:

| File | Why it's complete |
|---|---|
| `proj3/src/PercolationStats.java` | Spec: *"we've now given you the full solution for this class, so you don't need to worry about this step."* Read it, run its `main`. |
| `hw06/src/ULLMap.java`, `hw08/src/hashmap/ULLMap.java` | Reference unordered-linked-list map. It's the model you study before writing `BSTMap`. |
| `proj0/src/ParticleSimulator.java` | `getNeighbors`, `drawParticles`, `toString` are scaffolding. Your only change: call `decrementLifespan()` inside `tick()`. |
| `proj0/src/Direction.java`, `ParticleFlavor.java` | Given enums. Don't edit. |
| `hw03/src/IntList.java` — `size`, `iterativeSize`, `get` | Worked examples. The tasks are `incrRecursiveDestructive` + the three optional methods, all still stubs. |
| `hw01/src/Arithmetic.java` — `product` | Given so you can see a passing test. `sum` is the broken one. |
| `hw09/src/RedBlackTree.java` — `isRed`, `insert`, node class | Helpers. `flipColors`, `rotateRight`, `rotateLeft`, `insertHelper` are all `// TODO: YOUR CODE HERE`. |
| `proj3/src/*Visualizer.java`, `PercolationPicture.java` | Tools for the ungraded visualisation task. |
| `Map61B.java`, `Deque61B.java` | Interfaces. Only proj2 asks you to touch one. |

Deleting these would cost you the material the assignments tell you to read.

---

## Homework

### hw01 — Setup
| File | State |
|---|---|
| `src/Arithmetic.java` | fill in — `sum` returns `a * b`; make it add |

`product` already passes. One-line fix; this exists to prove your setup works.

### hw02 — Java Intro
| File | State |
|---|---|
| `src/DoubleUp.java` | fill in — `doubleUp("hello")` → `"hheelllloo"` |
| `src/PrintIndexed.java` | fill in — `printIndexed("hello")` → `h4e3l2l1o0` |
| `src/StarTriangle5.java` | fill in — 5-row right-aligned star triangle |
| `src/StarTriangleN.java` | fill in — same, parameterised by N |

No test files. Run each `main` directly: `./cs61b run hw02 DoubleUp`

### hw03 — IntLists
| File | State |
|---|---|
| `src/IntList.java` | fill in — the later methods; `size`/`iterativeSize` are given as examples |
| `src/IntListMystery.java` | fill in |

`tests/IntListRequiredTests.java` is your spec. `IntListOptionalTests.java` is extra practice.

### hw06 — BSTMap
| File | State |
|---|---|
| **`src/BSTMap.java`** | **created empty — write it** |
| `src/speedTestResults.txt` | fill in — numbers from `InsertRandomSpeedTest` |

Declaration the spec requires:
```java
public class BSTMap<K extends Comparable<K>, V> implements Map61B<K, V>
```
Required: `put`, `get`, `containsKey`, `size`, `clear`. Optional (throw
`UnsupportedOperationException` until you get to them): `iterator`, `remove`, `keySet`.

`src/ULLMap.java` is a complete unordered-linked-list map — read it as a model.
`src/Map61B.java` is the interface; don't edit it.

### hw08 — HashMap
| File | State |
|---|---|
| `src/hashmap/MyHashMap.java` | fill in |
| `src/results.txt` | fill in |

The file exists but declares **none** of the interface methods yet — only `Node`,
three empty constructors, and `createBucket()`. That's why javac currently says
*"does not override abstract method remove(K)"*. It isn't a broken file.

### hw09 — LLRBs
| File | State |
|---|---|
| `src/RedBlackTree.java` | fill in |

---

## Projects

### proj0 — Particle Simulator
| File | State |
|---|---|
| `src/Particle.java` | fill in |
| `src/ParticleSimulator.java` | fill in |

`Direction.java` and `ParticleFlavor.java` are given — don't edit them.

### proj0_hardmode
| File | State |
|---|---|
| `src/Particle.java` | fill in — currently an empty class shell |
| **`src/ParticleSimulator.java`** | **created empty — write it** |
| **`src/Direction.java`** | **created empty — write it** |
| **`src/ParticleFlavor.java`** | **created empty — write it** |
| `tests/TestParticle.java` | fill in — empty class; you write the tests too |

Hardmode gives you essentially nothing. Do this one *or* proj0, not both.

### proj1 — LinkedListDeque61B
| File | State |
|---|---|
| **`src/LinkedListDeque61B.java`** | **created empty — write it** |
| `tests/LinkedListDeque61BTest.java` | fill in — tests are commented out; uncomment as you go |

Circular, doubly-linked, with a sentinel. No `java.util` structures except an
`ArrayList` inside `toList`, and don't call `toList` from other methods. Only a
no-arg constructor is allowed.

### proj2 — ArrayDeque61B
| File | State |
|---|---|
| **`src/ArrayDeque61B.java`** | **created empty — write it** |
| **`tests/ArrayDeque61BEnhancementTest.java`** | **created empty — iterator/equals/toString tests** |
| `tests/ArrayDeque61BTest.java` | fill in — empty class; you write the tests |
| `src/Deque61B.java` | one-line edit — make it `extends Iterable<T>` |

This is the only assignment that asks you to modify a provided interface.

### proj3 — Percolation
| File | State |
|---|---|
| `src/Percolation.java` | fill in |
| `src/PercolationStats.java` | fill in |

`inputFiles/` and the visualizers are given. Uses `WeightedQuickUnionUF` from algs4.

### proj4a — NGordnet (NGrams)
| File | State |
|---|---|
| `src/main/TimeSeries.java` | fill in |
| `src/main/NGramMap.java` | fill in |
| **`src/main/HistoryTextHandler.java`** | **created empty — write it** |

⚠️ These live in a package. Every file in `src/main/` must start with `package main;`
— the empty ones don't have it yet.

Also needs the ngrams data under `proj4a/data/`, distributed separately by the course.

### proj4cd — NGordnet (WordNet)
| File | State |
|---|---|
| `src/main/HyponymsHandler.java` | fill in |
| `src/main/AutograderBuddy.java` | fill in — currently throws |
| your own graph/WordNet classes | **not created — you choose the names** |

The spec doesn't mandate filenames for the WordNet graph itself, so nothing was
scaffolded. Add them under `src/main/` with `package main;`.

---

## Not in the skeleton

**hw04** is CBTF exam practice — no code, so no folder. There is no hw05 or hw07.
