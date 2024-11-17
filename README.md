周易、易经、算卜、秦彩庄
=======================

# 清史与复兴公元前秦史

![](诸子百家考工记/中科红旗，量化对冲（乙）.png)

咱们秦人（英译：Chinese）在清末时期，从祖国（目前的东亚秦国——中国，英译：China）飘洋过海到东南亚南洋或星洲。公元一九四九己丑年国共（中国国民党与中国共产党）内战时期，海外华人公会建党、家慈出生、中国共产党建国。
郜国

- [「文派」《赢家黄氏江夏堂》 – 始祖赢政ξηg Tεηg·黄永春家谱](https://englianhu.wordpress.com/2022/02/22/《雪隆江夏堂》-家谱/)

# 第一篇、秦彩庄

## 第一章、[福彩三码分析](http://rpubs.com/englianhu/lottery-3D-analysis)

### 第一章第二节、介绍

彩票市场在中国内地甚至全球的市场占有份额日益增加，越来越多赌徒热爱购买彩票。今天愚生尝试分析随机内地彩票---**福彩3D**为数据，分析是否可能从中获利。

### 第一章第三节、读取数据

[<span style='color:blue'>福彩三码：直选走势</span>](http://sports.sina.com.cn/l/tubiao/3d_jibenzoushitu.html)数据从*2016158期*至*2017158期*，一共有360个观测数据。该福彩类型规则乃预测3个随机数字，从000至999。

### 第一章第四节、数学模式

- `kfoots`：[<span style='color:blue'>kfoots</span>](https://github.com/lamortenera/kfoots)程序包使用马克夫链，举例此期开彩010，该模式将分析及预测每当开彩该成绩后的下一个成绩（状态的转换率）的机率
- `PoisNor`：[<span style='color:blue'>PoisNor</span>](https://cran.r-project.org/package=PoisNor)程序包提供多随机变量产生器及相关系数分析
- `poilog`：[<span style='color:blue'>poilog</span>](https://cran.r-project.org/package=poilog)程序包分析双变量泊松模式
- `mvrpois`：[<span style='color:blue'>mvrpois</span>](https://github.com/alekdimi/mvrpois)程序包分析多变量泊松模式

在此，愚生使用`mvrpois`多变量泊松模式分析**仨变量泊松**三码彩票数据，有关详情请查阅*Dimitris Karlis and Loukia Meligkotsidou (2005)^[**7.3 参考文献**中的4th文献]*和*Dimitris Karlis (2002)^[**7.3 参考文献**中的3rd文献]*。

$$(X_{1},X_{2},X_{3})_{i} ~ 3 - Pois(\theta_{1i},\theta_{2i},\theta_{3i},\theta_{12i},\theta_{13i},\theta_{23i}) \dots equation\ 3.1$$

- $log(\theta_{1i}) = \alpha_{1} + \beta_{1}z_{i}$
- $log(\theta_{2i}) = \alpha_{2} + \beta_{2}z_{i}$
- $log(\theta_{3i}) = \alpha_{3} + \beta_{3}z_{i}$
- $log(\theta_{12i}) = \alpha_{4} + \beta_{4}z_{i}$
- $log(\theta_{13i}) = \alpha_{5} + \beta_{5}z_{i}$
- $log(\theta_{23i}) = \alpha_{6} + \beta_{6}z_{i}$

联合分布函数将为：

$$P(X = x) = \sum_{(y_{12},y_{13},y_{23})\in C}\frac{exp(-\sum\theta_{i})\theta_{1}^{x_{1}-y_{12}-y_{13}}\theta_{2}^{x_{2}-y_{12}-y_{23}}\theta_{3}^{x_{3}-y_{13}-y_{23}}\theta_{12}^{y_{12}}\theta_{13}^{y_{13}}\theta_{23}^{y_{23}}}{(x_{1}-y_{12}-y{13})!(x_{2}-y_{12}-y{23})!(x_{3}-y_{13}-y{23})!y_{12}!y_{13}!y_{23}!} \dots equation\ 3.2$$
  而 $C \subset N^3$ 设为：

$$C = (y_{12},y_{13},y_{23}) \in N^3 : \{y_{12}+y_{13}\leq x_{1}\} \cup \{y_{12}+y_{23}\leq x_{2}\} \cup \{y_{13}+y_{23}\leq x_{3}\} \neq \theta$$

**多元泊松尤物参考文献：**

- [<span style='color:blue'>Can a Multivariate Poisson Distribution be implemented in Stan?</span>](https://groups.google.com/forum/#!topic/stan-users/3VHq_GxGWEw)
- [<span style='color:blue'>n-mixture model in Stan? marginalizing</span>](https://groups.google.com/forum/#!newtopic/stan-users/stan-users/9mMsp1oB69g)
- [<span style='color:blue'>karlis-ntzoufras-reproduction/model.stan</span>](https://github.com/Torvaney/karlis-ntzoufras-reproduction/blob/master/model.stan)
- [<span style='color:blue'>Reproductions of models for football (soccer) matches in Stan/PyStan</span>](https://github.com/Torvaney/soccerstan)^[So far, the following models have been implemented:] ^[1) Maher (1982) - Modelling Association Football Scores - maher] ^[2) Dixon and Coles (1997) - Modelling Association Football Scores and Inefficiencies in the Football Betting Market - dixon-coles] ^[3)Karlis and Ntzoufras (2008) - Bayesian modelling of football outcomes (using the Skellam's distribution) - karlis-ntzoufras]

## 第一章第五节、投注模式

由于凯利投资模式，在此使用该模式。有关凯利模式投注，请参阅：

- [<span style='color:blue'>Application of Kelly Criterion model in Sportsbook Investment</span>](https://github.com/scibrokes/kelly-criterion)
- [<span style='color:blue'>Job Application - Quantitative Analyst (binary.com)</span>](https://github.com/englianhu/binary.com-interview-question)

## 第一章第六节、盈利

## 第一章第七节、结论

## 第一章第八节、附录

### 第一章第八节第一子章节、文献明细

It's useful to record some information about how your file was created.

- File creation date: 2017-06-15
- File latest updated date: `r Sys.Date()`
- `r R.version.string`
- R version (short form): `r getRversion()`
- [<span style='color:blue'>**rmarkdown** package</span>](https://github.com/rstudio/rmarkdown) version: `r packageVersion('rmarkdown')`
- [<span style='color:blue'>**tint** package</span>](http://dirk.eddelbuettel.com/code/tint.html) version: `r packageVersion('tint')`
- File version: 1.0.0
- Author Profile: [<span style='color:blue'>®γσ, Eng Lian Hu</span>](englianhu.github.io/2016/12/ryo-eng.html)
- GitHub: [<span style='color:blue'>Source Code</span>](https://github.com/englianhu/lottery)
- Additional session information

### 第一章第八节第二子章节、版本
  
- 文献版本: 1.0.0 - *"2017-06-15 20:47:50 JST"*


### 7.3 参考文献

1. [<span style='color:blue'>**Bayesian Multivariate Poisson Regression for Models of Injury Count, by Severity** *by Jianming Ma and Kara M. Kockelman (2006)*</span>](https://github.com/englianhu/lottery/tree/master/reference/Bayesian%20Multivariate%20Poisson%20Regression%20for%20Models%20of%20Injury%20Count%2C%20by%20Severity.pdf)
2. [<span style='color:blue'>**FlexMix - An R package for finite mixture modelling** *by Bettina Grun and Friedrich Leisch (2007)*</span>](https://github.com/englianhu/lottery/tree/master/reference/FlexMix%20-%20An%20R%20package%20for%20finite%20mixture%20modelling.pdf)
3. [<span style='color:blue'>**Multivariate Poisson Models** *by Dimitris Karlis (2002)*</span>](https://github.com/englianhu/lottery/tree/master/reference/Multivariate%20Poisson%20Models.pdf)
4. [<span style='color:blue'>**Multivariate Poisson Regression with Covariance Structure (Preview)** *by Dimitris Karlis and Loukia Meligkotsidou (2005)*</span>](https://github.com/englianhu/lottery/tree/master/reference/Multivariate%20Poisson%20Regression%20with%20Covariance%20Structure%20(Preview).pdf)
5. [<span style='color:blue'>**Package 'poilog'** *by Vidar Grøtan and Steinar Engen (2015)*</span>](https://github.com/englianhu/lottery/tree/master/reference/Package%20'poilog'.pdf)
6. [<span style='color:blue'>**Resampling Methods for Longitudinal Data Analysis** *by Yue Li (2005)*</span>](https://github.com/englianhu/lottery/tree/master/reference/Resampling%20Methods%20for%20Longitudinal%20Data%20Analysis.pdf)

### 7.4 感言

# 第二篇、海外秦彩庄



