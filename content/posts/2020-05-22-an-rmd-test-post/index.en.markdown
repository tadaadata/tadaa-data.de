---
title: "An Rmd Test Post"
author: jemus42
date: '2020-05-22'
slug: "an-rmd-test-post"
categories:
  - R
tags: []
subtitle: ''
authorLink: ''
description: ''
hiddenFromHomePage: no
hiddenFromSearch: no
featuredImage: ''
featuredImagePreview: ''
toc:
  enable: yes
math:
  enable: no
lightgallery: no
license: ''
---



This is only a test

<!--more-->

This is a plot I made to see if the output gets saved in the same folder as the post's `.Rmarkdown` file and gets included correctly:


```r
library(ggplot2)

ggplot(mpg, aes(x = year, y = cty, color = cyl)) +
  geom_point() +
  theme_minimal()
```

<img src="testplot-1.png" width="672" />

