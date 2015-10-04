# citrus

A fork of SQLite's Lemon parser generator. See original website at [http://www.hwaci.com/sw/lemon/](http://www.hwaci.com/sw/lemon/).

## Features

This fork adds (or will add) the following features, which are primarily intended for my own convenience and sense of style; they are not designed specifically for everyone, and I make no judgements that my changes are objective improvements:

- Better management of output files: `lemon` in its present form gives no control of where its outputs go or what their names are. Just about all you can do is disable the report file, plus disable the header by putting the source file into `makeheaders` mode. This fork will add commandline options to control these outputs more exactly.
- Better C++ compatibility and modern code features: The `lempar.c` parser template as is (as well as `lemon`'s code generator for filling it in) makes heavy use of `#define` macros and doesn't take advantage of some C11/C++14 capabilities. This provides lots and lots of compatibility and makes `lemon` extremely ubiquitous. There is no strong motivation to change this, but it feels like an interesting challenge, and in some ways may make the resulting code more readable.
- More version reporting: `lemon -x` always displays "1.0", making it really hard to tell what version of Lemon you actually have. My guess is that some people are still using the one from 2009 that comes in the Homebrew formula. People on Debian and derivatives are getting a version that's compiled from whatever release of SQLite their Debian release is working from. This fork provides a version number based on the upstream SQLite.

So far, that's all. Maybe more later.

## Why?

Why not just wrap `lemon` in a shell script and use my own template file? Why, in fact, do the changes in this fork matter at all?

- A shell script is a bit cumbersome and has to depend on the version of Lemon in use to maintain its existing semantics. A fork avoids extra version dependencies and allows skipping work that doesn't need to be done for a given set of options.
- Some of the changes in the parser template are rather awkward syntactically; a lot of assumptions are hardcoded into Lemon's code generation. For example, to use `const int YYNRULE = ...;` instead of `#define YYNRULE ...` requires preprocessor trickery (e.g. `const int YY/**/NRULE = YYNRULE; #undef YYNRULE`).
- Lemon explicitly has no copyright (which according to my IANAL understanding places it in the public domain; I may be wrong). Therefore there's no boundary on playing around with it.
- Lemon is not distributed as a source _or_ binary package separately from SQLite, at least not through any official channel that I've found. The Homebrew formula for it at the time of this writing (version 1.69) refers to a download from a third-party personal website, and the code dates to 2009. Quite a bit has been done with Lemon in the SQLite development tree since that time. A fork makes it a bit easier to keep up with upstream changes than "download `lemon.c` and `lempar.c` from the SQLite repo and install them manually" or "build all of SQLite".

## License

This code is presently distributed under the MIT license. See the `LICENSE` file for details. To the best of my understanding, this relicensing is permitted due to the explicit disavowing of copyright by the original Lemon code. The original work on Lemon is not mine, and I do not claim credit to the bulk of the program, nor to its operation.
