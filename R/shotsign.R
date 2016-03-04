#' Peter Beshai's Shooting Signatures
#' 
#' Create shooting signatures plots using R and d3.js.  Although originally
#' designed for basketball (see
#' \href{https://gist.github.com/pbeshai/ffd0f9d84b4e8df27db2}{discussion}), 
#' these plots can be used for various data sources.
#' 
#' @param data \code{data.frame} with data to plot
#' @param xdomain two element array representing the domain for the \code{x}
#'   scale.  If NULL, defaults to \code{range(data$x)}.
#' @param ydomain two element array representing the domain for the \code{y}
#'   scale.  If NULL, defaults to \code{range(data$y)}.
#' @param wdomain two element array representing the domain for the \code{width}
#'   scale.  If NULL, defaults to \code{range(data$widthValue)}.
#' @param colordomain two element array representing the domain for the
#'   \code{color} scale.  If NULL, defaults to \code{range(data$colorValue)}.
#' @param width,height valid \code{CSS} unit for the height and width of the
#'   htmlwidget container \code{div}
#' @param elementId \code{character} for a custom \code{id}
#'   
#' @example inst/examples/examples.R
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
  width = NULL, height = NULL,
  elementId = NULL
) {
  
  # defaults to range of each variable
  if(is.null(xdomain)) xdomain = range(data[["x"]])
  if(is.null(ydomain)) ydomain = range(data[["y"]])
  if(is.null(wdomain)) wdomain = range(data[["widthValue"]])
  if(is.null(colordomain)) colordomain = range(data[["colorValue"]])

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
    package = 'shotsignR',
    elementId = elementId
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
