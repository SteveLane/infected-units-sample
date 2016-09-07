library(shiny)

exTxt <-
    "This simple calculator shows the sample size required to detect \\(m \\geq 1\\) infected units, from a lot with design prevalence \\(p\\). The number of infected units in the sample follows a hypergeometric distribution, given the number of infected units in the lot. Because of the requirement to use an integer number of infected units, the design prevalence is translated into the number of infected units in the lot, rounded down. This gives an <em>apparent</em> prevalence, lower than required design prevalence (a good thing &#12483;)."

fluidPage(
    
    ## Need mathjax
    withMathJax(),
    
    ## Application title
    titlePanel("Sample size calculation for infected unit detection."),
    
    sidebarLayout(
        ## Sidebar with a slider input
        sidebarPanel(
            numericInput("n",
                         "Number of units in lot",
                         value = 2000,
                         min = 1,
                         step = 1),

            numericInput("a",
                         "Minimum confidence level",
                         value = 0.95,
                         min = 0.5,
                         max = 1),
            numericInput("p",
                         "Design prevalence",
                         value = 0.01,
                         min = 0,
                         max = 1)
        ),
     
        ## Show a plot of the generated distribution
        mainPanel(
            fluidRow(
                column(8, h3("Description"), HTML(exTxt))
            ),
            fluidRow(
                column(
                    width = 4,
                    h4("Sample size"),
                    textOutput("sampSize")),
                column(
                    width = 4,
                    h4("Apparent prevalence"),
                    textOutput("appPrev"))
            ),
            fluidRow(
                column(8, h3("Confidence statement"),
                       textOutput("confState")
                       )
            )
        )
    )

    ## Change
    ## includeCSS("~/github/Website/css/app.css")
)
