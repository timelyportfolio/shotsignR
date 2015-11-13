#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
shotsign <- function(
  data,
  xdomain = NULL,
  ydomain = NULL,
  wdomain = NULL,
  colordomain = NULL,
  width = NULL, height = NULL
) {
  
  #set up defaults to work with basketball shot data
  if(is.null(xdomain)) xdomain = c(0,30)
  if(is.null(ydomain)) ydomain = c(0,1)
  if(is.null(wdomain)) wdomain = c(0,250)
  if(is.null(colordomain)) colordomain = c(-0.15,0.15)

  # forward options using x
  x = list(
    data = data,
    xdomain = xdomain, 
    ydomain = ydomain,
    wdomain = wdomain,
    colordomain = colordomain
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
  htmlwidgets::shinyWidgetOutput(outputId, 'shotsign', width, height, package = 'shotsignR')
}

#' @rdname shotsign-shiny
#' @export
renderShotsign <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, shotsignOutput, env, quoted = TRUE)
}
