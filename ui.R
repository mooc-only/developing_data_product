
library(shiny)
library(datasets)
data(mtcars)

shinyUI(
  # fluidPage(
  navbarPage(
    #titlePanel(
    "Regression analysis on mtcars dataset.", 
    #),
  
    tabPanel("Documentation", 
      h3("Summary"),
      p("The second aim of this project (The first one is to fullfil the ", strong("Developing Data Product"), " project) is",
        "to build a linear model with what you can predict the miles per gallons (MPG) run by a car having the ideal predictors."),
      p("The dataset used is ", em("mtcars"), " from R datasets package."),
      p("The panel ", strong("Model fitting"), " shows at left hand side some static information like the correlation between ",
        "the possible predictors and the outcome (mpg). That information give some heads up to start playing around with the model",
        " creation. Below, there is a set of checkboxes that you can select to choose the predictors that will form the model.",        
        "At the right hand side panel, you will see the formula used in R, the ", strong("Rsquared"), " that is a good indicator ",
        "of how much variability is covered by the model. Following, you'll see a table of coefficient where you can see the ",
        "statistic test result and check if a particular predictor is relevant to model the problem. And at the bottom it is shown",
        " many plots indicating normality of residuals, variance behaviour and independence in the fitted values."),
      p(strong("Note"), ": It would be useful to implement some additional features like, model save to perform an ANOVA test between ",
        "the available models, and give more options to the user interface to insert interactions between covariates.")
    ),
  
    tabPanel(
      "Model fitting",
      sidebarPanel(
        strong(p("Correlation of predictors with the outcome (MPG): ")), 
        fluidRow(
          column( 6, p(paste("cyl: ", round(with(mtcars, cor(mpg, cyl)), 3))) ),
          column( 6, p(paste("disp: ", round(with(mtcars, cor(mpg, disp)), 3))) )
        ),
        fluidRow(
          column( 6, p(paste("hp: ", round(with(mtcars, cor(mpg, hp)), 3))) ),
          column( 6, p(paste("drat: ", round(with(mtcars, cor(mpg, drat)), 3))) )
        ),
        fluidRow(
          column( 6, p(paste("wt: ", round(with(mtcars, cor(mpg, wt)), 3))) ),
          column( 6, p(paste("qsec: ", round(with(mtcars, cor(mpg, qsec)), 3))) )
        ),
        fluidRow(
          column( 6, p(paste("vs: ", round(with(mtcars, cor(mpg, vs)), 3))) ),
          column( 6, p(paste("am: ", round(with(mtcars, cor(mpg, am)), 3))) )
        ),
        fluidRow(
          column( 6, p(paste("gear: ", round(with(mtcars, cor(mpg, gear)), 3))) ),
          column( 6, p(paste("carb: ", round(with(mtcars, cor(mpg, carb)), 3))) )
        ),
        checkboxGroupInput(
          "predictors", 
          label = "Select those predictors to conform the model.",
          choices = c("Number of cylinders (cyl)" = "cyl", 
                      "Displacement (disp)" = "disp", 
                      "Gross horsepower (hp)" = "hp", 
                      "Rear axle ratio (drat)" = "drat", 
                      "Weight [lb/1000] (wt)" = "wt",
                      "1/4 mile time (qsec)" = "qsec",
                      "V/S (vs)" = "vs",
                      "Transmission (am)" = "am",
                      "Number of forward gears (gear)" = "gear",
                      "Number of carburators (carb)" = "carb") 
        )
      ), # sidebarPanel 
      mainPanel(
        br(),
        p(strong("Formula: "), textOutput("call", inline = T)), 
        p(strong("R^2: "), textOutput("Rsquared", inline = T)),
        tableOutput("coefficients"),
        plotOutput("myPlot")
      ) # mainPanel
    ) # tabPanel
  ) # navbarPage instead of fluidPage
) # shinyUI
