Copyright (C) 2017 The LineageOS Project

Device configuration for Nubia Z11
==============
1. 用清华镜像同步源码。

```
$ mkdir ~/bin
```
```
$ PATH=~/bin:$PATH
```
```
$ curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo> ~/bin/repo
```
```
$ chmod a+x ~/bin/repo
```

2. repo 的运行过程中会尝试访问官方的 git 源更新自己，如果想使用 tuna 的镜像源进行更新，可以将如下内容复制到你的 ```~/.bashrc``` 里

```
$ export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'
```

3. 建立LineageOS目录并同步源码和依赖

```
$ mkdir ~/LineageOS && cd ~/LineageOS
```

4.：设置的你Github用户名和邮箱（没有账号的去github官网用邮箱申请一个）

```$ git config --global user.email "qq371043382@Gmail.com"```（"you@example.com"改为你的谷歌邮箱）

```$ git config --global user.name "Tlntin"```（"Your Name"改为你的github用户名）

```$ repo init -u https://mirrors.tuna.tsinghua.edu.cn/git/lineageOS/LineageOS/android.git -b cm-14.1```

4.打开 ```.repo/manifest.xml```，请到文件管理器菜单栏打开运行查看隐藏文件

将

```
  <remote  name="github"
           fetch=".."
```

改成

```
  <remote  name="github"
           fetch="https://mirrors.tuna.tsinghua.edu.cn/git/lineageOS/"
```

将

```
  <remote  name="aosp"
           fetch="https://android.googlesource.com"
```

改成

```
<remote  name="aosp"
           fetch="https://aosp.tuna.tsinghua.edu.cn"
```

```$ repo sync```(同步失败一次就继续用这个命令同步) 

异常处理

对于有些 Lineage 的 prebuild 仓库，因为使用了 ```clone-depth="1"``` 导致了 HTTP 协议下同步出现错误 ```fatal: dumb http transport does not support --depth```，
解决的办法如下：

同步 cm-14.1 及以下版本，在终端中输入：

```
$ sed -i 's/clone-depth="1"//' .repo/manifest.xml
```
```
$ sed -i 's/clone-depth="1"//' .repo/manifests/snippets/cm.xml (具体是不是叫cm.xml得看实际情况)
```

同步完源码后，需要下这些东西，路径没有就自己建一个。这个 device 是解压重命名为nx53j，放到 ```device/nubia``` 目录。

1.下载 TWRP 源码，替换自带 recovery，https://github.com/omnirom/android_bootable_recovery 
重命名为 ```recovery```，放到 ```bootable/recovery``` 目录（放置前请删 ```bootable``` 里面的 ```recovery``` 目录）。

2.下载 busybox 源码，[https://github.com/LineageOS/android_external_busybox](https://github.com/LineageOS/android_external_busybox)，解压，重命名为 ```busybox``` 放到 ```external``` 目录。

3.下载 deviceseting 源码，[https://github.com/LineageOS/android_packages_resources_devicesettings](https://github.com/LineageOS/android_packages_resources_devicesettings)，解压，重命名为 ```devicesettings``` 放到 ```packages/resources``` 目录。

4.下载 vendor，[https://github.com/Tlntin/vendor_nubia_nx531j-lineage14.1](https://github.com/Tlntin/vendor_nubia_nx531j-lineage14.1)，解压重命名为 ```nx531j```，放到 ```vendor/nubia``` 目录下面。

5.下载 kernel，[https://github.com/CyanogenMod/android_kernel_nubia_msm8996](https://github.com/CyanogenMod/android_kernel_nubia_msm8996)，解压重命名为msm8996,放到 ```kernel/nubia``` 目录下

6.[https://github.com/LineageOS/android_device_qcom_common](https://github.com/LineageOS/android_device_qcom_common) 解压重命名为 ```common```，放到 ```device/qcom```目录下。

7.[https://github.com/LineageOS/android_external_stlport](https://github.com/LineageOS/android_external_stlport)  解压，重命名为 ```stlport```，放到 ```external``` 目录下。

8.[https://github.com/Tlntin/vendor_nxp-nfc-lineage14.1](https://github.com/Tlntin/vendor_nxp-nfc-lineage14.1) 下载 nfc 驱动。

先安装这个,不然编译到一半会失败

```
# apt-get install rsync
```


 开始编译：
1.设置编译环境
```
$ source build/envsetup.sh
```

2.设置加快编译速度
```
$ export USE_CCACHE=1
 ```
 
3.加入root
```
$ export WITH_SU=true
```

4.设置缓存
```
$ ~/Los14/prebuilts/misc/linux-x86/ccache/ccache -M 80G
```
```
$ export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx16000m" （本人内存8g，所以这里允许内存填8192M）
```

4.开安装 jack，

进 ```prebuilts/sdk/tools``` 目录打开终端，
```
$ ./jack-admin install-server jack-launcher.jar jack-server-4.8.ALPHA.jar
```

5.并且开启 jack 服务。

如何编译到一半失败,请关闭j开启jack或者,手动杀死java服务.不然的话16g内存也不够用。
```
$ ./prebuilts/sdk/tools/jack-admin kill-server
```
```
$ ./prebuilts/sdk/tools/jack-admin start-server
```

6.编译开始
```
$ breakfast  nx531j
```
```
$ make -j8
```

注意：如何编译到一半失败,请关闭j开启jack或者,手动杀死java服务.不然的话16g内存也不够用.
```
$ ./prebuilts/sdk/tools/jack-admin kill-server
```
```
$ ./prebuilts/sdk/tools/jack-admin start-server
```

7.打包
```
$ mka bacon
```


## Device picture

![Nubia Z11](http://static.nubia.cn/product/z11/images/gallery/7.jpg "Nubia Z11 Standard Edition")
