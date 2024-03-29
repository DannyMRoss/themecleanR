#' Format html table
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
    tab_style( style = "vertical-align:middle", locations = cells_column_labels()) %>%
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

#' Save formatted html table
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
  return(tab)
}

#' Format LaTeX table
#'
#' @import xtable
#'
#' @param DT data.table
#' @param shading add alternate row shading
#' @param align latex table align codes
#' @param cwidth set column widths
#' @param cletters add column sub-header labels, use option "default" for [A], [B], etc.
#' @param rowspace add extra blank row after row number(s)
#' @param longtable set longtable formatting
#' @param continued add continued text to multi-page longtables
#' @param ... xtable print options
#'
#' @return latex table from data.table
#' @export
#'
tabtex <- function(DT,
                   shading = FALSE,
                   align = NULL,
                   cwidth="1in",
                   cletters=NULL,
                   rowspace=NULL,
                   boldrow=NULL,
                   longtable = FALSE,
                   continued=NULL,
                   ...) {

  if (is.numeric(cwidth)){
    cwidth <- paste0(cwidth,"in")
  }
  t <- xtable(DT, caption = "", label = "")

  if (!is.null(align)){
    align(t) <- align
  } else{
    align(t) <- rep(paste0("M{",cwidth,"}"), ncol(DT) + 1)
  }

  bold <- function(x) paste0('{\\bfseries ', x, '}')
  addtorow <- list()
  addtorow$pos <- list()
  addtorow$command <- as.character()

  if (is.null(cletters)){
    cletters <- NULL
  } else if (length(cletters)==1 && cletters=="default"){
    cletters <- paste0("[",LETTERS[1:ncol(DT)],"]")
  } else if (is.character(cletters) & length(cletters)!=ncol(DT)){
    cletters <- c(cletters, rep("",ncol(DT)-length(cletters)))
  }

  if (!is.null(cletters)){
    l <- paste0(paste0(cletters, collapse = " & "), " \n")
    addtorow$pos <- c(addtorow$pos, 0)
    addtorow$command <- c(addtorow$command, l)
  }
  if (!is.null(continued)){
    continued <- "{\\footnotesize Continued $\\downarrow$} \n"
  }

  if (!is.null(rowspace)){
    addtorow$pos <- c(addtorow$pos, rowspace)
    blank <- rep("& & & &  \\\\ \n", length(rowspace))
    addtorow$command <- c(addtorow$command, blank)
  }

  if (shading){
    rws <- seq(1, nrow(DT), 2)
    col <- rep("\\rowcolor[gray]{.95}", length(rws))
    addtorow$pos <- c(addtorow$pos, rws)
    addtorow$command <- c(addtorow$command, col)
  }

  if (longtable){
    addtorow$pos <- c(addtorow$pos, 0)
    lt  <- paste0(
      #"\\hline \n",
      "\\endhead \n",
      "\\hline \n",
      continued,
      "\\endfoot \n",
      "\\endlastfoot \n")
    addtorow$command <- c(addtorow$command, lt)

    print(
      t,
      caption.placement = "top",
      sanitize.colnames.function = bold,
      include.rownames = FALSE,
      floating = FALSE,
      comment = FALSE,
      tabular.environment = "longtable",
      add.to.row = addtorow,
      ...
    )
  } else{
    print(
      t,
      caption.placement = "top",
      sanitize.colnames.function = bold,
      include.rownames = FALSE,
      floating = FALSE,
      comment = FALSE,
      add.to.row = addtorow,
      ...
    )
  }
}

#' boldrows
#'
#' @param DT table
#' @param rows rows to bold
#'
#' @return table with bold tags to sanitize
#' @export
#'
boldrows <- function(DT, rows) {
  bold <- function(x) paste0("BOLD0",x,"BOLD1")
  DT[rows, ] <- lapply(DT[rows, ], bold)
  return(DT)
}

#' sanitizex
#'
#' @param str latex code to sanitize
#'
#' @return sanitized table
#' @export
#'
sanitizex <- function(str){
  result <- str
  result <- gsub("\\\\", "SANITIZE.BACKSLASH", result)
  result <- gsub("$", "\\$", result, fixed = TRUE)
  result <- gsub(">", "$>$", result, fixed = TRUE)
  result <- gsub("<", "$<$", result, fixed = TRUE)
  result <- gsub("|", "$|$", result, fixed = TRUE)
  result <- gsub("BOLD0", "\\textbf{", result, fixed = TRUE)
  result <- gsub("BOLD1", "}", result, fixed = TRUE)
  #result <- gsub("{", "\\{", result, fixed = TRUE)
  #result <- gsub("}", "\\}", result, fixed = TRUE)
  result <- gsub("%", "\\%", result, fixed = TRUE)
  result <- gsub("&", "\\&", result, fixed = TRUE)
  result <- gsub("_", "\\_", result, fixed = TRUE)
  result <- gsub("#", "\\#", result, fixed = TRUE)
  result <- gsub("^", "\\verb|^|", result, fixed = TRUE)
  result <- gsub("~", "\\~{}", result, fixed = TRUE)
  result <- gsub("SANITIZE.BACKSLASH", "$\\backslash$", result, fixed = TRUE)
  return(result)
}
