#!/bin/bash

# CONFIGURACIÓN INICIAL DEL SISTEMA BASE UBUNTU MINIMIZED
# Ejecutar script luego de finalizar la instalación del sistema.

# Usuario a configurar, configurar usuario
USUARIO="user" # <------ reemplazar "user" con el usuario a utilizar

echo "[*] Paso 1: Actualizando el sistema..."
apt update && apt upgrade -y

echo "[*] Paso 2: Instalando herramientas básicas del sistema..."
apt install -y \
    sudo \
    vim \
    curl \
    wget \
    htop \
    net-tools \
    gnupg \
    ca-certificates \
    software-properties-common \
    lsb-release \
    unzip \
    bash-completion

echo "[*] Paso 3: Verificando permisos de sudo para el usuario '$USUARIO'..."
if id "$USUARIO" &>/dev/null; then
    if id -nG "$USUARIO" | grep -qw "sudo"; then
        echo "[+] El usuario '$USUARIO' ya tiene permisos sudo."
    else
        echo "[+] Agregando '$USUARIO' al grupo sudo..."
        usermod -aG sudo "$USUARIO"
    fi
else
    echo "[!] El usuario '$USUARIO' no existe. Abortando."
    exit 1
fi

echo "[*] Paso 4: Habilitando el comando sudo sin tener que escribir la contraseña (opcional)..."
# Descomentar esta línea para NOPASSWD:
# echo "$USUARIO ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USUARIO && chmod 440 /etc/sudoers.d/$USUARIO

echo "[*] Paso 5: Configurando hostname (si querés cambiarlo)..."
# hostnamectl set-hostname tu-hostname-aqui

echo "[*] Paso 6: Configurando zona horaria (opcional)..."
# timedatectl set-timezone America/Argentina/Buenos_Aires

echo "[*] Paso 7: Activando bash completion si está disponible..."
echo "if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi" >> /home/$USUARIO/.bashrc

echo "[✔] Configuración básica completada. Reiniciar o cerrar sesión para aplicar cambios."
