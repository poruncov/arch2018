#!/bin/bash
rm -rf ~/.config/xfce4/*
mkdir ~/Downloads
cd ~/Downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
sudo pacman -S wget --noconfirm
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Установка программ'
sudo pacman -S firefox ufw qt4 f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils file-roller p7zip unrar gvfs aspell-ru pulseaudio --noconfirm

echo 'Установить рекомендумые программы?'
read -p "1 - Да, 0 - Нет: " prog_set
if [[ $prog_set == 1 ]]; then
  sudo pacman -S obs-studio veracrypt freemind filezilla cherrytree gimp libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch vlc qbittorrent gnome-calculator --noconfirm
  yay -S dropbox timeshift flameshot-git xflux sublime-text-dev hunspell-ru pamac-aur --noconfirm 
elif [[ $prog_set == 0 ]]; then
  echo 'Установка программ пропущена.'
fi

echo 'Скачать и установить конфиг и темы для XFCE?'
read -p "1 - Да, 0 - Нет: " xfce_set
if [[ $xfce_set == 1 ]]; then
  echo 'Качаем и устанавливаем настройки Xfce'
  # Чтобы сделать копию ваших настоек XFCE перейдите в домашнюю директорию ~/username открйте в этой категории терминал и выполните команду ниже.
  # tar -czf xfce4.tar.gz .config/xfce4
  # Выгрузите архив в интернет и скорректируйте ссылку на XFCE файл заменив ссылку на свою.
  wget git.io/xfce4.tar.gz
  sudo rm -rf ~/.config/xfce4/panel/
  sudo rm -rf ~/.config/xfce4/*
  sudo tar -xzf xfce4.tar.gz -C ~/
 
  echo 'Установка тем'
  yay -S osx-arc-shadow papirus-maia-icon-theme-git breeze-default-cursor-theme --noconfirm
  sudo pacman -S capitaine-cursors
  
  echo 'Ставим лого ArchLinux в меню'
  wget git.io/arch_logo.png
  sudo mv -f ~/Downloads/arch_logo.png /usr/share/pixmaps/arch_logo.png

  echo 'Ставим обои на рабочий стол'
  wget git.io/bg.jpg
  sudo rm -rf /usr/share/backgrounds/xfce/* #Удаляем стандартрые обои
  sudo mv -f ~/Downloads/bg.jpg /usr/share/backgrounds/xfce/bg.jpg
elif [[ $xfce_set == 0 ]]; then
  echo 'Скачивание и установка конфига XFCE пропущена.'
fi

echo 'Убираем меню граб для выбора системы?'
read -p "1 - Да, 0 - Нет: " grub_set
if [[ $grub_set == 1 ]]; then
  wget git.io/grub.tar.gz
  sudo tar -xzf grub.tar.gz -C /
  sudo grub-mkconfig -o /boot/grub/grub.cfg
elif [[ $grub_set == 0 ]]; then
  echo 'Пропускаем.'
fi

#echo 'Установить conky?'
#read -p "1 - Да, 0 - Нет: " conky_set
#if [[ $conky_set == 1 ]]; then
#  sudo pacman -S conky conky-manager --noconfirm
#  wget git.io/conky.tar.gz
#  tar -xzf conky.tar.gz -C $HOME/
#elif [[ $conky_set == 0 ]]; then
#  echo 'Установка conky пропущена.'
#fi
echo 'Установить conky?'
read -p "1 - для XFCE, 2 - для KDE, 0 - Нет: " conky_set
if [[ $conky_set == 1 ]]; then
  sudo pacman -S conky conky-manager --noconfirm
  wget git.io/conky.tar.gz
  tar -xzf conky.tar.gz -C $HOME/
elif [[ $conky_set == 2 ]]; then
  sudo pacman -S conky conky-manager --noconfirm
  wget git.io/conky-kde.tar.gz
  tar -xzf conky-kde.tar.gz -C $HOME/
elif [[ $conky_set == 0 ]]; then
  echo 'Установка conky пропущена.'
fi
echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/Downloads
sudo rm -rf ~/arch3.sh

echo 'Установка завершена!'
