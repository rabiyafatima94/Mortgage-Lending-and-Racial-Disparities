#First Sample R Program for Labor Market Analysis

#Install psych package
library(psych)

m(list=ls(all=TRUE)) #clears memory
options(digits=12) #keeps 12 digits in memory, otherwise summary statistics may be off due to rounding

#Import Data
MLD <- read.csv("MLD.csv", header=TRUE)  


#Print variable names on the screen
colnames(MLD_1)


#changing column names
colnames(MLD) <- c('Married','Compliant_Credit_History','Total_Income_Percent','Black','Hispanic','Male','Loan_Approval','Loan_Amount_Percent')

# Data sample selection criteria
#We have removed records with missing values and total income percent = 0. Also, we have considered LOANPRC <= 1 and GDLIN == 0 | GDLIN ==1 as we have GDLIN = 666 in our data.   

MLD_1 <- subset(MLD, Loan_Amount_Percent <= 1 & Male != "." & Married != "." & (Compliant_Credit_History == 1 | Compliant_Credit_History == 0) & Total_Income_Percent > 0)

#checking missing values
any(is.na(MLD_1))

#grouping attributes
non_Hispanic_white <- ifelse(MLD_1$Hispanic == 0 & MLD_1$Black == 0, 1, 0)
non_Hispanic_Black <- ifelse(MLD_1$Hispanic == 0 & MLD_1$Black == 1, 1, 0)


#Summary for Quantitative variables
install.packages("stargazer")
library(stargazer)
stargazer(MLD_1[c('Total_Income_Percent','Loan_Amount_Percent')],
          type="text",title="Table 1: Descriptive Statistics for Quantitative Variables",
          summary.stat = c("n", "min", "median" ,"mean", "max"),
          align=TRUE)

Compliant_Credit_History_ = factor(MLD_1$Compliant_Credit_History, levels=c(0,1), labels=c("Not Eligible","Eligible"))
Gender_ = factor(MLD_1$Gender, levels=c(1,2), labels=c("Male","Female"))
Race_ = factor(MLD_1$Race, levels = c(1,2,3,4,5,6,7,8,9) , labels = c("White","African_American","American_Indian",
                                                                          "Alaska_Native","American_Indian_Alaska_Native","Asian","Native_Hawaiian", "Some_Other",
                                                                          "Two_or_more")) 
