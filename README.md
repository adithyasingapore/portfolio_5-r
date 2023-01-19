# Portfolio Project 5 - R - COVID-19 Statistical Analysis

Welcome to my fifth portfolio project. In this data cleaning and statistical analysis project, I analyse COVID-19 statistics by age, gender and country.

**Project Guide**

I use R to statistically verify 3 hypotheses:

1) Age - if older patients have a higher risk of death
2) Gender - if men have a higher risk of death than women
3) Country - if the risk of death is higher in South Korea or Japan

In doing so, I first clean the dataset column for deaths to ensure it has only 2 unique values, '0' (zero) if the patient survived or '1' (one) if the patient died.

I then perform the calculations for each hypothesis, then test each hypothesis with the t-test for statistical validity.

I intentionally chose an early-2020 COVID dataset as it can show us how initial statistical analysis would offer us an idea as to future trends, whether we can rely on these calculations to bear out in the future etc.

**Project Files and Data Source Citation**

There is 1 project file (R) and 1 data file (CSV) in this repository.

Original dataset: "Novel Corona Virus 2019 Dataset"

Published online at https://www.kaggle.com/datasets/sudalairajkumar/novel-corona-virus-2019-dataset/versions/25?resource=download

Thanks to Johns Hopkins University for the original source data. Thanks to Sudalai Rajkumar for the Kaggle data set.
