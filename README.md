# DATASCI 306, Spring 2026

Homework assignments for **DATASCI 306: Introduction to Statistical Computing**,
University of Michigan, Spring 2026 (short term).

## Getting the assignments

You will pull updates to this repository as new assignments are released. From
your local copy:

```sh
git pull
```

If you have not yet cloned the repo, do so once with:

```sh
git clone <repo url>
```

## Working on a homework

**Always open `datasci306_sp26.Rproj` first** (double-click it in your file
browser, or use `File -> Open Project...` in RStudio). This sets the working
directory to the repo root and ensures that data files load correctly on every
operating system, including Windows.

Once the project is open, navigate to the homework directory (e.g. `hw1_sp26/`)
in the **Files** pane, open its `.Rmd` file, replace the name and uniqname in
the YAML header, and work through the questions in place.

To produce the file you submit, click **Knit** in RStudio. Submit the knitted
**PDF** on Canvas.

## Required packages

The assignments use the `tidyverse` family of packages. Install once:

```r
install.packages("tidyverse")
```

Individual assignments may load additional packages; install those as needed.

## Grading

Most assignments use a two-part scheme:

- **Code questions** are graded on completion. Attempt every part in good faith;
  code that runs and shows you engaged with the question earns full credit.
- **Reflection** at the end of each assignment is graded on the substance of
  your answers. This is where careful thinking pays off.

## Assignments

- `hw1_sp26/` --- RMarkdown, AI tools, basic R, intro to plotting. Due Wed May
  13

## Getting help

- Office hours and help desk (see Canvas for links).
- The R help system (`?function_name`) and the
  [R for Data Science](https://r4ds.hadley.nz/) book.
- AI assistants like [UMGPT](https://umgpt.umich.edu) --- you are encouraged to
  use these as collaborators. We will talk in class about how to use them well.
