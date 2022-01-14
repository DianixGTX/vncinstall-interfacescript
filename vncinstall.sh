# Instalación limpia de tightvncserver

sudo su
sudo apt-get remove -y tightvncserver
sudo apt-get install -y tightvncserver
mkdir -p "$HOME/.vnc"
vncpasswd -f <<< $PASSWORD > "$HOME/.vnc/passwd"

# Comprobación y ejecución de tightvncserver

sudo tee /etc/init.d/tightvnc > /dev/null <<EOF
#!/bin/sh
### BEGIN INIT INFO
# Provides: tightvncserver
# Required-Start:
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start vnc server
# Description:
### END INIT INFO

. /lib/lsb/init-functions

USER=$USER
HOME=$HOME
export USER HOME

# Solucionador de posibles errores
case "\$1" in
  start)
    su - \${USER} -c "/usr/bin/vncserver :1 -geometry 1280x800 -depth 16 -pixelformat rgb565"
    echo "Starting VNC server"
    ;;
  stop)
    su - \${USER} -c "/usr/bin/vncserver -kill :1"
    echo "VNC Server has been stopped"
    ;;
  *)
    echo "Usage: /etc/init.d/tightvnc {start|stop}"
    exit 1
    ;;
esac
EOF

# Permisos y instalación de interfaz grafica de ubuntu 16.04 / 18.04 18.04 / 20.04

sudo chmod 0755 /etc/init.d/tightvnc
sudo update-rc.d tightvnc defaults
sudo service tightvnc stop
sudo service tightvnc start
sudo apt update
sudo apt upgrade
sudo apt install ubuntu-desktop -y
reboot