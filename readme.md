# Grokking Bitcoin

This repository contains the [Asciidoctor](https://asciidoctor.org) source
code for Grokking Bitcoin.

## About the open source version

Grokking Bitcoin is released in a commercial version and an open
source version. The content is the same in the two versions, but there
are some important differences between them:

The commercial version is available in various online book stores and
at
[Manning’s website](https://www.manning.com/books/grokking-bitcoin). It
is professionally and _beautifully_ typeset and available as a print
book as well as ePub, Kindle, and PDF formats, all DRM-free. We
strongly recommend to read the print version of this book. We have put
a lot of hard work into making the spreads into extensions of your
short-term memory. You’ll have most of the necessary information
_right there_ in the current spread.

The open source version (this repository), is where development of the
book has taken place and where improvements and corrections are
made. This repository will also serve as the basis for potential later
editions.

It’s our hope that people will contribute bug reports, fixes, and
improvements while having fun doing it. Together we’ll make this book
even better.

We also hope that people who can afford to buy the book will chose
that option over the open source version, because the reading
experience is _so_ much more awesome, but also to financially support
all the hard work Manning and I have put into this project.

We release the book open source for several reasons, among which the
most important are:

* We want _everyone_ to have access to top-class sources of Bitcoin
  information. This will strengthen Bitcoin as a system.
  
* We hope that we will get more feedback through bug reports,
  improvement proposals, etc through this repository.

* When people have the opportunity to browse the content before buying
  the book, they can better decide whether this book is for them or
  not. This will hopefully benefit sales.
  
* I (Kalle) have gotten so much out of Bitcoin, be it knowledge, jobs,
  lols, friends, excitement, and drama, so I think it’s fair that I
  make my work available as a gesture of gratitude.

If you read the open source version, please consider giving the book a
review, for example on
[Amazon](https://www.amazon.com/Grokking-Bitcoin-Kalle-Rosenbaum/dp/1617294640).

## Build

The source is written to produce HTML5 output. Other target formats
_might_ work as well, but no effort has been made to keep them
working.

### Dependencies

* Asciidoctor >= 1.5.7 and < 2.0 or >= 2.0.12
* GNU Make
* Inkscape >= 1.0.2
* Fonts:
  * [FreeMono](https://ftp.gnu.org/gnu/freefont/freefont-ttf-20120503.zip)
  * Arial
  * Humanst521 Cn BT (see section Fonts below)

#### Linux

If you’re running Ubuntu 18.10 or Debian 11 you can install all these
dependencies (but see below for Inkscape), except Arial and Humanst521
Cn BT using:

```shell
sudo apt-get install asciidoctor make fonts-freefont-ttf inkscape
```

On other systems, asciidoctor may not exist as a package in your Linux
distribution, in which case you’ll have to install it in some other
way, for example via ruby `gem` on debian 11:

```shell
sudo apt install ruby-rubygems
sudo gem install asciidoctor --version 2.0.17
```

If you run an Ubuntu version earlier than 21.10, your version of
Inkscape is too old. If so, you can install Inkscape using a ppa as
described on their
[web page](https://inkscape.org/release/inkscape-1.0.2/gnulinux/ubuntu/ppa/dl/).

Please report any problems you encounter when building.

#### macOS

Assuming you already have [Homebrew](https://brew.sh), you need to install the following dependencies:

```shell
brew install asciidoctor inkscape
```

Then, FreeFont Mono needs to be downloaded and put in the fonts folder,

```shell
wget -qO- https://ftp.gnu.org/gnu/freefont/freefont-ttf-20120503.zip | tar -xq freefont-20120503/FreeMono.ttf
mv freefont-20120503/FreeMono.ttf ~/Library/Fonts/ && rmdir freefont-20120503
```

#### Fonts

In order to generate images that will display correctly on any web
browser, that’s independent on system-installed fonts on the reader’s
machine, you need to have the fonts _FreeMono_, _Arial_, and
_Humanst521 Cn BT_ installed on your system. If you don’t have them,
your images will be generated using similarly looking fonts, which may
or may not result in bad looking images.

To give a little background, the images were originally created by
Manning (publisher) in Adobe Illustrator on macOS. They chose Arial
and Humanst521 Cn BT because they thought they looked good and they
had access to them on their machines. Unfortunately, these fonts
aren’t free to use as we please. In the future I aim to replace those
fonts as follows:

* Arial -> Liberation Sans or Nimbus Sans
* Humanst521 Cn BT -> Don’t know yet. Maybe Nimbus Sans Narrow, Bold

Until then I leave it up to you to install the needed fonts as you
please. 'Humanst521 Cn BT' is apparently licensed as "Free For
Personal Use", but I’m not allowed to redistribute it. You can
download it from a lot of web sites.

Arial is supplied with macOS, and can usually be installed on Debian/Ubuntu by
using the non-free package `ttf-mscorefonts-installer`, eg `sudo apt install
ttf-mscorefonts-installer`.

### Single HTML file

To build the complete book as a single HTML file, go to the root folder of this
repository and run

```shell
make full
```

The resulting HTML file will be `build/grokking-bitcoin.html`. This
HTML page will take approximately _forever_ to load in a web browser
(~100 MB of .svg images), but once loaded it’s a nice page to use for
search and casual browsing.

### Chunked HTML

To build a "chunked" version of the book, with one HTML file per
chapter, run

```shell
make chunked
```

This will build one HTML file for each chapter and put them in the
`build` directory with the names grokking-bitcoin-&lt;X>.html, where X
is the chapter number (1-11), and grokking-bitcoin-app&lt;Y>.html,
where Y is the appendix number (1-3). The front matter will be named
grokking-bitcoin-fm.html. The cross references between chapters will
not work in the chunked build, unfortunately.

### Build all

To build both chunked and full versions, run the default target `all`:

```shell
make
```

## Book structure

The book is written using one `.adoc` file per chapter. There’s a
`grokking-bitcoin.adoc` file that includes all the different chapter
files into a complete book. This file is also used for defining global
attributes.

There are two css files that control the look of the HTML page:

* `style/asciidoctor.css` is the default css that ships with
  Asciidoctor. It will be created by Asciidoctor automatically. Don’t
  edit this file.
* `style/grokking-bitcoin.css` contains special css styling specific
  for this book. This file overrides styling in the `asciidoctor.css`
  file above.

All images are stored under `images` directory in a
one-directory-per-chapter structure. There is also a `images/common`
directory that contains images that are used in multiple chapters. The
format of images should be .svg, but exceptions do occur. The images
found under `style/images` are considered to be part of the styling
and not the content.

A script to find unused files is available in
`images/findunused.sh`. Use that to search for image files that are
not referenced from any `.adoc` file. It does require that you have
built the book prior to running the script.

## Translations

The book is prepared for translations through the use of `.po` files
and a `grokking-bitcoin.pot` file. A `.po` file, for example
`po4a/po/de_DE.po`, is the file that contains all the translated
strings. The `.pot` file is a template for `.po` files. A new
translation is created by copying the `.pot` file into a `.po` file,
for example `sv_SE.po` and then edit the `.po` file. There are several
tools available for editing `.po` files.

I have setup a
[project on Transifex](https://www.transifex.com/none-684/grokking-bitcoin/dashboard/),
which is an online translation tool. The German and Finnish
translations were successfully made using this tool.

Apart from the `.po` files you also need to edit all images that
contains textual content. I recommend using the open source tool
Inkscape to edit the .svg images.

### Build translation

When a `.po` file is ready, or when you want to test a partially
finished `.po` file, let’s call it `sv_SE.po` you need to put it in
the folder `lang/po4a/po`.

Some meta words, typically "figure", "chapter", etc, that are used by
asciidoctor to generate meta content, are translated in separate files
under `lang/locale/attributes-<LANG>.adoc`. For example
`lang/locale/attributes-de_DE.adoc` for the German
translation. Asciidoctor ships with a predefined set of such files for
various languages under `<asciidoctor_installation>/data/locale`. They
are typically named without country code, for example
`attributes-de.adoc`. Copy and rename the one for your language into
`lang/locale`, eg

```shell
cp /path/to/asciidoctor/data/locale/attributes-sv.adoc /path/to/grokkingbitcoin/lang/locale/attributes-sv_SE.adoc
```

You may also modify the translations in this file to your liking. To build the Swedish translation, run:

```shell
make sv_SE
```

The resulting translation can then be found under `build/lang/de_DE/build/`.
