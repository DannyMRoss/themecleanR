#' Clean a ggplot
#'
#' @param grid Add x- and y-axis grid lines
#' @param x_lines Add x-axis vertical grid lines
#' @param y_lines Add y-axis horizontal grid lines
#' @param legend_position Change legend position
#' @param plot_margin_in Plot margin (inches)
#' @param caption_margin Caption margin (inches)
#' @param title_margin Title margin (inches)
#' @param subtitle_margin Subtitle margin (inches)
#' @param borderizer Margins so plot fits in LaTeX borderizer
#' @param font Font name
#' @param text_size Default text size for axes (points)
#' @param title_size Title size (points)
#' @param subtitle_size Subtitle size (points)
#' @param caption_size Subtitle size (points)
#' @param legend_title_size Legend title size (points)
#' @param legend_title_face Legend title font face ("plain", "bold", "italic", or "bold.italic")
#' @param text_color Text color
#' @param grid_color Grid line color
#' @param no_axis Remove axis lines and ticks
#' @param axis_label_face Axis label font face ("plain", "bold", "italic", or "bold.italic")
#' @param axis_line_width Axis line width
#' @param grid_line_width Grid line width
#' @param x_axis_label_angle X-axis label angle
#'
#' @return
#' @export
#'
#' @examples
theme_clean <- function(grid=FALSE,
                          x_lines=FALSE,
                          y_lines=FALSE,
                          legend_position="bottom",
                          plot_margin_in=0.5,
                          caption_margin=0.25,
                          title_margin=0,
                          subtitle_margin=0.25,
                          borderizer=FALSE,
                          font="sans",
                          text_size=14,
                          title_size=18,
                          subtitle_size=16,
                          caption_size=11,
                          legend_title_size=14,
                          legend_title_face="plain",
                          text_color="black",
                          grid_color="#D3D3D3",
                          no_axis=FALSE,
                          axis_label_face="plain",
                          axis_line_width=0.5,
                          grid_line_width=0.1,
                          x_axis_label_angle=0){

  if (borderizer==TRUE){
    subtitle_margin = 0.3
    plot_margin_in = 0.5
    title_margin = 0.55
  }

  t <- theme(text=element_text(size=text_size, family=font, colour=text_color),
             plot.title = element_text(hjust=0.5, face="bold", size=title_size, margin=margin(t=title_margin, unit="in")),
             plot.subtitle = element_text(hjust=0.5, face="italic", size=subtitle_size, margin=margin(b=subtitle_margin, unit="in")),
             plot.caption = element_text(hjust=0.5, size=caption_size, margin=margin(t=caption_margin, unit="in")),
             axis.text = element_text(colour=text_color, face=axis_label_face),
             axis.text.x = element_text(colour=text_color, face=axis_label_face, angle=x_axis_label_angle),
             axis.line = element_line(linewidth=axis_line_width, color=text_color),
             axis.title = element_text(face="bold"),
             plot.background = element_blank(),
             panel.background = element_blank(),
             panel.grid.major = element_blank(),
             panel.grid.minor = element_blank(),
             panel.border = element_blank(),
             strip.background = element_rect(fill=NA),
             strip.text = element_text(face="bold", colour=text_color),
             legend.title = element_text(face=legend_title_face, size=legend_title_size),
             legend.position = legend_position,
             legend.text = element_text(colour = text_color),
             legend.background = element_rect(fill=NA),
             legend.key = element_rect(fill=NA),
             plot.margin = margin(plot_margin_in, plot_margin_in, plot_margin_in, plot_margin_in, unit="in"))

  if (grid==TRUE){
    t <- t + theme(panel.grid.major=element_line(color=grid_color, linewidth=grid_line_width),
                   panel.grid.minor=element_line(color=grid_color, linewidth=grid_line_width))
  }

  if (x_lines==TRUE){
    t <- t + theme(panel.grid.major.x=element_line(color=grid_color, linewidth=grid_line_width),
                   panel.grid.minor.x=element_line(color=grid_color, linewidth=grid_line_width))
  }

  if (y_lines==TRUE){
    t <- t + theme(panel.grid.major.y=element_line(color=grid_color, linewidth=grid_line_width),
                   panel.grid.minor.y=element_line(color=grid_color, linewidth=grid_line_width))
  }

  if (no_axis==TRUE){
    t <- t + theme(axis.line=element_blank(), axis.ticks = element_blank())
  }

  return(t)
}
