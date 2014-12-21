library(ggplot2)
library(datasets)
data(cars)

speedCoef <- function(s) {
        if (s=="km.per.h") {c <- 1.60934}
        else if (s=="m.per.s") {c <- 0.44704}
        else {c <- 1}
        c
}

distCoef <- function(s) {
        if (s=="meters") {c <- 0.3048}
        else {c <- 1}
        c
}

speedToString <- function(s, units) {
        if (units=="km.per.h") {c <- paste(as.character(s),"km per hour",sep=" ")}
        else if (units=="m.per.s") {c <- paste(as.character(s),"m per second",sep=" ")}
        else {c <- paste(as.character(s),"miles per hour",sep=" ")}
        c
}

distToString <- function(s, units) {
        if (units=="meters") {c <- paste(as.character(s),"meters",sep=" ")}
        else {c <- paste(as.character(s),"feet",sep=" ")}
        c
}


shinyServer(
        function(input, output) {
                CAR <- reactive({
                        data.frame(dist=cars$dist*distCoef(input$dist.units),
                                   speed=cars$speed*speedCoef(input$speed.units),
                                   sq=(cars$speed*speedCoef(input$speed.units))^2)
                })
                K <- reactive({coef(lm(data=CAR(), dist ~ sq -1))})
                given.speed <- reactive({as.numeric(input$speed)})
                predicted.distance <- reactive({K()*(given.speed())^2})
                output$newPlot <- renderPlot({    
                        pred.dist <- function(x) {
                                K()*x^2
                        }
                        X0 <<- given.speed()
                        Y0 <<- predicted.distance()
                        P <- ggplot(CAR(), aes(y=dist, x=speed)) +
                                geom_point() +  #geom_smooth(method=lm) +
                                ggtitle("Speed vs stopping distance") +
                                xlab(input$speed.units) + 
                                ylab(input$dist.units) + 
                                xlim(0,50*speedCoef(input$speed.units)) +
                                ylim(0,250*distCoef(input$dist.units)) +
                                geom_point(aes(x=X0, y=Y0), 
                                           color="red",size=5) +
                                stat_function(fun=pred.dist,color="blue")
                        P                         
                })
                output$inputValue <- renderText({speedToString(input$speed,input$speed.units)})
                output$predictedDistance <- renderText({
                        distToString(round(predicted.distance(),2),input$dist.units)
                })
                output$inputDist <- renderText({input$dist.units})
                output$inputSpeed <- renderText({input$speed.units})
        }
)
