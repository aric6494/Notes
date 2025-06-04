# Termux
## Termux 的图形化界面

推荐 GitHub 上的一个 Termux 图形化界面项目：

项目地址：https://github.com/LinuxDroidMaster/Termux-Desktops

该项目提供三种方式安装图形化界面：

1. Termux 本地环境
2. proot 环境
3. chroot 环境（需要 root）

本文仅介绍前两种方式，使用的软件为 **Termux: X11**。

#### 1. 本地环境安装图形化界面

```bash
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio  ## 在图形界面中播放音频
```

安装 XFCE（轻量级桌面环境）：

```bash
pkg install xfce4
```

- 安装 Firefox 浏览器：

  ```bash
  pkg install tur-repo
  pkg install firefox
  ```

- 安装 VS Code：

  ```bash
  pkg install tur-repo
  pkg install code-oss
  ```

下载桌面环境启动脚本：

```bash
cd ~
pkg install wget
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/startxfce4_termux.sh
```

启动桌面环境：

```bash
chmod +x startxfce4_termux.sh
./startxfce4_termux.sh
```

#### 2. proot 环境安装图形化界面

```bash
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
```

以 Debian 为例：

```bash
pkg install proot-distro
proot-distro install debian
proot-distro login debian
```

###### 2.1 配置 sudo

```bash
apt update && apt install -y sudo
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  ## 设置时区
```

创建普通用户 `droidmaster`：

```bash
useradd -m droidmaster
passwd droidmaster      ## 设置密码（输入不可见）
usermod -aG sudo droidmaster
```

编辑 sudoers：

```bash
apt install vim
vim /etc/sudoers  ## 在文件末尾添加:
## droidmaster 用户免密码执行所有命令
 droidmaster ALL=(ALL) NOPASSWD: ALL
```

切换到新用户：

```bash
su - droidmaster
```

安装 XFCE：

```bash
sudo apt install -y xfce4
```

退出 proot 环境并下载启动脚本：

```bash
exit
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startxfce4_debian.sh
chmod +x startxfce4_debian.sh
```

启动桌面环境：

```bash
./startxfce4_debian.sh
```

更多安装方式请移步 GitHub 仓库查看。

## Termux 主题美化

#### 更改字体

1. 前往 https://www.nerdfonts.com/font-downloads 下载字体（示例：`0xProtoNerdFont-Regular.ttf`）。

2. 创建字体文件夹：

   ```bash
   mkdir -p ~/.termux/fonts
   ```

3. 复制字体到文件夹并重命名：

   ```bash
   cp 0xProtoNerdFont-Regular.ttf ~/.termux/fonts/
   mv ~/.termux/fonts/0xProtoNerdFont-Regular.ttf ~/.termux/font.ttf
   ```

4. 重启 Termux，测试 Nerd 字体：

   ```bash
   echo -e "\ue0b0 \u26a1 \ue709"
   ```

#### 安装 Oh My Zsh

Oh My Zsh 是基于 Zsh 的配置框架，用于增强和扩展 Shell。

```bash
pkg install zsh
chsh -s zsh        ## 设置 zsh 为默认 Shell
```

复制 `.bashrc` 内容到 `.zshrc`，然后安装 Oh My Zsh：

```bash
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
## 国内用户可替换为:
sh -c "$(wget -O - https://install.ohmyz.sh)"
```

#### 配置 powerlevel10k 主题

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

编辑 `~/.zshrc`：

```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.zshrc
```

#### 安装插件

###### zsh-autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

在 `.zshrc` 中启用：

```bash
plugins=(
  git
  zsh-autosuggestions
)
```

###### zsh-syntax-highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

在 `.zshrc` 中启用：

```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source ~/.zshrc
```

## 常用包安装

#### Manim

Manim 是 Python 动画引擎，用于数学演示和可视化。

```bash
pkg install cmake
pkg install tur-repo
pkg install manim
```

如遇问题，可在 Ubuntu 环境中安装：

```bash
## 同时安装 Ubuntu
pkg update && pkg upgrade -y && pkg install wget proot git -y
cd ~ && git clone https://github.com/MFDGaming/ubuntu-in-termux && cd ubuntu-in-termux
chmod +x ubuntu.sh && ./ubuntu.sh -y && ./startubuntu.sh

## Ubuntu 内安装依赖
apt-get update && apt-get upgrade -y
apt-get install -y sudo build-essential python3-dev libcairo2-dev libpango1.0-dev ffmpeg texlive texlive-latex-extra python3-pip python3-venv pipx
pipx install manim

## 生成动画
manim --resolution 2560,1440 main.py
```

#### mpv

mpv 是命令行音乐播放器：

```bash
pkg install mpv pulseaudio ffmpeg
pulseaudio --start
mpv --ao=pulse your_audio_file.mp3
pkill mpv      ## 停止播放
```

#### cava（音频可视化）

```bash
pkg install cava
pulseaudio --start
mpv --ao=pulse your_audio_file.mp3 & cava
```

![cava 音频可视化](https://raw.githubusercontent.com/aric6494/images/main/img/1738379894565.jpg)

配置文件：`~/.config/cava/config`

#### yt-dlp

yt-dlp 是命令行下载 YouTube 视频工具。

```bash
pkg update && pkg upgrade -y
pkg install python ffmpeg
pip install yt-dlp
```

常用命令：

```bash
yt-dlp <URL>                         ## 下载视频
yt-dlp -x <URL>                      ## 下载音频
yt-dlp --skip-download --write-subs --write-auto-subs --sub-lang zh --sub-format srt -o "transcript.%(ext)s" '<URL>'
## 下载无时间码字幕并清洗
yt-dlp --skip-download --write-subs --write-auto-subs --sub-lang en --sub-format ttml -o "transcript.en.ttml" '<URL>' && sed -e 's/<[^>]*>//g' -e '/^[[:space:]]*$/d' transcript.en.ttml > output.txt
```

#### latex

latex 可与 manim 结合创造有意思的数学动画。

```shell
pkg update && pkg upgrade -y
pkg install texlive-installer -y 
termux-install-tl
```

到了上面的最后一步，termux 打开文字图形界面，然后你可以先输入 s，选择安装多大的包，这里推荐 basic，因为它包含了 latex。之后等待安装就行。不过如果想要运行 manim，还需要安装以下包：

```shell
tlmgr install standalone
tlmgr install preview
```

不过并不支持中文。如果想要删除 latex，按照以下步骤：

```
rm -rf /data/data/com.termux/files/usr/bin/texlive
rm -rf /data/data/com.termux/files/usr/share/texlive
pkg uninstall texlive-installer
```

