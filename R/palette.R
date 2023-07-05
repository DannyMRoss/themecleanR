# Colors for clean palette
clean_colors <- c("#1F4E79", "#D00000", "#C49500", "#517D33",
                  "#9B4F96", "#00A3AD", "#FF5733", "#FFB6C1",
                  "#F2D49B", "#C7E5F0","#F8766D", "#C49A6C",
                  "#53B3CB", "#00BA38", "#FC8D62", "#8DA0CB",
                  "#66C2A5", "#E78AC3", "#A6D854", "#FF7F00",
                  "#B2DF8A", "#33A02C", "#FB9A99", "#BEBADA",
                  "#CCEBC5", "#FFC0CB", "#D9D9D9", "#BC80BD",
                  "#CEDB9C", "#FFFFB3")

#' Clean color palette
#'
#' @param n Number of colors
#' @param colors Vector of colors
#' @param type Discrete or continuous scale
#'
#' @return Clean palette object
#' @export
clean_palette = function(n, colors = clean_colors, type = c("discrete", "continuous")) {
  if (is.null(colors)){
    colors <- clean_colors
  }
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
#' @param colors Override colors
#' @return Clean manual color scale
#' @export
scale_color_clean <- function(colors){
  ggplot2::scale_colour_manual(values = clean_palette(colors=colors, type = "discrete"))
}

#' Clean manual fill scale for ggplots
#'
#' @import ggplot2
#' @param colors Override colors
#' @return Clean manual fill scale
#' @export
scale_fill_clean <- function(colors){
  ggplot2::scale_fill_manual(values = clean_palette(colors=colors, type = "discrete"))
}
