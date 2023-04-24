
<!-- README.md is generated from README.Rmd. Please edit that file -->

# themecleanR

<!-- badges: start -->
<!-- badges: end -->

The goal of themecleanR is to create clean ggplots for reports

## Installation

You can install the development version of themecleanR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DannyMRoss/themecleanR")
#> Skipping install of 'themecleanR' from a github remote, the SHA1 (44ee58d9) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Example

``` r
attach(iris)
library(ggplot2)
library(themecleanR)

# make plot
plot <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  labs(title="Iris Flowers", subtitle="Sepal Length vs. Width",
       x="Sepal Length", y="Sepal Width") +
  geom_point()

# standard ggplot
plot
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r

# cleaned ggplot
plot + theme_clean()
```

<img src="man/figures/README-example-2.png" width="100%" />
