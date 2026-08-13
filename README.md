# CS 61B — Spring 2026

Working through <https://sp26.datastructur.es> independently. Skeleton code from
[Berkeley-CS61B/skeleton-sp26](https://github.com/Berkeley-CS61B/skeleton-sp26);
solutions are mine.

See [ASSIGNMENTS.md](ASSIGNMENTS.md) for what each assignment requires.

## Layout

```
Github/
├── library-sp26/       86 jars — algs4, ucb, jh61b, JUnit 5 + 4, Truth, spark…
└── CS61B/              this repo
    ├── hw01/ … proj4cd/    13 assignments, each src/ + tests/
    ├── lec2_intro2/        lecture scratch
    ├── cs61b               CLI runner (no build tool needed)
    ├── build.gradle        one Gradle subproject per assignment
    ├── configure-intellij.sh
    └── setup-cs61b.sh      fetches library-sp26 on a fresh clone
```

`library-sp26` is a **sibling**, not nested — the course requires it, and every
path here (`../library-sp26`) depends on it. It's gitignored, so after cloning
this repo somewhere new:

```bash
./setup-cs61b.sh && ./configure-intellij.sh
```

## Running

```bash
./cs61b list                    # show assignments
./cs61b test hw01               # compile + run tests
./cs61b test hw06 TestBSTMap    # one test class
./cs61b run  hw02 DoubleUp      # run a main, stdin connected
```

Or via Gradle: `./gradlew :hw01:test`, `./gradlew :hw01:test --tests '*sum*'`,
`./gradlew :hw01:runMain -PmainClass=Arithmetic`.

In IntelliJ, just open this folder — 14 modules, library attached, green gutter
arrows on any test.

## Toolchain

- Assignments compile against **Java 25** (`cs61b.javaRelease`), matching the course.
  Default `java` here is 26; `--release 25` targets 25 from a newer compiler.
- **Gradle 9.7.0** via the wrapper, running on JDK 26 directly. No JDK pin needed.

  Don't downgrade the wrapper. Gradle 9.0.0's supported ceiling is JDK **24** —
  it runs on 25 from the terminal, but IntelliJ enforces the official matrix and
  refuses to sync: *"maximum compatible Gradle JVM version is 24, minimum
  compatible Gradle version is 9.4.1."* Anything ≥ 9.4.1 is fine on JDK 26.

## New assignments

```bash
git pull skeleton main      # or: --no-rebase --allow-unrelated-histories
./configure-intellij.sh     # regenerate modules
```
Gradle discovers new folders on its own.

## Notes

- `hw06` and `hw08` don't compile until you write `BSTMap` / finish `MyHashMap` —
  that's the assignment, not a broken setup.
- `proj1` and `proj2` ship their tests disabled; writing them is part of the work.
- `proj4a`/`proj4cd` need ngrams data under `proj4*/data/`, distributed separately.
- `hw04` is CBTF exam practice (no code). There is no hw05 or hw07.
