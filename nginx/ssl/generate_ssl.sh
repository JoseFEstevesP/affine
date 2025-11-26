#!/bin/bash

# Solicitar la IP o nombre de dominio al usuario
read -p "Ingrese la IP o nombre de dominio para el certificado (por ejemplo, affine.example.com o 192.168.0.131): " server_name

# Validar que se haya ingresado un valor
if [[ -z "$server_name" ]]; then
    echo "Error: El nombre de servidor no puede estar vacío."
    exit 1
fi

# Solicitar el subjectAltName al usuario
read -p "Ingrese el valor para subjectAltName (deje en blanco para usar el mismo nombre): " san_value

# Si el usuario no proporciona un valor para subjectAltName, usar el mismo valor ingresado
if [[ -z "$san_value" ]]; then
    san_value="$server_name"
fi

# Construir el valor de -subj correctamente
subj="/CN=$server_name"

# Verificar si el directorio ssl existe, si no, crearlo
if [ ! -d "./nginx/ssl" ]; then
    mkdir -p "./nginx/ssl"
fi

# Generar el certificado autofirmado con los valores proporcionados
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ./nginx/ssl/nginx-selfsigned.key \
    -out ./nginx/ssl/nginx-selfsigned.crt \
    -subj "$subj" \
    -addext "subjectAltName=DNS:$san_value"

# Verificar si el comando se ejecutó correctamente
if [[ $? -eq 0 ]]; then
    echo "Certificado generado exitosamente."
    echo "Clave privada: ./nginx/ssl/nginx-selfsigned.key"
    echo "Certificado: ./nginx/ssl/nginx-selfsigned.crt"
else
    echo "Error al generar el certificado."
    exit 1
fi