#The UI object is implemented near the bottom of the page.
#The parts of the UI implemented at the top and combined into the UI object.

#the title bar at the top of the page
dbHeader <- dashboardHeader(title="Exploring DBSCAN")

#the opened sidebar at the left of the page, the list of all of its menuItems.
#the menu items have tabNames which refer to a tabItem in the body.
dbSidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Learn", icon=icon('font-awesome', lib='font-awesome'), startExpanded=TRUE,
             menuSubItem("What is DBSCAN?", tabName="whatisDBSCAN"),
             menuSubItem("How does it work?", tabName="howDBSCAN")
             ),
    menuItem("Examples", icon=icon('circle-check', lib='font-awesome'), tabName="examplesDBSCAN"),
    menuItem("Try it out", icon=icon('pen-to-square'), tabName="tryDBSCAN"),
    br(),
    menuItem("Further research", icon=icon('chart-bar', lib='font-awesome'), tabName="researchDBSCAN")
  )
)

#Contains a list of tabItem, which are basically what will be shown in the main area of
#the page whenever a specific menuItem in the sidebar is activated.
dbBody <- dashboardBody(
  tabItems(
    tabItem(tabName = "whatisDBSCAN", 
            fluidRow(
              tags$head(
                tags$style(HTML("
                body {
                    max-width: inherit;
                    margin: auto;
                    padding: 0;
                    line-height: 1.5;
                }
                p, span{
                  font-size:1.5em;
                }
                img{
                  margin: 20px 20px;
                }
                ul.nav.nav-tabs{ 
                  background: #3c8dbc;
                  background-color:#3c8dbc;
                }
                .nav-tabs-custom>.nav-tabs>li.header {
                  line-height: 35px;
                  padding: 0 10px;
                  font-size: 18px;
                  color: #FFFFFF;
                }
                .main-container p, .main-container span{
                  font-size:initial;
                }
                .content-wrapper{
                   width:auto;             
                }
                #clusterPlot img {
                  margin:0px;
                }   
                #plotData img {
                  margin:0px;
                }
                #epsPlot img {
                  margin:0px;
                }
                                ")) #i hate this formatting, this is like indentation hell
              ),
              column(width=10, offset=1, #basically offset of 1 on both sides
                     box(
                       width=NULL,
                       h1("What is DBSCAN?"),
                       p("Density-Based Spatial Clustering of Applications with Noise (DBSCAN) is an unsupervised 
                         machine learning clustering algorithm. It's called an unsupervised algorithm because it's trained
                         on dataset without labels; its purpose isn't regression or classification."), 
                       br(),
                       
                       div(img(src='machine_learning_methods.png', width="80%"), align="center"),
                       div(a("https://www.researchgate.net/figure/Examples-of-real-life-problems-in-the-context-of-supervised-and-unsupervised-learning_fig8_319093376"), align="center"),
                       br(),
                       
                       p("Instead, it's used to find patterns
                         that exist in the data which can then be used for further analysis as a part of an exploratory data analysis 
                         or it can have immediate practical use."),
                       br(),
                       p("1) For example, it can either yield insight about fertility in certain fields of a farm,
                         or it can reveal faulty equipment producing anomalous outlier results."),
                       p("2) It's a clustering algorithm, which means that it identifies groups in the data based on a distance
                         measurement. In this case, that is the Euclidean distance or the distance between two points on a graph."),
                       hr(),
                       
                       h2("What does it do?"),
                       span("Basically, DBSCAN checks, point by point, if a point can be considered as a ",strong("core")," or a backbond of a
                            group of data or if it’s just a part of the ",strong("border")," of that group. If the data point doesn’t belong to
                            any group of data, it’s considered noise: an ",strong("outlier"),". It creates groups in a natural way: it's similar
                            to how you would expect humans to identify clusters on a graph."),
                       br(),
                       
                       h2("How can it be used?"),
                       p("DBSCAN can specifically be used to find oddly shaped clusters of data, instead of just clusters that resemble 
                         a circle or a convex shape in the same way that the similar unsupervised algorithm K-means clustering would."),
                       div(img(src='kmeans_vs_dbscan.png', width='80%'), align="center"),
                       div(a("https://miro.medium.com/max/1400/1*KqWII7sFp1JL0EXwJGpqFw.png"), align="center"),
                       p("The image above shows how K-means might seem limited compared to DBSCAN. The biggest takeaway for DBSCAN is that it 
                         can capture the shapes of the clusters of data based on the density of plotted points, and it has the potential to identify outliers very well. 
                         It has weaknesses that should be considered however. These will be highlighted later."),
                       br(),
                       
                       h2("When do we use something like DBSCAN?"),
                       p("Unsupervised learning, specifically clustering in this case, should be used when trying to observe patterns in data, 
                         which is not the same as trying to create models which attempt to explain the variance of data by using supervised learning. 
                         Something like DBSCAN might be appropriate if..."),
                       p("1) Labeling data for an un-labeled data set would consume too much time/resources and there is an interest for insight about the data set."),
                       p("2) The goal is to try to create a new predictor for a classifier. i.e. if a value happens to be in a specific column category."),
                       p("3) The shape of the clusters identified might matter."),
                       p("4) The goal is to find outliers which could represent faults in a system or a case of fraud in a specific dataset."),
                       p("5) More insight can be gained from the information as a part of a exploratory data analysis."),
                       
                       span("Lastly, it is not recommended that DBSCAN would be used ",em("as a conclusion")," to a data analysis, because it produces a 'weak' output and isn't 
                            likely to solve a problem accurately. It is easy to 'wastefully' use clustering or DBSCAN.")
                     ))
            )),
    tabItem(tabName="howDBSCAN",
            fluidRow(
              column(width=10, offset=1,
                     box(
                       width=NULL,
                       h1("How does it work?"),
                       p("The DBSCAN algorithm works by determining if a point can be called one of three types of points: 
                         a core point, an edge point, or a border point. In this process, it consequently highlights clusters in the data."),
                       div(img(src="dbscan_image.png", width="30%", height="30%"), align="center"),
                       div(a("https://i.stack.imgur.com/5aikc.png"), align="center"),
                       br(),
                       p("DBSCAN in two dimensions can only work on two columns of data at a time. This just means you have to extract two columns for analysis from each object in the dataset. 
                       Each point is labeled as one of the three mentioned types by using the distances of points plotted using the two dimensions."),
                       p("There are two parameters to DBSCAN that affect how it decides clusters. The first is a defined distance which 
                         acts as a radius to a circle that we can imagine around each point which is called epsilon or ‘eps.’ The second 
                         is the minimum number of points within the radius of a point that would be needed to label that point accordingly: ‘minPts.’"),
                       hr(),
                       
                       div(
                         h2("The steps of the algorithm, using the matrix-based implementation"),
                         p("i.	Initialize a matrix with the Euclidean distances between all points on the graph. "),
                         p("ii.	Iterate to the next randomly selected point that doesn't belong to a cluster yet."),
                         p("iii.	Find each Euclidean distance between the currently selected point and the rest of the points. This means finding the rest of the columns
                         in the row of the matrix for the Euclidean distances that have already been calculated."),
                         p("iv. Given these distances, label the point according to the cluster it belongs. Are there any distances that are less than or equal to eps 
                           (within the radius of the circle that can be imagined by length eps)? If there are no distances, then the 
                           point is called a noise point, or an outlier. If there are at least MinPts distances, then the point is called a core point. 
                           If there are less than MinPts distances and if one of the distances is to a core point, then point is called a border point. "),
                         p("v.	If there are still points that don't belong to a cluster or aren't marked as an outlier yet, go back to the second step. If not, return the list of points detailing if they’re an outlier or 
                           a part of a cluster. "),
                         em("The result of this algorithm on a set of points is shown in the above image."),
                         br()
                       ),
                       
                       h2("How to implement it"),
                       p("Unlike K-Means, DBSCAN can be a little confusing because there is no generally known efficient or automatic way to decide an optimal value of minPts, and then eps. And to find a value requires knowledge about the
                         data that is being used. It's a sacrifice for the powerful ability of being able to determine the shapes of clusters. There are guidelines for how it can be set however.
                         Before setting these values, it's generally recommended to make sure that the data being used is scaled and has all NA values removed. This is to ease the process of deciding values for 
                         the parameters by decreasing the differences and the spread of the value of the columns used as data."),
                       p("Remember that, when interpreting DBSCAN outputs, any insight gained is based off of distances between data points on a graph. Whether this actually holds any value must be decided based 
                       off of whether plotting the columns of data makes sense."),
                       p("If there isn't a minPts parameter that can be guessed before working with the data, then there are two rules that can be followed. The first is that minPts can be set to a rounded value 
                       of ln(n), where n is the number of points to be clustered [1]. The next is to consider the number of dimensions in the data and just use that as the value of minPts [2]. Generally, as the 
                       noise in the data increases so also should the value used for minPts."),
                       p("Once a value for minPts has been decided, an optimal value for eps can be found by using the K-nearest neighbors algorithm. K-NN is normally used for classification, and its basic idea 
                         is to determine the class of a point by looking at the classes of the 'k' nearest points to it and guessing based off calculations using those points. This will be explored later near the 
                         end of the section with the examples."),
                       p("As a spoiler, the process involves finding an elbow in a graph that shows how eps increases for a sorted list of distances and using the value of eps, or distance, at that elbow. Interestingly, 
                         this process of finding an 'elbow' in a sort of graph is common for optimizing parameters for most density-based clustering functions such as deciding the optimal number 
                         of clusters in k-Means. Isn't that cool?"),
                       br(),
                       
                       h3("Interesting notes:"),
                       p("1.	A matrix-based implementation of the algorithm requires O(n^2) memory, with a worst-case time complexity of O(n^2). It can be expensive to run. "),
                       p("2.	It is not easy to assume a minPts parameter value that easily makes sense without expert knowledge of the information. K-means clustering isn’t 
                         hindered by something like this, and the optimal number of clusters can be chosen using systematic methods. "),
                       p("3.	It doesn’t tolerate a variety in the density of data very well i.e. one side of a graph has more points than another side. ")
                     ))
            )),
    #The includeHTML function is bugging out, so I have to use tags$iframe instead to import my HTML renders. 
    tabItem(tabName="examplesDBSCAN",
            fluidRow(
              column(width=10, offset=1,
                     box(
                       width=NULL, height="100%",
                       h1("Using DBSCAN"),
                       h2("First example: USArrests data set"),
                       
                       htmltools::tags$iframe(src="example_1.html", height=1600, width="100%", style="overflow:hidden; border:none;"), 
                       
                       p("It's easy to notice that there are three groups. Two of them have either a high or low UrbanPop but still have a relatively high Assault rate. 
                         The other group has a varying UrbanPop but a relatively low crime rate. It could be interesting to investigate the weighted mean of the locations of 
                         the places in each cluster i.e. is there a general area or coordinate in the U.S. that may be indicated by a low urban population and a low assualt rate? 
                         We might be able to use the green cluster to answer something like this.")
                     )
              )),
            fluidRow(
              column(width=10, offset=1,
                     box(
                       width=NULL,
                       h2("Second example: The holy DBSCAN example"),
                       p("It has been seen how DBSCAN could be used as a clustering algorithm, but what benefit does it have over k-means clustering? When using that method, 
                         there is a well known algorithm for finding the optimal number of clusters for the best separation of data. While there is a similar method for defining 
                         an eps value, there isn't one for determining a minPts value that maximizes the separation of the data. Instead, again, the use case of DBSCAN is when there 
                         are discrete shapes in the data that can't otherwise be identified by simply defining a number of clusters. It is observed that DBSCAN works relatively closely 
                         to how people might identify clusters by sight. "),
                       htmltools::tags$iframe(src="example_2.html", height=2600, width="100%", style="overflow:hidden; border:none;"), 
                       
                       #includeHTML("example_2.html"),
                       p("We were able to capture the various shapes of the data very well! K-means was not able to separate the data into discrete shapes that make sense.")
                     )
              )),
            fluidRow(
              column(width=10, offset=1,
                     box(
                       width=NULL,
                       h2("Third example: Bananas!"),
                       p("The next case we will investigate is a similar one by the way of odd shapes: banana-shaped clusters of data. The banana shapes can be seen if the differences in density are noticed. "),
                       htmltools::tags$iframe(src="example_3.html", height=2870, width="100%", style="overflow:hidden; border:none;"), 
                       
                       #includeHTML("example_3.html"),
                       p("It looks like, at best, we can try to roughly get the area around the banana in the middle of the picture, and use the outliers to get a rough idea of the shape of where the banana could be. 
                          Even if we weren't able to capture the banana shape well, we know that in this example of a data being in discrete shapes, our method would be more effective in clustering according to the 
                         class than k-means clustering would. ")
                     )
              )),
            fluidRow(
              column(width=10, offset=1,
                     box(
                       width=NULL,
                       h2("Fourth example: Wheat Kernels"),
                       p("In the next example, we will observe a data set with three different class labels for three different types of wheat kernels. Maybe we can look at significant predictors 
                        in the data and see if different clusters on an axis are common. 
                        The seven variables are known: 
                        1) area A, V1.
                        2) perimeter P, V2.
                        3) compactness C = 4piA/P^2, V3.
                        4) length of kernel, V4.
                        5) width of kernel, V5.
                        6) asymmetry coefficient, V6.
                        7) length of kernel groove, V7.
                        To make our observation of data most diverse, it was guessed that two pairs might be very significant: (area, length of kernel) and (length of kernel, length of kernel groove)"),
                       htmltools::tags$iframe(src="example_4.html", height=2840, width="100%", style="overflow:hidden; border:none;"), 
                       
                       #includeHTML("example_4.html"),
                       p("Notice that we can either force our data to look like what we might want it to and suffer much outliers, sort of like overfitting in supervised learning, or we can have a generalized model 
                         as we did in the second example.")
                     )
              )),
            fluidRow(
              column(width=10, offset=1,
                     box(
                       width=NULL,
                       h2("Fifth example: Harvesting Eucalyptus"),
                       p("How much of the eucalyptus can be successfully harvested from specific physical fields of the plant in this data set?"),
                       htmltools::tags$iframe(src="example_5.html", height=1900, width="100%", style="overflow:hidden; border:none;"), 
                       
                       #includeHTML("example_5.html"),
                       p("It looks like ranges of fields where eucalyptus plants were planted become discrete. It's also noticed that the shapes of the two major clusters are different. 
                         One is broad but the other is narrow, producing the tallest trees and likely the most value in eucalyptus that can be harvested. A new predictor for whether an observation
                         is in the narrow cluster might be useful in producing an arbitrary supervised model with a higher accuracy for classifying eucalyptus yield.")
                     )
              )),
            fluidRow(
              column(width=10, offset=1,
                     box(
                       width=NULL,
                       h2("Optimizing minPts and eps"),
                       #includeHTML("optimizing_example.html"),
                       htmltools::tags$iframe(src="optimizing_example.html", height=1400, width="100%", style="overflow:hidden; border:none;"), 
                       
                       p("Trying to optimize the eps value seemed to highlight the big empty void between the two larger clusters. It would be interesting to guess what reason for that void
                         could be. It may just be infertile farming land. It seems like trying to optimize our clustering while keeping minPts constant made our broader major cluster more narrow,
                         which is interesting.")
                     )
              ))
            ),
    tabItem(tabName="tryDBSCAN",
            fluidRow(
              column(width=6,
                     box(title="Inputs", solidHeader=TRUE, width=NULL, status="primary", height="100%",
                         fluidRow(
                           h3("Data options", align="center"),
                           column(width=4,
                                  selectInput(inputId = "dataX", label="first column / attribute", 
                                              choices=c("Murder", "Assault", "Rape", "UrbanPop")) 
                           ),
                           column(width=4,
                                  selectInput(inputId = "dataY", label="second column / attribute", 
                                              choices=c("Murder", "Assault", "Rape", "UrbanPop")) 
                           ),
                           column(width=4,
                                  checkboxInput(inputId="scale", "Scale data", value=TRUE, width = "100%")
                           )
                         ),
                         hr(),
                         fluidRow(
                           h3("Cluster options", align="center"),
                           column(width=6,
                                  textInput(inputId="eps", label="Epsilon (eps) value")
                            ),
                           column(width=6,
                                  textInput(inputId="minPts", label="Minimum points (minPts) value")
                            )
                         ),
                         hr(),
                         fluidRow(
                           h3("Appearance options", align="center"),
                           column(width=6, align="center",
                              checkboxInput(inputId="point", "Points will represent observations", value=TRUE, width = "100%")
                           ),
                           column(width=6, align="center",
                              checkboxInput(inputId="text", "Text will represent observations", value=FALSE, width = "100%")
                           )
                         ),
                         fluidRow(
                           column(width=6, align="center",
                                  checkboxInput(inputId="ellipse", "Show ellipse around clusters", value=FALSE, width = "100%")
                           ),
                           column(width=6, align="center",
                                  checkboxInput(inputId="center", "Show cluster centers", value=FALSE, width = "100%")
                           )
                         ),
                         actionButton(inputId="execute", label="Execute")
                         
              )),
              column(width=6,
                     tabBox(title = tagList("Outputs"), width=NULL,  height="100%", selected="Clusters", 
                         tabPanel("Clusters", 
                                  verbatimTextOutput(outputId="dbscanResult")
                                  ),
                         tabPanel("Plot",
                                  plotOutput(outputId="clusterPlot", height="60vh", width="100%")
                                  ),
                         tabPanel("View",
                                  verbatimTextOutput(outputId="headData"),
                                  plotOutput(outputId="plotData", height="40vh", width="100%")
                                  )
              ))
            ),
            fluidRow(
              #column(width=4, offset=2,
              #       box(title="K-means Helper", solidHeader=TRUE, width=NULL,status="warning", height="100%",
              #        p("help")
              #)),
              column(width=6, offset=3, align="center",
                     box(title="Eps graph", solidHeader=TRUE, width=NULL, status="warning", height="100%", 
                     plotOutput(outputId = "epsPlot", height="40vh", width="100%")
              )),
            )
        ),
    tabItem(tabName="researchDBSCAN",
            fluidRow(
              column(width=10,offset=1,
                     box(
                       width=NULL,
                       h1("Further research for DBSCAN"),
                       p("There are still things that I didn't get to covering here, but are worth looking into."),
                       br(),
                       h2("Dimensionality reduction: "),
                       p("While researching implementations of DBSCAN and how it could be used, the most interesting idea found was using dimensionality reduction to focus multiple
                         columns into a maybe two or three columns. These columns, largely explaining the variance in the data and trying to represent it in a collective way, could 
                         be used to more accurately cluster data points. Because it is known that more columns (or more features: more dimensions) can decrease accuracy in machine 
                         learning models, dimensionality reduction can be used to try to minimize the inaccuracy and prepare our data to be used by a 2D DBSCAN method."),
                       p("Another interesting idea that could beworth looking into for beginning analysis on data could be to using something like Principle Components Analysis (PCA) to 
                       find the first two principle components for the purpose of finding the first two variables that best describe the data. Then these variables can be used in DBSCAN, and may reveal significant groups in the data. "),
                       br(),
                       h2("Clustering metrics: "),
                       p("Some standard clustering metrics are the Silhouette Coefficient, Calinski-Harabasz index, and Davies-Bouldin index. However, these all have their own assumptions 
                         that must be met. The Silhouette Coefficient measures how distinguished clusters are, but it can’t be used with DBSCAN because it assumes that clusters are a convex shape. 
                         Instead, DBCV is the only metric that was found to be compatible with DBSCAN. "),
                       
                       br(),
                       h2("Using DBSCAN in higher dimensions: "),
                       p("Self-explanatory: just use DBSCAN in the 3rd dimension or higher. It only requires changing the matrix to be of three dimensions and the calculation of distances to be in three dimensions if using a 3rd dimension implementation.")
                     ))
            ))
  )
)



ui <- dashboardPage(
  setBackgroundColor(
    color = c("#9221a6", "#e67959"),
    gradient = "linear",
    direction = "bottom",
    shinydashboard = TRUE
  ), #causing an issue with .content-wrapper width attribute. Fixed with custom css in body
  header=dbHeader,
  sidebar=dbSidebar,
  body=dbBody,
  skin=c("purple")
)