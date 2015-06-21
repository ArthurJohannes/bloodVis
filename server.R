


library (shiny)
library (reshape2)
library (ggplot2)
library (pheatmap)

datasetlist <- readRDS ("data/datasetlist.rds")


shinyServer(function(input, output, session) {
  output$myqplot <- renderPlot({
    
    
    gdsselect <- switch(input$var, 
                        "gds1449 HIV1" = datasetlist$gds1449$gds1449ft,
                        "gds2048 rota" = datasetlist$gds2048$gds2048ft,
                        "gds2756 measles" = datasetlist$gds2756$gds2756ft,
                        "gds3919 inflA" = datasetlist$gds3919$gds3919ft,
                        "gds4240 inflH1N1" = datasetlist$gds4240$gds4240ft,
                        "gds4786 HIV TBC" = datasetlist$gds4786$gds4786ft,
                        "gds4854 inflH1N1 rota" = datasetlist$gds4854$gds4854ft,
                        "gds5093 dengue" = datasetlist$gds5093$gds5093ft
    )
    
    gds4854 <- gdsselect
    
    keep <- gds4854 [1,]
    for (i in input$features) {newrow <- gds4854 [gds4854$cluster == i,] 
                               keep <- rbind (keep,newrow)} 
    keep <- keep [-1,]
    
    gds4854z <- keep
    
    gds4854k <- t (gds4854z [,-1])
    colnames (gds4854k) <- gds4854z$cluster
    gds4854l <- as.data.frame (gds4854k) 
    
    kolom <- switch(input$order, 
                    "B_cell" = gds4854l$B_cell,
                    "basophil" = gds4854l$basophil,
                    "eosinobaso" = gds4854l$eosinobaso,
                    "eosinophil" = gds4854l$eosinophil,
                    "eosinobasoetal" = gds4854l$eosinobasoetal,
                    "erythroid" = gds4854l$erythroid,
                    "NK_cell" = gds4854l$NK_cell,
                    "thromboid" = gds4854l$thromboid,
                    "T_cell" = gds4854l$T_cell,
                    "female" = gds4854l$female,
                    "male" = gds4854l$male,
                    "proliferation" = gds4854l$proliferation,
                    "interferonRepr" = gds4854l$interferonRepr,
                    "neutrophil" = gds4854l$neutrophil,
                    "monocyte" =  gds4854l$monocyte,
                    "inflammasome" =  gds4854l$inflammasome,
                    "interferonInd" =  gds4854l$interferonInd)
    gds4854m <- gds4854l [order (kolom),]
    gds4854n <- t (gds4854m)
    gds4854o <- as.data.frame (gds4854n)
    gds4854o$cluster <- rownames (gds4854o)
    
    featuretablemelt <- melt (gds4854o, id = c ("cluster"))
    p <- qplot (value, variable, data = featuretablemelt, colour = cluster, size = 10, main = paste ("Blood profile for", input$var), xlab = "standard deviation from mean in dataset", ylab = "blood sample number")
    print (p)
    
    
  })
  
  output$myqplotb <- renderPlot({
    
    
    
    gdsselect2b <- switch(input$varb, 
                          "gds1449 HIV1" = datasetlist$gds1449$gds1449meta,
                          "gds2048 rota" = datasetlist$gds2048$gds2048meta,
                          "gds2756 measles" = datasetlist$gds2756$gds2756meta,
                          "gds3919 inflA" = datasetlist$gds3919$gds3919meta,
                          "gds4240 inflH1N1" = datasetlist$gds4240$gds4240meta,
                          "gds4786 HIV TBC" = datasetlist$gds4786$gds4786meta,
                          "gds4854 inflH1N1 rota" = datasetlist$gds4854$gds4854meta,
                          "gds5093 dengue" = datasetlist$gds5093$gds5093meta
    )
    
    
    kolommenb <- gdsselect2b
    rownames (kolommenb) <- kolommenb$sample
    kolommenbb <- kolommenb [,-1]
    
    
    
    
    gdsselectb <- switch(input$varb, 
                         "gds1449 HIV1" = datasetlist$gds1449$gds1449ft,
                         "gds2048 rota" = datasetlist$gds2048$gds2048ft,
                         "gds2756 measles" = datasetlist$gds2756$gds2756ft,
                         "gds3919 inflA" = datasetlist$gds3919$gds3919ft,
                         "gds4240 inflH1N1" = datasetlist$gds4240$gds4240ft,
                         "gds4786 HIV TBC" = datasetlist$gds4786$gds4786ft,
                         "gds4854 inflH1N1 rota" = datasetlist$gds4854$gds4854ft,
                         "gds5093 dengue" = datasetlist$gds5093$gds5093ft
    )
    
    gds4854b <- gdsselectb
    
    keepb <- gds4854b [1,]
    for (i in input$featuresb) {newrowb <- gds4854b [gds4854b$cluster == i,] 
                                keepb <- rbind (keepb,newrowb)} 
    keepb <- keepb [-1,]
    
    featuretableb <- keepb
    clustergs1b <- t (featuretableb) 
    colnames (clustergs1b) <- featuretableb$cluster
    clustergs2b <- clustergs1b [- 1,] 
    clustergs3b <- apply (clustergs2b, 2, as.numeric)
    rownames (clustergs3b) <- rownames (clustergs2b)
    clustergs4b <- as.matrix (clustergs3b)
    rownames (clustergs4b) <- rownames (clustergs2b)
    
    
    pb <- pheatmap (clustergs4b,  annotation_row = kolommenbb [1:2])
    
    
    print (pb)
  })
  
  
  output$table <- renderDataTable({
    
    gdsselect2b <- switch(input$varb, 
                          "gds1449 HIV1" = datasetlist$gds1449$gds1449meta,
                          "gds2048 rota" = datasetlist$gds2048$gds2048meta,
                          "gds2756 measles" = datasetlist$gds2756$gds2756meta,
                          "gds3919 inflA" = datasetlist$gds3919$gds3919meta,
                          "gds4240 inflH1N1" = datasetlist$gds4240$gds4240meta,
                          "gds4786 HIV TBC" = datasetlist$gds4786$gds4786meta,
                          "gds4854 inflH1N1 rota" = datasetlist$gds4854$gds4854meta,
                          "gds5093 dengue" = datasetlist$gds5093$gds5093meta
    )
    
    
    
    
  }, options=list(iDisplayLength=10))
})