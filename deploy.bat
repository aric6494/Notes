@echo off
REM 执行Git操作
git add .
git commit -m "upgrade"
git push origin main

REM 部署MkDocs
mkdocs gh-deploy

REM 防止窗口自动关闭（可选）
pause