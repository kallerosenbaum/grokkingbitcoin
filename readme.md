# Grokking Bitcoin instructions

This repository contains the source code for Grokking Bitcoin. The book is written to produce html output. Other target formats *could* be used as well, but no effort has been made to keep other formats working.

## Dependencies

The book build is only tested on a single linux system, please report any problems you encounter when building. The following software is needed:

* Asciidoctor 1.5.7 or later
* GNU Make (Not stictly needed, but convenient. See below how to build without it)

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

This will build one html file for each chapter and put them in the `build` directory with the names grokking-bitcoin-<X>.html, where X is the chapter number. The cross references between chapters will not work in chunked build so this is only a tool to be used for development purposes.

### Build all

To build both chunked and full versions:

```shell
make
```

### Build without GNU Make

If you don't have GNU Make, you can still build the html book by using `asciidoctor` directly:

```shell
asciidoctor -b html5 grokking-bitcoin.adoc
```

This will build the full book in a single html file. To build an individual chapter, for example chapter 4, run:

```shell
asciidoctor -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$((4-1)) -a ch4 -b html5 grokking-bitcoin.adoc -o grokking-bitcoin-4.html
```

To build another chapter, replace each occurance of `4` with your desired chapter number. You can also consult `Makefile` to learn how to build chapters and the full book.

## Book structure

The book is written using one `.adoc` file per chapter. There's a `grokking-bitcoin.adoc` file that collects all the different chapters into a complete book. This file is also used for defining global attributes.

There are two css files that control the look of the book:

* `styles/asciidoctor.css` is the default css that ships with asciidoctor. It will be created by by asciidoctor automatically. Not to be edited.
* `styles/grokking-bitcoin.css` contains special css styling specific for this book. This file overrides styling in the `asciidoctor.css` file above.

All images are stored under `images` directory in a one directory per chapter structure. There is also a `images/common` directory that contains images that are used in multiple chapters. The format of images should be SVG, but exceptions may occur. There is also an `style/images` directory, but those images are considered to be part of the styling and not the content.

A script to find unused files is available in `images/findunused.sh`. Use that to search for image files that are not referenced from any `.adoc` file.
