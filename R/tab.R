#' Format table
#'
#' @import gt
#' @import dplyr
#'
#' @param gt table to format
#' @param dark dark column labels
#' @param title table title
#' @param subtitle table subtitle
#' @param notes table notes vector
#' @param table.font.size table font size
#' @param title.font.size title font size
#' @param col.height column label row height
#' @param title.padding title padding
#'
#' @return html table
#' @export
#'
tab <- function(gt,
                dark=FALSE,
                title="", subtitle="", notes=c(),
                table.font.size = 11,
                title.font.size = 18,
                col.height = 5,
                title.padding = 50){
  if(!is(gt,"gt_tbl")){
    gt <- gt %>% gt()
  }

  gt <- gt %>%
    cols_width(everything() ~ px(100)) %>%
    cols_align(align="center") %>%
    tab_style(style = cell_text(align = "center"), locations = cells_source_notes()) %>%
    tab_options(table.font.color = "black",
                table.font.size = table.font.size,
                heading.title.font.size = title.font.size,
                column_labels.padding = col.height,
                heading.padding = title.padding,
                column_labels.font.weight = "bold",
                source_notes.padding = 10) %>%
    tab_options(table.border.top.width = 0,
                table.border.bottom.width = 0,
                heading.border.bottom.width = 0,
                column_labels.border.top.width = 0,
                column_labels.border.bottom.width = 0,
                table_body.border.top.width = px(1),
                table_body.border.bottom.width = px(1),
                source_notes.border.bottom.width = 0,
                table_body.hlines.width = 0) %>%
    tab_options(table_body.border.top.color="black",
                table_body.border.bottom.color="black")

  if(dark){
    gt <- gt %>%
      tab_style(style=list(cell_fill("black"),
                           cell_text(color="white"),
                           cell_borders(sides="all", color="white",
                                        weight = px(1))),
                locations=list(cells_column_labels(), cells_column_spanners())) %>%
      tab_options(table.font.names = "Arial",
                  column_labels.border.bottom.width = 1,
                  column_labels.border.bottom.color = "white",
                  column_labels.vlines.color = "white",
                  column_labels.vlines.style = "solid",
                  column_labels.vlines.width = 1)
  }else{
    gt <- gt %>% tab_options(table.font.names = "Palatino Linotype")
  }

  if(title!=""){
    title <- paste0("**",title,"**")
  }

  if(subtitle!=""){
    subtitle <- paste0("*",subtitle,"*")
    title <- paste(title,subtitle,sep="<br>")
  }

  if(title!=""){
    gt <- gt %>% tab_header(title=md(title))
  }

  if(!is.null(notes)){
    n <- paste0(notes, collapse="<br>")
    gt <- gt %>% tab_source_note(source_note = md(paste0("**Notes & Sources:**<br>", n)))
  }

  return(gt)
}

#' Save formatted table
#'
#' @import gt
#' @importFrom pagedown chrome_print
#'
#' @param tab table to save to html and pdf
#' @param path path name
#' @param options chrome_print options
#'
#' @return html and pdf
#' @export
#'
tabpdf <- function(tab,
                   path,
                   options=list(landscape=TRUE, marginTop=.5, marginBottom=.5, marginLeft=.5, marginRight=.5)){
  tab %>% gtsave(paste0(path, ".html"))
  pagedown::chrome_print(paste0(path, ".html"), paste0(path, ".pdf"),
                         options=options)
}
