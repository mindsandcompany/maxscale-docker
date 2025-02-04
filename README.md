# MariaDB MaxScale Container image for GenOS
Maxscale 컨테이너 이미지 빌드 및 실행 
## Prerequisites
- Docker
- 외부망 인터넷이 가능한 환경에서 빌드
- 버전은 24.02.4으로 고정

## Build & Push
```
# Build
make build

# Push
make push
```

## Save
maxscale_24.02.4.tar 파일 생성
```
make save
```
