问词典 <- function(阳历) {
  阳历 %<>% 
    str_split('-') %>% 
    llply(., function(迭) paste(as.numeric(迭), collapse = '-')) %>% 
    unlist()
  
  ## 道家----------
  黄历 <- paste0('https://www.cidianwang.com/nongli/', 阳历, '-2.htm')
  
  llply(1:length(黄历), function(迭) {
    cat(paste0('第', num2c(迭), '：https://www.cidianwang.com/nongli/', 
               阳历[迭], '-2.htm\n', collapse = ''))
    
    黄历[迭] %>% 
      read_html() %>% 
      html_table()
    
    ### 
    ### 
    ### 
    })
}




