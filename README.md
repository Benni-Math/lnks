# lnks

`lnks` allows you to search through and open browser bookmarks on the command line. Use it for yourself or to share important bookmarks with your team.

![lnks demo](/demo/demo.gif)

All credit to [Ham Vocke](https://github.com/hamvocke), I just wrapped this in a Nix flake for portability. Check out [his blog post](https://www.hamvocke.com/blog/lnks-command-line-bookmarks/) and [his repository](https://github.com/hamvocke/lnks/tree/main) for more details.

## Setup

Before you can get started, you've got to set up a few things once.

### 1. Install via Nix

Install Nix and enable flakes, then simply run

```sh
nix profile install Benni-Math/lnks
```

### 2. Add your bookmarks

You can open a specific bookmark file via the `open` subcommand:

```
lnks open bookmarks.txt
```

By default, these files will be storied (and queried from) `~/.bookmarks/`, but you can change this directory by setting the `$BOOKMARK_DIR` environment variable.

Following the pattern in `bookmarks.txt` add all your bookmarks into one (or many) `.txt` files next to `lnks.sh`.

Like this:

```txt
My bookmark https://example.com
Stack Overflow https://stackoverflow.com
lnks Git Repository https://github.com/hamvocke/lnks
```

The rules:

* One bookmark per line
* Each line consists of a searchable name and a URL
* The URL goes last and is separated from the searchable name with a `space`
* The file needs to have the `.txt` extension
* You can have as many `.txt` files in your `$BOOKMAR_DIR` as you want

## Usage

1. Run `lnks`
2. Type to run a fuzzy search against the names of your bookmarks
3. Use arrow keys to navigate up and down
4. Hit `Enter` to open a bookmark in your browser


```
Usage: lnks.sh [OPTIONS...]
  -k        --keep-open     Keep lnks open after selecting a bookmark
  -d <dir>  --dir <dir>     Specify a directory where bookmarks files are stored
```

## Working with a team

`lnks` works well for software development teams. Use it to share a well-known list of bookmarks to your production and staging systems, your build pipelines, your bug tracker, important observability dashboards or whatever else might be relevant for your day to day work.

Fork this repo, set the `$BOOKMARK_DIR` environment variable to its location locally, add all your team's important URLs to a text file, and share the git repo with your team. Team members can add, update and remove bookmarks and check them back in to your shared repository to ensure that everyone's got up to date bookmarks to important URLs and systems.
