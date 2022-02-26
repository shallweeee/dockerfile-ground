## 도커 이미지를 호스트 사용자 UID 로 실행
tomcat 도커 이미지는 root 권한으로 실행되어 로칼 디렉토리를  
볼륨으로 연결하면 root 권한의 디렉토리 및 파일이 생성된다.  
개인 환경에서는 root 권한 또는 sudo 를 이용하여 삭제할 수 있지만  
일반 계정에 도커 사용 권한만 받은 경우, 처리가 곤란해진다.  
(물론 꽁수를 동원하면 삭제할 수는 있다.)  

### 사용 방법
1. .env 파일에 정보 설정
```bash
cat << EOF > .env
COMPOSE_PROJECT_NAME=$USER
UID=$(id -u)
GID=$(id -g)
EOF
```
2. docker-compose 명령 사용
```bash
docker-compose up -d
...
docker-compose down
```

### 설명
1. gosu 를 사용하여 root 에서 일반 계정으로 전환하여 실행한다.
2. tomcat 이미지는 gosu 가 없어, 설치하여 새 이미지를 만든다.  
   원본과 구별하기 위해 namespace 를 바꿨다.  
   시스템 사용자로 tomcat 을 추가했다.
3. mysql 과 tomcat UID/GID 를 호스트 사용자의 것으로 바꾸기 위해  
   docker-compose.yml 에서 entrypoint 를 덮어쓴다.  
   이 방법으로 사용자마다 다른 이미지를 만들지 않아도 된다.
4. 로칼 디렉토리를 볼륨으로 연결할 때는 경로가 건너뛰지 않게 주의한다.  
   가령 web 서비스의 ./web_logs:/usr/local/tomcat/logs 를  
   ./web/logs:/usr/local/tomcat/logs 로 변경하고 실행하면  
   web 디렉토리는 root 권한으로 생성된다.  
   entrypoint 에서는 접근할 수 없는 영역이라 방법이 없고, 하려면  
   docker-compose up 전에 디렉토리를 만들어 두어야 한다.

### 참고
- [왜 도커에서 gosu 를 써야하지?](https://developpaper.com/why-should-you-use-gosu-in-docker/)
- [gosu github](https://github.com/tianon/gosu/)
- [non-root-tomcat](https://gitlab.com/krisz.kern/non-root-tomcat)  
  entrypoint 활용 힌트를 얻은 곳. 작은 수정이 필요했지만 잘 움직인다.
