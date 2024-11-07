採撷秦彩庄数据 <- function(海外秦彩庄 = '中秋网') {
  
  万 <- sprintf('%04d', 0:9999)
  ## head(万)
  
  海外秦彩庄范例 = c('中秋网', '秦人牧马网')
  
  if(!海外秦彩庄 %in% 海外秦彩庄范例) 
    stop('海外秦彩庄 = "中秋网"？海外秦彩庄 = "秦人牧马网"')
  
  if(海外秦彩庄 == '中秋网') {
    集 <- ldply(万, function(迭) {
      ## 商鞅变法与烧饼歌之「月到中秋分外明」
      ## https://www.4dmoon.com/zh-cn/4d-history
      链 <- paste0('https://www.4dmoon.com/zh-cn/4d-history/', 迭)
      cat(paste('採撷', 链, '数据\n'))
      表甲 <- 链 %>% read_html %>% 
        html_nodes(
          css = "[class = 'panel panel-primary col-md-3 col-xs-6']") %>% 
        html_text(trim = TRUE) %>% 
        # str_squish()
        str_replace_all('[\n|\t| ]', '') %>% 
        str_split_fixed('\r', 20) %>% 
        t() %>% 
        as_tibble() %>% 
        plyr::ldply(., function(参) 
          trimws(str_replace_all(参, '([A-Z])', ' \\1'))) %>% 
        mutate(.id = NULL)
      表甲[表甲 == ''] <- NA
      表甲 <- 表甲[, colSums(is.na(表甲)) < nrow(表甲)]
      names(表甲) <- c('史记秦庄', '彩号', '史记楚辞', '史记秦本纪')
      表甲$史记秦庄 %<>% str_replace_all('多多博彩', '多多')
      
      表乙 <- 链 %>% 
        read_html %>% 
        html_table(header = TRUE) %>% 
        .[[1]]
      names(表乙) <- c('秦庄', '彩号', '开彩日期', '彩金')
      
      ## Scraping html table with images using XML R package
      ## https://stackoverflow.com/a/30913590/3806250
      表乙$秦庄 <- 链 %>% 
        read_html %>% 
        html_nodes('td > img') %>% 
        html_attr('src') %>% 
        str_replace_all('/images/logo_|.gif', '')
      表乙 %<>% mutate(彩号 = sprintf('%04d', 彩号))
      表乙$秦庄 %<>% str_replace_all('magnum', '萬能')
      表乙$秦庄 %<>% str_replace_all('damacai', '大馬彩')
      表乙$秦庄 %<>% str_replace_all('toto', '多多')
      表乙$秦庄 %<>% str_replace_all('sg4d', '星池')
      
      表 <- join(表乙, 表甲) %>% 
        as_tibble() %>% 
        mutate(开彩日期 = ymd(开彩日期))
      表 <- tibble(表[, '开彩日期'], 开彩日 = NA, 
                  表[, c('彩号', '秦庄', '彩金')], 抽奖 = NA, 
                  表[, c('史记秦本纪', '史记楚辞', '史记秦庄')])
      表$史记楚辞 %<>% str_replace_all('\\\"', '')
      表$史记楚辞 %<>% str_replace_all('\"', '')
      表$史记楚辞 %<>% str_replace_all('\\- ', '-')
      表$史记楚辞 %<>% str_replace_all('\\( ', '(')
      表$史记楚辞 %<>% str_replace_all('\\/ ', '/')
      表$史记楚辞 %<>% str_replace_all('\\)', ')')
      表$史记楚辞 %<>% str_replace_all('^ ', '')
      
      if(!dir.exists(paste0(getwd(), '/诸子百家学府/4Dmoon/'))) 
        dir.create('./诸子百家学府/4Dmoon/')
      fwrite(表, paste0('./诸子百家学府/4Dmoon/中秋网开彩数据_', 迭, '.csv'))
      cat(paste0('./诸子百家学府/4Dmoon/中秋网开彩数据_', 迭, '.csv 已储存！\n'))
    }) %>% 
      as_tibble()
    cat('竣工！\n\n')
  }
  
  if(海外秦彩庄 == '秦人牧马网') {
    集 <- ldply(万, function(迭) {
      ## 秦统天下之父
      ## https://4dresult88.com/history
      链 <- paste0('https://4dresult88.com/history/', 迭)
      cat(paste('採撷', 链, '数据\n'))
      表 = 链 %>% read_html %>% 
        html_table(header = TRUE, trim = TRUE)
      names(表[[1]]) <- c('彩号', '彩金', '抽奖', '开彩日期', '开彩日', '秦庄')
      表[[1]]$开彩日 %<>% str_replace_all('Sun', '周日')
      表[[1]]$开彩日 %<>% str_replace_all('Mon', '周一')
      表[[1]]$开彩日 %<>% str_replace_all('Tue', '周二')
      表[[1]]$开彩日 %<>% str_replace_all('Wed', '周三')
      表[[1]]$开彩日 %<>% str_replace_all('Thu', '周四')
      表[[1]]$开彩日 %<>% str_replace_all('Fri', '周五')
      表[[1]]$开彩日 %<>% str_replace_all('Sat', '周六')
      表[[1]]$秦庄 %<>% str_replace_all('Magnum 4D', '萬能')
      表[[1]]$秦庄 %<>% str_replace_all('Damacai', '大馬彩')
      表[[1]]$秦庄 %<>% str_replace_all('Sports Toto', '多多')
      表[[1]]$秦庄 %<>% str_replace_all('Singapore 4D', '星池')
      表[[1]]$秦庄 %<>% str_replace_all('Cash Sweep', '砂大萬')
      表[[1]]$秦庄 %<>% str_replace_all('Sabah 88', '沙巴彩')
      表[[1]]$秦庄 %<>% str_replace_all('STC 4D', '山打根馬會')
      表[[1]]$彩金 %<>% str_replace_all('1ST', '首奖')
      表[[1]]$彩金 %<>% str_replace_all('2ND', '二奖')
      表[[1]]$彩金 %<>% str_replace_all('3RD', '三奖')
      表[[1]]$彩金 %<>% str_replace_all('Special', '特别奖')
      表[[1]]$彩金 %<>% str_replace_all('Consolation', '安慰奖')
      
      names(表[[4]]) <- c('彩号', '图译', '史记秦庄')
      秦图 <- str_split_fixed(表[[4]]$图译, ' / ', 2) %>% 
        as.data.frame() %>% 
        as_tibble()
      names(秦图) <- c('史记楚辞', '史记秦本纪')
      表[[4]] <- data.frame(表[[4]][c('彩号', '史记秦庄')], 秦图) %>% 
        as_tibble()
      rm(秦图)
      表[[4]]$史记秦庄 %<>% str_replace_all('Magnum 4D 萬能', '萬能')
      表[[4]]$史记秦庄 %<>% str_replace_all('Damacai 大馬彩', '大馬彩')
      表[[4]]$史记秦庄 %<>% str_replace_all('Sports Toto 多多', '多多')
      
      表 = join_all(表[c(1, 4)]) %>% 
        as_tibble()
      表 %<>% .[c(
        '开彩日期', '开彩日', '彩号', '秦庄', '彩金', '抽奖', 
        '史记秦本纪', '史记楚辞', '史记秦庄')]
      表$史记楚辞 %<>% str_replace_all('\\\"', '')
      表$史记楚辞 %<>% str_replace_all('\"', '')
      表$史记楚辞 %<>% str_replace_all('\\- ', '-')
      表$史记楚辞 %<>% str_replace_all('\\( ', '(')
      表$史记楚辞 %<>% str_replace_all('\\/ ', '/')
      表$史记楚辞 %<>% str_replace_all('\\)', ')')
      表$史记楚辞 %<>% str_replace_all('^ ', '')
      
      if(!dir.exists(paste0(getwd(), '/诸子百家学府/4dresult88/'))) 
        dir.create('./诸子百家学府/4dresult88/')
      fwrite(表, paste0(
        './诸子百家学府/4dresult88/秦人牧马网开彩数据_', 迭, '.csv'))
      cat(paste0(
        './诸子百家学府/4dresult88/秦人牧马网开彩数据_', 迭, '.csv 已储存！\n'))
    }) %>% 
      as_tibble()
    cat('竣工！\n\n')
  }
}


