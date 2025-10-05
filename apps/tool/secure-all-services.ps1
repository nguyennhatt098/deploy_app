# Script PowerShell để apply tất cả cấu hình bảo mật IP whitelist

Write-Host "🔒 Đang áp dụng bảo mật IP whitelist cho tất cả services..." -ForegroundColor Green

Write-Host "`n1. Cập nhật Tool service (chặn NodePort 30050)..." -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\tool\tool-30050-whitelist.yaml"

Write-Host "`n2. Cập nhật Kibana service + Ingress (chặn NodePort 30601)..." -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\kibana\kibana-deployment.yaml"
kubectl apply -f "g:\deploy_app\apps\kibana\kibana-ingress.yaml"

Write-Host "`n3. Cập nhật Redis service (chặn NodePort 30679)..." -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\redis\redis-deployment.yaml"

Write-Host "`n🔍 Kiểm tra trạng thái services..." -ForegroundColor Cyan
Write-Host "Tool service:" -ForegroundColor White
kubectl get svc tool-service -n web-stock-future

Write-Host "`nKibana service:" -ForegroundColor White
kubectl get svc kibana-service -n kibana

Write-Host "`nRedis service:" -ForegroundColor White
kubectl get svc redis-service -n redis

Write-Host "`n🌐 Kiểm tra Ingress..." -ForegroundColor Cyan
kubectl get ingress -A

Write-Host "`n📊 Kiểm tra middlewares..." -ForegroundColor Cyan
kubectl get middleware -A

Write-Host "`n✅ HOÀN THÀNH! Tất cả NodePort đã được chặn." -ForegroundColor Green
Write-Host "Giờ chỉ có thể truy cập qua:" -ForegroundColor White
Write-Host "  - Tool: https://tool.nefyo.com (có IP whitelist)" -ForegroundColor Cyan
Write-Host "  - Kibana: https://kibana.nefyo.com (có IP whitelist)" -ForegroundColor Cyan
Write-Host "  - Redis: Chỉ internal cluster access" -ForegroundColor Cyan

Write-Host "`n🧪 Test truy cập (chỉ từ IP được phép):" -ForegroundColor Yellow
Write-Host "Invoke-WebRequest https://tool.nefyo.com -UseBasicParsing" -ForegroundColor Gray
Write-Host "Invoke-WebRequest https://kibana.nefyo.com -UseBasicParsing" -ForegroundColor Gray