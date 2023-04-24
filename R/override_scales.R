scale_x_continuous <- function(name = waiver(), breaks = waiver(),
                               minor_breaks = waiver(), n.breaks = NULL,
                               labels = waiver(), limits = NULL,
                               expand = expansion(mult=c(0,0.05)), oob = censor,
                               na.value = NA_real_, trans = "identity",
                               guide = waiver(), position = "bottom",
                               sec.axis = waiver()) {
  sc <- continuous_scale(
    ggplot_global$x_aes,
    "position_c", identity, name = name, breaks = breaks, n.breaks = n.breaks,
    minor_breaks = minor_breaks, labels = labels, limits = limits,
    expand = expand, oob = oob, na.value = na.value, trans = trans,
    guide = guide, position = position, super = ScaleContinuousPosition
  )

  set_sec_axis(sec.axis, sc)

}


scale_x_continuous <- function (name = waiver(), breaks = waiver(), minor_breaks = waiver(),
                                n.breaks = NULL, labels = waiver(), limits = NULL, expand = expansion(mult=c(0,0.05)),
                                oob = censor, na.value = NA_real_, trans = "identity", guide = waiver(),
                                position = "bottom", sec.axis = waiver()){
  {
    sc <- continuous_scale(ggplot_global$x_aes, "position_c",
                           identity, name = name, breaks = breaks, n.breaks = n.breaks,
                           minor_breaks = minor_breaks, labels = labels, limits = limits,
                           expand = expand, oob = oob, na.value = na.value, trans = trans,
                           guide = guide, position = position, super = ScaleContinuousPosition)
    set_sec_axis(sec.axis, sc)
}
}

scale_y_continuous <- function(...){
  scale_y_continuous(..., expand=expansion(mult = c(0,0.05)))
}

scale_x_discrete <- function(...){
  scale_x_discrete(..., expand=expansion(mult = c(0,0.05)))
}

scale_y_discrete <- function(...){
  scale_y_discrete(..., expand=expansion(mult = c(0,0.05)))
}
