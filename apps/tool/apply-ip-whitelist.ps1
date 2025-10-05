# Script để apply IP whitelist cho truy cập trực tiếp qua IP

Write-Host "🔒 Đang áp dụng IP whitelist cho 157.10.199.177..." -ForegroundColor Green

# Apply middleware và IngressRoute
kubectl apply -f "g:\deploy_app\apps\tool\tool-30050-whitelist.yaml"

Write-Host "`n🔍 Kiểm tra trạng thái..." -ForegroundColor Yellow
kubectl get middleware tool-whitelist-30050 -n web-stock-future
kubectl get ingressroute ip-access-whitelist -n web-stock-future

Write-Host "`n✅ HOÀN THÀNH!" -ForegroundColor Green
Write-Host "IP 157.10.199.177 bây giờ chỉ cho phép truy cập từ whitelist IP" -ForegroundColor White

Write-Host "`n🧪 Test từ IP được phép:" -ForegroundColor Cyan
Write-Host "Invoke-WebRequest http://157.10.199.177/ -UseBasicParsing" -ForegroundColor Gray

Write-Host "`n❌ Từ IP không được phép sẽ nhận HTTP 403 Forbidden" -ForegroundColor Red