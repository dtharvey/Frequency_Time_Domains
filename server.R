# server for fourier transform

library(shiny)
library(shinythemes)
library(shinyBS)

# set colors
palette("Okabe-Ito")

shinyServer(function(input,output,session){
  
  output$domains = renderPlot({
    # set x-axis and vector of y-values
    x = seq(1,512,1)
    y1 = rep(0,512)
    y2 = rep(0,512)
    
    # calculate signal
    s1 = input$w1/2
    s2 = input$w2/2
    h1 = input$a1/(pi*s1)
    h2 = input$a2/(pi*s2)
    y1 = h1 * (1 + (x - input$p1)^2/s1^2)^{-1}
    y2 = h2 * (1 + (x - input$p2)^2/s2^2)^{-1}
      # y1 = input$a1/(pi*input$w1) * (1 + ((x - input$p1)/input$w1)^2)^-1
      # y2 = input$a2/(pi*input$w2) * (1 + ((x - input$p2)/input$w2)^2)^-1
      
      # y1 = input$a1/(pi*input$w1) * (1 + (x - input$p1)^2/input$w1^2)^-1
      # y2 = input$a2/(pi*input$w2) * (1 + (x - input$p2)^2/input$w2^2)^-1
 
    # if including second peak, then combine data for two peaks
    if (input$include2 == "yes") {y = y1 + y2} else {y = y1}
    
    # complete fft
    yfft = fft(y)
    yfft1 = fft(y1)
    yfft2 = fft(y2)
    
    # create plots
    layout(mat = matrix(c(1,2),
                        nrow = 2,
                        ncol = 1),
           heights = c(1.25,2))
    if(input$include2 == "no"){
    plot(x = x[1:256], y = y[1:256], type = "l", 
           lwd = 1, col = 6, ylim = c(0,max(y)),
           xlab = "frequency", ylab = "signal",
                main = "frequency domain spectrum")
    grid()
    plot(x = x[1:256], y = Re(yfft[1:256]), type = "l", 
         lwd = 1, col = 6, 
         xlab = "time", ylab = "signal",
         main = "time domain spectrum")
      grid()
    }
    if(input$include2 == "yes" & input$showspectra == "no"){
      plot(x = x[1:256], y = y[1:256], type = "l", 
           lwd = 1, col = 6, ylim = c(0,max(y)),
           xlab = "frequency", ylab = "signal",
           main = "frequency domain spectrum")
      grid()
      plot(x = x[1:256], y = Re(yfft[1:256]), type = "l", 
           lwd = 1, col = 6, 
           xlab = "time", ylab = "signal",
           main = "time domain spectrum")
      grid()  
    }
    if(input$include2 == "yes" & input$showspectra == "yes"){  
      plot(x = x[1:256], y = y[1:256], type = "l", 
           lwd = 1, col = 6, ylim = c(0,max(y)),
           xlab = "frequency", ylab = "signal",
           main = "frequency domain spectrum")
      grid()
      plot(x = x[1:64], y = Re(yfft[1:64]), type = "l", 
           lwd = 2, col = 6, 
           xlab = "time", ylab = "signal",
           main = "time domain spectrum")
      grid()
      lines(x = x[1:64], y = Re(yfft1[1:64]),
              lty = 2, col =  4, lwd = 2)
        lines(x = x[1:64], y = Re(yfft2[1:64]),
              lty = 3, col = 7, lwd = 2)
        legend(x = "topright",
               legend = c("peak 1", "peak 2", "sum"),
               lty = c(2,3,1), lwd = 2, col = c(4,7,6), bty = "n")
        grid()
      }
    })
}) # close server
