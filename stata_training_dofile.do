use "C:\Users\JEREMIAH\Desktop\stata\STATA training materials\datasets\stidata-unclean.dta", clear
*describe command describes data in the memory
describe
tabulate a1age a2occupation  
//shows the frequencies of the variables

 histogram height
 //histogram used to test normality
//shows continuous and categorical variables

// used for comment writing
edit 
//edit command gives out the dataset itself
// Browse or edit data with Data Editor
codebook
// describe data content/ summarises 
***********************************************************************
list casestatus a1age a2occupation
// list the values of variables
//DATA CLEANING
//Check data ranges
sort a1age
*sort variable - enter -browse- enter   
// a command that sorts ascending only
gsort a1age
 // it sorts ascending form
gsort-idnumber
// sorts in descending order
//IDENTIFYING MISSING VALUES
tab sex, missing
// getting to know missing value
//handling missing values
list idnumber if sex==""
//inserting the missing values
list idnumber if n12usecondom=="2 No"
replace n12usecondom="2 no" if idnumber==47
replace sex="Male" if idnumber== 48
replace sex="Female" if idnumber==213
// summarize -- Summary statistics
//sum is used in quantitative variables and it isn't used on qualitative (categorical variable)
//sum gives us mean,sd,min,max
sum a1age height
sum  a2occupation
tab  a2occupation
//gives frequencies in a report
//CHECKING INCOSISTENCY*  dependent variables e.g casestatus
codebook casestatus
//correcting incosistency
list idnumber if casestatus==3
replace casestatus=1 if (idnumber==1|idnumber==31)
//replace casestatus=1 if (idnumber==1) *if it is a case
//replace casestatus=2 if (idnumber==31)* if it is a control
*************************************************************8
//HANDLING DUPLICATES
*finding the duplicates
duplicates report idnumber
*using a unique identifier to find duplicates
duplicates list idnumber
//Dropping duplicates
//to drop a duplicate we need more than one variable
drop if idnumber==51 & a1age==23
//Duplicates in terms of idnumber a2occupation a3church
//duplicates drop idnumber a2occupation a3church , force
//. for numeric and "" for string
list idnumber if height== .
//to save we write (save abimo.dta, replace)
**********************************************
//creating new variables
//generate short form gen
//gen variablename="" -string/character
//gen variablename=. -numeric
gen agecut=""
replace agecut="<25" if(a1age>0) & (a1age<=24)
replace agecut="25-34" if(a1age>=25) & (a1age<=34)
replace agecut="35-44" if(a1age>=35) & (a1age<=44)
replace agecut="45-54" if(a1age>=45) & (a1age<=54)
replace agecut="55-64" if(a1age>=55) & (a1age<=64)
 
//alternatively
gen Agecut = a1age
recode Agecut (16/34=1) (35/64=2), generate(Agecut_num)
label list Agecut_num
label drop Agecut_num
label define Agecut_num 1 "16-34" 2 "35-64"
label values Agecut_num Agecut_num
tab Agecut_num
//
gen Agecuut = ""
replace Agecuut = "1" if a1age >= 16 & a1age <= 34
replace Agecuut = "2" if a1age >= 35& a1age <= 64
label def Agecuut 1 "Young" 2 "Adult"
encode Agecuut, generate(Agecuut_num)
//encode to change into numeric
label define age_label 1 "young" 2 "Adult"
label values Agecuut_num age_label
*******************************************
//populating by calculation
//bmi-body mass index
// egen -- Extensions to generate
gen bmi=weight/((height/100)^2)
//generating by calculation
gen bmi3= round(bmi2,0.1)
//rounding off to 2dp
egen meanage_sex = mean(a1age),by(sex)
//find mean of age by female or male
//Mean age by sex
gen meanage2= round(meanage_sex,0.01)
//Mean age (total)
egen meanage=mean(a1age)
//Sum (numeric variable)
egen sumage=sum(a1age)
//data-variable manager-variable using menu driven
//replace maritalstatus="single" if maritalstatus=="1" if in the data it is
// given in the form of 1--- to the number your given of choices and you want
// to give it an actual name
**************************************
//combinig categories
//merging variables (formal,
gen occup=1 if a2occupation=="2 informal"
replace occup=1 if a2occupation==" 3 formal"
replace occup=2 if a2occupation=="1 unemployed"
replace occup=2 if a2occupation=="4 student"
label define occup1b 1" employed" 2 "not employed"
label value occup occup1b

gen Marital_status =1 if a5maritalstatus==" 2 married"
replace Marital_status=1 if a5maritalstatus=="3 co-habiting"
replace Marital_status=2 if a5maritalstatus =="1 single"
replace Marital_status=2 if a5maritalstatus ==" 4 divorced"
replace Marital_status=2 if a5maritalstatus ==" 5 widowed"
label define Marital_status1c 1 "Married" 2 " Not Married"
label value Marital_status Marital_status1c
//string to numeric
encode sex, gen(sex_num)
encode a2occupation, gen(occupation_num)
//string in variable should be represented by red  and blue should be represented by blue
//sub-setting observations
keep if sex=="Female"
//deletes all the male in the browse data
keep idnumber a1age sex_num a2occupation
save Female, replace
//assignment
gen Education=1 if a4levelofeducation =="4 tertiary"
replace Education=1 if a4levelofeducation=="3 secondary" 
replace Education=2 if a4levelofeducation=="1 none"
replace Education=2 if a4levelofeducation =="2 primary"
label define Education1b 1"skilled" 2 "not skilled"
label value  Education Education1b
//assignment
gen Church =1 if a3church =="2 apostolic" 
replace Church=1 if  a3church=="3 methodist"
replace Church =1 if a3church =="4 anglican"
replace Church =1 if a3church =="5 pentecostal" 
replace Church=1 if a3church =="7 roman catholic"
replace Church =2 if  a3church =="6 atheist"
replace Church =3 if  a3church =="8 other"
label define Church1d 1"organised believers" 2 " non-believers" 3 " believers"
label value Church Church1d
// 
encode sex, gen(sex_num)
encode a2occupation, gen(a2occupation_num)
encode a3church, gen(a3church_num)
encode a4levelofeducation, gen(a4levelofeducation_num)
encode a5maritalstatus, gen(a5maritalstatus_num)
encode d2group1, gen(d2group1_num)
encode d2group2, gen(d2group2_num)
encode n10givereceiveforsex, gen(n10givereceiveforsex_num)
encode n12usecondom, gen(n12usecondom_num)
encode n11usedcondom, gen(n11usedcondom_num)
encode n13takenalcohol, gen(n13takenalcohol_num)
encode typeofsti, gen(typeofsti_num) 
encode agefirstsex, gen(agefirstsex_num)
*********************************************************************
//choosing the correct statistical test
corr a1age weight
pwcorr a1age height,sig
//between a1age and height there is a weak negative relation
//the correlation between the  same variables is the varaiance. 
//correlation
ttest a1age, by(sex)
//t-test command  is used to test  indepency btween two variables 
anova a1age height
regress bmi weight height
//it is super  accurate due to the percentage of the r-squared and adjusted r/coefficient of determination(more accurate)
// when populating the bmi using 
//relationship between independent and dependent variables.
tab casestatus n12usecondom, row chi
          |     N12UseCondom
//CaseStatus |     1 yes       2 no |     Total
//-----------+----------------------+----------
  //       1 |        12        101 |       113 
  //         |     10.62      89.38 |    100.00 
//-----------+----------------------+----------
 //        2 |        20         93 |       113 
  //         |     17.70      82.30 |    100.00 
//-----------+----------------------+----------
   //  Total |        32        194 |       226 
      //     |     14.16      85.84 |    100.00 

        //  Pearson chi2(1) =   2.3299   Pr = 0.127
		  //cross tabulation to check frequencies p-value and prcentages

tab casestatus n12usecondom, column chi 
        |     N12UseCondom
//CaseStatus |     1 yes       2 no |     Total
//-----------+----------------------+----------
    //     1 |        12        101 |       113 
   //        |     37.50      52.06 |     50.00 
//-----------+----------------------+----------
 //        2 |        20         93 |       113 
   //        |     62.50      47.94 |     50.00 
//-----------+----------------------+----------
 //    Total |        32        194 |       226 
    //       |    100.00     100.00 |    100.00 

     //     Pearson chi2(1) =   2.3299   Pr = 0.127

*****************************************************************************
//VISUALIZATION IN STATA
//use of menu driven interface and use of commands
graph bar (count), over(casestatus)
//bar chart-menu driven interface
//bar plot for categorical data
graph bar a1age height, over(casestatus)
graph bar occup Marital_status Education,over(casestatus)stack percent
graph bar (count) occup Marital_status Education,over(casestatus)stack percent
graph bar occup Marital_status Education,over(casestatus)blabel(total)
//blabel(total) for labelling
graph twoway scatter a1age height
graph twoway scatter weight height
twoway (scatter a1age height)(lfit a1age height)
//scatter plot for continuos data and shows association
graph pie,over(casestatus)plabel(_all percent)
//pie chart
graph pie,over(casestatus)plabel(_all percent)
label values casestatus casestat
******************************************************************************/
//REGRESSION ANALYSIS
//Multivariate analysis
//logistic-binary outcomes and logit/probit
replace casestatus=.0 if casestatus ==2
logistic casestatus a5maritalstatus_num a4levelofeducation_num a3church_num a2occupation_num a1age height sex_num
//social demographic variables only
logistic casestatus ib2.a5maritalstatus_num ib1.a2occupation_num ib3.a3church_num ib2.a4levelofeducation_num ib1.sexpartner1year ib1.sex_num
 // interpretation of marital status in reference to married of which is ib2
 //single people are 1.855 times at higher risk of getting sti compared to married
 //single people are 1.855 more likely to contact sti compare to married
 //<1-less risk ,1-no risk,>1 -high risk in accordance to odds ratio












