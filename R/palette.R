#' Clean colors
#'
#' @name clean_colors
#' @export
clean_colors <- list(
  blue = "#1F4E79",
  red = "#D00000",
  gold = "#C49500",
  green = "#517D33",
  purple = "#9B4F96",
  cyan = "#00A3AD",
  salmon = "#FF5733",
  pink = "#FFB6C1",
  tan = "#F2D49B",
  light_blue = "#C7E5F0",
  light_red = "#F8766D",
  light_brown = "#C49A6C",
  turquoise = "#53B3CB",
  lime = "#00BA38",
  light_orange = "#FC8D62",
  light_purple = "#8DA0CB",
  mint = "#66C2A5",
  lavender = "#E78AC3",
  light_green = "#A6D854",
  dark_orange = "#FF7F00",
  light_pink = "#FB9A99",
  pale_lavender = "#BEBADA",
  light_mint = "#CCEBC5",
  pale_pink = "#FFC0CB",
  gray = "#D9D9D9",
  dark_purple = "#BC80BD",
  pale_yellow = "#CEDB9C",
  light_yellow = "#FFFFB3"
)

#' Clean color palette
#'
#' @param n Number of colors
#' @param colors Named list of colors
#' @param type Discrete or continuous scale
#' @param order Colors to move to the front
#'
#' @return Clean palette object
#' @export
clean_palette = function(n, colors = clean_colors, type = c("discrete", "continuous"), order = NULL) {
  if(is.null(colors)){
    colors <- clean_colors
  }

  if (!is.null(order)) {
    ordered_colors <- unlist(colors[order])
    remaining_colors <- unlist(colors[setdiff(names(colors), order)])
    colors <- as.vector(c(ordered_colors, remaining_colors))
  } else {
    colors <- as.vector(unlist(colors))
  }

  if (missing(n)) {
    n <- length(colors)
  }
  type <- match.arg(type)
  out <- switch(
    type,
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
