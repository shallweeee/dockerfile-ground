설치
```bash
sudo apt install docker.io docker-compose
sudo usermod -aG docker $USER
sudo shutdown -r 0
```

실행
```bash
docker-compose up -d  # 처음에
docker-compose stop   # 정지
docker-compose start  # 시작
```

접속
```bash
chrome http://localhost:8787/
```

참고:  
https://hub.docker.com/r/rocker/rstudio
https://docs.docker.com/compose/compose-file/compose-file-v3/
