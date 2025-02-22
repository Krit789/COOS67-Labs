# Computer Organization and Operating System Lab #12

# Section 0: Introduction

## What is Docker
![docker.png](./image/docker.png)


## What is Docker-Compose
![docker-compose.png](./image/docker-compose.png)

Docker Compose เป็นเครื่องมือที่ช่วยให้เราสามารถจัดการและรันแอปพลิเคชันที่ประกอบด้วยหลายๆ คอนเทนเนอร์ได้ง่ายขึ้น โดยเราสามารถกำหนดการตั้งค่าต่างๆ ของคอนเทนเนอร์ในไฟล์เดียวที่เรียกว่า ```docker-compose.yaml```

## What is .YAML



### version (Optional)
```yaml
version: '3'
```
ระบุเวอร์ชันของ Docker Compose ที่เราใช้

### service (Require)

```yaml
services:
  foo:
    image: busybox
    environment:
      - COMPOSE_PROJECT_NAME
    command: echo "I'm running ${COMPOSE_PROJECT_NAME}"
```

 service คือการกำหนดค่าตัวเลือกของคอนเทนเนอร์ที่สร้างขึ้นด้วย Docker Compose  service แต่ละตัวที่ระบุในส่วนนี้จะถูกสร้างเป็นคอนเทนเนอร์ และจะถูกจัดการโดย Docker Compose ในฐานะโปรเจกต์เดียว ชื่อของ service จะถูกกำหนดเป็นรายการย่อยภายใต้หัวข้อ `services` และตัวเลือกของคอนเทนเนอร์จะถูกกำหนดเป็นรายการย่อยภายใต้ชื่อบริการนั้นๆ

# Section 1: Preparation

## Install Docker Desktop
- [Docker Desktop for Window-x86_64](https://docs.docker.com/desktop/setup/install/windows-install/)
- [Docker Desktop for MacOS](https://docs.docker.com/desktop/setup/install/mac-install/)
- [Docker Desktop for Linux](https://docs.docker.com/desktop/setup/install/linux/)

## Install Node.js
- [Node.js](https://nodejs.org/en/download)

## Set Up 

### Docker Desktop
1.  Run Docker Desktop Installer.exe

### Node.js
![](./image/nodejs-install-1.png/)

![](./image/nodejs-install-2.png/)

![](./image/nodejs-install-3.png/)

![](./image/nodejs-install-4.png/)

![](./image/nodejs-install-5.png/)

![](./image/nodejs-install-6.png/)

![](./image/nodejs-install-7.png/)


#### Check Node.js Version
```bash
  node -v
```
![](./image/node-v.png/)

#### Check NPM Version
```bash
  npm -v
```
![](./image/npm-v.png/)

## Section 2: Docker Basics

### 1. Create package.json

![](./image/create-package-json.png)

### 2. Install Express.js
```bash
  npm i express@latest
```

### 3. Create index.js
```javascript
  const express = require('express');
  const app = express();
  const port = 3000;

  app.get('/', (req, res) => {
    res.send('Hello World!');
  });

  app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
  });
```
### 4. Run Node.js Application
```bash
  node index.js
```
![](./image/run-node-js.png/)

![](./image/hello-world.png/)

### Add script to package.json

![](./image/add-script.png/)

### Run Node.js Application with NPM
```bash
  npm run start
```
![img.png](./image/npm-run-start.png)

### 5. Create Dockerfile
![](./image/create-dockerfile.png/)

### 6. Create .dockerignore

![](./image/create-dockerignore.png/)

### 7. Build Docker Image

![](./image/build-docker-image.png/)

![](./image/build-docker-image2.png/)

เช็คว่า Image ถูกสร้างขึ้นมาหรือยัง
![](./image/docker-image.png/)

#### or

![](./image/docker-image2.png/)

### 8. Run Docker Container
![](./image/run-test.png/)

![](./image/error.png/)


### 9. Expose Port

![](./image/expose-port.png/)

![](./image/hello-world.png/)

### 10. แสดง Container ที่กำลังทำงานอยู่

![](./image/docker-ps-a.png/)

### 10. เปลี่ยน index.js and Rebuild Docker Image

![](./image/rebuild-image.png/)

### 11. Stop Container

![](./image/stop-container.png/)

### 12. Remove Container

![](./image/remove-container.png/)

### 13. Run Docker Container with New Image

![](./image/run-new-image.png/)
![](./image/chill-guy.png/)

### 14. Mount Volume
```docker
docker run -v $(pwd):/app -v $(pwd):/app/node_modules
```

#### $(pwd) คือคำสั่งที่ใช้ในการแสดงตำแหน่งปัจจุบันของไฟล์ หรือ Working Directory ของเรา
#### :/app คือตำแหน่งที่เราต้องการ mount ไปที่ Container

![](./image/mount-volume.png/)
#### Command Prompt อาจจะไม่ไม่ได้ 

### 15. คำสั่งที่ใช้ในการเข้าไปทำงานใน Container
![](./image/enter-container.png/)

### 16. แก้ insatll nodemon and add script to package.json
![](./image/install-nodemon.png/)

### 17. สร้าง Dockerfile.dev
![](./image/create-dockerfile-dev.png/)

### 18. Build Docker Image with Dockerfile.dev
![](./image/build-dockerfile-dev.png)

### 19. Stop All Container And Delete All Container
![](./image/stop-all-container.png/)

### 20. Run Docker Container with myapp:v3
![](./image/run-myapp-v3.png/)

![](./image/chill-guy-!!!!!!.png/)
