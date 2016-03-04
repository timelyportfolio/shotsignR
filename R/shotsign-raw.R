#' Exploratory visualization for 3 Quantitative Variables
#' 
#' @param data \code{data.frame} with data to plot
#' @param x the variable to plot on the x axis.  This should be the unquoted 
#'   name of the column in \code{data} containing the x values.
#' @param y the variable to plot on the y axis.  This should be the unquoted 
#'   name of the column in \code{data} containing the y values.
#' @param color the variable to use to color the plot.  This should be the 
#'   unquoted name of the column in \code{data} containing the color values.
#' @param ... additional arguments passed to \code{\link{shotsign}}.
#' @details Estimates the density of \code{x} using \code{\link{density}}. 
#'   \code{density(x)$x} will be used as the x values in \code{\link{shotsign}},
#'   and \code{density(x)$y} will be used as the width values.
#'   
#'   Fits Generalized Additive Models (GAMs) for \code{y} and \code{color} using
#'   \code{\link[mgcv]{gam}}.  These models are specified as \code{gam(y ~ s(x,
#'   bs = "ts", k = 7))} and the predictions are used to generate the y and
#'   color values for \code{shotsign}.
#' @seealso shotsign
#' @export
#' @examples 
#' shotsign_raw(iris, x = Sepal.Length, y = Sepal.Width, color = Petal.Length, 
#'              xdomain = c(4, 8), ydomain = c(2, 4.5), wdomain = c(1, 2), colordomain = c(1, 7))
shotsign_raw <- function(data, x, y, color, ...) {
  # extracting the x, y, color variables from data
  # see http://adv-r.had.co.nz/Computing-on-the-language.html#capturing-expressions for more details
  x <- data[[deparse(substitute(x))]]
  y <- data[[deparse(substitute(y))]]
  color <- data[[deparse(substitute(color))]]
  
  # a kernel density estimate of x
  x_density <- density(x)
  # a nonlinear model for y ~ x
  y_model <- mgcv::gam(y ~ s(x, bs = "ts", k = 7), 
                       data = list(y = y, x = x))
  # a nonlinear model for color ~ x
  color_model <- mgcv::gam(color ~ s(x, bs = "ts", k = 7), 
                           data = list(color = color, x = x))
  
  # extracting x and width values from the density estimate
  new_data <- data.frame(x = x_density$x, widthValue = x_density$y)
  # predicting y and color from the fitted models
  new_data$y <- predict(y_model, newdata = data.frame(x = x_density$x))
  new_data$colorValue <- predict(color_model, newdata = data.frame(x = x_density$x))
  
  shotsign(new_data, ...)
}
