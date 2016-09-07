library(shiny)

server <- function(input, output){

    ## Function to return sample size.
    nHyper <- function(prev, n, C){
        m <- max(1, floor(prev*n))
        k <- 1:n
        p <- 1 - dhyper(0, m, n - m, k)
        err.min <- min(which(p >= C))
        list(k = k[err.min], m = m, appPrev = m/n*100)
    }

    currentSamp <- reactive({
        nHyper(prev = input$p, n = input$n, C = input$a)
    })
    
    ## Sample size
    output$sampSize <- renderText({
        return(currentSamp()$k)
    })

    ## Apparent prevalence in lot (due to integer fails)
    output$appPrev <- renderText({
        return(paste0(formatC(currentSamp()$appPrev, 2, format = "f"), "%"))
    })
    
    ## Confidence statement
    output$confState <- renderText({
        confTxt <- paste0(
            "In a lot of size ", input$n, ", a sample size of at least ",
            currentSamp()$k,
            " is required to detect at least 1 infected unit with confidence ",
            input$a, ", given the lot contains ", currentSamp()$m,
            " infected units (apparent prevalence greater than ",
            formatC(currentSamp()$appPrev, 2, format = "f"), "%).")
        return(confTxt)
    })
  
}
