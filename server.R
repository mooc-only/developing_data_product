
library(shiny)
library(ggplot2)
library(datasets)
data(cars)

buildFormula <- function(pred) {
  len <- length(pred)
  if (len == 0) 
    formula <- ""
  else
  {
    formula <- paste("mpg ~", pred[1])
    if (len > 1)
      for (i in 2:len)
        formula <- paste(formula, pred[i], sep = "+")
  }
  formula
}

shinyServer(function(input, output) {

  formula <<- reactive({ buildFormula(input$predictors) })
  output$call <- renderText( formula() )

  model <<- reactive({ lm(formula = formula(), data = mtcars) })
  
  output$Rsquared <- renderText({
    if (formula() != "") round( summary(model())$r.squared, 3 )
  })
  
  output$coefficients <- renderTable({
    if ( formula() != "" ) summary(model())$coef
  })
  
  output$myPlot <- renderPlot({
    if (formula() != "")
    {
      par(mfrow = c(2, 2))
      plot(model())
    }
  })

})
