# Grokking Bitcoin

This repository contains the Asciidoctor source code for Grokking
Bitcoin.

## About the open source version

Grokking Bitcoin is released in a commercial version and an open
source version. The content is the same in the two versions, but there
are some important differences between them:

The commercial version is available in various online book stores and
at
[Manning's website](https://www.manning.com/books/grokking-bitcoin). It
is professionally and _beautifully_ typeset and available as a print
book as well as ePub, Kindle, and PDF formats. We strongly recommend
to read the print version of this book. We have put a lot of hard work
into making the spreads into extensions of your short-term
memory. You'll have most of the neccesary information _right there_ in
the current spread.

The open source version (this repository), is where development of the
book has taken place and where improvements and corrections are
made. This repository will then serve as the basis for potential later
editions.

It's our hope that people will contribute bug reports, fixes, and
improvements while having fun doing it. Together we'll make this book
even better.

We also hope that people who can affort to buy the book will chose
that option over the open source version, because the reading
experience is _so_ much more awesome, but also to financially support
all the hard work Manning and I have put into this project.

We release the book open source for several reasons, among which the
most important are:

* We want _everyone_ to have access to top-class sources of Bitcoin
  information. This will strengthen Bitcoin as a system.
  
* We hope that we will get more feedback through bug reports,
  impovement proposals, etc through this repository.

* When people have the opportunity to browse the content before buying
  the book, they can better decide whether this book is for them or
  not. This will hopefully benefit sales.
  
* I (Kalle) have gotten so much out of Bitcoin, be it knowledge, jobs,
  lols, friends, excitement, and drama, so I think it's fair that I
  make my work available as a gesture of gratitude.
 
If you read the open source version, please consider giving the book a
review, for example on
[Amazon](https://www.amazon.com/Grokking-Bitcoin-Kalle-Rosenbaum/dp/1617294640).

## Build

The source is written to produce html output. Other target formats
*could* be used as well, but no effort has been made to keep them
working.

### Dependencies

The book build process is only tested on linux systems, please report
any problems you encounter when building. The following software is
needed:

* Asciidoctor >= 1.5.7 and < 2.0
* GNU Make
* pdfcrop (To crop .ai images)
* pdf2svg (To convert .ai images to svg)

If you're running Ubuntu 18.10 or Debian 10 (Buster) you can install
all these dependencies using:

```bash
sudo apt-get install asciidoctor make texlive-extra-utils pdf2svg
```

### Single html file

To build the complete book as a single html file, go to the root
folder of this repository and run

```shell
make full
```

The resulting html file will be `build/grokking-bitcoin.html`. This
html page will take approximately _forever_ to load in a web browser
(~116 MB of .svg images), but once loaded it's a nice page to use for
search and casual browsing.

### Chunked html

To build a "chunked" version of the book, with one html file per
chapter, run

```shell
make chunked
```

This will build one html file for each chapter and put them in the
`build` directory with the names grokking-bitcoin-&lt;X>.html, where X
is the chapter number (1-11), and grokking-bitcoin-app&lt;Y>.html,
where Y is the appendix number (1-3). The cross references between
chapters will not work in the chunked build, unfortunately.

### Build all

To build both chunked and full versions, run the default target `all`:

```shell
make
```

## Book structure

The book is written using one `.adoc` file per chapter. There's a
`grokking-bitcoin.adoc` file that `include`s all the different
chapters into a complete book. This file is also used for defining
global attributes.

There are two css files that control the look of the html page:

* `style/asciidoctor.css` is the default css that ships with
  Asciidoctor. It will be created by Asciidoctor automatically. Don't
  edit this file.
* `style/grokking-bitcoin.css` contains special css styling specific
  for this book. This file overrides styling in the `asciidoctor.css`
  file above.

All images are stored under `images` directory in a
one-directory-per-chapter structure. There is also a `images/common`
directory that contains images that are used in multiple chapters. The
format of images should be .ai (Adobe Illustrator), but exceptions do
occur. There is also a `style/images` directory, but those images are
considered to be part of the styling and not the content. All .ai
images will be converted to SVG by the build script.

A script to find unused files is available in
`images/findunused.sh`. Use that to search for image files that are
not referenced from any `.adoc` file.
