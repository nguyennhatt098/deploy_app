# PowerShell script để apply IP whitelist cho tool service port 30050

Write-Host "Đang apply Traefik Middleware và IngressRoute cho tool service..." -ForegroundColor Green

# Apply middleware và IngressRoute
kubectl apply -f "g:\deploy_app\apps\tool\tool-30050-whitelist.yaml"

Write-Host "Kiểm tra trạng thái middleware:" -ForegroundColor Yellow
kubectl get middleware tool-whitelist-30050 -n web-stock-future

Write-Host "Kiểm tra trạng thái IngressRoute:" -ForegroundColor Yellow
kubectl get ingressroute tool-service-secure-30050 -n web-stock-future

Write-Host "Hoàn thành! Tool service bây giờ chỉ cho phép truy cập từ các IP được whitelist." -ForegroundColor Green
Write-Host "Truy cập qua: http://157.10.199.177/ hoặc http://tool.nefyo.com/" -ForegroundColor Cyan

# Kiểm tra xem Traefik có nhận middleware không
Write-Host "`nKiểm tra Traefik logs (5 dòng cuối):" -ForegroundColor Yellow
kubectl logs deployment/traefik -n kube-system --tail=5