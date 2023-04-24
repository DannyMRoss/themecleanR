#' atopify helper function for notes formatting
atopify <- function(A, i){
  if(i==length(A)){
    return(bquote(atop(textstyle(.(A[i])))))
  } else{
    return(bquote(atop(textstyle(.(A[i])), .(atopify(A, i+1)))))
  }
}

#' Clean caption element of ggplot
#'
#' @param caption Vector of caption lines
#' @param caption_title Captiin title
notes_format <- function(caption, caption_title="Notes & Sources:"){
  return(bquote(atop(NA,
                     atop(textstyle(bold(.(caption_title))),
                          .(atopify(caption, 1))))))
}
