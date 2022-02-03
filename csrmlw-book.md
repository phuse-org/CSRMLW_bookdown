---
title: "Clinical Statistical Reporting in a Multilingual World"
author: "PHUSE Whitepaper Team"
date: "2022-02-03"
site: "bookdown::bookdown_site"
url: https://github.com/phuse-org
description: An overview of the CSRMLW Framework
output:
  bookdown::bs4_book: 
    repo:
      base: https://github.com/phuse-org/CSRMLW_bookdown
      branch: main
      icon: "fab fa-github"
---

# Preface {-}

Objective: at least cover the high value insights from R vs SAS use cases as examples in the in-depth exposition (note: not meant to be exhaustive)

<!--chapter:end:index.Rmd-->

# Introduction

Several discrepancies have been discovered in statistical analysis results between different programming languages, even in fully qualified statistical computing environments. Subtle differences exist between the fundamental approaches implemented by each language, yielding differences in results which are each correct in their own right. The fact that these differences exist causes unease on the behalf of sponsor companies when submitting to a regulatory agency, as it is uncertain if the agency will view these differences as problematic. In its Statistical Software Clarifying Statement, the US Food and Drug Administration (FDA) states that it “FDA does not require use of any specific software for statistical analyses” and that “the computer software used for data management and statistical analysis should be reliable.” Observing differences across languages can reduce the analyst’s confidence in reliability and, by understanding the source of any discrepancies, one can reinstate confidence in reliability. 

This white paper aims to empower analysts to make informed choices on the implementation of statistical analyses when multiple languages yield different results. Our objective is not to prescribe what that choice should be, but rather provide guidance on the types of questions an analyst should ask in order to identify the fundamental sources of discrepant results. These discrepancies may exist for a variety of different reasons, of which this paper will explore and provide examples.

In this context, the risk of interpreting numerical differences in analysis results due solely to differences in programming language can be mitigated, instilling confidence in both the sponsor company and the agency during the review period. 

- WIP Note: I don’t like this sentence but I need to think about how I’d actually want to change it.

## Motivation

## Background

As clinical data analytics evolves within the pharmaceutical industry, a large and noteworthy contingent of people and organizations have explored the use of various computational technologies as an effort to reimagine how to tell the story about the data that is collected during the course of a clinical trial. These technologies, whether available commercially or as open source, offer new potential in the ability of a sponsor company to discover new medicines and demonstrate that they can be safely and effectively administered to patients for a given indication. We see applications of machine learning and artificial intelligence being built into exploratory analyses as well as automation of conventional reporting pipelines, both as expanded offerings of commercial products and through tools developed and available as open source. We are witnessing a desired transformation of how we deliver clinical insights from flat data files with rows/columns and compiled PDF reports into dynamic visualization platforms which facilitate a reviewer to explore the trial database in a three-dimensional way. And, most notably, because the tools that other industries most commonly used for these ‘new’ ways of data engineering, data analytics, and data reporting are often built on programming languages not historically used within the pharmaceutical industry, we are experiencing a dramatic shift away from dependence on a small set of commercially available solutions and toward embracing many languages to build and use the best-fit tools to extract the most knowledge from clinical data. 

- WIP Note: 
- Any value to discussing the changing demographic of analysts in the industry – R vs SAS as grad experience, for example
- Want to trim this back and make it more concise. I like the storytelling piece, but I think we should also focus in on access to new/advanced statistical methods and the rapid advancements of open-source data analysis tools over the past 10 years or so. 

This last piece has brought to light an element of our data analytics that was previously overlooked due to an over dependence on a single solution from one programming language. Within the clinical reporting pipeline (transforming patient level clinical trial data from collection to submission), the industry has historically relied on comparing results to an independently generated second set of results as the primary form of quality control (QC). In the early years, comparisons were made on paper and thoroughly verified by a human that the number in the table matched the number independently derived by a second programmer. As technology progressed, electronic comparisons of the output data presented in a table reduced the risk of human error that the validator missed a discrepancy. The theory is that if two people put the same inputs through two independently developed processes (the code) and achieve the same outcome, then the outcome must be right. It’s not a perfect system and it can produce false positives, but efficiencies were gained and quality improved.

However, up until recently, the QC process has nearly always been implemented with the same programming language being used both for the generation of results (‘on production’) and for independent QC. The shift in the industry to explore other languages has now raised questions such as “What if the numbers don’t match? Which is correct?” 

For example, if one were to take a use case to compare rounding rules between SAS® and R, it is now becoming well understood that the default rounding rule (implemented in the respective language’s round() function) are different, but only when the number being rounded is equidistant between the two possible results. The round() function in SAS will round the number ‘away from zero’, meaning that 12.5 rounds to the integer 13. The round() function in Base R will round the number ‘to even’, meaning that 12.5 rounds to the integer 12. SAS also has the rounde() function which rounds to even and the janitor package in R contains a function that rounds away from zero. In this use case, SAS produces a correct result from its round() function, based on its documentation, as does R. Both are right based on what they say they do, but they produce different results. 

- WIP Note: Can we make a table to illustrate this?
- I want to see how the rest of the paper pans out but I think we could move this into use cases for discussion. Referencing rounding I think it’s important to also note that the round to even is based on the IEC 60559 standard

Now, the analyst has a choice to make if both R and SAS are in their toolbox – how do I round this result? To answer this question, the analyst needs to understand the rationale behind round-to-even rule and the round-away-from-zero rule, and even other rounding rules that may exist. To our knowledge, this ‘how do I round’ question has never been asked with respect to clinical trial reporting until the difference between R and SAS default rounding was discovered. The ‘correct’ answer is up to the analyst to determine and justify. It likely depends on such things as understanding the impact on the resulting data story about the safety and efficacy of the investigational product.

Why should the analyst care? Why does it matter? One answer is because they want to tell the most accurate story of their data. However, and perhaps more importantly in the highly regulated pharmaceutical industry, because a third-party reviewer will be assessing the integrity of the data. If the reviewer attempts to reproduce the same results and chooses a different language, the analyst needs to be able to explain why results may differ, else the integrity of the entire package may be questioned. By fully understanding the implications of choosing a statistical modeling implementation in Language A vs Language B, the analyst can communicate the rationale of the choice, based on sound statistical reasoning, and instill confidence in the regulatory body reviewing the submitted data.

It should be noted that in what follows, it is assumed that statistical packages and routines perform in a manner consistent with their documentation. The question at hand is not whether the procedures are accurate or reliable, but rather, in what ways to similar implementations across languages differ. Hence, we are not concerned with another major area of discussion within the industry – the so-called validation of packages and software.

## Other Readings

- Perhaps cite the TransCelerate MoA project
- Perhaps cite other working groups or published conference proceedings

<!--chapter:end:intro.Rmd-->

# Available Resources

## Contributing via GitHub

Git is a localized version control system that allows users to make changes to their files and revert to a working state whenever it is needed.  GitHub is a service that allows for sharing of git repositories, so that any number of people can make contributions to a project, while maintaining separate stable and development branches of the project files.  In addition to storing git repositories, GitHub is useful for displaying project documentation, tracking issues and feature requests, making comments, and taking part in discussions, along with offering tools for project management and some automation.  

GitHub integrates seamlessly with RStudio.  When you create a new project within RStudio, you are given the option to use git to track your repository, and to connect this local repository to an online repository on GitHub.  This goes both ways – you start a project in RStudio and later link it to a new repository on GitHub, or you can make a clone of an existing repository on GitHub for use in your local RStudio.  Because R is built on a foundation of open-source principles, GitHub has become the central location for many open-source R packages, including many of RStudio’s own packages like the Tidyverse and Shiny.   

There are also free online books that are stored and made publicly available using GitHub.  Some examples include Hadley Wickham’s “R for Data Science”, and this whitepaper you are currently reading.  If you visit the website for “R for Data Science” on a desktop browser, you will notice in the upper right side of the page a button that says, “View source” and “Edit this page”.  

Clicking on the source button will take you to the file that was used to create the HTML version of the book.  From there, you’ll be able to explore the repository of files that are used to create each individual chapter of the book.  

Clicking on the edit button will take you to a page that instructs you to, “Fork this repository”.  What this means is that you, or anyone else, can propose changes to this book.  The term “fork” simply means that you will be downloading the files to use and edit locally, and once you have made your proposed changes to the file, you will be able to submit your changes for the authors to review.  These are referred to as “pull requests”, and you can see a listing of pull requests from other users on the GitHub page for this repository by clicking on the “Pull Requests” tab.  

## WIP: Development Feedback

- Goal is to quickly introduce git and GitHub, then give an overview of how the reader can use pull requests to suggest edits to packages, projects, papers
- We can probably share the published version on GitHub, but not in a bookdown version or one that can be updated to new versions. PHUSE will likely create the final, - formatted version with a PHUSE template. That pdf can exist in the repo as a static document.
- Discussing forking, branching, pull requests are probably good, but instead of in the context of Wickham’s book, perhaps reframe this to “This is the repository for - CSRMLW” and ‘This is how you can contribute to the codebase in the repo”


<!--chapter:end:resources.Rmd-->

# Use Cases 

In this whitepaper we outline a framework for conducting statistical analyses in different programming languages, particularly when results across languages may not exactly match numerically.  The purpose of this paper is support statisticians and analysts to identify and reconcile differences in numerical results, providing confidence in the integrity of those results even if another language provides seemingly different results.  

To illustrate the framework, we provide examples from use cases of SAS and R differences within select families of analyses.

Specifically, we’re going to cover summary statistics, linear models, mixed models, survival models, and the Cochran-Mantel-Haenszel test.  The following list is a simple breakdown of what this paper will assist with.

Topic             |Concept|Reference
-----             |-------|---------
Summary Stats| FIVE NUMBER SUMMARIES | ...
. | FREQUENCY TABLES | ...
. | GROUPED SUMMARIES | ...
. | MISCELLANEOUS SUMMARY VALUES | ...
Linear Models| REGRESSION | ...
. | COMPARING MEANS | ...
. | ANOVA MODELS | ...
. | ANCOVA MODELS | ...
. | MANOVA MODELS | ...
. | USING CONTRASTS  | ...
. | TESTS OF NORMALITY | ...
. | TESTS OF EQUAL VARIANCE | ...
Mixed Models| MIXED MODEL ANOVA | ...
. | REPEATED MEASURES | ...
. | … | ...
Survival Models| KAPLAN MEIER | ...
. | LOG-RANK TEST | ...
. | COX PROPORTIONAL HAZARDS MODEL | ...
. | PARAMETRIC MODEL | ...
. | COCHRAN-MANTEL-HAENSZEL | ...


## WIP Notes:

- 1st paragraph: I wonder if this should be in 3rd person instead of 1st person.
- Table: This is a nice table. The third column may not be necessary depending on the length of the paper. Page numbers for the ‘Topic’ level may be more meaningful (with less repetition)
- Table: Find an easier way to keep table updated without using MD table formatting

<!--chapter:end:usecase.Rmd-->

# Framework

This paper ...

## Types of Questions to Ask

- Differences in documentation
- Differences in modeling assumptions
- Differences in default values
- Differences in available parameters 
- Edge cases
- Can default call in one language be replicated in another
    + If yes, do we have numerical equivalence within an acceptable level
- Can a common/historical specification in one language be replicated in another
    + If yes, do we have numerical equivalence within an acceptable level
    + If no, is the common/historical specification the statistically preferred method or should it be abandoned?
- Can the preferred specification in one language be replicated in another?
    + If yes, do we have numerical equivalence within an acceptable level
- Differences in available output statistics
- Differences ‘deep’ in the implementation which are the result of decisions developers make when implementing a particular algorithm
    + May not be clear in the documentation at the level exposed to the user
    
## Possible Solutions

- Select a method for the analysis plan – be transparent on known alternatives and known differences
- Are there multiple solutions within a given language to consider?

<!--chapter:end:framework.Rmd-->

# In Depth

- Go through each class of question – describe, explore, illustrate with use cases
- Matrix of use cases and questions

## Topic 1

## Topic 2

<!--chapter:end:depth.Rmd-->

# Summary Statistics

<!--chapter:end:summary-stats.Rmd-->

# Linear Models

<!--chapter:end:linear-models.Rmd-->

# Mixed Models

## Repeated Measures

### Introduction

This document focuses on a comparison of results generated using a Mixed Model for Repeated Measures (MMRM) in SAS and R. Data for the comparison was the lab ADaM dataset adlbh.xpt from the Phuse Pilot Study. Results were generated for each lab parameter and time point in the dataset using three different covariance structures, i.e. unstructured, compound symmetry and autoregressive of first order (AR(1)).

#### Fitting the MMRM in SAS

In SAS the following code was used (assessments at `avisitn=0` should also be removed from the response variable):





```r
proc mixed data=adlbh;
where base ne . and avisitn not in (., 99);
class usubjid trtpn(ref="0") avisitn;
by paramcd param;
model chg=base trtpn avisitn  trtpn*avisitn / solution cl alpha=0.05 ddfm=KR;
repeated avisitn/subject=usubjid type=&covar;
lsmeans trtpn * avisitn / diff cl slice=avisitn;
lsmeans trtpn / diff cl;
run;
```

where the macro variable `covar` could be `UN`, `CS` or `AR(1)`. The results were stored in .csv files that were post-processed in R and compared with the results from R.

### Fitting the MMRM in R

#### Using the `nlme::gls` function

The code below implements an MMRM fit in R with the `nlme::gls` function.


```r
gls(model = CHG ~ TRTP + AVISITN + TRTP:AVISITN + AVISITN + BASE,
    data = data,
    correlation = corSymm(form = ~1|SUBJID),
    weights = varIdent(form = ~1|AVISITN),
    control = glsControl(opt = "optim"),
    method = "REML",
    na.action = "na.omit")
```

here we can swap out `corSymm` for `corCompSymm` to give the compound symmetry structure or `corCAR1` for autoregressive of first order (AR(1)).

#### Using the `lme4::lmer` function

An alternative way to fit an MMRM with unstructured covariance matrices is to use the `lme4::lmer` function as described by Daniel Sabanes Bove in his R in Pharma talk from 2020 see [here](https://github.com/rinpharma/2020_presentations/blob/main/talks_folder/2020-Sabanes_Bove-Implementing_MMRM_in_R.pdf). The relevance of this fit is apparent when we consider the availability of the Kenward-Roger's degrees of freedom for the MMRM in R, which at the time of writing, were not yet available for the `nlme::gls` function via the `pbkrtest` package (see [here](https://people.math.aau.dk/~sorenh/software/pbkrtest/#NEWS)).


```r
lmer(CHG ~ TRTA * VISIT + VISIT + BASE + (0 + VISIT|SUBJID),
     data = data,
     control = lmerControl(check.nobs.vs.nRE = "ignore"),
     na.action = na.omit)
```

#### Extracting effect estimates using `emmeans`

In order to extract relevant marginal means (LSmeans) and contrasts we can use the `emmeans` package. Below we start by constructing a `ref_grid` used to make explicit just how the predictions are generated across the levels of `TRTP` and `AVISITN`. The `emmeans` function permits various marginal means to be extracted depending on the `formula` provided and the following `pairs()` function call derives relevant contrasts. Note that more control can be obtained by calling the `contrast()` function.


```r
mod_grid <- ref_grid(model, data = data, mode = "df.error")
mod_emm <- emmeans(mod_grid, ~TRTP * AVISITN, mode = "df.error") 
pairs(mod_emm) 
```

### Comparison between SAS and R

With results available for SAS and R model fits, we turn our attention to generating some visual comparisons of the results. Note that here we adopt a Bland-Altman type plot which plots the difference on the y-axis and the average on the x-axis. This offers a way to inspect any bias or relationships with the size of effect and the associated bias.

For the extracted LS-means

<img src="mixed-models_files/figure-html/unnamed-chunk-6-1.png" width="100%" /><img src="mixed-models_files/figure-html/unnamed-chunk-6-2.png" width="100%" /><img src="mixed-models_files/figure-html/unnamed-chunk-6-3.png" width="100%" /><img src="mixed-models_files/figure-html/unnamed-chunk-6-4.png" width="100%" />

and corresponding SEs

<img src="mixed-models_files/figure-html/unnamed-chunk-7-1.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-7-2.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-7-3.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-7-4.png" width="672" />

For the derived contrasts

<img src="mixed-models_files/figure-html/unnamed-chunk-8-1.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-8-2.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-8-3.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-8-4.png" width="672" />

and corresponding 95%CI widths

<img src="mixed-models_files/figure-html/unnamed-chunk-9-1.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-9-2.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-9-3.png" width="672" /><img src="mixed-models_files/figure-html/unnamed-chunk-9-4.png" width="672" />

### Analysis of SAS and R Comparison

Using SAS PROC MIXED and R functions such as gls, lmer, mod_grid, and mod_emm, results were broadly aligned. Results not being exact can be attributed to many factors such as rounding precision, data handling, and many other internal processing nuances.  However, Bland-Altman type plots showed small but randomly distributed differences across a broad range of parameters from the input data.  Apart from a small subset of the parameters, there were no trends observed which would have suggested systemic differences between the languages.  These analyses were based on a single set of data so more research must be done. However, based on comparing R documentation with SAS documentation, as well as the results displayed above in this paper, it is evident that the R and the SAS methods cover do produce similarly valid results for the options which were tested.

### Future work

-   Run SAS code by also removing assessments at `avisitn=0` from the response variable, and using `trtp` (or `trtpn`) and `avisit` (or `avisitn`)
-   Investigating the differences
-   Implement `lmer` equivalent to MMRM with compound symmetry
-   Comparisons for other models, i.e. only random, random and repeated, no repeated

<!--chapter:end:mixed-models.Rmd-->

# Survival Models

<!--chapter:end:survival.Rmd-->

# CMH

<!--chapter:end:cmh.Rmd-->

# Bookdown Template: Title of Chapter

Replace this text with an introduction to this chapter.  

- Ensure the first line of this document starts with a single # and defines the chapter title



## Title of Sub-Section

Replace this text with discussion of sub-section topic.  

- Insert R code chunks where necessary
- Refer to RStudio Help Menu > Markdown Quick Reference for formatting guidance
- See [RMarkdown](https://bookdown.org/yihui/rmarkdown/) for more information on how `rmarkdown` works
- See [Bookdown](https://bookdown.org/yihui/bookdown/) for more information on how `bookdown` works
- The [The GitHub Page](https://github.com/rstudio/bookdown/tree/main/inst/examples) for examples of how these individual `.Rmd` files should be formatted


```r
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

```markdown
# Markdown chunks will be treated as raw markdown syntax, and will not be converted to HTML
```

## Title of Sub-Section

Replace this text with discussion of sub-section topic.  



## Title of Sub-Section

Replace this text with discussion of sub-section topic.  

<!--chapter:end:chapter-template.Rmd-->

