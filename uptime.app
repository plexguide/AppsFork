#!/bin/bash

#!/bin/bash

# ================================ DEFAULT VALUES ================================ #

default_variables() {
    port_number=45000
    time_zone=America/New_York
    appdata_path=/pg/appdata/uptimekuma
    version_tag=1
    expose=
    subdomain=uptime  # Subdomain to use for Traefik routing
    domain=9705.us  # Base domain for Traefik routing
}

# ================================ CONTAINER DEPLOYMENT ================================ #

deploy_container() {

create_docker_compose() {
    cat << EOF > /pg/ymals/${app_name}/docker-compose.yml
services:
  ${app_name}:
    image: louislam/uptime-kuma:${version_tag}
    container_name: ${app_name}
    ports:
      - "${expose}${port_number}:3001"
    volumes:
      - ${appdata_path}:/app/data
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.${app_name}.rule=Host(\`${subdomain}.${domain}\`)"
      - "traefik.http.routers.${app_name}.entrypoints=web"
      - "traefik.http.services.${app_name}.loadbalancer.server.port=3001"
    networks:
      - plexguide

networks:
  plexguide:
    external: true
EOF
}

}

# ================================ MENU GENERATION ================================ #
# NOTE: Generates Menus for the App. Requires 4 #'s' - See Wiki for Details


# ================================ EXTRA FUNCTIONS ================================ #
# NOTE: Extra Functions for Script Organization