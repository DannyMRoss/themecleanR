#' intdays
#'
#' @param start start date
#' @param end end date
#'
#' @return day diff
#' @export
intdays <- function(start, end){
  return(as.integer(difftime(end, start, units = "days")) + 1)
}

#' intoverlapdays
#'
#' @param start1 start date 1
#' @param end1 end date 1
#' @param start2 start date 2
#' @param end2 end date 2
#'
#' @return overlap day number
#' @export
intoverlapdays <- function(start1, end1, start2, end2) {
  overlap_start <- pmax(start1, start2)
  overlap_end <- pmin(end1, end2)
  overlap <- intdays(overlap_start, overlap_end)
  return(overlap)
}

#' cr
#'
#' @param x number
#' @param v ceiling to
#'
#' @return ceiling round
#' @export
cr <- function(x, v){
  return(ceiling(x/v)*v)
}

#' roundup
#'
#' @param x number
#' @param v round up to
#'
#' @return ceiling round number
#' @export
#'
#' @examples
#' roundup(272, 50)
roundup <- function(x, v){
  return(ceiling(max(x)/v)*v)
}

#' limroundup
#'
#' @param min vector min
#' @param x number
#' @param v round to
#'
#' @return limits
#' @export
#'
#' @examples
#' limroundup(0, 272, 50)
limroundup <- function(min, x, v){
  return(c(min, roundup(x, v)))
}

#' seqroundup
#'
#' @param x number
#' @param v round to
#' @param s steps
#'
#' @return breaks
#' @export
#'
#' @examples
#' seqroundup(272, 50, 5)
seqroundup <- function(x, v, s){
  return(seq(0, roundup(x, v), roundup(x, v)/s))
}

#' facetseq
#'
#' @param x number
#' @param m max test
#' @param sq1 seq 1
#' @param sq2 seq 2
#'
#' @return sequence
#' @export
#'
#' @examples
#' facetseq(c(.1,.5,.9), 1, 0:4, c("0","0.25","0.5", "0.75", "1"))
facetseq <- function(x, m, sq1, sq2){
  if(max(x)>m) return(sq1) else return(sq2)
}

#' monthsl
#'
#'@import data.table
#'
#' @param DF data.table
#' @param b buckets
#' @param f date format
#' @param last include last month
#'
#' @return breaks and labels
#' @export
monthsl <- function(DF, b=4, f="%b-%y", last=TRUE){
  DF[, M:=.GRP, MONTH]
  maxm <- DF[,max(M)]
  s <- seq(1,maxm,b)
  if ((last) & !(maxm %in% s)){
    s <- c(s, maxm)
  }
  l <- format(DF[M %in% s,unique(MONTH)], "%b-%y")
  return(list(s, l))
}

#' Add letters to column names
#'
#' @param DT table to add column letters
#' @param delim delimiter
#'
#' @return table with changed names
#' @export
#'
colid <- function(DT, delim="/"){
  l <- paste0("[", LETTERS[1:ncol(DT)], "]")
  cn <- names(DT)
  for (i in seq_along(cn)){
    nn <- paste0(cn[i], delim, l[i])
    setnames(DT, cn[i], nn)
  }
  return(DT)
}

#' format columns
#'
#' @param DT import table
#' @param comma_cols comma columns
#' @param dollar_cols dollar columns
#' @param percent_cols percent columns
#' @param comma_accuracy comma accuracy
#' @param dollar_accuracy dollar accuracy
#' @param percent_accuracy percent accuracy
#'
#' @return data.table with formatted columns
#' @export
#'
formatcols <- function(DT, comma_cols = NULL, dollar_cols = NULL, percent_cols = NULL,  comma_accuracy = 1, dollar_accuracy = 1, percent_accuracy = 0.01) {

  if (!is.null(comma_cols)) {
    DT[, (comma_cols) := lapply(.SD, comma, accuracy = comma_accuracy), .SDcols = comma_cols]
  }

  if (!is.null(dollar_cols)) {
    DT[, (dollar_cols) := lapply(.SD, dollar, accuracy = dollar_accuracy), .SDcols = dollar_cols]
  }

  if (!is.null(percent_cols)) {
    DT[, (percent_cols) := lapply(.SD, percent, accuracy = percent_accuracy), .SDcols = percent_cols]
  }

  return(DT)
}
