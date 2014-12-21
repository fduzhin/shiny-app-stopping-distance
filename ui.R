shinyUI(fluidPage(
        titlePanel("Prediction of stopping distance of an old car"),
        
        sidebarLayout(
                sidebarPanel(
                        textInput('speed', label=h4("The car's speed"),value="19.5"),
                        selectInput("speed.units", label = h4("units of speed"), 
                                    choices = list("mph"="miles.per.h", 
                                                   "km/h"="km.per.h", 
                                                   "m/s"="m.per.s"), selected = "km.per.h"),
                        selectInput("dist.units", label = h4("units of stopping distance"), 
                                    choices = list("feet"="feet", 
                                                   "meters"="meters"), selected = "meters")
                ),
                
                mainPanel(
                        tabsetPanel(
                                tabPanel("Prediction and plot",
                                        plotOutput('newPlot'),
                                        h4('You entered'),
                                        verbatimTextOutput("inputValue"),            
                                        h4('The predicted stopping distance is'),
                                        verbatimTextOutput("predictedDistance")
                                        ),
                                tabPanel("Documentation",
                                         h3("General info"),
                                         p("We used the dataset cars in R to construct a model
                                           that predicts the stopping distance of a car.
                                           The dataset was collected in 1920s. Thus our model
                                           will only be applicable to old cars"),
                                         p("To use our app, simply type the speed of the car in the 
                                           textbox and choose the units of speed (miles per hour,
                                           kilometers per hour, or meters per second) 
                                           and distance (meters or feet) you want to work with."),
                                         p("The app will show the stopping distance, i.e., how long
                                           the car will go before it stops if you apply the brake
                                           at the given speed."),
                                         p("The plot shows the original dataset cars with black dots
                                           with stopping distance vs the speed. The blue curve is
                                           our model. It's a parabola since the stopping distance
                                           is proportional to kinetic energy, which is a 
                                           quadratic function of the speed. The red dot indicates
                                           the input speed and the predicted stopping distance."),
                                         h4("Dealing with incorrect input"),
                                         p("The app works well with speeds between 0 and 64 km.h.
                                           If you enter a bigger number, it will predict the
                                           stopping distance correctly but won't plot it.
                                           If you enter a negative number, the app will
                                           predict the same stopping distance as it were a 
                                           positive number. If you enter a non-numeric string, the
                                           result will be NA."),
                                         h4("Warnings"),
                                         p("Using this app, you must remember that the data
                                           set it is based on was collected in 1920s with cars
                                           equipped with old inefficient drum brakes. Thus it
                                           cannot be used to predict a stopping distance of a 
                                           new car."),
                                         p("Our model doesn't include either car's weight or the
                                           road conditions (like wet vs dry road). Also, we
                                           just calculated the average stopping distance and
                                           didn't do the confidence interval. You must 
                                           remember that it's a very simple model.")
                                         )
                        )
                )
        )
))