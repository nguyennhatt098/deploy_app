# Script PowerShell để setup IP whitelist cho port 30050 - CẢ 2 PROJECT

Write-Host "🔒 Đang setup IP whitelist cho port 30050 trên cả 2 project..." -ForegroundColor Green

Write-Host "`n=== BƯỚC 1: Apply Traefik config cho entryPoint 30050 ===" -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\tool\traefik-port30050-config.yaml"

Write-Host "`n=== BƯỚC 2: Apply whitelist middleware và IngressRoute ===" -ForegroundColor Yellow
kubectl apply -f "g:\deploy_app\apps\tool\tool-30050-whitelist.yaml"

Write-Host "`n=== BƯỚC 3: Commit và push Tool project để cập nhật NodePort 30050 ===" -ForegroundColor Yellow
Write-Host "Chạy các lệnh sau trong project Microsoft.AspNetCore.Tool:" -ForegroundColor Cyan
Write-Host "cd c:\Users\PC\source\repos\Microsoft.AspNetCore.Tool" -ForegroundColor Gray
Write-Host "git add ." -ForegroundColor Gray
Write-Host "git commit -m 'Add NodePort 30050 for Tool service with IP whitelist'" -ForegroundColor Gray
Write-Host "git push" -ForegroundColor Gray

Write-Host "`n=== BƯỚC 4: Restart Traefik để load entryPoint mới ===" -ForegroundColor Yellow
kubectl rollout restart deployment/traefik -n kube-system

Write-Host "`n🔍 Kiểm tra trạng thái..." -ForegroundColor Cyan
Start-Sleep -Seconds 10

Write-Host "`nTraefik pods:" -ForegroundColor White
kubectl get pods -n kube-system -l app.kubernetes.io/name=traefik

Write-Host "`nTraefik service:" -ForegroundColor White
kubectl get svc traefik -n kube-system

Write-Host "`nTool services:" -ForegroundColor White
kubectl get svc -n web-stock-future | Select-String tool

Write-Host "`nMiddleware:" -ForegroundColor White
kubectl get middleware tool-whitelist-30050 -n web-stock-future

Write-Host "`nIngressRoute:" -ForegroundColor White
kubectl get ingressroute nodeport-30050-whitelist -n web-stock-future

Write-Host "`n✅ HOÀN THÀNH!" -ForegroundColor Green
Write-Host "Sau khi Traefik restart và Tool service redeploy:" -ForegroundColor White
Write-Host "- Port 30050 chỉ cho phép IP: 14.191.166.230 và các IP nội bộ" -ForegroundColor Cyan
Write-Host "- Traffic đi qua: Internet → Traefik (port 30050) → Middleware (whitelist) → Tool service" -ForegroundColor Cyan

Write-Host "`n🧪 Test sau 2-3 phút:" -ForegroundColor Yellow
Write-Host "Invoke-WebRequest http://157.10.199.177:30050/ -UseBasicParsing" -ForegroundColor Gray

Write-Host "`n⚠️  Lưu ý:" -ForegroundColor Red
Write-Host "- Phải chạy git push cho project Tool để NodePort 30050 có hiệu lực" -ForegroundColor Gray
Write-Host "- Nếu vẫn không hoạt động, kiểm tra Traefik logs và Service endpoints" -ForegroundColor Gray