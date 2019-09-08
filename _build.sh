#!/bin/bash

Rscript -e "blogdown::build_site(run_hugo = FALSE)"
hugo
