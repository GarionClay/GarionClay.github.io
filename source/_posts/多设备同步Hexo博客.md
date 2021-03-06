---
title: 多设备同步Hexo博客
date: 2018-10-30 18:18:08
categories: "其他"
tags: ["Hexo","博客","NexT"]
---
## 说明 ##
一开始搭建的时候是用台式机搭建的博客，后来每次想写东西的时候手边都只有笔记本，于是就在想怎么才能在多个终端保持同步？也看了下别人的教程，大致思路就是把环境文件一起用一个新的分支来同步。于是下面的步骤就简单了——

## 把环境文件推送到远程仓库 ##
1. 需要在原来的远程repo里新建一个分支，比如就起名hexo好了，然后把默认分支也改成这个hexo分支。
2. 然后在本地随便选个位置，打开gitbash，```git clone repoURL```把这个仓库克隆下来。
3. 我们其实只需要.git文件夹而已，把.git文件夹剪切到hexo项目根目录下，比如我的在```E:\blog\```，这时候这个hexo项目已经变成了和远程hexo分支关联的本地仓库了。接下来把所有文件都推送到远程分支就可以了，但在此之前需要注意，如果你和我一样用的NexT主题的话，```/theme/next/```事实上也是一个git仓库，需要把这下面的```.git/```文件夹删掉才能正常同步（或者可以把那个作为子项目，太麻烦了我没搞）。
4. 把改动推送到远程仓库。
       git add -A
       git commit -m "some description"
       git push origin hexo

## 新电脑上同步博客 ##
搞定以上步骤之后就可以在新电脑上同步啦。
1. 环境安装。安装git,Node.js这个就不细说了Google下就有了。
2. 打开gitbash，```git clone repoURL```克隆远程仓库。
3. cd到项目根目录下，安装环境：

       npm install hexo
       npm install
       npm install hexo-deployer-git

4. 然后就可以正常使用了。

## 日常使用 ##
就和使用git的方法一样。
1. ```git pull```更新本地仓库
2. 写文章
3. 推送到远程仓库
       git add -A
       git commit -m "..."
       git push origin hexo
4. ```hexo g; hexo d;```发布文章并同步master分支
5. 可以```hexo s```本地测试一下


参考：https://www.zhihu.com/question/21193762