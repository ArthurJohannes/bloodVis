
shinyUI(navbarPage("bloodVis",
                   tabPanel("Presence",
                            sidebarLayout(
                              sidebarPanel(
                                helpText("View blood profiles from gene expression data."),
                                
                                selectInput("var", 
                                            label = "Choose a dataset to display",
                                            choices = c("gds1449 HIV1", "gds2048 rota",
                                                        "gds2756 measles", "gds3919 inflA", "gds4240 inflH1N1", "gds4786 HIV TBC", "gds4854 inflH1N1 rota", "gds5093 dengue"), 
                                            selected = "gds1449 HIV1"),
                                
                                selectizeInput("features", label = "select features to display", choices = c("B_cell", "basophil", "eosinobaso", "eosinophil","eosinobasoetal", "erythroid", "monocyte", "neutrophil", "NK_cell", "thromboid", "T_cell", "female", "male", "interferonInd", "interferonRepr", "inflammasome", "proliferation"), selected = c ("B_cell", "basophil", "eosinobaso", "eosinophil","eosinobasoetal", "monocyte", "neutrophil", "NK_cell", "thromboid", "T_cell", "interferonInd", "interferonRepr", "inflammasome", "proliferation"),  multiple = TRUE ),
                                
                                
                                
                                selectInput("order", 
                                            label = "Order samples by a selected feature value",
                                            choices = c("B_cell", "basophil", "eosinobaso", "eosinophil","eosinobasoetal", "erythroid", "monocyte", "neutrophil", "NK_cell", "thromboid", "T_cell", "female", "male", "interferonInd", "interferonRepr", "inflammasome", "proliferation"),
                                            selected = "inflammasome")
                              ),
                              
                              mainPanel(
                                plotOutput("myqplot")
                              )
                            )
                   ),
                   tabPanel("Clusters",
                            sidebarLayout(
                              sidebarPanel(
                                helpText("View blood profiles from gene expression data."),
                                
                                selectInput("varb", 
                                            label = "Choose a dataset to display",
                                            choices = c("gds1449 HIV1", "gds2048 rota",
                                                        "gds2756 measles", "gds3919 inflA", "gds4240 inflH1N1", "gds4786 HIV TBC", "gds4854 inflH1N1 rota", "gds5093 dengue"), 
                                            selected = "gds1449 HIV1"),
                                
                                selectizeInput("featuresb", label = "select features to display", choices = c("B_cell", "basophil", "eosinobaso", "eosinophil","eosinobasoetal", "erythroid", "monocyte", "neutrophil", "NK_cell", "thromboid", "T_cell", "female", "male", "interferonInd", "interferonRepr", "inflammasome", "proliferation"),selected = c("B_cell", "basophil", "eosinobaso", "eosinophil","eosinobasoetal", "monocyte", "neutrophil", "NK_cell", "thromboid", "T_cell", "interferonInd", "interferonRepr", "inflammasome", "proliferation"), multiple = TRUE ),
                                
                                
                                
                                helpText("Add; choose annotations, view pdf.")
                              ),
                              
                              mainPanel(
                                plotOutput("myqplotb")
                              )
                            )
                   ),
                   navbarMenu("More",
                              tabPanel("Table",
                                       dataTableOutput("table")
                              ),
                              
                              tabPanel("About",
                                       helpText ("bloodVis, an App to visualize general profiles of blood samples from several GEO datasets.
                                                
                                                Features include 9 common blood cell types, cell proliferation, inflammation, interferon action, and gender.
                                                Features represent clusters of co-expressed genes, using many peripheral human blood GEO datasets.
                                                
                                                Use page -Presence- to display dataset and order by features of choice.
                                                Use page -Clusters- to view clustering of samples and features of choice.
                                                Use tab -table- to view experimental annotation.
                                                
                                                Author:
                                                
                                                A.J.Molendijk,
                                                Vlissingen, NL.
                                                
                                                for contact email:  molendijkarthur@gmail.com")
                              )
                   )
))