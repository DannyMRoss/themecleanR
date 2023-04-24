#' Clean a ggplot
#'
#' @param grid
#' @param x_lines
#' @param y_lines
#' @param legend_position
#' @param plot_margin_in
#' @param plot_margin_top_in
#' @param caption_margin
#' @param title_margin
#' @param subtitle_margin
#' @param borderizer
#' @param font
#' @param text_size
#' @param title_size
#' @param subtitle_size
#' @param caption_size
#' @param legend_title_size
#' @param legend_title_face
#' @param text_color
#' @param grid_color
#' @param no_axis
#' @param axis_label_face
#' @param axis_line_width
#' @param grid_line_width
#' @param x_axis_label_angle
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
                          plot_margin_top_in=0.5,
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
             plot.margin = margin(plot_margin_top_in, plot_margin_in, plot_margin_in, plot_margin_in, unit="in"))

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
