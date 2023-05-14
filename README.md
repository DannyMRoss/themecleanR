
<!-- README.md is generated from README.Rmd. Please edit that file -->

# themecleanR

<!-- badges: start -->
<!-- badges: end -->

The goal of themecleanR is to create clean(R) ggplots with a more
concise syntax.

## Installation

You can install the development version of themecleanR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DannyMRoss/themecleanR")
```

## Examples

``` r
attach(iris)
library(ggplot2)
library(extrafont) # read https://github.com/wch/extrafont for font configuration
#> Registering fonts with R
library(scales)
library(themecleanR)

# make plot
plot <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  labs(title="Iris Flowers", subtitle="Sepal Length vs. Width",
       x="Sepal Length", y="Sepal Width") +
  geom_point()

# standard ggplot
plot
```

<img src="man/figures/README-example1-1.png" width="100%" />

``` r

# cleaned ggplot
theme_clean(plot)
```

<img src="man/figures/README-example1-2.png" width="100%" />

``` r

# add notes and sources
theme_clean(plot,
            font = "Palatino Linotype",
            caption = c("Sepal measurements in cm.","Iris data: Anderson, 1936; Fisher, 1936."))
```

<img src="man/figures/README-example1-3.png" width="100%" />

``` r

# includes parameters for formatting shortcuts
theme_clean(plot,
            font = "Palatino Linotype",
            caption = c("Sepal measurements in cm.","Iris data: Anderson, 1936; Fisher, 1936."),
            xlims=c(0,8), ylims=c(0,5), ylines = TRUE)
```

<img src="man/figures/README-example1-4.png" width="100%" />

``` r

# save plot
theme_clean(plot,
            font = "Palatino Linotype",
            caption = c("Sepal measurements in cm.","Iris data: Anderson, 1936; Fisher, 1936."),
            save_filename = "man/figures/iris.pdf", save_paper_size = "letter", save_orientation = "landscape")
```

<img src="man/figures/README-example1-5.png" width="100%" />

``` r

# apply same formatting to multiple plots and save in a single pdf
plot2 <- ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) +
  labs(title="Iris Flowers", subtitle="Petal Length vs. Width",
       x="Petal Length", y="Petal Width") +
  geom_point()

theme_clean(list(plot, plot2),
            font = "Palatino Linotype",
            caption = c("Measurements in cm.","Iris data: Anderson, 1936; Fisher, 1936."),
            save_filename = "man/figures/iris2.pdf")
#> [[1]]
```

<img src="man/figures/README-example1-6.png" width="100%" />

    #> 
    #> [[2]]

<img src="man/figures/README-example1-7.png" width="100%" />

``` r
# bar chart example
plot3 <- ggplot(USPersonalExpenditure, aes(x=year, y=expenditure, fill=category)) +
  geom_col(position=position_dodge(width = .9), color="black", width = .8) +
  geom_text(aes(label = dollar(expenditure, 1)), 
            position = position_dodge(width = .9), vjust=-.5, size=3) +
  labs(title="US Personal Expenditures", subtitle="1945 \u2013 1960",
       y="Expenditures (bn)", x="Year")

sources <- c("Tukey, J. W. (1977) Exploratory Data Analysis. Addison-Wesley.",
             "McNeil, D. R. (1977) Interactive Data Analysis. Wiley.")

theme_clean(plot3, 
            caption = sources, caption_title = "Sources:", 
            ylabels = dollar, ylims=c(0,100), ybreaks = seq(0,100,25))
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />
