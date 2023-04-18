#' atopify helper function for notes formatting
#'
#' @param A
#' @param i
#'
#' @return
#' @export
#'
#' @examples
atopify <- function(A, i){
  if(i==length(A)){
    return(bquote(atop(textstyle(.(A[i])))))
  } else{
    return(bquote(atop(textstyle(.(A[i])), .(atopify(A, i+1)))))
  }
}

#' Clean caption element of ggplot
#'
#' @param A
#' @param ct
#'
#' @return
#' @export
#'
#' @examples
notes_format <- function(A, ct="Notes & Sources:"){
  return(bquote(atop(NA,
                     atop(textstyle(bold(.(ct))),
                          .(atopify(A, 1))))))
}
