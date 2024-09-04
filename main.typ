#import "template.typ": project, chineseoutline
#import "@preview/fontawesome:0.4.0": fa-icon



#let vpn = box(baseline: 0.2em, stroke: 0.3pt + black, inset: (right: 0.3em, rest: 0.2em), radius: 5pt, fill: green.lighten(90%))[
  #box(height: 0.8em, baseline: 0.1em, inset: (left: 0.1em, right: 0.1em, top: 0.05em))[
    #fa-icon("shield-halved", fill: green.darken(20%), size: 0.8em)
  ]#text([校园网/VPN], size: 0.8em, font: "Source Han Sans")
]

#let http = box(baseline: 0.3em, stroke: 0.3pt + black, inset: (right: 0.3em, rest: 0.2em), radius: 5pt, fill: red.lighten(90%))[
  #box(height: 0.8em, baseline: 0.1em, inset: (left: 0.1em, right: 0.1em))[
    #image("icons/unsafe-icon.svg")
  ]#text([不支持 HTTPS], size: 0.8em, font: "Source Han Sans")
]
#let plink(name, https: true, suffix: "") = {
  link(
  (if https {"https://" } else { "http://" }) + name + ".bupt.edu.cn" + suffix,
  )[#{
    text(
      if https
        [https:\/\/]
      else
        [http:\/\/],
      fill: blue.lighten(50%),
      weight: "extralight"
    )
    text(
      [#name],
      fill: blue.lighten(10%),
      weight: "extrabold"
    )
    [\.bupt.edu.cn]
    if suffix != "" {
      [#suffix]
    }
  }]

  if not https {
    h(0.2em)
    http
  }
}

#show: project.with(title: "北邮网络资源手册", author: "YouXam")

#heading(outlined: false, numbering: none)[前言]

亲爱的北邮学弟学妹们：

首先我诚挚欢迎各位加入北京邮电大学这个大家庭。作为北邮的新成员，你们将开启人生的新篇章，在这片充满机遇与挑战的热土上追求独特的大学梦想。

进入大学，我们需要熟练运用各种网络资源和工具，借助线上平台来学习、生活、交流。而北邮的的网络资源繁多，既有学校的各种网站、平台，也有学长学姐们开发的各类工具。对于新生来说，这些资源可能并不是那么容易找到，也缺乏一个统一的指引。

有鉴于此，我汇集了校内外各类优质网站，编撰了这份“北邮网络资源手册”，希望能为你们提供一个获取有用资讯的指引。这个手册囊括了校园生活、学习资源、实用工具等多个维度，我真诚地希望它能在求学路上助你们一臂之力。

此手册内容源于我个人的经验和了解，不代表北邮官方和任何其他组织的观点和立场。由于我知识面有限，手册难免有疏漏之处，非常欢迎大家继续补充和完善，让它更加贴近同学们的实际需求。

你可以在 #fa-icon("github") #link("https://github.com/YouXam/bupt-network-resources-guide")[YouXam/bupt-network-resources-guide] 上找到这份手册的源代码，也欢迎提出 issue 和 pull request。

最后，衷心祝愿各位学弟学妹在北邮取得圆满成就，未来都能在梦寐以求的事业领域施展才华，成就非凡！

#align(right)[
  YouXam\
  #link("mailto:youxam@bupt.edu.cn")[youxam\@bupt.edu.cn] \
  2024 年 8 月 8 日
]

#pagebreak()

#chineseoutline()

#pagebreak()

= 北邮官方资源

#h(2em)本章主要介绍北邮学校的各类官方网站、平台。

== 北邮认证系统介绍

#h(2em)新生可以在 @welcome 查询学号，然后就可以激活或注册北邮的各类账号了。大体而言，在北邮常使用的账号有以下五类，其中账号为你的学号，*密码则相互独立*：

+ #link("https://netaccount.bupt.edu.cn")[校园网]账号;
+ #link("https://jwgl.bupt.edu.cn")[本科教务管理系统]账号;
+ #link("https://mail.bupt.edu.cn")[北邮教育邮箱]账号；
+ 学生卡账号；
+ #link("https://auth.bupt.edu.cn")[统一身份认证系统]账号。

#h(2em)其中校园网账号用于在学校内连接校园网和使用电子资源统一访问系统，本科教务管理系统账号用于查询课表、成绩、选课等，北邮教育邮箱账号用于登录北邮教育邮箱（腾讯企业邮），其他系统则大都使用统一身份认证系统账号登录。当然也有一些较不常用的不使用统一身份认证系统的系统，例如#link("https://win.bupt.edu.cn/")[大学生创新创业计划训练平台]。

== 学生卡

在校园内，学生卡的主要作用有以下三点：

+ 作为门禁卡，进出校园、图书馆等；
  
  进出校园一般使用人脸识别，而图书馆的闸机和其他某些区域的门禁可以在完美校园 App / 钥匙串中直接控制。
+ 借阅图书；
+ 在食堂、超市消费，在澡堂、水房用水。

  需使用完美校园 App/微信小程序充值、查询余额、消费记录等。其中食堂和超市使用的刷卡机同时也支持微信和支付宝扫码支付（第一次使用需要绑定校园卡）。若单日消费超过一定金额，需要输入校园卡密码，初始密码为身份证号后 6 位，若末位为 “X” 则用 “0” 代替。

== VPN <vpn>

在校外环境，如果需要访问某些只有校园网环境才能访问的网站和资源，你需要使用 VPN 连接到校园网。北邮官方提供的方式有以下三种：

+ #link("https://vpn.bupt.edu.cn")[Atrust VPN]。这是推荐使用的方式。需要下载客户端、并使用北邮企业微信/校园网自服务（或在微信中访问 #plink("netaccount")） 查看 OTP 动态口令。登录时，用户名为学号，密码为 OTP 动态口令。
+ #link("https://webvpn.bupt.edu.cn")[WebVPN]。这是网页版的 VPN，不需要下载客户端。需要使用微信扫码登录。
+ #link("https://libcon.bupt.edu.cn")[电子资源统一访问系统]。此系统虽然是用于在非校园网环境访问数据库，但也可以访问校园网环境下的普通资源。需要使用校园网账号登录。

== 网站


#h(2em)本节中的网站可使用浏览器直接访问，域名均为 bupt.edu.cn 结尾。需要使用校园网环境或者 VPN（见 @vpn） 连接的会使用 #vpn 标识，不支持 HTTPS 的会使用 #http #h(0.2em)#footnote[必须使用形如 *http:\/\/*xxx.bupt.edu.cn 的网址而不能使用 *http#text(fill: red)[s]:\/\/*xxx.bupt.edu.cn 的网址访问。] 标识。

=== #link("https://welcome.bupt.edu.cn/")[北京邮电大学迎新网] <welcome>

#h(2em)#plink("welcome")

这是北邮的迎新网站，是新生首先需要使用的第一个网站。你应当首先阅读#link("https://welcome.bupt.edu.cn/info/1002/1011.htm")[迎新系统说明]，按照指引完成各项任务。其中最重要的一项是#link("https://stu.bupt.edu.cn/xsfw/sys/xhcxappcqjtu/*default/index.do?xhcx#/xhcx")[查询学号]。详细的迎新流程在随录取通知书中的新生手册中应当有详细说明。

=== #link("https://netaccount.bupt.edu.cn")[校园网自服务系统] <netaccount>

#h(2em)#plink("netaccount")

在这里你可以修改校园网账号的密码。初始密码为证件号后 6 位，最后一位如为 “X” 用 “0” 代替。

你同样可以通过“北邮企业微信/校园网”（或在微信中访问 #plink("netaccount")）修改校园网账号的密码。

=== #link("https://jwgl.bupt.edu.cn/")[本科教务管理系统]

#h(2em)#plink("jwgl") #vpn

本科教务管理系统是北邮学生查询课表、成绩、选课等信息的主要平台。初始密码为 8 位生日，登录后请及时修改密码。

在抢课的时候，突发的高并发可能导致本科教务管理系统负载均衡出现问题，此时你可以尝试直接访问源站：http:\/\/10.3.58.1$x$:1808$x$/jsxsd，其中 $x in [0, 7]$。

=== #link("https://mail.bupt.edu.cn/")[北邮教育邮箱]

#h(2em)#plink("mail")

新用户请先#link("https://register.bupt.cn/")[注册账号] #vpn。注册完成后，你就可以使用形如 foo\@bupt.edu.cn （其中 foo 为注册时指定）和 2024210001\@bupt.cn （校友邮箱，其中 2024210001 为学号示例）的邮箱地址了。

若需要修改邮箱地址，请使用当前邮箱发邮件到 #link("mailto:admin@bupt.edu.cn")[admin\@bupt.edu.cn] 说明情况，注销后重新注册。


=== #link("https://auth.bupt.edu.cn")[统一身份认证系统] <auth>

#h(2em)#plink("auth")

北邮的大部分系统均使用统一身份认证系统登录，可以使用学号和统一身份认证系统的密码登录，也可以使用微信/企业微信认证（例如扫码或者直接在微信中访问）。

新用户请先 #link("https://uc.bupt.edu.cn/#/register/index")[激活账号]。

=== #link("http://my.bupt.edu.cn/")[信息服务门户]

#h(2em)#plink("my", https: false) #vpn

信息服务门户主要的作用是查看校内通知和新闻，同时也通过“系统直通车”、“服务导航”等分区提供北邮各网络资源的跳转渠道，如教务系统、学工系统、正版软件等。

=== #link("https://ucloud.bupt.edu.cn/uclass")[云邮教学空间]

#h(2em)#plink("ucloud", suffix: "/uclass")

云邮教学空间是北邮的在线教学平台，用于发布课程资料、作业等。大部分作业和实验报告等都需要在这里提交。

注：可以使用第三方 Telegram 机器人 #link("https://t.me/bupt_ucloud_bot")[\@bupt_ucloud_bot] 来订阅作业提醒和提交作业。

=== #link("https://lib.bupt.edu.cn")[图书馆]

#h(2em)#plink("lib")

北邮图书馆的网站，可以查询图书馆馆藏书目、使用各类信息资源（例如学校购买的各类科研数据库）。

=== #link("https://libcon.bupt.edu.cn")[电子资源统一访问系统]

#h(2em)#plink("libcon")

你可以使用电子资源统一访问系统访问学校购买的各类数据库，例如知网、维普、IEL 等。该系统本是用于在非校园网环境访问数据库，但由于学校网络出口的限制，校园网环境下可能也需要使用此系统才能访问各类数据库。

登录账号为校园网账号。

=== #link("https://order.bupt.edu.cn/")[北京邮电大学图书馆/教三楼空间预约管理系统]

#h(2em)#plink("order") #vpn

该系统一般用于预约沙河图书馆研讨间。

=== #link("https://service.bupt.edu.cn")[网上服务大厅] <service>

#h(2em)#plink("service")

网上服务大厅可用于填报和提交各类申请表，例如校外人员入校申请、请假申请等。

=== #link("https://software.bupt.edu.cn")[软件正版化平台]

#h(2em)#plink("software") #vpn

你可以在软件正版化平台下载和安装正版 Windows, Office, Visual Studio 等。

=== #link("https://3039.bupt.edu.cn")[信息化报修系统] <3039>

#h(2em)#plink("3039")

若遇到校园网、官方网站故障或使用问题，可以在此系统中提交报修。

也可以直接拨打电话 010-62283039（周一至周五的 9:00-17:00）。

=== #link("https://dekt.bupt.edu.cn")[第二课堂(管理端)]

#h(2em)#plink("dekt")

第二课堂是北邮的活动报名、签到平台。

此网页版用于教师、学生干部或社团负责人发布和管理活动，使用统一认证账户登录。报名和签到需要使用微信小程序“北邮第二课堂”。

第二课堂使用教程见#link("https://mp.weixin.qq.com/s/KaXWdPVSi5likW4P2B4YYg")[ 你好，新同学！第二课堂新手任务已发布！
]。

== 企业微信

=== 使用方式

#h(2em)需要通过导员发送的二维码扫描绑定企业微信帐号。

=== 应用介绍

#h(2em)北邮企业微信中包含很多应用，因为相对而言较为集中，并且有应用目录，所以这里只介绍几个较为重要的，其他应用你可以在企业微信中查看。

+ 网上服务大厅：同 @service；
+ 校园网自服务：查看用于连接 VPN 的 OTP；
+ 体育馆预约：预约健身房、羽毛球场、游泳馆等；
+ 宿舍用电：缴纳宿舍电费；
+ 北邮接诉即办：提供维修服务（如宿舍电器报修）、服务监管（可于此投诉校园生活中遇到的各类问题）；
+ 信息帮：同 @3039；
+ 微教学：查看课程表、考试安排、成绩等。某些课程签到时，可在常用功能/云平台/我的课程/当前课程中签到。

== 杂项

=== 校历

#h(2em)https://www.bupt.edu.cn/ggfw/xl.htm

=== 办公电话

#h(2em)https://www.bupt.edu.cn/ggfw/bgdh.htm

=== 校园地图

#h(2em)https://www.bupt.edu.cn/bygk/zjby/xydt.htm

#pagebreak()

= 北邮其他资源

#h(2em)本章中的资源大多由北邮学长学姐们开发和维护，但其中部分同样受到北邮官方的监督和支持（例如北邮人论坛）。

== #link("https://bbs.byr.cn")[北邮人论坛]

#h(2em)北邮人论坛是北京邮电大学官方网络论坛，面向全部在校生与校友开放，是国内最活跃的高校论坛之一。论坛内版块全面，信息丰富，能够解答北邮人方方面面的问题，无论你是想咨询选课、发表论文、奖学金、考研保研出国校招的各类攻略，还是想谈天说地、恋爱征友、寻找出游攻略，你都能在这里找到一起讨论的人，共同寻求答案。

北邮人论坛有以下四种访问方式：

+ 电脑网页版：https://bbs.byr.cn；
+ 手机网页版（通过直链查看帖子无需登录，但不能发帖）：https://bbs.byr.cn/n
+ 客户端
  - App Store：https://apps.apple.com/cn/app/id1115232927
  - Android 下载：https://github.com/BYR-App-Dev/BYR_App_Android_Release/releases/latest/download/release.apk
  - Android 加速镜像：https://bbs.byr.cn/files/apk/byrbbs-android-app/latest/release.apk
  - Github Org：https://github.com/BYR-App-Dev
+ telnet（支持更多高级功能）：#link("telnet://bbs.byr.cn")[telnet:\/\/bbs.byr.cn]

#h(2em)新生必须先访问#link("https://bbs.byr.cn")[电脑网页版]，使用*网关账户（校园网账户，见 @netaccount）*认证身份并注册账户，然后#link("https://bbs.byr.cn/#!user/passwd")[通过手机号验证]。

注：北邮人论坛是北邮人独有的精神家园，禁止外借账号使用，违者面临封禁风险。

详细使用方式可见#link("https://mp.weixin.qq.com/s/cC7LivGeex88aO4a_mJrBg")[21 年版新生论坛指南]。

北邮人论坛由#link("https://team.byrio.work/")[北邮人团队]维护和运营。

== #link("https://overleaf.byrio.work")[Overleaf]

#h(2em)https://overleaf.byrio.work #vpn

Overleaf 是一个在线 LaTeX 编辑器，支持多人协作。北邮人团队提供了一个 Overleaf 实例，具有 Overleaf 官方的专业版功能。必须使用结尾为 \@bupt.edu.cn 或者 \@bupt.cn 的邮箱注册。

== #link("https://bitwarden.byrio.work")[Bitwarden]

#h(2em)https://bitwarden.byrio.work 

Bitwarden 是一个密码管理器，支持多平台。北邮人团队提供了一个 Bitwarden (Vaultwarden) 实例，具有 Bitwarden 官方服务器的专业版功能。必须使用结尾为 \@bupt.edu.cn 或者 \@bupt.cn 的邮箱注册。

== 开源镜像

#h(2em)由北邮人团队维护的北邮开源镜像站提供了大量的开源软件镜像，包括：

+ pypi
+ npm
+ golang
+ cargo
+ linux 相关软件源

#h(2em)镜像站地址：https://mirrors.byr.ink/ #vpn

== #link("https://git.byr.moe")[GitLab]

#h(2em)https://git.byr.moe

北邮人团队维护的 GitLab 实例。可以用于托管代码、协作开发等。

== “巴普特今天网炸了吗” QQ 群聊

#h(2em)北邮人团队负责的*非北邮官方*校园网帮助群，如果你遇到了校园网网络问题，可以加入群聊咨询：835973564。

== #link("https://wiki.buptnet.icu")[北邮校园网指南]

#h(2em)https://wiki.buptnet.icu

北邮人团队维护的北邮校园网使用指南，详细介绍了北邮校园网的使用方法和常见问题等。

== #link("https://byr.pt/")[北邮人 PT]

#h(2em)https://byr.pt

可用于下载和分享各类资源（例如电影、剧集、游戏、软件等）。必须使用非三大运营商的 IPv6 网络访问（例如教育网 IPv6 网络或国外 IPv6 网络），可以使用校园网访问。

== #link("https://byrdocs.org")[BYR Docs]

#h(2em)https://byrdocs.org

BYR Docs 是一个资料分享平台，旨在使北邮学生更方便地获取与北邮课程有关的教育资源，包括电子书籍、考试题目和复习资料等。

可使用北邮教育网 IPv6 免登录访问。若在校外，需使用统一身份认证系统登录。

= 公共资源

#h(2em)本章中的资源与北邮无关。

== zlibrary

#h(2em)https://zh.singlelogin.re/

常用电子书下载网站。注意，zlibrary 有许多*假冒*网站（例如 #text(fill: red)[z-lib.io, z-lib.id, zlibrary.to]），请注意链接的正确性。zlibrary 官方并不强制要求收费下载电子书，凡要求付费下载电子资源的，一律为假冒网站。

zlibrary Telegram 频道：https://t.me/zlibrary_official

zlibrary Telegram 中文频道：https://t.me/zlib_china_official

== 教育认证

#h(2em)当你注册了北邮教育邮箱后，你可以使用北邮教育邮箱注册一些教育认证服务，例如：

+ GitHub Education Pack：https://education.github.com/pack
+ JetBrains 学生许可证：https://www.jetbrains.com/zh-cn/community/education/#students

#h(2em)由于网上可以找到很多教程，故不再赘述。