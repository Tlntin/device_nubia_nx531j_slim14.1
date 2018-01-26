Copyright (C) 2017 The LineageOS Project

Device configuration for Nubia Z11
==============
1. 用清华镜像同步源码。

```shell
$ mkdir ~/bin
```
```shell
$ PATH=~/bin:$PATH
```
```shell
$ curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo> ~/bin/repo
```
```shell
$ chmod a+x ~/bin/repo
```

2. repo 的运行过程中会尝试访问官方的 git 源更新自己，如果想使用 tuna 的镜像源进行更新，可以将如下内容复制到你的 ```~/.bashrc``` 里

```shell
$ export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'
```

3. 建立 Slim 目录

```shell
$ mkdir ~/Slim && cd ~/Slim
```

4. 设置的你 GitHub 用户名和邮箱（没有账号的去 GitHub官网用邮箱申请一个）

```$ git config --global user.email "you@example.com"```（"you@example.com"改为你的谷歌邮箱）

```$ git config --global user.name "Your Name"```（"Your Name"改为你的github用户名）

```$ repo init -u git://github.com/SlimRoms/platform_manifest.git -b ng7.1```

5. 打开 ```.repo/manifest.xml```，请到文件管理器菜单栏打开运行查看隐藏文件


将

```xml
  <remote  name="aosp"
           fetch="https://android.googlesource.com"
```

改成

```xml
<remote  name="aosp"
           fetch="https://aosp.tuna.tsinghua.edu.cn"
```

6. 同步源码

```$ repo sync```(同步失败一次就继续用这个命令同步) 


同步完源码后，需要下这些东西，路径没有就自己建一个。这个 device 是解压重命名为nx53j，放到 ```device/nubia``` 目录。

1. 下载 TWRP 源码，替换自带 recovery，https://github.com/omnirom/android_bootable_recovery 
重命名为 ```recovery```，放到 ```bootable/recovery``` 目录（放置前请删 ```bootable``` 里面的 ```recovery``` 目录）。

2. 下载 busybox 源码，[https://github.com/LineageOS/android_external_busybox](https://github.com/LineageOS/android_external_busybox)，解压，重命名为 ```busybox``` 放到 ```external``` 目录。

3. 下载 deviceseting 源码，[https://github.com/LineageOS/android_packages_resources_devicesettings](https://github.com/LineageOS/android_packages_resources_devicesettings)，解压，重命名为 ```devicesettings``` 放到 ```packages/resources``` 目录。

4. 下载 vendor，[https://github.com/Tlntin/vendor_nubia_nx531j-lineage14.1](https://github.com/Tlntin/vendor_nubia_nx531j-lineage14.1)，解压重命名为 ```nx531j```，放到 ```vendor/nubia``` 目录下面。

5. 下载 kernel，[https://github.com/CyanogenMod/android_kernel_nubia_msm8996](https://github.com/CyanogenMod/android_kernel_nubia_msm8996)，解压重命名为msm8996,放到 ```kernel/nubia``` 目录下

6. [https://github.com/LineageOS/android_device_qcom_common](https://github.com/LineageOS/android_device_qcom_common) 解压重命名为 ```common```，放到 ```device/qcom```目录下。

7. [https://github.com/LineageOS/android_external_stlport](https://github.com/LineageOS/android_external_stlport)  解压，重命名为 ```stlport```，放到 ```external``` 目录下。

8. [https://github.com/Tlntin/vendor_nxp-nfc-lineage14.1](https://github.com/Tlntin/vendor_nxp-nfc-lineage14.1) 下载 nfc 驱动。

先安装这个,不然编译到一半会失败

```shell
# apt-get install rsync
```



 开始编译：
1. 设置编译环境
```shell
$ source build/envsetup.sh
```

2. 设置加快编译速度
```shell
$ export USE_CCACHE=1
 ```
 
3. 加入root
```shell
$ export WITH_SU=true
```

4. 设置缓存
```shell
$ ~/Slim/prebuilts/misc/linux-x86/ccache/ccache -M 80G
```
```shell
$ export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx16000m" （本人内存8g，所以这里允许内存填8192M）
```

5. 开安装 jack，

进 ```prebuilts/sdk/tools``` 目录打开终端
```shell
$ ./jack-admin install-server jack-launcher.jar jack-server-4.8.ALPHA.jar
```

6. 并且开启 jack 服务。

如何编译到一半失败，请关闭开启 jack 或者手动杀死 java 服务，不然的话 16G 内存也不够用。
```shell
$ ./prebuilts/sdk/tools/jack-admin kill-server
```
```shell
$ ./prebuilts/sdk/tools/jack-admin start-server
```

7. 编译开始
```shell
$ breakfast  nx531j
```
```shell
$ make -j8
```

注意：如何编译到一半失败,请关闭开启 jack 或者手动杀死 java 服务，不然的话 16G 内存也不够用.
```shell
$ ./prebuilts/sdk/tools/jack-admin kill-server
```
```shell
$ ./prebuilts/sdk/tools/jack-admin start-server
```

8. 打包
```shell
$ mka bacon
```


## Device picture

![Nubia Z11](http://static.nubia.cn/product/z11/images/gallery/7.jpg "Nubia Z11 Standard Edition")
