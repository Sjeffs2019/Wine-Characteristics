source("global.R")
library(shiny)
library(tidyverse)


server <- (function(input, output, session) {
    wine <- read.csv(paste("data/", "winered.csv", sep=""))
    Quality <- group_by(wine, Quality)
    list <- c("Quality", "ABV", "pH", "Density", "Total Sulfur Dioxide", "Free Sulfur Dioxide", "Chlorides", "Residual Sugar", "Citric Acid", "Volatile Acidity", "Fixed Acidity")
    
    
    # Tab 1
    observe({
        if (input$type == "ABV"){
            summ <- summarize(Quality, Mean = mean(ABV))
            summ1 <- summarize(Quality, Median = median(ABV))
            summ2 <- summarize(Quality, SD = sd(ABV))
            total <- data.frame(Quality = "Total", Mean = mean(wine$ABV), Median = median(wine$ABV), SD = sd(wine$ABV))
            newtext <- "Alcohol by volume, or the percentage of alcohol in the wine"
        }
        if (input$type == "pH"){
            summ <- summarize(Quality, Mean = mean(pH))
            summ1 <- summarize(Quality, Median = median(pH))
            summ2 <- summarize(Quality, SD = sd(pH))
            total <- data.frame(Quality = "Total", Mean = mean(wine$pH), Median = median(wine$pH), SD = sd(wine$pH))
            newtext <- "Describes how acidic or basic a wine is on a scale from 0 (very acidic) to 14 (very basic)"
        }
        if (input$type == "Density"){
            summ <- summarize(Quality, Mean = mean(Density))
            summ1 <- summarize(Quality, Median = median(Density))
            summ2 <- summarize(Quality, SD = sd(Density))
            total <- data.frame(Quality = "Total", Mean = mean(wine$Density), Median = median(wine$Density), SD = sd(wine$Density))
            newtext <- "Measured in kilograms per liter, the density is determined by the amount of sugar and alcohol in the wine"
        }
        if (input$type == "Total Sulfur Dioxide"){
            summ <- summarize(Quality, Mean = mean(Total.Sulfur.Dioxide))
            summ1 <- summarize(Quality, Median = median(Total.Sulfur.Dioxide))
            summ2 <- summarize(Quality, SD = sd(Total.Sulfur.Dioxide))
            total <- data.frame(Quality = "Total", Mean = mean(wine$Total.Sulfur.Dioxide), Median = median(wine$Total.Sulfur.Dioxide), SD = sd(wine$Total.Sulfur.Dioxide))
            newtext <- "Measured in miligrams per liter, the portion of sulfur dioxides that is free in the wine plus the portion that is bound to other chemicals in the wine"
        }
        if (input$type == "Free Sulfur Dioxide"){
            summ <- summarize(Quality, Mean = mean(Free.Sulfur.Dioxide))
            summ1 <- summarize(Quality, Median = median(Free.Sulfur.Dioxide))
            summ2 <- summarize(Quality, SD = sd(Free.Sulfur.Dioxide))
            total <- data.frame(Quality = "Total", Mean = mean(wine$Free.Sulfur.Dioxide), Median = median(wine$Free.Sulfur.Dioxide), SD = sd(wine$Free.Sulfur.Dioxide))
            newtext <- "Measured in milligrams per liter, the portion of sulfur dioxides that is free in the wine or not bound to other chemicals"
        }
        if (input$type == "Chlorides"){
            summ <- summarize(Quality, Mean = mean(Chlorides))
            summ1 <- summarize(Quality, Median = median(Chlorides))
            summ2 <- summarize(Quality, SD = sd(Chlorides))
            total <- data.frame(Quality = "Total", Mean = mean(wine$Chlorides), Median = median(wine$Chlorides), SD = sd(wine$Chlorides))
            newtext <- "Measured in grams per liter, the amount of salt in the wine"
        }
        if (input$type == "Residual Sugar"){
            summ <- summarize(Quality, Mean = mean(Residual.Sugar))
            summ1 <- summarize(Quality, Median = median(Residual.Sugar))
            summ2 <- summarize(Quality, SD = sd(Residual.Sugar))
            total <- data.frame(Quality = "Total", Mean = mean(wine$Residual.Sugar), Median = median(wine$Residual.Sugar), SD = sd(wine$Residual.Sugar))
            newtext <- "Measured in grams per liter, the amount of sugar remaining after fermentation stops"
        }
        if (input$type == "Citric Acid"){
            summ <- summarize(Quality, Mean = mean(Citric.Acid))
            summ1 <- summarize(Quality, Median = median(Citric.Acid))
            summ2 <- summarize(Quality, SD = sd(Citric.Acid))
            total <- data.frame(Quality = "Total", Mean = mean(wine$Citric.Acid), Median = median(wine$Citric.Acid), SD = sd(wine$Citric.Acid))
            newtext <- "Measured in grams per liter, the amount of citric acid in the wine"
        }
        if (input$type == "Volatile Acidity"){
            summ <- summarize(Quality, Mean = mean(Volatile.Acidity))
            summ1 <- summarize(Quality, Median = median(Volatile.Acidity))
            summ2 <- summarize(Quality, SD = sd(Volatile.Acidity))
            total <- data.frame(Quality = "Total", Mean = mean(wine$Volatile.Acidity), Median = median(wine$Volatile.Acidity), SD = sd(wine$Volatile.Acidity))
            newtext <- "Measured in grams per liter, the the amount of acetic acid or gaseous acids in the wine"
        }
        if (input$type == "Fixed Acidity"){
            summ <- summarize(Quality, Mean = mean(Fixed.Acidity))
            summ1 <- summarize(Quality, Median = median(Fixed.Acidity))
            summ2 <- summarize(Quality, SD = sd(Fixed.Acidity))
            total <- data.frame(Quality = "Total", Mean = mean(wine$Fixed.Acidity), Median = median(wine$Fixed.Acidity), SD = sd(wine$Fixed.Acidity))
            newtext <- "Measured in grams per liter, the amount of nonvolatile acids, or acids that do not evaporate easily"
        }
        summm <- mutate(summ, Median = summ1$Median, SD = summ2$SD)
        sum <- rbind(summm, total)
        colnames(sum)<-  c("Quality", "Mean", "Median", "Standard Deviation")
        output$table <- renderTable(sum, digits = 4)
        output$text <- renderText({paste("<b>","<font size=4.5>", input$type, ":", "</font>","</b>", "<font size=3.5>", newtext, "</font>")
        })
    })
    
    # Tab 2
    observe ({
        if(!is.null(input$independent)){
            updateSelectInput(session, "dependent", choices = list[!(list %in% c(input$independent, input$third))], selected = isolate(input$dependent))
        }
    }) 
    observe ({
        if(!is.null(input$dependent)){
            updateSelectInput(session, "third", choices = c("None", list[!(list %in% c(input$dependent, input$independent))]), selected = isolate(input$third))
        }
    })
    observe ({
        if(!is.null(input$third)){
            updateSelectInput(session, "independent", choices = list[!(list %in% c(input$third, input$dependent))], selected = isolate(input$independent))
        }
    })

    yvar <- reactive({
        if("Quality" %in% input$dependent) return(wine$Quality)
        if("ABV" %in% input$dependent) return(wine$ABV)
        if("pH" %in% input$dependent) return(wine$pH)
        if("Density" %in% input$dependent) return(wine$Density)
        if("Total Sulfur Dioxide" %in% input$dependent) return(wine$Total.Sulfur.Dioxide)
        if("Free Sulfur Dioxide" %in% input$dependent) return(wine$Free.Sulfur.Dioxide)
        if("Chlorides" %in% input$dependent) return(wine$Chlorides)
        if("Residual Sugar" %in% input$dependent) return(wine$Residual.Sugar)
        if("Citric Acid" %in% input$dependent) return(wine$Citric.Acid)
        if("Volatile Acidity" %in% input$dependent) return(wine$Volatile.Acidity)
        if("Fixed Acidity" %in% input$dependent) return(wine$Fixed.Acidity)
    })
    xvar <- reactive({
        if("Quality" %in% input$independent) return(wine$Quality)
        if("ABV" %in% input$independent) return(wine$ABV)
        if("pH" %in% input$independent) return(wine$pH)
        if("Density" %in% input$independent) return(wine$Density)
        if("Total Sulfur Dioxide" %in% input$independent) return(wine$Total.Sulfur.Dioxide)
        if("Free Sulfur Dioxide" %in% input$independent) return(wine$Free.Sulfur.Dioxide)
        if("Chlorides" %in% input$independent) return(wine$Chlorides)
        if("Residual Sugar" %in% input$independent) return(wine$Residual.Sugar)
        if("Citric Acid" %in% input$independent) return(wine$Citric.Acid)
        if("Volatile Acidity" %in% input$independent) return(wine$Volatile.Acidity)
        if("Fixed Acidity" %in% input$independent) return(wine$Fixed.Acidity)
    })
    clr <- reactive({
        if("None" %in% input$third) return(NULL)
        if("Quality" %in% input$third) return(wine$Quality)
        if("ABV" %in% input$third) return(wine$ABV)
        if("pH" %in% input$third) return(wine$pH)
        if("Density" %in% input$third) return(wine$Density)
        if("Total Sulfur Dioxide" %in% input$third) return(wine$Total.Sulfur.Dioxide)
        if("Free Sulfur Dioxide" %in% input$third) return(wine$Free.Sulfur.Dioxide)
        if("Chlorides" %in% input$third) return(wine$Chlorides)
        if("Residual Sugar" %in% input$third) return(wine$Residual.Sugar)
        if("Citric Acid" %in% input$third) return(wine$Citric.Acid)
        if("Volatile Acidity" %in% input$third) return(wine$Volatile.Acidity)
        if("Fixed Acidity" %in% input$third) return(wine$Fixed.Acidity)
    })
    
    output$plot <- renderPlot({default_title <- paste("Plot of", input$dependent, "vs", input$independent)
                              ggplot(data = wine) +
                                  geom_point(mapping = aes(x = xvar(), y = yvar(), color = clr()))+
                                  labs(title = default_title, x = input$independent, y = input$dependent, color = input$third)+
                                  theme(plot.title = element_text(hjust = 0.5, size =21))
    })
    
    # Tab 3
    
    observe ({
        if(!is.null(input$response)){
            updateCheckboxGroupInput(session, "regressor", choices = list[!(list %in% input$response)], selected = isolate(input$regressor))
        }
    })
        
    observeEvent(input$click, {
        reg <- isolate(input$regressor)
        res <- isolate(input$response)
        if(is.null(reg)){
            output$text2 <- renderText({"At least one regressor must be chosen."})
            output$text3 <- renderText({NULL})
            output$text4 <- renderText({NULL})
            output$text5 <- renderText({NULL})
        }
        else{
            output$text2 <- renderText({NULL})
            regressors <- gsub(" ", ".", reg)
            responsevar <- gsub(" ", ".", res)
            fit <- lm(as.formula(paste(responsevar," ~ ",paste(regressors,collapse="+"))),data=wine)
            output$text3 <- renderPrint({fit$coefficients})
            if (length(reg)==1){
                output$text4 <- renderText({paste("<b>", "The simple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg)})
            }
            if (length(reg)==2){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2])})
            }
            if (length(reg)==3){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2], "+", fit$coefficients[4], reg[3])})
            }
            if (length(reg)==4){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2], "+", fit$coefficients[4], reg[3], "+", fit$coefficients[5], reg[4])})
            }
            if (length(reg)==5){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2], "+", fit$coefficients[4], reg[3], "+", fit$coefficients[5], reg[4], "+", fit$coefficients[6], reg[5])})
            }
            if (length(reg)==6){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2], "+", fit$coefficients[4], reg[3], "+", fit$coefficients[5], reg[4], "+", fit$coefficients[6], reg[5], "+", fit$coefficients[7], reg[6])})
            }
            if (length(reg)==7){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2], "+", fit$coefficients[4], reg[3], "+", fit$coefficients[5], reg[4], "+", fit$coefficients[6], reg[5], "+", fit$coefficients[7], reg[6], "+", fit$coefficients[8], reg[7])})
            }
            if (length(reg)==8){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2], "+", fit$coefficients[4], reg[3], "+", fit$coefficients[5], reg[4], "+", fit$coefficients[6], reg[5], "+", fit$coefficients[7], reg[6], "+", fit$coefficients[8], reg[7], "+", fit$coefficients[9], reg[8])})
            }
            if (length(reg)==9){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2], "+", fit$coefficients[4], reg[3], "+", fit$coefficients[5], reg[4], "+", fit$coefficients[6], reg[5], "+", fit$coefficients[7], reg[6], "+", fit$coefficients[8], reg[7], "+", fit$coefficients[9], reg[8], "+", fit$coefficients[10], reg[9])})
            }
            if (length(reg)==10){
                output$text4 <- renderText({paste("<b>", "The multiple linear regression model is :", "</b>", "</br>", res,"=", fit$coefficients[1], "+", fit$coefficients[2], reg[1], "+", fit$coefficients[3], reg[2], "+", fit$coefficients[4], reg[3], "+", fit$coefficients[5], reg[4], "+", fit$coefficients[6], reg[5], "+", fit$coefficients[7], reg[6], "+", fit$coefficients[8], reg[7], "+", fit$coefficients[9], reg[8], "+", fit$coefficients[10], reg[9], "+", fit$coefficients[11], reg[10])})
            }
            predictdata <- data.frame(Quality = input$sliderQuality, ABV = input$sliderABV, pH = input$sliderpH, Density = input$sliderDensity, Total.Sulfur.Dioxide = input$sliderTotal , Free.Sulfur.Dioxide = input$sliderFree, Chlorides = input$sliderChlorides, Residual.Sugar = input$sliderSugar, Citric.Acid = input$sliderCitric, Volatile.Acidity = input$sliderVolatile, Fixed.Acidity = input$sliderFixed)
            prediction <- predict(fit, newdata = predictdata)
            output$text5 <- renderText({paste("<b>", "The predicted value for", res, " is :", "</b>", "</br>", res,"=", prediction)})
        }
    })
})




