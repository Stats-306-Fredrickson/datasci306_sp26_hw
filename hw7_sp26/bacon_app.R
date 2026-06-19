library(shiny)
library(tidyverse)
library(DBI)
library(duckdb)

# ---- Database & Helpers (do not modify) ----
#
# The game's data lives in a Parquet file, and DuckDB queries that file DIRECTLY
# (FROM 'data/movie_actors.parquet') -- nothing is imported into the database. Each
# helper below answers a question with a SQL query against the file, including
# the co-star self-join you wrote in Question 2, now powering a live app.

con <- dbConnect(duckdb::duckdb(), ":memory:")        # the engine; no tables stored
onStop(function() dbDisconnect(con, shutdown = TRUE)) # close the connection on exit

# get_movies(): an actor's movies, oldest first. The release year is pulled out
# of the "Title (YYYY)" suffix with regexp_extract, right in the query.
get_movies <- function(actor_name) {
  dbGetQuery(con, "
    SELECT movie
    FROM 'data/movie_actors.parquet'
    WHERE actor = ?
    ORDER BY TRY_CAST(regexp_extract(movie, '(\\d{4})\\)$', 1) AS INTEGER), movie",
    params = list(actor_name))$movie
}

# get_cast(): the actors in a movie.
get_cast <- function(movie_name) {
  dbGetQuery(con, "
    SELECT actor FROM 'data/movie_actors.parquet'
    WHERE movie = ?
    ORDER BY actor",
    params = list(movie_name))$actor
}

# Every actor except Kevin Bacon, and how many movies each is in (used to weight
# the random starting actors toward more recognizable names).
non_bacon_actors <- dbGetQuery(con, "
  SELECT DISTINCT actor FROM 'data/movie_actors.parquet'
  WHERE actor <> 'Kevin Bacon'
  ORDER BY actor")$actor

actor_weights <- dbGetQuery(con, "
  SELECT COUNT(*) AS n FROM 'data/movie_actors.parquet'
  WHERE actor <> 'Kevin Bacon'
  GROUP BY actor
  ORDER BY actor")$n

# ---- UI (do not modify) ----

ui <- fluidPage(
  titlePanel("Six Degrees of Kevin Bacon"),
  sidebarLayout(
    sidebarPanel(
      actionButton("new_game", "New Game"),
      hr(),
      textOutput("step_display"),
      hr(),
      radioButtons("selection", "Make a choice:", choices = c("Click 'New Game' to start")),
      actionButton("choose", "Select")
    ),
    mainPanel(
      h4("Your Path"),
      htmlOutput("path_display"),
      hr(),
      h3(textOutput("result_message"))
    )
  )
)

# ---- Server ----

server <- function(input, output, session) {

  # Game state -- use these reactive values in your TODOs below.
  # - active: TRUE while a game is in progress
  # - phase: "actor" when the player is choosing an actor,
  #          "movie" when choosing a movie
  # - step: number of actors selected so far (0 to 6)
  # - path: character vector of the trail, alternating actor/movie names
  # - visited: character vector of actors already chosen (to exclude from casts)
  # - visited_movies: character vector of movies already chosen (to exclude
  #   from future movie option lists)
  # - won / lost: flags for game outcome
  game <- reactiveValues(
    active = FALSE,
    phase  = "actor",
    step   = 0L,
    path   = character(),
    visited = character(),
    visited_movies = character(),
    won    = FALSE,
    lost   = FALSE
  )

  # Step counter display (do not modify)
  output$step_display <- renderText({
    if (!game$active && !game$won && !game$lost) return("")
    paste0("Step ", game$step, " of 6")
  })

  # ============================================================
  # TODO 1: New Game button
  # ============================================================
  # When input$new_game is clicked:
  #   - Set game$active to TRUE, game$won and game$lost to FALSE
  #   - Reset game$step to 0, game$path, game$visited, and game$visited_movies
  #     to empty character()
  #   - Set game$phase to "actor"
  #   - Sample 5 actors from non_bacon_actors with probability proportional
  #     to their number of movies. Pass prob = actor_weights to sample().
  #   - Use updateRadioButtons() to set those actors as the choices for
  #     the "selection" input. The syntax is:
  #       updateRadioButtons(session, "selection", choices = your_vector)



  # ============================================================
  # TODO 2: Select button (main game logic)
  # ============================================================
  # When input$choose is clicked:
  #   Use req(game$active, input$selection) to guard the handler.
  #
  #   If game$phase == "actor":
  #     - Add the chosen actor (input$selection) to game$path and game$visited
  #     - Increment game$step by 1
  #     - If the chosen actor is "Kevin Bacon": set game$won to TRUE,
  #       game$active to FALSE, and return()
  #     - If game$step >= 6: set game$lost to TRUE, game$active to FALSE,
  #       and return()
  #     - Otherwise: get the actor's movies using get_movies(), remove any
  #       already-visited movies with setdiff(movies, game$visited_movies),
  #       update the radio buttons with updateRadioButtons(), and set
  #       game$phase to "movie". (Note: get_movies() already returns movies
  #       sorted by release year, so the options appear in chronological order.)
  #
  #   If game$phase == "movie":
  #     - Add the chosen movie (input$selection) to game$path AND to
  #       game$visited_movies
  #     - Get the cast using get_cast()
  #     - Remove already-visited actors with setdiff(cast, game$visited)
  #     - Update the radio buttons with the filtered cast
  #     - Set game$phase to "actor"



  # ============================================================
  # TODO 3: Path display
  # ============================================================
  # Render the path as formatted HTML using renderUI().
  #   - If game$path is empty, show: tags$p(tags$em("No moves yet."))
  #   - Otherwise, loop through game$path:
  #       - Odd-indexed entries are actors: wrap in tags$strong()
  #       - Even-indexed entries are movies: wrap in tags$em()
  #     Separate entries with arrows: HTML(" &rarr; ")
  #   - Combine everything with do.call(tagList, ...)
  output$path_display <- renderUI({
    tags$p(tags$em("No moves yet."))
  })

  # ============================================================
  # TODO 4: Result message
  # ============================================================
  # Use renderText() to show:
  #   - If game$won: a message like "You found Kevin Bacon in X steps!"
  #     and the Bacon number (game$step)
  #   - If game$lost: "Game over! You didn't reach Kevin Bacon in 6 steps."
  #   - Otherwise: "" (empty string)
  output$result_message <- renderText({
    ""
  })
}

shinyApp(ui, server)
