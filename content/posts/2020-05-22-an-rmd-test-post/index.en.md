---
title: "An Rmd Test Post"
author: jemus42
date: '2020-05-22'
slug: "an-rmd-test-post"
draft: true
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
output: hugodown::md_document
rmd_hash: 25db7cddd77af23a

---

This is only a test

<!--more-->

This is a plot I made to see if the output gets saved in the same folder as the post's `.Rmarkdown` file and gets included correctly:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='http://ggplot2.tidyverse.org'>ggplot2</a></span><span class='o'>)</span>

<span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='nv'>mpg</span>, <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='nv'>year</span>, y <span class='o'>=</span> <span class='nv'>cty</span>, color <span class='o'>=</span> <span class='nv'>cyl</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggtheme.html'>theme_minimal</a></span><span class='o'>(</span><span class='o'>)</span>

</code></pre>
<img src="figs/testplot-1.png" width="700px" style="display: block; margin: auto;" />

</div>

