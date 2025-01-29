# mdns-repeater-docker

`mdns-repeater-docker` is a Dockerized service that is designed to repeat mDNS packets across networks. It allows for seamless discovery of mDNS services in docker environments which typically do not support broadcasting across different subnets. This is particularly useful in scenarios where you have services running on separate docker networks and want them to be discoverable via mDNS.

## Key Features

- **Dockerized Service**: Easily deployable in any environment that supports Docker.
- **Network Discovery**: Facilitates service discovery by repeatreing mDNS across docker networks.
- **Automatic Restart**: Configured to restart automatically if issues arise.

## Getting Started

To deploy the `mdns-repeater-docker`, you can use the provided `docker-compose.yaml` file. Below are the instructions to set up the environment.

### Prerequisites

- Docker and Docker Compose installed on your system.

### Deployment

1. **Clone the Repository**: Begin by cloning the repository to your local environment.
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Create the Docker Compose File**: Create or modify the `docker-compose.yaml` file as follows:

   ```yaml
   services:
     mdns:
       image: mdns:latest
       network_mode: host
       restart: always
       environment:
         - IFDEV=eth0 br-a43b21f4351d br-2a3b4c5d6e7f
   ```

3. **Start the Service**:  Run the following command to start the service.
   ```bash
   docker-compose up -d
   ```

## License

This software is distributed under the terms of the GNU General Public License v3.0 (or any later version). It is free software, and copying, modification, and distribution are permitted. It comes without any warranty.

