# Script để chặn NodePort 30050 với IP whitelist

Write-Host "🔒 Đang thiết lập chặn NodePort 30050 với IP whitelist..." -ForegroundColor Green

Write-Host "`n1. Apply NodePort service và whitelist middleware..." -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\tool\tool-30050-whitelist.yaml"

Write-Host "`n2. Apply NetworkPolicy (tùy chọn - chặn ở network level)..." -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\tool\networkpolicy-30050.yaml"

Write-Host "`n🔍 Kiểm tra services..." -ForegroundColor Cyan
kubectl get svc -n web-stock-future | findstr tool

Write-Host "`n📊 Kiểm tra middleware..." -ForegroundColor Cyan
kubectl get middleware tool-whitelist-30050 -n web-stock-future

Write-Host "`n🌐 Kiểm tra IngressRoute..." -ForegroundColor Cyan
kubectl get ingressroute nodeport-30050-whitelist -n web-stock-future

Write-Host "`n✅ HOÀN THÀNH!" -ForegroundColor Green
Write-Host "NodePort 30050 bây giờ chỉ cho phép truy cập từ IP whitelist" -ForegroundColor White

Write-Host "`n🧪 Test truy cập port 30050:" -ForegroundColor Cyan
Write-Host "Invoke-WebRequest http://157.10.199.177:30050/ -UseBasicParsing" -ForegroundColor Gray

Write-Host "`n⚠️  Cập nhật IP whitelist trong file:" -ForegroundColor Yellow
Write-Host "g:\deploy_app\apps\tool\tool-30050-whitelist.yaml" -ForegroundColor Gray
Write-Host "g:\deploy_app\apps\tool\networkpolicy-30050.yaml" -ForegroundColor Gray