#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
shotsign <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'shotsign',
    x,
    width = width,
    height = height,
    package = 'shotsignR'
  )
}

#' Shiny bindings for shotsign
#'
#' Output and render functions for using shotsign within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a shotsign
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name shotsign-shiny
#'
#' @export
shotsignOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'shotsign', width, height, package = 'shotsignR')
}

#' @rdname shotsign-shiny
#' @export
renderShotsign <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, shotsignOutput, env, quoted = TRUE)
}
