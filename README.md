# Affine con Proxy Inverso de Nginx

Este proyecto configura Affine (la alternativa de código abierto a Notion) con nginx como proxy inverso para acceso seguro HTTPS.

## Servicios

- **nginx**: Proxy inverso con terminación SSL
- **affine-server**: Servidor principal de la aplicación Affine
- **postgres**: Base de datos PostgreSQL para almacenamiento de datos
- **redis**: Redis para caché y sincronización en tiempo real
- **db-backup**: Servicio de copias de seguridad automatizadas para PostgreSQL

## Requisitos Previos

- Docker
- Docker Compose

## Instrucciones de Configuración

1. **Configurar variables de entorno**:

   ```bash
   cp .env.example .env
   # Edita .env con tu configuración específica
   ```

2. **Generar certificados SSL**:
   ```bash
   cd nginx/ssl
   chmod +x generate_ssl.sh
   ./generate_ssl.sh
   ```
3. **Iniciar los servicios**:

   ```bash
   docker-compose up -d
   ```

4. **Acceder a Affine**:
   - La aplicación estará disponible en `https://localhost` (o el nombre de servidor que configuraste)
   - El primer acceso te permitirá crear una cuenta de administrador

## Detalles de Configuración

- La configuración de nginx proporciona terminación SSL con redirección de HTTP a HTTPS
- El servidor de Affine funciona en un puerto interno, accedido a través de nginx
- PostgreSQL y Redis están configurados con volúmenes persistentes
- Las copias de seguridad automatizadas de la base de datos están configuradas para ejecutarse en intervalos específicos

## Características de Seguridad

- Cifrado SSL/TLS
- Cabeceras de seguridad (X-Content-Type-Options, X-Frame-Options, X-XSS-Protection)
- Límites aumentados de subida de archivos (100MB)
- Soporte para WebSocket para colaboración en tiempo real

## Personalización

- Actualiza `SERVER_NAME` en `.env` con tu dominio
- Modifica el script de generación de certificados SSL para tu dominio/IP específico
- Ajusta los días de retención e intervalos de copia de seguridad en `.env`
- Modifica la configuración de nginx en `nginx/nginx.conf` según sea necesario

## Resolución de Problemas

- Si recibes errores sobre certificados SSL faltantes, ejecuta primero el script generate_ssl.sh
- Revisa los logs de los servicios con `docker-compose logs [nombre_servicio]`
- Asegúrate de que los puertos requeridos (80, 443, 3010) no estén siendo usados por otras aplicaciones
