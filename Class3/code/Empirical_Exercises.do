cd "C:\Users\sjgom\Documents\MasterMetrics\Class3\"
// 2.6 Using data from 1988 for houses sold in Andover, Massachusetts, from Kiel 
// and McClain (1995), the following equation relates housing price (price) to 
// the distance from a recently built garbage incinerator (dist):
//
// (i) Interpret the coefficient on log(dist). Is the sign of this estimate what 
// you expect it to be?
// (ii) Do you think simple regression provides an unbiased estimator of the
// ceteris paribus elasticity of price with respect to dist? (Think about the
// city's decision on where to put the incinerator.)
// (iii) What other factors about a house affect its price? Might these be corre
// lated with distance from the incinerator?
clear all
bcuse kielmc

reg lprice ldist if year == 1978
outreg2 using "output/results.doc", replace word
reg lprice ldist if year == 1981
outreg2 using "output/results.doc", word

////////////////////////////////////////////////////////////////////////////////

// C2.1 The data in 401K.RAW are a subset of data analyzed by Papke (1995) to 
// study the relationship between participation in a 401(k) pension plan and the 
// generosity of the plan. The variable prate is the percentage of eligible 
// workers with an active account; this is the variable we would like to explain. 
// The measure of generosity is the plan match rate, mrate.
// This variable gives the average amount the firm contributes to each worker's 
// plan for each $1 contribution by the worker. For example, if mrate 
// 0.50, then a $1 contribution by
// the worker is matched by a 50¢ contribution by the firm.
// (i)
// Find the average participation rate and the average match rate in the
// sample of plans.
clear all 
bcuse 401k

sum prate mrate

kdensity prate

// (ii) Now, estimate the simple regression equation prate on mrate,
// and report the results along with the sample size and R-squared.

reg prate mrate

// (iii) Interpret the intercept in your equation. Interpret the coefficient on mrate.


// (iv) Find the predicted prate when mrate 3.5. Is this a reasonable predic
// tion? Explain what is happening here.


di _b[_cons] + _b[mrate] * 3.5


// (v) How much of the variation in prate is explained by mrate? Is this a lot
// in your opinion?

////////////////////////////////////////////////////////////////////////////////
// C2.3 Use the data in SLEEP75.RAW from Biddle and Hamermesh (1990) to study 
// whether there is a tradeoff between the time spent sleeping per week and the 
// time spent  in paid work.
// We could use either variable as the dependent variable. For concreteness, 
// regress sleep on totwrk, where sleep is minutes spent sleeping at night per 
// week and totwrk is total minutes worked
// during the week.
clear all
// (i) Report your results in equation form along with the number of observa
// tions and R2. What does the intercept in this equation mean?
bcuse sleep75
sum sleep // Reasonable?
reg sleep totwrk

// (ii) If totwrk increases by 2 hours, by how much is sleep estimated to fall?
// Do you find this to be a large effect?

