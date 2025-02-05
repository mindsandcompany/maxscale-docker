# MariaDB MaxScale Container image for GenOS
Maxscale 컨테이너 이미지 빌드 및 실행 
## Prerequisites
- Docker
- 외부망 인터넷이 가능한 환경에서 빌드
- 버전은 24.02.4으로 고정

## Build & Push
- 기본적으로 non-root 이미지를 빌드하며, 기본 계정은 `UID`, `GID`, `UNAME`, `GNAME` 옵션으로 변경가능 
- root 이미지는 `SECURITY=false` 옵션 사용
```
# Build
make build

# Push
make push
```

## Save
mariadb-maxscale_24.02.4.tar 파일 생성
```
make save
```
