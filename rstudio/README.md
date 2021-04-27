설치
```bash
sudo apt install docker.io docker-compose
sudo usermod -aG docker $USER
sudo shutdown -r 0
```

실행
```bash
docker-compose up -d
```

참고:  
https://hub.docker.com/r/rocker/rstudio
