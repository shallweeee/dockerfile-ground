data()
# library(help='datasets')
# data(package='ggplot2')

> library(ggplot2)
RStudio Community is a great place to get help: https://community.rstudio.com/c/tidyverse
> ?ggplot
> example(ggplot)

boston <- read.table('housing.data')
names(boston) <- c('crim', 'zn', 'indus', 'chas', 'nox', 'rm', 'age', 'dis', 'rad', 'tax', 'ptratio', 'black', 'lstat', 'medv')
plot(boston)
summary(boston)
glimpse(boston)

library(data.table)
dt <- fread('very_big.csv')
df <- fread('very_big.csv', data.table=false)

library(readxl)
read_excel('test.xls', sheet='data', na='NA')

library(sqldf)
library(dplyr)
(df1 <- tibble(x = c(1,2), y = 2:1))

read.table
write.table
read.csv
write.csv

observations = rows, variables = columns

dplyr 핵심 동사  
동사|용도
---|---
filter|행 선택
arrange|행 정렬
select|열 선택
mutate|새 열
summarize|요약 통계
distinct|unique 값
sample_n|랜덤 샘플(개수)
sample_frac|랜덤 샘플(%)

glimpse
tbl_df
%>%
class

df <- tbl_df(read.csv('csv'))
iris %>% head()


요약함수
min max, mean, sum, sd, median, IRQ # R
n, n_distinct, first, last, nth     # dplyr
sample_n, sample_frac



참고
http://archive.ics.uci.edu/ml/index.php  
https://goo.gl/AlvXNr  
https://goo.gl/SpCOlK  
https://goo.gl/IGGcGU  
https://goo.gl/xcE4cz  
