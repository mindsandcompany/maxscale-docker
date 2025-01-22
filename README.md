# MariaDB MaxScale Container image for GenOS
Maxscale 컨테이너 이미지 빌드 및 실행 
## Prerequisites
- Docker
- 외부망 인터넷이 가능한 환경에서 빌드
- 버전은 24.02.4으로 고정

## Build & Push
이미지 버전이나 이름 변경은 Makefile에서 수정
```
# Build
make build-image

# Push
make push-image
```

## Save
maxscale.tar 파일 생성
```
make save-image
```
