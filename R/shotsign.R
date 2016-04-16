#' Peter Beshai's Shooting Signatures
#' 
#' Create shooting signatures plots using R and d3.js.  Although originally
#' designed for basketball (see
#' \href{https://gist.github.com/pbeshai/ffd0f9d84b4e8df27db2}{discussion}), 
#' these plots can be used for various data sources.
#' 
#' @param data \code{data.frame} with data to plot
#' @param xdomain two element array representing the domain for the \code{x}
#'   scale
#' @param ydomain two element array representing the domain for the \code{y}
#'   scale
#' @param wdomain two element array representing the domain for the \code{width}
#'   scale
#' @param colordomain two element array representing the domain for the
#'   \code{color} scale
#' @param width,height valid \code{CSS} unit for the height and width of the
#'   htmlwidget container \code{div}
#' @param margin named list of margins for plotting window.  For more details,
#'   see \href{http://bl.ocks.org/mbostock/3019563}{Mike Bostock's explanation}
#' @param ylab the label for the y axis
#' @param xlab the label for the x axis
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
  margin = list(top = 20, right = 10, bottom = 20, left = 30), 
  ylab = "y", 
  xlab = "x", 
  elementId = NULL
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
    colordomain = colordomain, 
    margin = margin, 
    ylab = ylab, 
    xlab = xlab
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
