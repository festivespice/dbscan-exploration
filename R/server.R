#global functions

server <- function(input, output){
  #functions and values for every visitor
  data("USArrests") #Built-in R data set
  arrestData <- as.matrix(USArrests[, 1:4])
  glimpseDataOutput <- glimpse(USArrests[, 1:4])
  
  
  verifyInputs <- function(dataX, dataY, eps, minPts){
    #TODO: verify that minPts is integer.
    dataValid <- TRUE
    invalidMessages <- c()

    if(dataX == dataY){
      dataValid <- FALSE
      invalidMessages <- append(invalidMessages, "The X and Y columns cannot be the same: choose different ones.")
    }
    if(!is.na(eps)){
      if(eps <= 0.0){
        dataValid <- FALSE
        invalidMessages <- append(invalidMessages, "Your eps value must be greater than 0.")
      }
    }
    if(!is.na(minPts)){
      if(minPts < 1){
        dataValid <- FALSE
        invalidMessages <- append(invalidMessages, "The value of minPts must be greater than 1.")
      }
    }
    if(is.na(minPts)){
      dataValid <- FALSE
      invalidMessages <- append(invalidMessages, "Your minPts value may not be empty.")
    }
    if(is.na(eps)){
      dataValid <- FALSE
      invalidMessages <- append(invalidMessages, "Your eps value may not be empty.")
    }
    return(list(dataValid, invalidMessages))
  }
  
  #in our server interaction most of the parameters of these functions will use input$ and will make return values go to $output
  
  formatData <- function(willScale, columns){
    inputData <- 0
    if(willScale){
      inputData <- arrestData %>%
        na.omit() %>%
        scale()
    }else{
      inputData <- arrestData %>%
        na.omit()
    }
    inputData <- inputData[, columns] #returns two desired columns of data.
    return(inputData)
  }
  
  performClustering <- function(data, eps, minPts){
    outputCluster <- dbscan::dbscan(x=data, eps=eps, minPts=minPts)
    return(outputCluster)
  }
  
  getClusterInformation <- function(clusterObject){
    output <- paste(c("Sequence of cluster labels where each label is associated with an observation:", clusterObject$cluster), collapse=", ")
    return(output)
  }
  
  getClusterPlot <- function(clusterObject, data, points, text, ellipse, centers){
    geom <- c()
    if(points){
      geom <- append(geom, "point")
    }
    if(text){
      geom <- append(geom, "text")
    }
    plot <- fviz_cluster(object=clusterObject, stand=FALSE, data=data, geom=geom, ggtheme=theme_bw(), 
                 show.clust.cent = centers, ellipse = ellipse, pointsize=1.5, outlier.pointsize = 0.5, labelsize=12,
                 outlier.labelsize = 7, repel=TRUE)
    return(plot)
  }
  
  getEpsPlot <- function(data, minPts){
    plot <- dbscan::kNNdistplot(x=data, minPts=minPts)
    return(plot)
  }
  
  getDataPlot <- function(data){
    dfData <- as.data.frame(data)
    plot <- ggplot(data=dfData, aes(x=dfData[, 1], y=dfData[, 2])) + 
      geom_point() 

    return(plot)
  }
  
  getDataInformation <- function(data){
    return(head(data))
  }
  
  getKnnPlot <- function(data, minPts){
    plot <- dbscan::kNNdistplot(x=data, minPts=minPts)
    return(plot)
  }
  
  #server interactions
  #check if the inputs are valid. If not, give specific feedback
  clusteringInputs <- eventReactive(input$execute, {
    datax <- as.character(input$dataX)
    datay <- as.character(input$dataY)
    eps <- as.numeric(input$eps)
    minPts <- as.integer(input$minPts)

    inputStatus <- verifyInputs(dataX = datax, dataY = datay, eps = eps, minPts = minPts)
    if(inputStatus[[1]]){ #if data is valid
      #add dbscan object, add cluster plot, add cluster information.. The next index is len + 1
      dbscanResults <- inputStatus
      dbscanResults[[length(dbscanResults)+1]] <- formatData(input$scale, c(datax, datay)) #uses column names
      
      dbScanData <- dbscanResults[[length(dbscanResults)]]
      dbscanResults[[length(dbscanResults)+1]] <- performClustering(data=dbScanData, eps, minPts)
      return(dbscanResults)
    }else{ #if data is not valid
      return(inputStatus)
    }
  }, ignoreNULL = TRUE)
  
  #clusteringInputs returns whether input is valid, validity messages, the data matrix, and the cluster object
  #for every instance of input$<> outside of the reactive expression, make sure to isolate()
  output$dbscanResult <- renderPrint({
    if(clusteringInputs()[[1]]){
      dbscanObject <- (clusteringInputs()[[4]])
      print(dbscanObject)
      dbscanInformation <- getClusterInformation(clusterObject = dbscanObject)
      print(dbscanInformation)
    }else{
      print(clusteringInputs[[2]])
    }
  })
  
  output$clusterPlot <- renderPlot({
    if(clusteringInputs()[[1]])
    {
      dbscanObject <- (clusteringInputs()[[4]])
      dbscanData <- (clusteringInputs()[[3]])
      
      plot <- getClusterPlot(clusterObject=dbscanObject, data=dbscanData, points=isolate(input$point), text=isolate(input$text), ellipse=isolate(input$ellipse), centers=isolate(input$center))
      print(plot)
    }
  })
  
  output$headData <- renderPrint({
    if(clusteringInputs()[[1]])
    {
      dbscanData <- (clusteringInputs()[[3]])
      
      dataInfo <- getDataInformation(data=dbscanData)
      print(dataInfo)
    }
  })
  
  output$plotData <- renderPlot({
    if(clusteringInputs()[[1]]){
      dbscanData <- (clusteringInputs()[[3]])
      
      plot <- getDataPlot(data=dbscanData)
      print(plot)
    }
  })
  
  output$epsPlot <- renderPlot({
    if(clusteringInputs()[[1]]){
      dbscanData <- (clusteringInputs()[[3]])
      minPts <- as.integer(isolate(input$minPts))
      
      plot <- getKnnPlot(data=dbscanData, minPts = minPts)
      print(plot)
    }
  })
}