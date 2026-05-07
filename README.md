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

Each assignment lives in its own directory (e.g. `hw1_sp26/`). Open the `.Rmd`
file in RStudio, replace the name and uniqname in the YAML header, and work
through the questions in place.

To produce the file you submit, click **Knit** in RStudio (or run
`rmarkdown::render("hw1_sp26/hw1_sp26.Rmd")`). Submit the knitted **PDF** on
Canvas.

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

- `hw1_sp26/` --- RMarkdown, AI tools, basic R, intro to plotting. Due Wed.

## Getting help

- Office hours and Piazza (see Canvas for links).
- The R help system (`?function_name`) and the [R for Data Science](https://r4ds.hadley.nz/) book.
- AI assistants like [UMGPT](https://umgpt.umich.edu) --- you are encouraged to
  use these as collaborators. We will talk in class about how to use them well.
