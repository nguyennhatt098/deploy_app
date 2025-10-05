# Script đơn giản - chỉ cần chạy 1 file

Write-Host "🔒 Setup IP whitelist port 30050 - TẤT CẢ TRONG 1 FILE" -ForegroundColor Green

Write-Host "`n📝 Apply tất cả cấu hình từ 1 file..." -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\tool\tool-30050-whitelist.yaml"

Write-Host "`n🔄 Restart Traefik để load cấu hình mới..." -ForegroundColor Yellow
kubectl rollout restart deployment/traefik -n kube-system

Write-Host "`n⏱️  Đợi 30 giây để services khởi động..." -ForegroundColor Cyan
Start-Sleep -Seconds 30

Write-Host "`n🔍 Kiểm tra trạng thái..." -ForegroundColor Cyan
kubectl get svc tool-service-nodeport-30050 -n web-stock-future
kubectl get ingressroute nodeport-30050-whitelist -n web-stock-future
kubectl get middleware tool-whitelist-30050 -n web-stock-future

Write-Host "`n✅ HOÀN THÀNH!" -ForegroundColor Green
Write-Host "Port 30050 đã được bảo vệ bằng IP whitelist" -ForegroundColor White
Write-Host "Chỉ IP 14.191.166.230 và các IP nội bộ mới truy cập được" -ForegroundColor Cyan

Write-Host "`n🧪 Test ngay:" -ForegroundColor Yellow
Write-Host "Invoke-WebRequest http://157.10.199.177:30050/ -UseBasicParsing" -ForegroundColor Gray