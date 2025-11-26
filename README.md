# Affine with Nginx Reverse Proxy

This project sets up Affine (the open-source Notion alternative) with nginx as a reverse proxy for secure HTTPS access.

## Services

- **nginx**: Reverse proxy with SSL termination
- **affine-server**: Main Affine application server
- **postgres**: PostgreSQL database for data storage
- **redis**: Redis for caching and real-time sync
- **db-backup**: Automated backup service for PostgreSQL

## Prerequisites

- Docker
- Docker Compose

## Setup Instructions

1. **Configure environment variables**:
   ```bash
   cp .env.example .env
   # Edit .env with your specific configuration
   ```

2. **Generate SSL certificates**:
   ```bash
   cd nginx/ssl
   chmod +x generate_ssl.sh
   ./generate_ssl.sh
   ```
   
3. **Start the services**:
   ```bash
   docker-compose up -d
   ```

4. **Access Affine**:
   - The application will be available at `https://localhost` (or your configured server name)
   - First time access will allow you to create an admin account

## Configuration Details

- The nginx configuration provides SSL termination with HTTP to HTTPS redirect
- Affine server runs on an internal port, accessed through nginx
- PostgreSQL and Redis are configured with persistent volumes
- Automated database backups are configured to run at specified intervals

## Security Features

- SSL/TLS encryption
- Security headers (X-Content-Type-Options, X-Frame-Options, X-XSS-Protection)
- Increased file upload limits (100MB)
- WebSocket support for real-time collaboration

## Customization

- Update `SERVER_NAME` in `.env` to your domain
- Modify SSL certificate generation script for your specific domain/IP
- Adjust retention days and backup intervals in `.env`
- Modify nginx configuration in `nginx/nginx.conf` as needed

## Troubleshooting

- If you get errors about missing SSL certificates, run the generate_ssl.sh script first
- Check service logs with `docker-compose logs [service_name]`
- Ensure required ports (80, 443, 3010) are not in use by other applications