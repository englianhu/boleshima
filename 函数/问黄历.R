问黄历 <- function(阳历, 黄历 = '老黄历') {
  
  ## 黄历分为道家老子黄历的《老黄历》与道家始祖春秋万载的《万年历》
  道家历法 <- c('老黄历', '万年历')
  if(!黄历 %in% 道家历法) {
    stop('黄历 = "老黄历"？黄历 = "万年历"？')
  }
  
  ## 道家始祖春秋万载的《万年历》
  if(黄历 == '万年历') {
    万年历 <- paste0('https://wannianrili.bmcx.com/', 阳历, '__wannianrili/')
    
    llply(1:length(万年历), function(迭) {
      
      cat(paste0('第', num2c(迭), '：读取 https://wannianrili.bmcx.com/', 阳历[迭], '__wannianrili/\n'))
      年份 <- str_split(阳历, '-')[[迭]][1] %>% 
        str_replace_all('0', '零') %>% 
        str_replace_all('1', '一') %>% 
        str_replace_all('2', '二') %>% 
        str_replace_all('3', '三') %>% 
        str_replace_all('4', '四') %>% 
        str_replace_all('5', '五') %>% 
        str_replace_all('6', '六') %>% 
        str_replace_all('7', '七') %>% 
        str_replace_all('8', '八') %>% 
        str_replace_all('9', '九') %>% 
        paste0('年', collapse = '')
      
      黄历甲 <- 万年历[迭] %>% 
        read_html() %>% 
        html_nodes(xpath = '//*[@id="wnrl_k_you_id_1"]') %>% 
        html_text() %>% 
        str_replace_all('宜', '宜 ') %>% 
        str_replace_all('忌', '忌 ')
      
      黄历甲 <- llply(1:length(干支), function(迭) {
        牍 <- 黄历甲 %>% 
          str_replace_all(
            paste0(干支[迭], '年'), paste0(' ', 干支[迭], '年'))
      }) %>% 
        unique()
      if(length(黄历甲) == 1) 黄历甲 <- 黄历甲[[1]]
      if(length(黄历甲) > 1) 黄历甲 <- 黄历甲[[2]]
      
      黄历甲 <- llply(1:length(干支), function(迭) {
        牍 <- 黄历甲 %>% 
          str_replace_all(
            paste0(干支[迭], '日'), paste0(干支[迭], '日 '))
      }) %>% 
        unique()
      if(length(黄历甲) == 1) 黄历甲 <- 黄历甲[[1]]
      if(length(黄历甲) > 1) 黄历甲 <- 黄历甲[[2]]
      
      黄历乙 <- 万年历[迭] %>% 
        read_html() %>% 
        html_nodes(xpath = '//*[@id="wnrl_k_xia_id_1"]/div[2]') %>% 
        html_text2()
      
      黄道吉日 <- 黄历甲 |> 
        str_split(' ') %>% 
        .[[1]] %>% 
        str_replace_all('【|】|\\(大\\)|\\(小\\)', '') %>% 
        str_split('[0-9]') %>% 
        unlist() %>% 
        .[. != '']
      黄道吉日[1] <- 年份
      
      黄历日期 <- 黄历甲 |> 
        str_split(' ') %>% 
        .[[1]] %>% 
        .[1:4] %>% 
        str_extract_all('[0-9]') %>% 
        .[c(1, 2, 4)] %>% 
        paste(collapse = '-') %>% 
        str_replace_all('c\\(|\"|, |\\)', '')
      
      月份 <- 黄历甲 |> 
        str_split(' ') %>% 
        .[[1]] %>% 
        .[2] %>% 
        str_extract_all('[0-9]') %>% 
        .[[1]] %>% 
        paste0(collapse = '') %>% 
        as.numeric() %>% 
        str_replace_all('0', '零') %>% 
        str_replace_all('1', '一') %>% 
        str_replace_all('2', '二') %>% 
        str_replace_all('3', '三') %>% 
        str_replace_all('4', '四') %>% 
        str_replace_all('5', '五') %>% 
        str_replace_all('6', '六') %>% 
        str_replace_all('7', '七') %>% 
        str_replace_all('8', '八') %>% 
        str_replace_all('9', '九') %>% 
        paste0('月', collapse = '')
      
      日 <- 黄历甲 |> 
        str_split(' ') %>% 
        .[[1]] %>% 
        .[4] %>% 
        str_extract_all('[0-9]') %>% 
        .[[1]] %>% 
        paste0(collapse = '') %>% 
        as.numeric() %>% 
        str_replace_all('0', '零') %>% 
        str_replace_all('1', '一') %>% 
        str_replace_all('2', '二') %>% 
        str_replace_all('3', '三') %>% 
        str_replace_all('4', '四') %>% 
        str_replace_all('5', '五') %>% 
        str_replace_all('6', '六') %>% 
        str_replace_all('7', '七') %>% 
        str_replace_all('8', '八') %>% 
        str_replace_all('9', '九') %>% 
        paste0('日', collapse = '')
      
      黄道吉日 <- c(黄道吉日[1], 月份, 日, 黄道吉日[c(3:length(黄道吉日))])
      黄道吉日 <- c(黄道吉日[1:4], 黄道吉日[7], 黄道吉日[5:6], 
                黄道吉日[8:length(黄道吉日)])
      rm(年份, 月份, 日)
      
      黄道吉日甲 <- tibble(
        宜忌 = c(
          rep('宜', (grep('忌', 黄道吉日)[1] - 1 - grep('宜', 黄道吉日)[1])), 
          rep('忌', length(黄道吉日) - grep('忌', 黄道吉日)[1] + 1)), 
        黄历 = 黄道吉日[c((grep('宜', 黄道吉日)[1] + 1):length(黄道吉日))]) %>% 
        dplyr::filter(宜忌 != 黄历)
      
      黄道吉日甲 <- tibble(
        data.frame(t(黄道吉日[1:(grep('宜', 黄道吉日)[1] - 1)])), 黄道吉日甲)
      names(黄道吉日甲) <- c(
        '阳历日期', '月份', '日', '周日', '生肖年', '农历月日', '干支年', 
        '干支月', '干支日', '宜忌', '黄历', 
        names(黄道吉日甲[ncol(黄道吉日甲):(ncol(黄道吉日甲) - 1)]))
      
      黄道吉日乙 <- c(
        '生肖', '星座', '彭祖百忌', '胎神占方', '年五行', '季节', '月五行', 
        '星宿', '日五行', '节气', '儒略日', '伊斯兰历', '冲', '煞', '六曜', 
        '十二神')
      
      黄道吉日乙 <- tibble(
        种类 = 黄道吉日乙, 明细 = 黄历乙 %>% 
          str_split('\n') %>% 
          .[[1]]) %>% 
        mutate(明细 = substring(明细, nchar(种类) + 1))
      
      黄道吉日乙 %<>% 
        t() %>% 
        data.frame()
      
      names(黄道吉日乙) <- unlist(黄道吉日乙[1, ])
      黄道吉日乙 %<>% .[-c(1), ]
      row.names(黄道吉日乙) <- NULL
      
      黄道吉日 <- data.frame(黄道吉日甲, 黄道吉日乙) %>% 
        tibble()
      黄道吉日 %<>% 
        dplyr::rename('回历' = '伊斯兰历')
      
      rm(黄历甲, 黄历乙, 黄历日期, 黄道吉日甲, 黄道吉日乙)
      
      藏经阁 <- '~/文档/猫城/zhongkehongqi-cangku/诸子百家学府/黄历书库/万年历/'
      if(!dir.exists(藏经阁)) dir.create('~/文档/猫城/zhongkehongqi-cangku/诸子百家学府/黄历书库/')
      if(!dir.exists(藏经阁)) dir.create('~/文档/猫城/zhongkehongqi-cangku/诸子百家学府/黄历书库/万年历/')
      fwrite(黄道吉日, file = paste0(藏经阁, '黄道吉日_', 阳历[迭], '.csv'))
      cat(paste0(藏经阁, '黄道吉日_', 阳历[迭], '.csv 已储存！\n\n'))
      
      return(黄道吉日)
    })
  }
  ## 道家老子黄历的《老黄历》
  if(黄历 == '老黄历') {
    万年历 <- paste0('https://laohuangli.bmcx.com/', 阳历, '__laohuangli/')
    
    llply(1:length(万年历), function(迭) {
      
      cat(paste0('第', num2c(迭), '：读取 https://laohuangli.bmcx.com/', 
                 阳历[迭], '__laohuangli/\n'))
      年份 <- str_split(阳历, '-')[[迭]][1] %>% 
        str_replace_all('0', '零') %>% 
        str_replace_all('1', '一') %>% 
        str_replace_all('2', '二') %>% 
        str_replace_all('3', '三') %>% 
        str_replace_all('4', '四') %>% 
        str_replace_all('5', '五') %>% 
        str_replace_all('6', '六') %>% 
        str_replace_all('7', '七') %>% 
        str_replace_all('8', '八') %>% 
        str_replace_all('9', '九') %>% 
        paste0('年', collapse = '')
      
      黄历甲 <- 万年历[迭] %>% 
        read_html() %>% 
        html_nodes(xpath = '//*[@id="wnrl_k_you_id_1"]') %>% 
        html_text() %>% 
        str_replace_all('宜', '宜 ') %>% 
        str_replace_all('忌', '忌 ')
    })
  }
}
