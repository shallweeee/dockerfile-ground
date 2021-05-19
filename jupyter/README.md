# 사용법
```bash
# 컨테이너 생성 및 시작
docker-compose up -d

# 컨테이너 중지 및 삭제
docker-compose down

# 컨테이너 시작
docker-compose start

# 컨테이너 중지
docker-compose stop

# jupyter lab 접속 URL 확인
docker-compose logs

# 파이썬 패키지 추가
# requirements.txt 에 패키지 추가
host$ cp requirements home/
# jupyter lab 의 Terminal 에서 다음 실행
jupyter lab$ pip install -r requirements.txt

# (패키지 설치등) root 로 컨테이너에 접속
docker-compose exec -u root jupyter bash
```
