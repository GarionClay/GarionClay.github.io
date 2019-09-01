---
title: 利用Github Pages和Hexo搭建博客
date: 2019-9-1 01:18:42
categories: "其他"
tags: ["Hexo","博客","NexT"]
---
# 概述

GitPage 是个什么东西？它和 GitHub 是什么关系？Hexo 又是什么？它和 GitPage 又是什么关系？为什么我要用 Hexo + GitPage 搭建博客？我们先解释一下这几个问题，再说搭建博客的详细步骤。

## Hexo简述

[Hexo](https://hexo.io/zh-cn/) 是一个快速、简洁且高效的博客框架。Hexo 使用 Markdown（或其他渲染引擎）解析文章，使用 Node.js 渲染页面，通常在很短的时间内即可利用靓丽的主题生成静态网页。同时 Hexo 也拥有强大的插件系统，支持 Jade, CoffeeScript 等诸多强大插件。

## GitPage简述

我们知道 GitHub 上有众多非常优秀的开源项目，有些项目比较大，涉及到框架级别的项目它的说明文档就不是写几个 Readme 就能讲清楚的事了，所以这种情况下这些项目的维护者就急需一个站点来详尽展示此项目的功能、用法、及更新动态等等，比如大名鼎鼎的 [ReactiveX](http://reactivex.io/) 的 GitPage 地址为 [http://reactivex.github.io](http://reactivex.github.io) 你在浏览器访问这个 URL 会自动跳转到 `reactivex.io`，这是其自定义域名（这是 GitPage 又一个很赞的功能，后面详细介绍），那么问题来了，程序猿们虽然看起来比较万能，但实际上并不是万能的，所以可能一些研究底层架构，程序开发很 NB 的程序员却真的是 HTML、CSS、Linux 小白，毕竟术业有专攻啊，所以这时候让他们自己去搭个站点就真的头疼了，毕竟是有时间成本的。

于是 GitPage 诞生了，GitPage 允许你将你的博客创建为一个 GitHub Project，通过 `your-account.github.io` 这样的特殊项目名称与 GitPage 进行关联，然后，你只需要像平时一样 commit 你的博文到 GitHub 上就 OK 了，GitPage 会自动将你的更新部署出去，完全不需要考虑服务器、数据库、运维、甚至 HTML 等这些发布站点的必备技能，所以 GitPage 诞生的目的就是要把你的专注点拉回到写文章上而不需要花时间去考虑其它事情。

这时你可能会注意到，我要如何去个性化我的站点？我真的仅仅需要 commit 一个文件上去就 OK 吗？当然不是的，想要个性化自己的站点还需要一个博客框架以及一款可自由配置的主题，接着 Hexo 闪亮登场，Hexo 简述在上面，详细介绍请看 [Hexo 中文官网](https://hexo.io/zh-cn/)，Hexo 很好的支持了 Markdown 语法的解析，炫酷的博客主题也很多，大家可以去 [Hexo Themes](https://hexo.io/themes/) 慢慢挑选，我目前用的是 [NexT](https://github.com/theme-next/hexo-theme-next) 这个主题。

OK ，接下来正式开始着手搭建吧。

# 搭建步骤

## 环境准备

### Node.js

进入[Node.js](https://nodejs.org/en)官网下载相应的安装包进行安装即可。我们要用它来安装博客框架、渲染主题等。

### Git

进入 [Git](https://git-scm.com)官网下载相应安装包安装即可。我们要用它来下载主题、提交、部署文章等。

安装完毕后，需要对git进行下设置。随便打开一个文件夹右键——Git Bash Here，打开一个bash命令行，然后执行下面的命令：

```sh
$ git config --global user.name "Type your name here"
$ git config --global user.email yourname@example.com
```

接下来我们还需要生成ssh公钥，以便之后再更新博客的时候与Github通信时验证身份。在gitbash中执行下列命令：

```sh
$ ssh-keygen
```

然后一路回车即可。完成后在你的用户目录下（`C:\Users\yourname`文件夹）应该会有一个`.ssh`文件夹，这个文件夹下的`id_rsa.pub`即为生成的公钥。

我们待会儿会用到这个文件。你可以现在执行`$ cat ~/.ssh/id_rsa.pub`命令查看公钥的内容，然后把公钥复制一下（Ctrl+Insert）粘贴到笔记本待会再用，也可以待会用的时候再去相应的文件夹找这个文件。

### Github

去[Github](https://github.com)官网注册一个账号，我们之后需要将网页托管到Github。

成功之后点击右上角你的头像——Settings——SSH and GPG keys——New SSH key

{% asset_img ssh-key-save.png tihis is an image %}

还记得刚刚生成的公钥吗？用记事本或者notepad++或者任何纯文本编辑器打开它，把里面的内容复制一下，然后粘贴到github的那个框里，title可以随便填。最后点击Add SSH key的按钮，这样你的公钥就在github上注册成功了。

我们可以打开Git Bash使用以下命令测试公钥是否添加成功：

```sh
$ ssh git@github.com
```

出现下图则说明已经成功添加：

{% asset_img ssh-key-success.png tihis is an image %}

完成这一步意味着你现在的这台设备之后可以通过ssh协议与Github服务器进行通信，对你的博客存放的仓库(repo)进行访问、克隆和修改了。

之后如果更换电脑或者重装系统没有保留用户文件夹的话，要记得在新设备或者新系统重新生成公钥并注册到github，否则你的新设备是没有权限对你的repo进行修改和克隆的。当然，这是后话了。

## 安装Hexo

以上几个必备程序安装完成后，只需要用 git-bash 执行如下命令即可安装 Hexo。

```sh
$ npm install -g hexo-cli
```

## 建站

安装 Hexo 完成后，就可以开始建站了。请为你的博客新建一个文件夹，然后在这个文件夹中右键——Git Bash Here打开bash命令行，然后执行下列命令，Hexo 将会在该文件夹中新建所需要的文件。需要注意的是文件夹必须是一个空文件夹。

```sh
$ hexo init
$ npm install
```

新建完成后，指定文件夹的目录如下：

```sh
.
├── _config.yml
├── package.json
├── scaffolds
├── source
|   ├── _drafts
|   └── _posts
└── themes
```

各个文件夹的作用如下：

| 文件/文件夹  | 作用                  |
| ------------ | -------------------------------------- |
| \_config.yml  | 网站的配置文件   |
| package.json | 应用程序的信息|
| scaffolds   | 模版文件夹。当您新建文章时，Hexo 会根据 scaffold 来建立文件  |
| source      | 资源文件夹是存放用户资源的地方。除 \_posts 文件夹之外，开头命名为 \_ (下划线)的文件 / 文件夹和隐藏的文件将会被忽略。Markdown 和 HTML 文件会被解析并放到 public 文件夹，而其他文件会被拷贝过去 |
| themes      | 主题文件夹。Hexo 会根据主题来生成静态页面|

### 站点配置

建站之后我们需要修改博客根目录下的`_config.yml`文件（即hexo配置文件）来对博客进行一些个性化的设置。

这里面的注释都蛮清楚的，可以根据需要自行进行设置。我只改了 `#Site`下几个设置：

```yaml
# Site
title: 这里打你的博客名字
subtitle: 博客副标题
description: 博客的介绍，会显示在侧边栏里
keywords:
author: 作者，会显示在侧边栏里
language: zh-CN
timezone:
```

修改的时候注意别把冒号后面的半角空格删掉了。

待会向github部署站点的时候还要修改`# Deployment`下面的设置，暂时先不管它。

## 创建主题

Hexo博客支持很多种[主题](https://hexo.io/themes/)，可以挑你喜欢的进行设置，这里以NexT主题为例，其他主题也大同小异。

使用如下命令下载主题：

```
$ cd themes/
$ git clone https://github.com/iissnan/hexo-theme-next.git
```

你也可以下载多个主题，然后修改 _config.yml（注意是网站的配置文件而非主题的配置文件） 内的 theme 设定，即可切换主题。这里我们修改Hexo的配置文件中theme设定为next主题：

```yaml
# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: next
```

注意theme的设定要和`theme/`文件夹下的主题的文件夹名完全相同。

打开主题文件夹，可以看到其下的文件和文件夹。一个主题通常有以下结构：

```
.
├── _config.yml
├── languages
├── layout
├── scripts
└── source
```

| 文件/文件夹 | 作用 |
| :---------- | :----------------------------------------------- |
| \_config.yml | 主题的配置文件                                     |
| languages   | 语言文件夹，请参见[国际化](https://hexo.io/zh-cn/docs/internationalization.html) |
| layout      | 布局文件夹。用于存放主题的模板文件，决定了网站内容的呈现方式，您可参考[模板](https://hexo.io/zh-cn/docs/templates.html)以获得更多信息  |
| scripts | 脚本文件夹。在启动时，Hexo 会载入此文件夹内的 JavaScript 文件，参见[插件](<br/>https://hexo.io/zh-cn/docs/plugins.html)获取更多信息 |
| source | 资源文件夹，除了模板以外的 Asset，例如 CSS、JavaScript 文件等，都应该放在这个文件夹中。文件或文件夹开头名称为 \_（下划线线）或隐藏的文件会被忽略 |

### 主题配置

每个主题的配置文件 `_config.yml` 内容可能都不太一样，但是大致都包括了菜单栏、侧边栏、站点图标、头像等常用项，如下是 NexT 主题的部分配置细节展示，其它主题可以去主题官网详细了解。

站点图标设置：

```yaml
favicon:
  small: /images/skyrin-16.png
  medium: /images/skyrin-32.png
  apple_touch_icon: /images/skyrin-180.png
  safari_pinned_tab: /images/logo.svg
  #android_manifest: /images/manifest.json
  #ms_browserconfig: /images/browserconfig.xml
```

页脚设置：

```yaml
footer:
  # Specify the date when the site was setup.
  # If not defined, current year will be used.
  #since: 2015

  # Icon between year and copyright info.
  icon: heart

  # If not defined, will be used `author` from Hexo main config.
  copyright:
  # -------------------------------------------------------------
  # Hexo link (Powered by Hexo).
  powered: false

  theme:
    # Theme & scheme info link (Theme - NexT.scheme).
    enable: false
    # Version info of NexT after scheme info (vX.X.X).
    version: true
  custom_text : Hosted by <a target="_blank" href="https://pages.coding.me" style="font-weight:bold">Coding Pages</a>
```

菜单设置：

```yaml
menu:
  home: / || home
  #about: /about/ || user
  tags: /tags/ || tags
  categories: /categories/ || th
  archives: /archives/ || archive
  #schedule: /schedule/ || calendar
  #sitemap: /sitemap.xml || sitemap
  #commonweal: /404/ || heartbeat

# Enable/Disable menu icons.
menu_icons:
  enable: true
```

方案设置：

```yaml
#scheme: Muse
scheme: Mist
#scheme: Pisces
#scheme: Gemini
```

社交：

```yaml
social:
  GitHub: https://github.com/ || github   #‘||’右侧为小图标名称，图标来源 https://fontawesome.com/，可自定义
  E-Mail: mailto:cnskyrin@163.com || envelope
  简书: https://www.jianshu.com/u/32f1afa17c58 || 
  音乐: http://www.xiami.com/collect/360454952 || music
  #Twitter: https://twitter.com/yourname || twitter
  #FB Page: https://www.facebook.com/yourname || facebook
  #VK Group: https://vk.com/yourname || vk
  #StackOverflow: https://stackoverflow.com/yourname || stack-overflow
  #YouTube: https://youtube.com/yourname || youtube
  #Instagram: https://instagram.com/yourname || instagram
  #Skype: skype:yourname?call|chat || skype

social_icons:
  enable: true
  icons_only: false
  transition: false
```

侧栏头像：

```yaml
# Sidebar Avatar
avatar:
  # In theme directory (source/images): /images/avatar.gif
  # In site directory (source/uploads): /uploads/avatar.gif
  # You can also use other linking images.
  url: /images/avatar.png
  # If true, the avatar would be dispalyed in circle.
  rounded: false
  # If true, the avatar would be rotated with the cursor.
  rotated: false
```

需要注意，如果你的博客中要使用TeX语法写一些数学公式的话，需要修改以下设置：

```yaml
math:
  enable: true

  # Default (true) will load mathjax / katex script on demand.
  # That is it only render those page which has `mathjax: true` in Front-matter.
  # If you set it to false, it will load mathjax / katex srcipt EVERY PAGE.
  per_page: true

  # hexo-renderer-pandoc (or hexo-renderer-kramed) required for full MathJax support.
  mathjax:
    enable: true
    # See: https://mhchem.github.io/MathJax-mhchem/
    mhchem: false

  # hexo-renderer-markdown-it-plus (or hexo-renderer-markdown-it with markdown-it-katex plugin) required for full Katex support.
  katex:
    enable: false
    # See: https://github.com/KaTeX/KaTeX/tree/master/contrib/copy-tex
    copy_tex: false
```

### 测试及部署站点

在站点根目录打开命令行，执行`hexo g`生成网页，然后执行`hexo s`，会在本地启动一个http服务，这时你可以打开浏览器输入[http://localhost:4000/](http://localhost:4000/)，就可以在本地预览博客了。

在命令行Ctrl+C 即可停止预览。win 10 的Git Bash貌似有bug，有时候这里Ctrl+C没反应，这时候打开任务管理手动杀掉Node.js: Server-side JavaScript这个进程即可。

样式符合预期的话我们接下来就可以将网站部署到GitHub或者其它提供 Page 托管的服务站点了，下面将以部署到 GitHub 为例进行操作：

1. 新建GitHub仓库用于托管网站

   在GitHub中创建一个名为`<username>.github.io.git`的仓库（把username替换成你的github用户名）。然后复制一下你的仓库地址：

   {% asset_img clone-git-repo.png tihis is an image %}

2. 在Hexo配置文件`_config.yml`中修改仓库地址

   ```yaml
   deploy:
     type: git
     repo: 
       github: git@github.com:<username>/<username>.github.io.git
   ```

3. 安装deploy git 插件

   ```shell
   npm install hexo-deployer-git --save
   ```

4. 执行`hexo d`即可发布到 GitHub 仓库

5. 以后新增或修改主题后请执行`hexo clean && hexo d -g`清理缓存文件并重新部署

到此为止我们就成功利用hexo搭建了一个使用NexT主题的静态网站，并将其托管到了GitHub，可以通过`<username>.github.io.git`这个网址来访问这个博客。接下来讲博客的日常使用。


# 写文章

Hexo引擎解析Markdown文档生成网页，所以我们写文章时需要使用Markdown语法来写。如果想要系统学习Markdown语法的话可以查看这个[文档](https://www.markdown.cn/)，也可以看我之前的[文章](https://garionclay.github.io/2018/06/23/%E5%85%B3%E4%BA%8EMarkdown/)。

要新建一篇文章，打开Git Bash，执行以下命令：

```bash
hexo n "文章名"
```

就会在博客目录下的`\source\_posts`目录下生成一个`文章名.md`文件，打开这个markdown文档开始愉快的写作吧。

hexo生成的文件头一般包括如下内容：

```markdown
---
title: postName #文章标题
date: 2013-12-02 15:30:16 #文章生成时间，一般不改，当然也可以任意修改
categories: 默认分类 #分类
tags: [tag1,tag2,tag3] #文章标签，可空，多标签请用格式，注意:后面有个空格
description: 附加一段文章摘要，字数最好在140字以内，会出现在meta的description里面
---
```

自己手动写Markdown文档的使用体验不是很好，推荐使用[Typora](https://www.typora.io/)进行md文档的编辑，真的超好用，良心推荐！可以用`Ctrl+/`一键切换源码模式和实时预览模式。

写完文章并保存后，在命令行中执行

```bash
hexo g
hexo d
```

即可生成网页并发布。不过github服务器的反应有时候有点慢，发布之后等一会儿（大概10分钟以内）网站才会更新。

你也可以在`hexo d`之前执行`hexo s`命令，这样就可以在浏览器中输入网址[http://localhost:4000/](http://localhost:4000/)在本地进行预览了，检查无误后再发布即可。

## 注意事项

* 博客中如果使用了TeX数学公式的话，需要打开数学公式渲染开关，在md文档前面加一行`mathjax: true`即可：

  ```markdown
  ---
  title: 面试题- 两个玻璃球100层楼
  date: 2019-01-13 22:00:00
  categories: "算法"
  tags: ["算法","面试","动态规划"]
  mathjax: true
  ---
  ```

  

