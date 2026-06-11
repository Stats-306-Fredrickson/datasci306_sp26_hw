# score_report.R
#
# A small pipeline that turns a vector of numeric exam scores into a
# letter-grade summary (a table of how many students earned each letter).
#
# There is exactly ONE bug. Calling score_report() on a vector of scores
# raises an error. The function the error points at may be
# behaving exactly as documented. Use debugging tools to figure out and 
# correct the error.

letter_grade <- function(score) {
  if (score >= 90) {
    "A"
  } else if (score >= 80) {
    "B"
  } else if (score >= 70) {
    "C"
  } else {
    "F"
  }
}

grade_one <- function(score) {
  letter_grade(score)
}

grade_all <- function(scores) {
  grade_one(scores)
}

score_report <- function(scores) {
  grades <- grade_all(scores)
  table(grades)
}
