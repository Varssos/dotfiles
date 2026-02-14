# Docker test readme

!!! TO refactor !!!

Proste Ubuntu do testów Ansible z SSH i Python/Ansible zainstalowanymi.

## Setup i uruchomienie

### 1. Clean old container (jeśli istnieje)
```bash
docker rm -f ubuntu2404
```

### 2. Build image
```bash
cd test_docker
docker build -t ubuntu2404-test .
```

### 3. Run container
```bash
docker run -d \
  --name ubuntu2404 \
  -p 2222:22 \
  ubuntu2404-test
```

### 4. Verify it's running
```bash
docker ps
docker logs ubuntu2404
```

## Połączenie do kontenera

### SSH
```bash
ssh -o StrictHostKeyChecking=no sw@localhost -p 2222
# hasło: sw
```

### Exec (szybki dostęp bez SSH)
```bash
docker exec -it ubuntu2404 bash
# lub konkretny user
docker exec -it -u sw ubuntu2404 bash
```

## Testing Ansible

### Opcja 1: Z hosta (via SSH)
```bash
cd /home/sw/dotfiles
ansible-playbook ansible/playbook.yml -i ansible/inventory/hosts.ini \
  -e "ansible_host=localhost ansible_port=2222 ansible_user=sw ansible_password=sw"
```

### Opcja 2: W kontenerze (localnie)
```bash
docker exec -it -u sw ubuntu2404 bash

# W kontenerze:
cd /home/sw/dotfiles
pip install ansible
./run_ansible.sh
```

### Opcja 3: Copy dotfiles do kontenera
```bash
docker cp /home/sw/dotfiles ubuntu2404:/home/sw/
docker exec -it -u sw ubuntu2404 bash

# W kontenerze:
cd dotfiles
pip install ansible
./run_ansible.sh
```

## Cleanup

### Zatrzymaj kontener
```bash
docker stop ubuntu2404
```

### Usuń kontener i image
```bash
docker rm ubuntu2404
docker rmi ubuntu2404-test
```

## Notes

- User: `sw`, Password: `sw`
- Ansible jest pre-installed w image
- SSH na porcie 2222 (TCP forward)
- `sudo` bez hasła dla user `sw`



## SSH to docker
ssh sw@localhost -p 2222