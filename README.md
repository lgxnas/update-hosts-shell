# manjaro 添加 windows共享打印机

办公室打印机 `HP LaserJet Professional P1106`安装在win7电脑上，还有一台电脑安装的是 Manjaro 系统。

samba连接总是失败，搜索到可以使用lpd://{ip}/{printername}的方法。

## 设置方法

1. windows电脑：
    
  - 主机名：`win-01702201552`
  - ~~共享打印机名称：`HP LaserJet Professional P1106`~~
  
  - <font color=red>已修改名称为：`P1106`</font>
  - ip：`192.168.200.13`
  - mac: `2c:56:dc:79:aa:02`
  - `控制面板 --> 程序和功能 --> 打开和关闭windows功能 -->打印 --> 启用lpd打印`

2. manjaro电脑上：

```shell
sudo pacman -S hplip-plugin
#hp-setup -i
#hp-plugin -i
打开cups web设置
http://localhost:631/
#添加-->LPD/LPR 主机或打印机-->lpd://192.168.200.13/HP%20LaserJet%20Professional%20P1106
添加-->LPD/LPR 主机或打印机-->lpd://192.168.200.13/P1106
就OJBK了
```

## 遇到问题：

1. 安装plugin失败，手动下载了两个文件

```
https://developers.hp.com/sites/default/files/hplip-3.19.11-plugin.run
https://developers.hp.com/sites/default/files/hplip-3.19.11-plugin.run.asc
# 镜象地址：
https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/
```

2. lpd://地址中ip位置填写成{win-01702201552}，安装完成后`打印机不在线`

   本来windows电脑为了同时访问内外网，已经设置好静态IP。网管来一次就搞成自动获取IP。

   为预防被修改后`打印机不在线` :

   - ~~使用了`lpd://win-01702201552/HP%20LaserJet%20Professional%20P1106`~~
   - 使用lpd://win-01702201552/P1106
- 修改hosts文件
   
   ```shell
   192.168.200.13 win-01702201552
```
   
   - 写此脚本加入crontab ，动态hosts

## 查询win-01702201552 ip

```shell
# 方法1：
nmblookup win-01702201552|cut -d' ' -f1
# 方法2：
cat /proc/net/arp |grep 2c:56:dc:79:aa:02|cut -d' ' -f1
```

```shell
cat /proc/net/arp
192.168.200.13   0x1         0x2         2c:56:dc:79:aa:02     *        enp2s0
# IP address: 192.168.200.13
# HW type: 0x1
# Flags-->0x2:在线
# HW address: 2c:56:dc:79:aa:02
# Mask: *
# Device: enp2s0
```

