# Linear Models



## Topic 1 (BV)

### Getting Started

## Sums of Squares Types

### Getting Started

## Contrasts

### Getting Started

To demonstrate contrasts, we'll be using a created data frame called `df_trial`. We see that the `drug` variable has three levels, _A_, _C_ and _E_.


```r
levels_drug <- levels(df_trial$drug)
summary(df_trial)
```

```
##  drug        pre             post       sex   
##  A:10   Min.   : 3.00   Min.   : 0.00   M:15  
##  C:10   1st Qu.: 7.00   1st Qu.: 2.00   F:15  
##  E:10   Median :10.50   Median : 7.00         
##         Mean   :10.73   Mean   : 7.90         
##         3rd Qu.:13.75   3rd Qu.:12.75         
##         Max.   :21.00   Max.   :23.00
```

```r
glimpse(df_trial)
```

```
## Rows: 30
## Columns: 4
## $ drug <fct> A, A, A, A, A, A, A, A, A, A, C, C, C, C, C, C, C, C, C, C, E, E,~
## $ pre  <dbl> 11, 8, 5, 14, 19, 6, 10, 6, 11, 3, 6, 6, 7, 8, 18, 8, 19, 8, 5, 1~
## $ post <dbl> 6, 0, 2, 8, 11, 4, 13, 1, 8, 0, 0, 2, 3, 1, 18, 4, 14, 9, 1, 9, 1~
## $ sex  <fct> M, F, M, F, M, F, M, F, M, F, M, F, M, F, M, F, M, F, M, F, M, F,~
```

In order to work with these levels as contrasts, we can use one of the pre-existing R functions to create the identity matrix for this factor variable. The `contr.treatment` definition is the default one that R uses, while the `contr.SAS` is the definition that SAS uses by default.


```r
contr.treatment(levels_drug)
```

```
##   C E
## A 0 0
## C 1 0
## E 0 1
```

```r
contr.SAS(levels_drug)
```

```
##   A C
## A 1 0
## C 0 1
## E 0 0
```

R also has the following definitions ready for use: `contr.sum`, `contr.poly`, and `contr.helmert`.


### Using Contrasts in R

There are many ways to work with contrasts in R, but here we're only going to focus on defining contrasts in the modeling function.  In this example, we're creating a linear model to predict post values from the pre and drug values. The only difference between the two is in the contrasts argument.  In one case, we're using the R default, and in the other we're using the SAS default.


```r
model_trt <- 
  lm(post ~ pre + drug, data = df_trial,
     contrasts = list(drug = contr.treatment))

model_sas <- 
  lm(post ~ pre + drug, data = df_trial,
     contrasts = list(drug = contr.SAS))
```

Comparing the output for these two models, we see that differ in which drug level is being used as the reference baseline.


```r
tidy(model_trt)
```

```
## # A tibble: 4 x 5
##   term        estimate std.error statistic    p.value
##   <chr>          <dbl>     <dbl>     <dbl>      <dbl>
## 1 (Intercept)   -3.88      1.99    -1.95   0.0616    
## 2 pre            0.987     0.164    6.00   0.00000245
## 3 drug2          0.109     1.80     0.0607 0.952     
## 4 drug3          3.45      1.89     1.83   0.0793
```

```r
tidy(model_sas)
```

```
## # A tibble: 4 x 5
##   term        estimate std.error statistic    p.value
##   <chr>          <dbl>     <dbl>     <dbl>      <dbl>
## 1 (Intercept)   -0.435     2.47     -0.176 0.862     
## 2 pre            0.987     0.164     6.00  0.00000245
## 3 drug1         -3.45      1.89     -1.83  0.0793    
## 4 drug2         -3.34      1.85     -1.80  0.0835
```

We can define a custom contrast as well.  In this case, we are comparing _A_ to _E_, where _E_ is the baseline group. As is typical of contrasts, the values must sum to 0, where negative numbers represent the baseline groups.


```r
lm(post ~ pre + drug, data = df_trial,
   constrasts = list(drug = c("A" = 1, "C" = "0", "E" = -1)))
```

It is possible to combine contrasts using `cbind`.  Notice here that contrast definitions don't require level names to be assigned, as long as the order of the levels is maintained. 


```r
contrast_1 <- c(1,  0, -1)
contrast_2 <- c(1, -2,  1)

contrast_c <- cbind(contrast_1, contrast_2)

lm(post ~ pre + drug, data = df_trial,
   contrasts = contrast_c)
```

### Easy Contrasts in R with `emmeans`

The `emmeans` package makes working with contrasts much easier.  In fact, this is the method that we recommend when trying to match contrast output between SAS and R.

We begin by defining some models.


```r
model_lm <-  lm(post ~ pre + drug + sex, data = df_trial)
model_av <- aov(post ~ pre + drug + sex, data = df_trial)
model_gm <- glm(post ~ pre + drug + sex, data = df_trial)
```

Then we convert these models to `emmeans` models.  In the `emmeans` function we can specify which variables we want to display estimated marginal means for.


```r
model_lm %>% emmeans(specs = "drug")
model_av %>% emmeans(specs = "drug", by = "sex")
model_gm %>% emmeans(specs = ~ drug | sex)
```

Or, we can define some common contrasts with the `contrast` function.


```r
# All Pairwise Comparisons
model_lm %>% 
  emmeans("drug") %>% 
  contrast(method = "pairwise")     

# Treatment v Control Comparison
model_gm %>% 
  emmeans("drug") %>% 
  contrast(method = "trt.vs.ctrl")  
```

We can also control the reference group, or reverse the contrast order using the arguments in the `contrast` function.


```r
model_lm %>% 
  emmeans("drug") %>% 
  contrast(method = "trt.vs.ctrl", ref = 2)     

model_lm %>% 
  emmeans("drug") %>% 
  contrast(method = "trt.vs.ctrl", rev = T)     
```

Custom contrasts can be defined as well.


```r
model_lm %>% 
  emmeans("drug") %>% 
  contrast(method = list(
    "A v E"  = c("A" = 1, "C" = 0, "E" = -1),
    "AE v C" = c(1, -2, 1),
    "A"      = c(1, 0, 0)
  ))
```

### Matching Contrasts: R and SAS

It is recommended to use the `emmeans` package when attempting to match contrasts between R and SAS.  In SAS, all contrasts must be manually defined, whereas in R, we have many ways to use pre-existing contrast definitions.   The `emmeans` package makes simplifies this process, and provides syntax that is similar to the syntax of SAS.

This is how we would define a contrast in SAS.


```r
# In SAS
proc glm data=work.mycsv;
   class drug;
   model post = drug pre / solution;
   estimate 'C vs A'  drug -1  1 0;
   estimate 'E vs CA' drug -1 -1 2;
run;
```

And this is how we would define the same contrast in R, using the `emmeans` package.


```r
lm(formula = post ~ pre + drug, data = df_trial) %>% 
  emmeans("drug") %>% 
  contrast(method = list(
    "C vs A"  = c(-1,  1, 0),
    "E vs CA" = c(-1, -1, 2)
  ))
```

Note, however, that there are some cases where the scale of the parameter estimates between SAS and R is off, though the test statistics and p-values are identical.  In these cases, we can adjust the SAS code to include a divisor.  As far as we can tell, this difference only occurs when using the predefined Base R contrast methods like `contr.helmert`.


```r
proc glm data=work.mycsv;
   class drug;
   model post = drug pre / solution;
   estimate 'C vs A'  drug -1  1 0 / divisor = 2;
   estimate 'E vs CA' drug -1 -1 2 / divisor = 6;
run;
```

