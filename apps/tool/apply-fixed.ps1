# Script apply sau khi fix conflicts

Write-Host "🔧 Apply IP whitelist cho port 30050 - ĐÃ FIX CONFLICTS" -ForegroundColor Green

Write-Host "`n📝 Apply middleware và NetworkPolicy..." -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\tool\tool-30050-whitelist.yaml"

Write-Host "`n🔍 Kiểm tra tool-service đã có NodePort 30050..." -ForegroundColor Cyan
kubectl get svc tool-service -n web-stock-future

Write-Host "`n🔍 Kiểm tra NetworkPolicy..." -ForegroundColor Cyan
kubectl get networkpolicy tool-service-30050-whitelist -n web-stock-future

Write-Host "`n🔍 Kiểm tra Middleware..." -ForegroundColor Cyan
kubectl get middleware tool-whitelist-30050 -n web-stock-future

Write-Host "`n✅ HOÀN THÀNH!" -ForegroundColor Green
Write-Host "Giải pháp:" -ForegroundColor White
Write-Host "- Tool service đã có NodePort 30050 từ project Tool workflow" -ForegroundColor Cyan
Write-Host "- NetworkPolicy chặn traffic trực tiếp chỉ cho phép IP whitelist" -ForegroundColor Cyan
Write-Host "- Middleware sẵn sàng cho các Ingress khác nếu cần" -ForegroundColor Cyan

Write-Host "`n🧪 Test truy cập port 30050:" -ForegroundColor Yellow
Write-Host "Invoke-WebRequest http://157.10.199.177:30050/ -UseBasicParsing" -ForegroundColor Gray

Write-Host "`n📋 Lưu ý:" -ForegroundColor Red
Write-Host "- NetworkPolicy chỉ hoạt động nếu cluster hỗ trợ Network Policies" -ForegroundColor Gray
Write-Host "- Nếu chưa có CNI network plugin (Calico, Weave, etc.) thì NetworkPolicy không có tác dụng" -ForegroundColor Gray
Write-Host "- Kiểm tra: kubectl get networkpolicy -A" -ForegroundColor Gray