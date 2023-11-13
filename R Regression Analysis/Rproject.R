df <- read.csv("insurance.csv", header = TRUE)
num_cols <- unlist(lapply(df, is.numeric))
plot(df[,num_cols])

```{r}
round(cor(df[,num_cols]),2)


```{r}
smoker = as.factor(df$smoker)
sex = as.factor(df$sex)
region = as.factor(df$region)

boxplot(charges ~ smoker, data = df, main = 'smoker')
boxplot(charges ~ sex, data = df, main = 'sex')
boxplot(charges ~ region, data = df, main = 'region')

```{r}
model1 = lm(charges ~. , data=df)

```{r}
summary(model1)