![Total Visitors](https://komarev.com/ghpvc/?username=aron-666-l1&color=green)
# Titan L1 服務管理腳本

一鍵部署和管理 Titan L1 挖礦服務的自動化腳本，支援 Docker 容器化部署，提供完整的服務生命週期管理。

---

## 系統需求

- **作業系統**: Linux (Ubuntu、Debian、CentOS、RHEL、Fedora 等)
- **權限要求**: root 權限
- **網路連接**: 穩定的網路連接
- **硬體需求**: 
  - 最低 16GB RAM
  - 最低 4TB 可用磁碟空間
  - CPU: 至少 8 核心 (若是虛擬核心需16核以上)
- **軟體依賴**: 
  - Docker 和 Docker Compose (腳本可自動安裝)
  - Git (用於下載腳本)

---

## 所有指令一覽

```bash
./l1.sh [指令] [選項]
```

### 基本指令

- `start`: 啟動 Titan L1 服務
- `stop`: 停止 Titan L1 服務
- `update`: 更新 Titan L1 服務到最新版本
- `config`: 配置 Titan L1 服務
- `logs`: 查看 Docker 容器日誌

### 全局選項

- `-i, --install [cn]`: 自動安裝 Docker 環境
  - 不帶參數: 使用國際源
  - 帶 `cn` 參數: 使用中國源
- `-l, --l1-code CODE`: 指定 L1 代碼
- `-e, --edge-id ID`: 指定 Edge 身份碼
- `-d, --data-dir PATH`: 指定數據目錄
- `-k, --k3s-data-dir PATH`: 指定 K3S 數據目錄

---

## 快速開始

### 基本安裝與啟動

#### 中國區域安裝

```bash
# 1. 下載腳本並設置權限
git clone https://github.com/aron-666/Titan-L1-Docker.git titan-l1
cd titan-l1
chmod +x l1.sh

# 2. 啟動服務 (會進入互動式配置)
sudo ./l1.sh start
```

#### 其他區域安裝

```bash
# 1. 下載腳本並設置權限
git clone https://github.com/aron-666/Titan-L1-Docker.git titan-l1
cd titan-l1
chmod +x l1.sh

# 2. 啟動服務 (會進入互動式配置)
sudo ./l1.sh start
```

### 快速部署 (一鍵啟動)

#### 中國區域部署

```bash
# 下載並快速啟動
git clone https://github.com/aron-666/Titan-L1-Docker.git titan-l1
cd titan-l1
chmod +x l1.sh

# 中國區域快速啟動
sudo ./l1.sh start -l 你的L1代碼 -e 你的身份碼 -i cn
```

#### 其他區域部署

```bash
# 下載並快速啟動
git clone https://github.com/aron-666/Titan-L1-Docker.git titan-l1
cd titan-l1
chmod +x l1.sh

# 其他區域快速啟動
sudo ./l1.sh start -l 你的L1代碼 -e 你的身份碼 -i
```

> **注意**: 
> - `-i cn` 參數用於在中國區域安裝 Docker 時使用中國鏡像源
> - L1代碼和身份碼需要從 Titan 官方獲取

---

## 指令詳解

### 啟動 Titan L1 服務

```bash
sudo ./l1.sh start [選項]
```

**選項**:
- `-l, --l1-code CODE`: 指定 L1 代碼
- `-e, --edge-id ID`: 指定 Edge 身份碼
- `-d, --data-dir PATH`: 指定數據目錄 (預設: ./data)
- `-k, --k3s-data-dir PATH`: 指定 K3S 數據目錄 (預設: ./data/k3s)
- `-i, --install [cn]`: 自動安裝 Docker

**示例**:
```bash
# 中國區域
sudo ./l1.sh start -l your_l1_code -e your_edge_id -i cn

# 其他區域
sudo ./l1.sh start -l your_l1_code -e your_edge_id -i

# 自定義數據目錄
sudo ./l1.sh start -l your_l1_code -e your_edge_id -d /opt/titan-data
```

### 配置 Titan L1 服務

```bash
sudo ./l1.sh config [選項]
```

**選項**:
- `-l, --l1-code CODE`: 設置 L1 代碼
- `-e, --edge-id ID`: 設置 Edge 身份碼
- `-d, --data-dir PATH`: 設置數據目錄
- `-k, --k3s-data-dir PATH`: 設置 K3S 數據目錄

**示例**:
```bash
# 互動式配置
sudo ./l1.sh config

# 非互動式配置
sudo ./l1.sh config -l your_l1_code -e your_edge_id
```

### 停止 Titan L1 服務

```bash
sudo ./l1.sh stop
```

### 更新 Titan L1 服務

```bash
sudo ./l1.sh update
```

此命令會：
1. 停止當前服務
2. 拉取最新的 Docker 映像
3. 重新啟動服務

### 查看 Docker 容器日誌

```bash
sudo ./l1.sh logs
```

此命令會顯示 Titan L1 容器的最新 100 條日誌記錄，並實時更新。可通過 Ctrl+C 退出。

### 互動式選單

不帶參數執行腳本將顯示互動式選單：

```bash
sudo ./l1.sh
```

選單選項：
1. 啟動 Titan L1 服務
2. 停止 Titan L1 服務
3. 更新 Titan L1 服務
4. 配置 Titan L1 服務
5. 查看 Docker 日誌
0. 退出

---

## 配置文件

### .env 檔案

腳本會在根目錄生成 `.env` 配置文件，包含以下設置：

```env
TITAN_NETWORK_LOCATORURL="https://cassini-locator.titannet.io:5000/rpc/v0"
TITAN_EDGE_BINDING_URL="https://api-test1.container1.titannet.io/api/v2/device/binding"
TITAN_L1_CODE="你的L1代碼"
TITAN_EDGE_ID="你的身份碼"
DATA_DIR="./data"
K3S_DATA_DIR="./data/k3s"
```

### docker-compose.yml

服務使用 Docker Compose 進行容器編排，包含：
- **k3s-server-1**: Kubernetes 叢集服務
- **aron-titan-l1**: Titan L1 主服務

### 數據目錄結構

```
./data/
├── k3s/                 # K3S 相關數據
│   ├── server/          # K3S 服務器數據
│   ├── output/          # kubeconfig 輸出
│   ├── etc/             # 配置文件
│   ├── secrets/         # 密鑰文件
│   └── storage/         # 存儲數據
└── (其他 Titan 數據)
```

---

## 疑難排解

### Docker 相關問題

**問題**: Docker 安裝失敗
```bash
# 解決方案: 使用 -i 參數重新安裝
sudo ./l1.sh start -i

# 中國大陸地區使用中國鏡像源
sudo ./l1.sh start -i cn
```

**問題**: Docker Compose 無法使用
```bash
# 檢查 Docker 版本
docker --version

# 檢查 Docker Compose
docker compose version

# 如果版本過舊，重新安裝 Docker
sudo ./l1.sh start -i
```

### 服務啟動問題

**問題**: 服務無法啟動
```bash
# 1. 檢查配置文件
cat .env

# 2. 查看 Docker 日誌
sudo ./l1.sh logs

# 3. 檢查容器狀態
docker compose ps

# 4. 重新配置服務
sudo ./l1.sh config
```

**問題**: 端口衝突
```bash
# 檢查端口佔用
netstat -tlnp | grep -E '(80|443|2345|6443|9000)'

# 停止衝突的服務或修改 docker-compose.yml 中的端口映射
```

### 網路連接問題

**問題**: 無法連接到 Titan 網路
```bash
# 1. 檢查網路連接
ping cassini-locator.titannet.io

# 2. 檢查防火牆設置
sudo ufw status
sudo firewall-cmd --list-all

# 3. 檢查 L1 代碼和身份碼是否正確
sudo ./l1.sh config
```

### 日誌查看問題

**問題**: 看不到日誌
```bash
# 1. 確認服務是否已啟動
docker compose ps

# 2. 檢查容器日誌
docker logs aron-titan-l1

# 3. 如果是新安裝，等待幾分鐘讓服務完全啟動
```

**問題**: 日誌顯示錯誤
```bash
# 常見錯誤及解決方案:

# 錯誤: "Invalid L1 code"
# 解決: 重新配置正確的 L1 代碼
sudo ./l1.sh config -l 正確的L1代碼

# 錯誤: "Network connection failed"
# 解決: 檢查網路連接和防火牆設置

# 錯誤: "Permission denied"
# 解決: 確保使用 root 權限運行腳本
sudo ./l1.sh start
```

### 配置問題

**問題**: 配置文件損壞或丟失
```bash
# 重新生成配置文件
sudo ./l1.sh config

# 手動檢查配置文件
cat .env
cat docker-compose.yml
```

**問題**: 數據目錄權限問題
```bash
# 修復數據目錄權限
sudo chown -R root:root ./data
sudo chmod -R 755 ./data
```

### 更新問題

**問題**: 更新失敗
```bash
# 1. 手動停止服務
sudo ./l1.sh stop

# 2. 清理舊映像
docker system prune -f

# 3. 重新啟動
sudo ./l1.sh start
```

---

## 進階使用

### 自動重啟設置

服務已配置為自動重啟，但如果需要系統級別的自動啟動：

```bash
# 創建 systemd 服務文件
sudo cat > /etc/systemd/system/titan-l1.service << EOF
[Unit]
Description=Titan L1 Service
After=docker.service
Requires=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=$(pwd)
ExecStart=$(pwd)/l1.sh start
ExecStop=$(pwd)/l1.sh stop
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

# 啟用服務
sudo systemctl enable titan-l1.service
sudo systemctl start titan-l1.service
```

### 監控和維護

```bash
# 查看資源使用情況
docker stats

# 檢查磁碟使用
du -sh ./data

# 備份配置文件
cp .env .env.backup
cp docker-compose.yml docker-compose.yml.backup

# 清理 Docker 系統
docker system prune -f
```

---

## 注意事項

- ⚠️ **此腳本需要 root 權限才能執行**
- ⚠️ **請確保 L1 代碼和身份碼的正確性**
- ⚠️ **定期備份數據目錄以防資料丟失**
- ⚠️ **確保防火牆允許所需端口的連接**
- ⚠️ **建議在穩定的網路環境下運行**

---

## 支援與回饋

如果您在使用過程中遇到問題，請：

1. 首先查看本文檔的疑難排解部分
2. 檢查 GitHub Issues 中是否有類似問題
3. 提供詳細的錯誤信息和系統環境信息

---

## 更新日誌

- **v1.0.0**: 初始版本發布，支援基本的 L1 服務管理功能

---

<div align="center">

**感謝使用 Titan L1 服務管理腳本！**

</div>

