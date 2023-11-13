df <- read.csv("insurance.csv", header = TRUE)
num_cols <- unlist(lapply(df, is.numeric))
plot(df[,num_cols])

```{r}
round(cor(df[,num_cols]),2)


```{r}
smoker = as.factor(df$smoker)
sex = as.factor(df$sex)
region = as.factor(df$region)

## creates boxplots for dependent variables set up against cost

boxplot(charges ~ smoker, data = df, main = 'smoker')
boxplot(charges ~ sex, data = df, main = 'sex')
boxplot(charges ~ region, data = df, main = 'region')

```{r}
model1 = lm(charges ~. , data=df)

```{r}
summary(model1)

## creates summary for dataset. With an R-squared of 0.75, we have fair confidence that the variables of smoking, age, and bmi have an impact on cost of charges.
## being in the southwest or southeast have a smaller but noticeable impact on charges as well. one must recognize correlation vs. causation with this relationship however.
