library(rvest)
library(stringr)

address<-lapply(paste0("https://www.property24.co.ke/property-to-rent-in-nairobi-c1890?Page=",1:10),
             function(myurl){
               myurl %>% read_html() %>%
                 html_nodes(".sc_listingTileAddress") %>%
                 html_text() %>%
                 gsub("[\r\n]","",.)
               
             })
address2<-unlist(address)
address2<-gsub(" ","",address2)
View(address2)
########################################

price<-lapply(paste0("https://www.property24.co.ke/property-to-rent-in-nairobi-c1890?Page=",1:10),
              function(url2){
                url2 %>% read_html() %>%
                  html_nodes(".primaryColor span:nth-child(1)") %>%
                  html_text() %>%
                  gsub("[\r\n]","",.) %>%
                  gsub("[\\KSh]","",.)
              })
price<-unlist(price)
price<-gsub(" ","",price)
price<-gsub("[^0-9]", "",price) 
price<-as.numeric(price)
length(price)
location<-rep("Nairobi",210)
houses<-data.frame(address2,location,price)
View(houses)
