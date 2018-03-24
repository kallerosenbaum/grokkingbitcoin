# Grokking Bitcoin instructions

This repository contains the source code for Grokking Bitcoin. The book is written to produce html output. Other target formats *could* be used as well, but no effort has been made to keep other formats working.

## Dependencies

The book build is only tested on a single linux system, please report any problems you encounter when building. The following software is needed:

* Asciidoctor 1.5.6.1 or later
* GNU Make
* Bash

Bash is only needed because of a hack to generate the web resources at the end of the book and the references to the resources. This will probably will be removed in future versions. But since most linux systems have bash by default, this should not cause problems.

## Build

### Single html file

To build the complete book as a single html file, run

```shell
make full
```

from the root folder of the repository. The resulting html file will be `build/grokking-bitcoin.html`

### Chunked html

To build a "chunked" version of the book, with one html file per chapter, run

```shell
make chunked
```

This will build one html file for each chapter and put them in the `build` directory with the names grokking-bitcoin-<X>.html, where X is the chapter number.

### Build all

To build both chunked and full versions:

```shell
make
```

## Book structure

The book is written using one `.adoc` file per chapter. There's a `grokking-bitcoin.adoc` file that collects all the different chapters into a complete book. This file is also used for defining global
attributes.

There are two css files that control the look of the book:

* `styles/asciidoctor.css` is the default css that ships with asciidoctor. Not to be edited.
* `styles/grokking-bitcoin.css` contains special css styling specific for this book. This file imports the `asciidoctor.css` file above.

All images are stored under `images` directory in a one directory per chapter structure. There is also a `images/common` directory that contains images that are used in multiple chapters. The format of images should be SVG, but exceptions may occur.

A script to find unused files is available in `images/findunused.sh`. Use that to search for image files that are not referenced from any `.adoc` file.


