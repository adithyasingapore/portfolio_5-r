# COVID-19 data analysed using R
# Data set name: "Novel Corona Virus 2019 Dataset"
# https://www.kaggle.com/datasets/sudalairajkumar/novel-corona-virus-2019-dataset/versions/25?resource=download
# Thanks to Johns Hopkins University for the original source data.
# Thanks to Sudalai Rajkumar for the Kaggle data set.



# In this project, we investigate a sample of early (2020) COVID cases data.
# This data set contains info for 1085 COVID-19 cases, including
# age of patient, gender, whether they survived or died etc.

# I have tried to explain in my comments in such a way that even people who
# don't know R coding can still make sense of what's going on.



# --------------------



# importing data set and running "describe" command
library(Hmisc)
covid <- read.delim("C:/Users/LENOVO/Desktop/R_Projects/COVID19_line_list_data.csv")


describe(covid) # The Hmisc library is required for this function
# Death column has 14 distinct values. But there should only be 2, i.e.
# whether the patient survived (0) or died (1). Why are there 14?
# Because for some entries, instead of '1' (died), the date of death is listed.

# So, we have to clean the data. Let's create an alternate "cleaned" column.
covid$death_alt <- as.integer(covid$death != 0)
# Now, any entry which is not equal to 0 (survived) is counted as 1 (died).

# The "unique" command it returns each different unique value.
unique(covid$death_alt)
# When we run this, it returns only 2 values, '0' and '1', so we're good to go.



# Calculating death rate - sum of deaths divided by number of rows
sum(covid$death_alt) / nrow(covid) 



# --------------------



# Hypothesis 1:
# Age - COVID risk of death is higher in older patients.


# First let's create 2 subsets of those who died and those who survived.
died = subset(covid, death_alt == 1)
survived = subset(covid, death_alt == 0)
# When we run this, we see 2 new rows in our environment.
# died = 63 observations (63 people died out of 1085)
# survived = 1022 observations (1022 out of 1085 survived)


mean(died$age, na.rm = TRUE)
mean(survived$age, na.rm = TRUE)
# When we run this, we see the mean age of those who died is 68.59...
# And the mean age of those who survived is 48.07...
# So there is a difference of about 20 years.


# But is this statistically significant?
t.test(survived$age, died$age, alternative = "two.sided", conf.level = 0.95)
# The 95% confidence interval shows an age difference ranging between 17 and 24 years (younger).
# p-value is less than 2.2e-16
# normally, if p-value is less than 0.05, null hypothesis is rejected
# Results are statistically significant.
# Hypothesis 1 is valid, risk of death is indeed higher in older patients.



# --------------------



# Hypothesis 2:
# Gender - COVID risk of death is higher in men.


men = subset(covid, gender == "male")
women = subset(covid, gender == "female")
# 2 new rows appear in our environment for "men" and "women".
# So we have 520 men and 382 women in this data set.


mean(men$death_alt, na.rm = TRUE)
mean(women$death_alt, na.rm = TRUE)
# Death rate is at 8.46 % for men, only 3.66 % for women.
# This is a major difference. But again, is it statistically significant?


t.test(men$death_alt, women$death_alt, alternative = "two.sided", conf.level = 0.99)
# With 99% confidence, men have between 0.78% and 8.8% higher chance of death.
# p-value 0.002 is less than 0.05, null hypothesis is rejected.
# Results are statistically significant.
# Hypothesis 2 is also valid, risk of death is indeed higher in men.



# --------------------



# Death rate comparison between Japan and South Korea

# Why did I choose these 2 countries?
# (A) Sufficient number of case entries in the dataset for each country.
# (B) Both East Asian, both developed countries, both democracies
# (C) Data published by these countries can be considered open and reliable.


Japan = subset(covid, country == "Japan")
SKorea = subset(covid, country == "South Korea")
# So we have 190 entries from Japan and 114 from South Korea.


mean(Japan$death_alt, na.rm = TRUE)
mean(SKorea$death_alt, na.rm = TRUE)
# Japan had a death rate of 2.63 % compared to South Korea's 7.89 %.
# This is also a big difference. Let's look at statistical significance.


t.test(SKorea$death_alt, Japan$death_alt, alternative = "two.sided", conf.level = 0.99)
# With 99% confidence, South Korea has between 2% less and 12.5% more deaths than Japan.
# But p-value is 0.06, which is more than 0.05. Therefore, statistical significance is questionable.


# As mentioned at the beginning, this is an early COVID data set (from 2020).
# Therefore, more data is needed to determine if South Korea's death rates
# are higher than Japan's, with sufficient statistical significance.



# --------------------
# END
