# Wine Characteristcs
 
 This dataset is related to the red variants of the Portuguese "Vinho Verde" wine. It contains 1599 different wines (observations) each with multiple variables describing the physicochemicals and quality of the wine.
 My app can be used to analysis the relationship between different variables by using the data to fit a regression model or by ploting the data for a visual of the relationship between up tp three different variables. 
 
 ### Database Source:
 
 P. Cortez, A. Cerdeira, F. Almeida, T. Matos and J. Reis.
 Modeling wine preferences by data mining from physicochemical properties. In Decision Support Systems, Elsevier, 47(4):547-553, 2009.
 
## How to use the App

Up at the top there are three different tabs, by clicking each one you can switch between the different pages for the app.

### Use the first tab labled "Summary based on Quality" to display the mean, median, and standard deviation.

1.  Using the buttons labeled "Choose a Physicochemical", choose which variable you would like to see the descriptive statistics for. 
2.  After selecting a variable, a short summary of the variable will be given along with a table containing a summary of the mean, median, and standard deviation for each quality and for the entire data set.

### Use the second tab labled "Display Plot of Data" to display a scatterplot.

1. Using the dropdown labeled "Choose a Dependent Variable",  select which variable you would like to have as the dependent variable.
2. Using the dropdown labeled "Choose an Independent Variable",  select which variable you would like to have as the independent variable.
3. Using the dropdown labeled "Choose a Third Variable",  you can select which variable you would like to have as a third variable plotted to color or you can choose "None" for there to only be two variables plotted.
4. At any point you can choose a different variable for any of the three and the plot will automaticly be updated with the chosen variable.

### Use the third tab labled "Regression Analysis" to fit a regression model and predict the value of the response variable.

1. Using the dropdown labeled "Choose a Response Variable",  select which variable you would like to have as the response variable.
2. Using the boxes labeled "Choose the Regressors",  select as many variables as you would like to have fit to the model.
3. For each regressor you add, a slider will appear that can be used to predict the model.
4. Use the slider to choose the value for the given variable that you want the model predicted for.
5. Each slider contains a range for which extrapolation will not be an issue.
6. Click the button labeled "Fit model or find predicted value" when you are ready to fit the model and find the predicted value.
7. The regression model will then be displayed for the chosen response variable and regressors, and the predicted value of the response variable will be given for the chosen values for each regressor.
8. At any point you can change the values for the prediction or choose variables to fit to the model but you must click the button again to see any change in the output.

# Run from GitHub

Run the app from GitHub by running the code below in R:

install.packages('shiny')

library(shiny)

shiny::runGitHub(repo = "Wine-Characteristics", username = "Sjeffs2019", ref="main")

# Shinyapp.io link

Run the app with shinyapp.io using the link below:

https://sjeffs2019.shinyapps.io/Wine-Characteristics/
