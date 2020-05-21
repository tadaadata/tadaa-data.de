---
title: "Are you lazy? Don't worry, tadaatoolbox got your back"
author: Lukas
date: '2015-10-02'
description: "It's our first R package and it's kind of exciting!"
categories:
  - R-Packages
tags:
  - tools
  - rstats
packages:
  - tadaatoolbox
banner: banners/emptyplot_wide.png
---

```{r setup, include=FALSE}
library(tadaatoolbox)
```


A while ago, we started developing the [tadaatoolbox](https://github.com/tadaadata/tadaatoolbox) R package.  
The goal is simple: There are certain things we tend to always do one after another, like performing effect size calculations after a t-test.  
The convenience tadaatoolbox aims to provide is centered around this: Do the usual stuff and leave me alone.

As an example, take one of the first functions I wrote for the package, `tadaa_t.test`:

```{r}
tadaa_t.test(data = ngo, response = stunzahl, group = geschl, print = "markdown")
```

What happened here?  
Let's take a look step by step:

1. We took the values you provided: A dataset (the infamous `ngo` data), the *response* or dependent variable and the *group* or independent variable
2. We performed a regular ol' t-Test via the common R function `t.test`
3. We calculated the effect size using an internal function that's also available in the package, see `?effect_size_t`
4. We calculated the power of the test via the `pwr` package
5. We tidied it up a bit using the `pixiedust` package (no, seriously) to make everything a little nicer
6. And finally, we returned a neat table to the console.

Notable bonus features:

- Remember how we didn't bother to check for heteroskedasticity / homogenity of variance? That's because the function does that under the hood and uses the appropriate setting for `var.equal`.
- The print method is customizable, and if you use the function in an RMarkdown document, you can specify `print = "markdown"` to return a markdown table so knitr can render it to a neat table, just like in this blogpost
- The power calculation notices which type of t-Test is called and calculates power for the specific test
- THe effect size is also aware of the test type, and calculated via the bonus feature function `effect_size_t`

Pretty neat, hm? Yeah.

Next up in the convenience department we have our old friend, the *ANOVA*.  
We're not digging too dep into the post-hoc area as we did with the t-Test, and we also don't bother testing for the prerequisites, but we do at least give you effect sizes.

```{r}
tadaa_aov(stunzahl ~ geschl, data = ngo, print = "markdown")
```

Or for two predictors:

```{r}
tadaa_aov(stunzahl ~ geschl * jahrgang, data = ngo, print = "markdown")
```

Notice how we give you both the partial eta^2 and Cohen's f. The latter is used for power calculations in software like *G\*Power* as well as the `pwr` package in R, while the former is generally used as an interpretable effect size, at least according to my stats class.

And lastly, we give you a simple template to create interaction plots with `tadaa_int`.  
Building your own interaction plots with `ggplot2` is kind of annoying, since you have to group/summarize your data beforehand and then write two relatively complex ggplots. `tadaa_int` does the work for you, and if you choose `grid = FALSE`, it returns a list of two `ggplot2` objects which you can save and modify as you wish with custom `scale_*` or `theme` components. If you choose `grid = TRUE`, the plots are arranged horizontally and printed as one image, which should probably be sufficient for most use case, especially in interactive use for explorative purposes.

```{r tadaatoolbox-tadaa-int}
tadaa_int(ngo, stunzahl, jahrgang, geschl, grid = TRUE)
```

I'm considering exposing more arguments to the user, e.g. the arrangement (horizontal vs. vertical), or the `shape` of the `geom_point` used for the `response` means, but if you're into that much customization, you're probably more than comfortable with building the plot yourself anyway.

An additional plotting bonus is Tobi's `tadaa_balance`, a simple template for heatmaps used for evaluating the balance of a design:

```{r tadaatoolbox-tadaa-balance}
tadaa_balance(data = ngo, geschl, jahrgang)
```

## Lazy wrappers

In the "minor conveniences" department, we have a bunch of wrappers for common statistics. The statistics themselves are usually calculated by base R or the packages `vcd` or `ryouready`, but they're tweaked so they're comfortable for use with `dplyr` and other tidy data functions in that they only ever return a single (usually numeric) value, which makes it easy to use them in `summarize` or `mutate`.

The functions are listed below:

* `modus`: A simple function to extract the mode of a frequency table.
    - This is *will return a character string* denoting multiple values, if applicable!
* `nom_chisqu`: Simple wrapper for `chisq.test` that produces a single value.
* `nom_phi`: Simple wrapper for `vcd::assocstats` to extract phi.
* `nom_v`: Simple wrapper for `vcd::assocstats` to extract Cramer's V.
* `nom_c`: Simple wrapper for `vcd::assocstats` to extract the contingency coefficient c.
* `nom_lambda`: Simple wrapper for `ryouready::nom.lambda` to extract appropriate lambda.
* `ord_gamma`: Simple wrapper for `ryouready::ord.gamma`.
* `ord_somers_d`: Simple wrapper for `ryouready::ord.somers.d`.

A side effect of having written all these wrappers is that we can now also provide easy functions to calculate all the stats relevant for a specific scale (nominal & ordinal):

```{r}
tadaa_nom(ngo$abschalt, ngo$geschl, print = "markdown")
```

```{r}
tadaa_ord(ngo$abschalt, ngo$geschl, print = "markdown")
```

Like previous `tadaa_*`-functions, these take a `print` argument so you can easily include them in RMarkdown documents by setting `print = "markdown"`.  
Please note that I'm aware it's suboptimal to just calculate all the stats, presumably to pick and choose which fits your needs best, but keep in mind that the intention of this package is to make teaching easier and provide convenient tools to communicate stats, so yes, if you're currently working on a *real science* thing, this is all just fun and games.

### It's the little things

And at last, there's a couple little functions I wrote primarily because I found myself writing the same few lines multiple times and thought "there should be a easier way to do this"… which is, coincidentally, pretty much the story behind everything in this package. Well.

* `generate_recodes`: To produce recode assignments for `car::recode` for evenly sequenced clusters.
* `interval_labels`: To produce labels for clusters created by `cut`.
* `tadaa_likertize`: Reduce a range of values to `n` classes (methodologically wonky).
* `delet_na`: Customizable way to drop `NA` observations from a dataset.
* `labels_to_factor`: If you mix and match `sjPlot`, `haven` and `ggplot2`, you might need to translate `labels` to `factors`, which is precisely what this functions does. Drop in `data.frame` with `label`, receive `data.frame` with `factors`.
* `drop_labels`: If you subset a `labelled` dataset, you might end up with labels that have no values with them. This function will drop the now unused `labels`.
* `pval_string`: Shamalessly adapted from `pixiedust::pvalString`, this will format a p-value as a character string in common `p < 0.001` notation and so on. The difference from the `pixiedust` version is that this function will also print `p < 0.05`.

Also, since I really like the `rmdformats::readthedown` RMarkdown template, I made a few tweaks to a `ggplot2` theme to match the template, you can use it by adding `+ theme_readthedown()` to your ggplots.  
It's a little brighter and let's you choose which axis (x, y, both) to emphasize visually.

```{r tadaatoolbox-theme-tadaa}
tadaa_int(ngo, stunzahl, jahrgang, geschl, grid = F, print = F)[[1]] +
  theme_tadaa(axis_emph = "y")
```

### Conclusion

This is it. The upcoming version (`0.10`) is going to be ready for CRAN soon, while `0.9` is already available.  
Try it and [submitt issues and feature reuqests](https://github.com/tadaadata/tadaatoolbox/issues) as much as you want.  
The next neat feature is probably going to be a `tadaa_normtest` function that gives you an easy way to perform tests for normality over subgroups.  

¯\\\_(ツ)_/¯