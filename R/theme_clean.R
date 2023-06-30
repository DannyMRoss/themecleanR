#' Clean a ggplot
#'
#' @import ggplot2
#' @import extrafont
#' @import scales
#' @importFrom grDevices cairo_pdf dev.off
#'
#' @param p ggplot object
#' @param grid Add x- and y-axis grid lines
#' @param xlines Add x-axis vertical grid lines
#' @param ylines Add y-axis horizontal grid lines
#' @param legend_position Change legend position
#' @param plot_margin_in Plot margin (inches)
#' @param caption Caption as a vector, each element appears on new line
#' @param caption_title Caption title
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
#' @param legend_item_size Legend item size
#' @param legend_rows Number of legend rows
#' @param text_color Text color
#' @param grid_color Grid line color
#' @param no_axis Remove axis lines and ticks
#' @param axis_label_face Axis label font face ("plain", "bold", "italic", or "bold.italic")
#' @param axis_line_width Axis line width
#' @param grid_line_width Grid line width
#' @param x_axis_label_size x-axis label size
#' @param x_axis_label_angle x-axis label angle
#' @param y_axis_label_size y-axis label size
#' @param y_axis_label_angle y-axis label angle
#' @param strip_title_size Strip title size
#' @param lims Set x and y axis limits
#' @param breaks Set x and y axis breaks
#' @param labels Set x and y axis labels
#' @param expand Set x and y axis expansion percentage
#' @param xlims Set x limits
#' @param ylims Set y limits
#' @param xbreaks Set x breaks
#' @param ybreaks Set y breaks
#' @param xlabels Set x labels
#' @param ylabels Set y labels
#' @param xexpand Set x expansion
#' @param yexpand Set y expansion
#' @param save_filename Optional filename to save plot
#' @param save_paper_size Paper size of saved plot
#' @param save_orientation Orientation of saved plot
#' @param save_width Manually set paper width
#' @param save_height Manually set paper height
#'
#' @returns Theme function
#' @export
theme_clean <- function(p,
                        grid=FALSE,
                        xlines=FALSE,
                        ylines=FALSE,
                        legend_position="bottom",
                        plot_margin_in=0.5,
                        caption=c(),
                        caption_title="Notes & Sources:",
                        caption_margin=0,
                        title_margin=0,
                        subtitle_margin=0.25,
                        borderizer=FALSE,
                        font="sans",
                        text_size=14,
                        title_size=18,
                        subtitle_size=16,
                        caption_size=11,
                        strip_title_size=14,
                        legend_title_size=11,
                        legend_item_size=14,
                        legend_title_face="bold",
                        legend_rows=NULL,
                        text_color="black",
                        grid_color="#D3D3D3",
                        no_axis=FALSE,
                        axis_label_face="plain",
                        axis_line_width=0.5,
                        grid_line_width=0.1,
                        x_axis_label_size=14,
                        x_axis_label_angle=0,
                        y_axis_label_size=14,
                        y_axis_label_angle=0,
                        lims=NULL,
                        breaks=NULL,
                        labels=NULL,
                        expand=NULL,
                        xlims=NULL,
                        ylims=NULL,
                        xbreaks=waiver(),
                        ybreaks=waiver(),
                        xlabels=waiver(),
                        ylabels=waiver(),
                        xexpand=c(0,0.05),
                        yexpand=c(0,0.05),
                        ...,
                        save_filename=NULL,
                        save_paper_size="ledger",
                        save_orientation="landscape",
                        save_width=NULL,
                        save_height=NULL){

  t <- theme(text=element_text(size=text_size, family=font, colour=text_color),
             plot.title = element_text(hjust=0.5, face="bold", size=title_size, margin=margin(t=title_margin, unit="in")),
             plot.subtitle = element_text(hjust=0.5, face="italic", size=subtitle_size, margin=margin(b=subtitle_margin, unit="in")),
             plot.caption = element_text(hjust=0.5, size=caption_size, margin=margin(t=caption_margin, unit="in")),
             axis.text = element_text(colour=text_color, face=axis_label_face),
             axis.text.x = element_text(colour=text_color, face=axis_label_face, angle=x_axis_label_angle, size=x_axis_label_size),
             axis.text.y = element_text(colour=text_color, face=axis_label_face, angle=y_axis_label_angle, size=y_axis_label_size),
             axis.line = element_line(linewidth=axis_line_width, color=text_color),
             axis.title = element_text(face="bold"),
             plot.background = element_blank(),
             panel.background = element_blank(),
             panel.grid.major = element_blank(),
             panel.grid.minor = element_blank(),
             panel.border = element_blank(),
             strip.background = element_rect(fill=NA),
             strip.text = element_text(face="bold", colour=text_color, size=strip_title_size),
             legend.title = element_text(face=legend_title_face, size=legend_title_size),
             legend.position = legend_position,
             legend.text = element_text(colour = text_color, size=legend_item_size),
             legend.background = element_rect(fill=NA),
             legend.key = element_rect(fill=NA),
             plot.margin = margin(plot_margin_in, plot_margin_in, plot_margin_in, plot_margin_in, unit="in"))

  if (grid==TRUE){
    t <- t + theme(panel.grid.major=element_line(color=grid_color, linewidth=grid_line_width),
                   panel.grid.minor=element_line(color=grid_color, linewidth=grid_line_width))
  }

  if (xlines==TRUE){
    t <- t + theme(panel.grid.major.x=element_line(color=grid_color, linewidth=grid_line_width),
                   panel.grid.minor.x=element_line(color=grid_color, linewidth=grid_line_width))
  }

  if (ylines==TRUE){
    t <- t + theme(panel.grid.major.y=element_line(color=grid_color, linewidth=grid_line_width),
                   panel.grid.minor.y=element_line(color=grid_color, linewidth=grid_line_width))
  }

  if (no_axis==TRUE){
    t <- t + theme(axis.line=element_blank(), axis.ticks = element_blank())
  }

  # apply color palette and default expansion
  out <-list(t,
             scale_color_clean(),
             scale_fill_clean(),
             guides(color=guide_legend(nrow = legend_rows)),
             guides(fill=guide_legend(nrow = legend_rows)),
             theme(...))

  if(!is.null(caption)){
    out <- append(out, list(labs(caption=notes_format(caption, caption_title))))
  }

  xyscale <- function(p_in){
    xn <- c(quo_name(p_in$mapping$x))
    yn <- c(quo_name(p_in$mapping$y))
    x_aes <- p_in$data[[xn]]
    y_aes <- p_in$data[[yn]]

  if(!is.null(lims)){
    xlims <- lims
    ylims <- lims
  }

  if(!is.null(breaks)){
    xbreaks <- breaks
    ybreaks <- breaks
  }

  if(!class(xbreaks)=="waiver" & is.null(xlims)){
      xlims <- c(min(xbreaks), max(xbreaks))
  }

  if(!class(ybreaks)=="waiver" & is.null(ylims)){
      ylims <- c(min(ybreaks), max(ybreaks))
  }

  if(!is.null(labels)){
    xlabels <- labels
    ylabels <- labels
  }

  if(!is.null(expand)){
    xexpand <- expand
    yexpand <- expand
  }

  if(is.null(x_aes) | is.numeric(x_aes)){
        out <- append(out, list(scale_x_continuous(limits=xlims,
                                                   breaks=xbreaks,
                                                   labels=xlabels,
                                                   expand=expansion(mult=xexpand))))
    }

  if(is.null(y_aes) | is.numeric(y_aes)){
      out <- append(out, list(scale_y_continuous(limits=ylims,
                                                 breaks=ybreaks,
                                                 labels=ylabels,
                                                 expand=expansion(mult=yexpand))))
    }

  p_out <- p_in + out
    return(p_out)
  }

  plotlist <- is.list(p) && all(sapply(p, function(p) inherits(p, "ggplot")))

  if(plotlist){
    p_cleaned <- lapply(p, xyscale)
  } else{
    p_cleaned <- xyscale(p)
  }


  if (!is.null(save_width) && !is.null(save_height)) {
    # Use custom width and height if provided
    plot_width <- save_width
    plot_height <- save_height
  } else if (save_paper_size == "letter") {
    # Use letter paper size if selected
    plot_width <- 11
    plot_height <- 8.5
  } else {
    # Use ledger paper size by default
    plot_width <- 17
    plot_height <- 11
  }

  if (save_orientation == "portrait") {
    # Flip dimensions for portrait orientation
    temp <- plot_width
    plot_width <- plot_height
    plot_height <- temp
  }


  if (borderizer){
    subtitle_margin = 0.3
    plot_margin_in = 0.5
    title_margin = 0.55
  }

  if (!is.null(save_filename)) {
    if(plotlist){
      cairo_pdf(save_filename, width=plot_width, height=plot_height, onefile = TRUE)
      for (i in seq_along(p_cleaned)) {
        print(p_cleaned[[i]])
      }
      dev.off()
    }else{
      cairo_pdf(save_filename, width=plot_width, height=plot_height)
      print(p_cleaned)
      dev.off()
    }
  }

  return(p_cleaned)
}
