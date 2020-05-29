#install.packages("shiny")
library("shiny")
library(arules)  
library(arulesViz)
library(htmltools)

headerImagePanel <- function(title, src) {
  div(
    style = "display: inline; position: relative",
    img(
      src = src, 
      style="width:110%;min-height:100%;background-size:cover; min-width:100%; position: fixed;z-index:-1;opacity:0.4;top:0;left:0;"
    ),
    h1(img(
      src = "https://www.syracuse.edu/wp-content/uploads/heritage-logo-syracuse-university-orange.png",style = "height: 80px;width: 80px;"
    ),title, 
    img(
      src = "https://clrc.org/wp-content/uploads/2015/07/SUiSchoollogo.jpg",style = "height: 65px;width: 250px;"
    ),
    style="display: table;color:white;font-size:3em;font-weight: bold;background-color: #3B5998;border-bottom: 5px solid black;
    width:100%;border-top: 5px solid black;border-right: 5px solid black;border-left: 5px solid black;text-align: center")
)}
ui <- fluidPage(
  tags$style(HTML("
    .tabbable > .nav > li > a {background-color: #008080;color:white; width:103%;font-size:1em;font-weight:bold;margin-top:12px;border:5px solid white;
    text-align:left}
  ")),
  headerImagePanel("CLASSIFICATION of CARS on AUCTION DATA",
                   "https://images.unsplash.com/photo-1485291571150-772bcfc10da5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=800&q=80"),
  #titlePanel("CLASSIFICATION of CARS USING AUCTION DATA",align = "center", style = "color: white",img(src = "https://www.fillmurray.com/1920/1080",height  = 250, width = 250)),
    mainPanel(
      tabsetPanel(
                  tabPanel('ABOUT',
                           h3("1. Problem Statement",style = "font-weight: bold;color:maroon"),
                           h4("Auto dealers who purchase used cars at an auto auction face the risk of buying a bad car with a lot of issues, 
                              because of which they will not be able to re sell it to their customers. The auto community refer to these unfortunate purchases as kicks.
                              Purchased cars are declared as bad cars if there are tampered odometers, mechanical issues or other unforeseen problems with the car. 
                              These bad cars can be a huge financial burden on the car dealers because of all the transportation, throw-away and repair costs that they must bear with. 
                              By predicting if a car is going to be a bad buy or not, we can help the dealers make wise and informed decisions on the cars that they need to
                              purchase which can in turn help them minimize their incurred loss and maximize profits.",style = "font-weight: bold;color:black"),
                           h3("2. Project Objective",style = "font-weight: bold;color:maroon"),
                           h4(
                             "The objective of the project is to help the car dealers accurately predict if a purchased car is going to be a good buy or a bad buy. 
                             The predictions made will help the car dealers take informed decisions on the cars that they should go ahead and purchase and on the cars 
                             that they should refrain from purchasing. 
                             We will also try to identify the most important attributes that will help us predict if a purchased car is going to be a good buy or a bad buy.",
                             style = "font-weight: bold;color:black"),
                           h3("3.	Dataset Description",style = "font-weight: bold;color:maroon"),
                           h4("We have a separate collection for train and test dataset. Based on the number of records, the train and test dataset are 
                              divided in the ratio 3:2. The training dataset has a total of 34 assessment parameters, one of which is the target variable. 
                              The group of independent variables we have is a mix of categorial and numerical type of data. There are 20 categorical, 
                              11 continuous numerical and 3 discrete numerical variables. The target attribute is a binary variable with 64007 good buys 
                              and 8976 'bad buys'. The large disparity between the counts of 2 classes in the target variable makes our dataset imbalanced. 
                              Most of the independent variables in our data describe various specifications of the auctioned car such as model, color, 
                              Wheel Type etc. Remaining attributes inform us about the acquisition and current price of that car during auction and retail 
                              sales. This dataset contains no NA's, but it has missing values. They are defined as a string value named NULL. 
                              18 of those 33 independent attributes contain NULL string values which must be treated. Link to dataset",style = "font-weight: bold;color:black"),
                           h3("4.	Data Science Methodology",style = "font-weight: bold;color:maroon"),
                           h4("Approach begins with identifying Data Quality issues and cleaning which includes handling missing/NA values and 
                              special characters, deleting duplicate values, treating unwanted outliers.Data Cleaning was followed by Exploratory 
                              Data Analysis using descriptive statistics by performing univariate analysis and bi variate analysis
                              involving the target variable accompanied by visualizations and examining the Correlations.",style = "font-weight: bold;color:black"),
                             h4("We employed the following techniques as part of Data Preprocessing: ",style = "font-weight: bold;color:black"),
                             h4( "a. Grouped together all the levels in categorical variables with very less occurences into one single level",style = "font-weight: bold;color:black"),
                             h4("b. Performed One Hot Encoding on all categorical variables",style = "font-weight: bold;color:black"),
                             h4("c. Used Chi Square and Logistic Regression to identify variable importance and drop the unimportant variables",style = "font-weight: bold;color:black"),
                             h4("d. Normalized all the numeric Variables",style = "font-weight: bold;color:black"),
                             h4("e. Performed Principal Component Analysis in order to reduce the dimensions prior to clustering",style = "font-weight: bold;color:black"),
                             h4("f. Performed SMOTE oversampling on minority class and undersampling in Majority class in order to reduce class imbalance",style = "font-weight: bold;color:black"),
                             h4("The training dataset was used to build machine learning models and the validation dataset was used to evaluate the 
                              performance of the models built on the training dataset. 
                              Classification techniques were used for classifying whether the car is a good buy or a bad buy. 
                              Association Rule Mining was applied to get best feature values associated with each class of target variable. 
                              The process of EDA followed by model building, fine tuning and performance evaluation is an iterative process which can be carried out until the best and
                              desirable results are achieved.",style = "font-weight: bold;color:black"),
                           h3("5.	Expected Results",style = "font-weight: bold;color:maroon"),
                           h4("By accurately predicting if a purchased car is going to be a good buy or a bad buy, the car dealer will be able to 
                           make a wise decision on whether 
                           to abstain or continue with the purchase. 
                          These good buys will help the car dealer maximize their profits and minimize their loss.",style = "font-weight: bold;color:black"),
                           h3("6.	Data Dictionary",style = "font-weight: bold;color:maroon"),
                           h5("RefID: Unique (sequential) number assigned to vehicles",style = "font-weight: bold;color:black"),
                           h5("IsBadBuy:Identifies if the kicked vehicle was an avoidable purchase",style = "font-weight: bold;color:black"),
                           h5("PurchDate: The Date the vehicle was Purchased at Auction",style = "font-weight: bold;color:black"),
                           h5("Auction: Auction provider at which the  vehicle was purchased",style = "font-weight: bold;color:black"),
                           h5("VehYear: The manufacturer's year of the vehicle",style = "font-weight: bold;color:black"),
                           h5("VehicleAge: The Years elapsed since the manufacturer's year",style = "font-weight: bold;color:black"),
                           h5("Make: Vehicle Manufacturer ",style = "font-weight: bold;color:black"),
                           h5("Model: Vehicle Model",style = "font-weight: bold;color:black"),
                           h5("Trim: Vehicle Trim Level",style = "font-weight: bold;color:black"),
                           h5("SubModel: Vehicle Submodel",style = "font-weight: bold;color:black"),
                           h5("Color: Vehicle Color",style = "font-weight: bold;color:black"),
                           h5("Transmission: Vehicles transmission type (Automatic, Manual)",style = "font-weight: bold;color:black"),
                           h5("WheelTypeID: The type id of the vehicle wheel",style = "font-weight: bold;color:black"),
                           h5("WheelType: The vehicle wheel type description (Alloy, Covers)",style = "font-weight: bold;color:black"),
                           h5("VehOdo: The vehicles odometer reading",style = "font-weight: bold;color:black"),
                           h5("Nationality: The Manufacturer's country",style = "font-weight: bold;color:black"),
                           h5("Size: The size category of the vehicle (Compact, SUV, etc.)",style = "font-weight: bold;color:black"),
                           h5("TopThreeAmericanName: Identifies if the manufacturer is one of the top three American manufacturers",style = "font-weight: bold;color:black"),
                           h5("MMRAcquisitionAuctionAveragePrice: Acquisition price for this vehicle in average condition at time of purchase",style = "font-weight: bold;color:black"),
                           h5("MMRAcquisitionAuctionCleanPrice: Acquisition price for this vehicle in the above Average condition at time of purchase",style = "font-weight: bold;color:black"),
                           h5("MMRAcquisitionRetailAveragePrice: Acquisition price for this vehicle in the retail market in average condition at time of purchase",style = "font-weight: bold;color:black"),
                           h5("MMRAcquisitonRetailCleanPrice: Acquisition price for this vehicle in the retail market in above average condition at time of purchase",style = "font-weight: bold;color:black"),
                           h5("MMRCurrentAuctionAveragePrice: Acquisition price for this vehicle in average condition as of current day",style = "font-weight: bold;color:black"),
                           h5("MMRCurrentAuctionCleanPrice: Acquisition price for this vehicle in the above condition as of current day",style = "font-weight: bold;color:black"),
                           h5("MMRCurrentRetailAveragePrice: Acquisition price for this vehicle in the retail market in average condition as of current day",style = "font-weight: bold;color:black"),
                           h5("MMRCurrentRetailCleanPrice: Acquisition price for this vehicle in the retail market in above average condition as of current day",style = "font-weight: bold;color:black"),
                           h5("PRIMEUNIT: Identifies if the vehicle would have a higher demand than a standard purchase",style = "font-weight: bold;color:black"),
                           h5("AcquisitionType: Identifies how the vehicle was aquired (Auction buy, trade in, etc)",style = "font-weight: bold;color:black"),
                           h5("AUCGUART: The level guarntee provided by auction for the vehicle (Green light - Guaranteed/arbitratable, Yellow Light - caution/issue, red light - sold as is)",style = "font-weight: bold;color:black"),
                           h5("KickDate: Date the vehicle was kicked back to the auction",style = "font-weight: bold;color:black"),
                           h5("BYRNO: Unique number assigned to the buyer that purchased the vehicle",style = "font-weight: bold;color:black"),
                           h5("VNZIP:  Zipcode where the car was purchased",style = "font-weight: bold;color:black"),
                           h5("VNST: State where the the car was purchased",style = "font-weight: bold;color:black"),
                           h5("VehBCost: Acquisition cost paid for the vehicle at time of purchase",style = "font-weight: bold;color:black"),
                           h5("IsOnlineSale: Identifies if the vehicle was originally purchased online",style = "font-weight: bold;color:black"),
                           h5("WarrantyCost: Warranty price (term=36month  and millage=36K)",style = "font-weight: bold;color:black")
                           ),
                  tabPanel('DATA EXPLORATION',
                           h3("1. Pick Vehicle Variable to produce bar graph against target variable(Is Bad Buy)",style = "font-weight: bold;color:maroon"),
                           selectInput("bar_graph_variable",
                                       "Plot Bar Graph for Is Bad Buy VS Warranty Cost/Vehicle Acquisition Cost/Vehicle Odometer Reading/Vehicle Age:",
                                       choices = c('Warranty Cost','Vehicle Acquisition Cost','Vehicle Odometer Reading','Vehicle Age'),
                                       selected = 'Warranty Cost'
                           ),
                           textOutput("BargraphInsights"),
                           tags$head(tags$style("#BargraphInsights{color: black;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"
                           )
                           ),
                           plotOutput("BargraphNumeric"),
                           h3("2. Pick Auction Price Variable to produce bar graph against target variable(Is Bad Buy)",style = "font-weight: bold;color:maroon"),
                           selectInput("bar_graph_auction_variable",
                                       "Plot Bar Graph for Is Bad Buy VS Acquisition Average Price/Acquisition Clean Price/Current Average Price/Current Clean Price:",
                                       choices = c('Acquisition Average Price','Acquisition Clean Price','Current Average Price','Current Clean Price'),
                                       selected = 'Acquisition Average Price'
                           ),
                           textOutput("BargraphAuctionInsights"),
                           tags$head(tags$style("#BargraphAuctionInsights{color: black;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"
                           )
                           ),
                           plotOutput("BargraphAuction"),
                           
                           
                           h3("3. Pick Categorical Variable to produce Stacked bar graph against target variable(Is Bad Buy)",style = "font-weight: bold;color:maroon"),
                           selectInput("bar_graph_categorical_variable",
                                       "Plot Stacked Bar Graph for Wheel Type/Transmission/State Vs Number of Cars Sold stacked by target variable Bad Buy:",
                                       choices = c('Wheel Type','Transmission','State'),
                                       selected = 'Wheel Type'
                           ),
                           textOutput("BargraphCategoricalInsights"),
                           tags$head(tags$style("#BargraphCategoricalInsights{color: black;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"
                           )
                           ),
                           plotOutput("BarGraphCategorical")
                           ),
                  navbarMenu('MODEL PERFORMANCE',
                           
                          tabPanel('KNN',
                                   h3(img(src = "https://annalyzin.files.wordpress.com/2016/09/knn-layman-explanation-borderless.png?w=820&h=312&crop=1",
                                          style = "height: 145px;width: 280px;")),
                                    h3("Tune the K Nearest Neighbors (KNN) algorithm hyperparameter, 
                             i.e. the K value to view the model performance for different values of K as shown below",style = "font-weight:bold;color:black;"),
                                   sliderInput("K",
                                               "K:",
                                               min = 21,
                                               max = 34,
                                               value = 30,step = 1),
                                   tableOutput("knn_accuracy_recall"),
                                   tags$head(tags$style("#knn_accuracy_recall tr{
                                                                    position:relative;
                                                                    font-size: x-large;
                                                                    font-weight: bold;
                                                                    text-align: center; 
                                                                    border-bottom: solid;
                                                                    border-right: solid;
                                                                    border-left: solid;
                                                                    border-top: solid;
                                                                    margin-bottom:30px;};
                                                                    ")),
                                   h3("Evaluation results of best performing KNN model are:",style = "font-weight: bold;color:maroon;margin-top:5em;"),
                                   h4("ACCURACY = 87 %",style = "font-weight: bold;color:black"),
                                   h4("PRECISION = 43 %",style = "font-weight: bold;color:black"),
                                   h4("RECALL = 47 %",style = "font-weight: bold;color:black"),
                                   h4("F1 SCORE = 48 %",style = "font-weight: bold;color:black"),
                                   h4("AUC SCORE = 71 %",style = "font-weight: bold;color:black")
                                    ),
                           tabPanel('RANDOM FOREST',
                                    h3(img(src = "https://www.frontiersin.org/files/MyHome%20Article%20Library/284242/284242_Thumb_400.jpg")),
                                    h3("Tune the Random Forest algorithm hyperparameters, i.e. Number of Features & Number of Trees to view the 
                                       model performance for different values of hyperparameters as shown below",style = "font-weight:bold;color:black;"),
                                    sliderInput("Number_Trees",
                                                "Number of Trees:",
                                                min = 400,
                                                max = 900,
                                                value = 600,step = 100),
                                    sliderInput("Number_Features",
                                                "Number of Features:",
                                                min = 6,
                                                max = 15,
                                                value = 15,step = 3),
                                    tableOutput("rf_accuracy_recall"),
                                    tags$head(tags$style("#rf_accuracy_recall tr{
                                                                    position:relative;
                                                                    font-size: x-large;
                                                                    font-weight: bold;
                                                                    text-align: center; 
                                                                    border-bottom: solid;
                                                                    border-right: solid;
                                                                    border-left: solid;
                                                                    border-top: solid;
                                                                    margin-bottom:30px;};
                                                                    ")),
                                    h3("Evaluation results of best performing RANDOM FOREST model are:",style = "font-weight: bold;color:maroon;margin-top:3em;"),
                                    h4("ACCURACY = 83 %",style = "font-weight: bold;color:black"),
                                    h4("PRECISION = 47 %",style = "font-weight: bold;color:black"),
                                    h4("RECALL = 55 %",style = "font-weight: bold;color:black"),
                                    h4("F1 SCORE = 54 %",style = "font-weight: bold;color:black"),
                                    h4("AUC SCORE = 74 %",style = "font-weight: bold;color:black")
                                    ),
                           tabPanel('GRADIENT BOOSTING',
                                    h3(img(src = "https://images.akira.ai/glossary/gradient-boosting-ml-technique-akira-ai.png",
                                           style = "height: 300px;width: 580px;")),
                                       h3("Tune the Gradient Boosting algorithm hyperparameters, to view the 
                                       model performance for different values of hyperparameters as shown below",style = "font-weight:bold;color:black;"),
                                       sliderInput("Number_Trees_gb",
                                                   "Number of Trees:",
                                                   min = 800,
                                                   max = 1400,
                                                   value = 1200,step = 200),
                                       sliderInput("maxdepth",
                                                   "Max Depth:",
                                                   min = 5,
                                                   max = 8,
                                                   value = 5,step = 1),
                                       tableOutput("gb_accuracy_recall"),
                                       tags$head(tags$style("#gb_accuracy_recall tr{
                                                                    position:relative;
                                                                    font-size: x-large;
                                                                    font-weight: bold;
                                                                    text-align: center; 
                                                                    border-bottom: solid;
                                                                    border-right: solid;
                                                                    border-left: solid;
                                                                    border-top: solid;
                                                                    margin-bottom:30px;};
                                                                    ")),
                                       
                              h3("Evaluation results of best performing GRADIENT BOOSTING model are:",style = "font-weight: bold;color:maroon;margin-top:3em;"),
                                    h4("ACCURACY = 81 %",style = "font-weight: bold;color:black"),
                                    h4("PRECISION = 35 %",style = "font-weight: bold;color:black"),
                                    h4("RECALL = 54 %",style = "font-weight: bold;color:black"),
                                    h4("F1 SCORE = 42 %",style = "font-weight: bold;color:black"),
                                    h4("AUC SCORE = 73 %",style = "font-weight: bold;color:black")
                           ),
                          tabPanel('ASSOCIATION RULES',
                                   h3(img(src = "https://blog-c7ff.kxcdn.com/blog/wp-content/uploads/2017/03/blog-01-1-compressed.jpg",
                                          style = "height: 200px;width: 410px;")),
                                   h3("Select Support, Confidence, Minimum Rule Length & Number of Rules to be displayed ",style = "font-weight:bold;color:black;"),
                                   fluidRow(
                                  column(2,
                                   sliderInput(inputId =  "Support_val",
                                               label =  "Support:",
                                               min = 0,
                                               max = 0.05,
                                               value = 0.01,step = 1/100),
                                   sliderInput("Confidence_val",
                                               "Confidence:",
                                               min = 0.5,
                                               max = 0.9,
                                               value = 0.85,step = 1/100)
                                  ),
                                  column(3,
                                   sliderInput("minlen_val",
                                               "Minimum Rule Length:",
                                               min = 3,
                                               max = 6,
                                               value = 4,step = 1),
                                   sliderInput("no_rules",
                                               "Number of top Rules selected:",
                                               min = 5,
                                               max = 7,
                                               value = 5, step = 1),
                                   selectInput("sort_by",
                                               "Sort Rules in descending order by Lift/Confidence/Support:",
                                               choices = c('lift','confidence','support'),
                                               selected = 'lift'
                                   )
                                  )
                                   ),
                                   verbatimTextOutput("rulesTable")
                                   
                                    )
                           
                  ),
                  tabPanel('WILL CAR BE LEMON',
                           h3("Enter values for these selected attributes to find out if your car is going to be a Bad Buy (Lemon)",style = "font-weight: bold;color:maroon;margin-top:0.9em;"),
                           fluidRow(
                             column(2,
                           selectInput(inputId = "VehicleAge", label = "Select your Vehicle Age", choices = c(1,2,3,4,5,6,7,8,9),
                                       selected = 3),
                           selectInput(inputId = "Transmission", label = "Select your Transmission Type", choices = c('AUTO','MANUAL'),
                                       selected = 'AUTO'),
                           selectInput(inputId = "WheelType", label = "Select your Vehicle Wheel Type", choices = c('Alloy','Covers','Special','OTHER'),
                                       selected = 'Covers'),
                             ),
                           column(3,
                           numericInput(inputId = "VehicleOdo", label = "Input your Vehicle Odometer Reading", value = 78240, min = 1, max = 200000, step = 1),
                           numericInput(inputId = "VehicleBCost", label = "Input your Vehicle Acquistion Cost", value = 9500, min = 1, max = 20000, step = 1),
                           
                           numericInput(inputId = "MMRAcqAucAvgPrice", label = "Input your Vehicle Acquistion Auction Average Price", value = 9294, min = 1, max = 20000, step = 1),
                           ),
                           column(5,
                           numericInput(inputId = "MMRAcqAucCleanPrice", label = "Input your Vehicle Acquistion Auction Clean Price", value = 394, min = 1, max = 20000, step = 1),
                           numericInput(inputId = "MMRCurrAucAvgPrice", label = "Input your Vehicle Current Auction Average Price", value = 9500, min = 1, max = 20000, step = 1),
                           numericInput(inputId = "MMRCurrAucCleanPrice", label = "Input your Vehicle Current Auction Clean Price", value = 9500, min = 1, max = 20000, step = 1),
                           )),
                           verbatimTextOutput("carprediction"),
                           tags$head(tags$style(HTML("
                            #carprediction { 
                           width: 380px;
                          height: 81px;
                          position: relative;
                          font-weight: bold;
                          color: white;
                          font-size: large;
                          background-color: #008080;
                          border: solid;
                          border-radius: 15px;
                          text-align: center;
                            }
                            ")))
                  )
                  )
             ),
  # WHERE YOUR FOOTER GOES
  print("Built by:"), 
  fluidRow(
     uiOutput("bk"),
     uiOutput("sp"),
     uiOutput("tp")
    )
)
 server <- function(input,output) {
   
   urlb <- a("Bhavish", href="https://www.linkedin.com/in/bhavish-kumar/")
   urls <- a("Sai", href = "https://www.linkedin.com/in/sai-praharsha-devalla/")
   urlt <- a("Tejas", href = "https://www.linkedin.com/in/tejas-d-patil/")
   
   output$bk <- renderUI({
     tagList(urlb)
   })
   
   output$sp <- renderUI({
     tagList(urls)
   })
   
   output$tp <- renderUI({
     tagList(urlt)
   })
   
   output$carprediction <- renderText(
     {
       VehicleAge <- as.numeric(input$VehicleAge)
       Transmission <- as.factor(input$Transmission)
       WheelType <- as.factor(input$WheelType)
       VehOdo <- as.numeric(input$VehicleOdo)
       VehBCost <- as.numeric(input$VehicleBCost)
       MMRAcqAucAvgPrice <- as.numeric(input$MMRAcqAucAvgPrice)
       MMRAcqAucCleanPrice <- as.numeric(input$MMRAcqAucCleanPrice)
       MMRCurrAucAvgPrice <- as.numeric(input$MMRCurrAucAvgPrice)
       MMRCurrAucCleanPrice <- as.numeric(input$MMRCurrAucCleanPrice)
       
       dash_input_df <- data.frame(VehicleAge,Transmission,WheelType,VehOdo,VehBCost,MMRAcqAucAvgPrice,MMRAcqAucCleanPrice,MMRCurrAucAvgPrice,MMRCurrAucCleanPrice)
       
       predict_rf_user <- predict(rf_model_minimized_dashb, newdata = dash_input_df)
       
       predict_gb_user <- predict(gb_model_minimized_dashb, newdata = dash_input_df)
       
       if(predict_rf_user == "1" & predict_gb_user == "1"){
         paste("Random Forest Prediction: YES","\n", 
          "Gradient Boosting Prediction: YES")
       }
       else if(predict_rf_user == "1" & predict_gb_user == "0"){
         paste("Random Forest Prediction: YES","\n",
          "Gradient Boosting Prediction: NO")
       }
       else if(predict_rf_user == "0" & predict_gb_user == "1")
       {
         paste("Random Forest Prediction: NO","\n",
         "Gradient Boosting Prediction: YES")
       }
       else
       {
         paste("Random Forest Prediction: NO","\n",
         "Gradient Boosting Prediction: NO")
       }
       
     }
   )
   
   output$rulesTable <- renderPrint({
     
     ar_yes <- apriori(rules_mat, parameter = list(support = as.numeric(input$Support_val), confidence = as.numeric(input$Confidence_val), 
                                                                   minlen = as.numeric(input$minlen_val)),
                       appearance = list(default = "lhs", rhs=("IsBadBuy=1")))
     
     inspect(head(sort (ar_yes, by=input$sort_by, decreasing=TRUE),input$no_rules))
     
   })
  
  output$knn_accuracy_recall <- renderTable({
    
    perf_knn[perf_knn$K==as.numeric(input$K),]
    
  }
  )
  
  output$gb_accuracy_recall <- renderTable({
    
    perf_gb[perf_gb$NUMBER_of_TREES==as.numeric(input$Number_Trees_gb) & perf_gb$MAX_DEPTH == input$maxdepth,]
    
  }
  ) 
   
  output$rf_accuracy_recall <- renderTable({
    
    perf_rf[perf_rf$NUMBER_of_TREES==as.numeric(input$Number_Trees) & perf_rf$NUMBER_of_FEATURES == as.numeric(input$Number_Features),]
  }
  )
  
  output$BargraphCategoricalInsights <- renderText({
    
    if(input$bar_graph_categorical_variable == "Wheel Type"){
      "Finding: We can observe that the Wheel Type OTHER has a high proportion of Bad Buys"
    }
    else if(input$bar_graph_categorical_variable == "Transmission"){
      "Finding: We can observe that both AUTO & MANUAL Transmission have approximately equal proportion of Bad Buys"
    }
    else{
      "Finding: We can observe that the states Florida and Texas have the highest number of car sales and hence highest proportion of Bad Buys"
    }
    
  })
  
  output$BarGraphCategorical <- renderPlot({
    
    if(input$bar_graph_categorical_variable == "Wheel Type"){
      WheelType_bad_buy_plot
    }
    else if(input$bar_graph_categorical_variable == "Transmission"){
      transmission_bad_buy_plot
    }
    
    else{
      VNST_bad_buy_plot
    }
  }, 
  height=400, width=1300
  )
  
  output$BargraphAuctionInsights <- renderText({
    
    if(input$bar_graph_auction_variable == "Acquisition Average Price"){
      "Finding: The Proportion of Bad Buys is lower for higher acquisition average price groups"
    }
    else if(input$bar_graph_auction_variable == "Acquisition Clean Price"){
      "Finding: Proportion of Bad Buy is lower for higher acquistion clean prices"
    }
    else if(input$bar_graph_auction_variable == "Current Average Price"){
      "Finding: Proportion of Bad Buy decreases with increase in Current Auction Average Price"
    }
    else{
      "Finding: Proportion of Bad Buy decreases with increase in Current Auction Clean Price"
    }
    
  })
  
  output$BargraphAuction <- renderPlot({
    
    if(input$bar_graph_auction_variable == "Acquisition Average Price"){
      acq_auc_avg_price
    }
    else if(input$bar_graph_auction_variable == "Acquisition Clean Price"){
      acq_auc_clean_price
    }
    else if(input$bar_graph_auction_variable == "Current Average Price"){
      current_auc_avg_price
    }
    else{
      current_auc_clean_price
    }
  }, 
  height=400, width=1300
  )
  
  output$BargraphInsights <- renderText({
    
    if(input$bar_graph_variable == "Vehicle Acquisition Cost"){
      "Finding: We can observe that proportion of Bad Buys is higher for lower Acquistion cost groups"
    }
    else if(input$bar_graph_variable == "Vehicle Odometer Reading"){
      "Finding: We can observe that proportion of Bad Buys increases with higher vehicle odometer reading groups"
    }
    else if(input$bar_graph_variable == "Vehicle Age"){
      "Finding: We can observe that the proportion of Bad Buys increases with vehicle age"
    }
    else{
      "Finding: We can observe that the proportion of Bad Buys increases for higher Warranty Cost groups"
    }
    
  })
  
  output$BargraphNumeric <- renderPlot({
    
    if(input$bar_graph_variable == "Vehicle Acquisition Cost"){
      VehBCostvsbadbuy
    }
    else if(input$bar_graph_variable == "Vehicle Odometer Reading"){
      Odovsbadbuy
    }
    else if(input$bar_graph_variable == "Vehicle Age"){
      Agevsbadbuy
    }
    else{
      WarrantyCostvsbadbuy
    }
    }, 
  height=400, width=1300
  )

  
}

shinyApp(ui = ui, server = server)