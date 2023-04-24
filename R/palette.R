
clean_colors <- c("#1F4E79", "#D00000", "#C49500", "#517D33",
                  "#9B4F96", "#00A3AD", "#FF5733", "#FFB6C1",
                  "#F2D49B", "#C7E5F0")

#' Clean color palette
#'
#' @param n Number of colors
#' @param colors Vector of colors
#' @param type Discrete or continuous scale
#'
#' @return Clean palette object
#' @export
clean_palette = function(n, colors = clean_colors, type = c("discrete", "continuous")) {
  if (missing(n)) {
    n = length(colors)
  }
  type = match.arg(type)
  out = switch(type,
               continuous = grDevices::colorRampPalette(colors)(n),
               discrete = colors[1:n]
  )
  structure(out, class = "palette")
}

#' Clean manual color scale for ggplots
#'
#' @import ggplot2
#' @return Clean manual color scale
#' @export
scale_color_clean <- function(){
  ggplot2::scale_colour_manual(values = clean_palette(type = "discrete"))
}

#' Clean manual fill scale for ggplots
#'
#' @import ggplot2
#' @return Clean manual fill scale
#' @export
scale_fill_clean <- function(){
  ggplot2::scale_fill_manual(values = clean_palette(type = "discrete"))
}
