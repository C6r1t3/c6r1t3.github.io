@echo off
set "MSG=%*"
if "%MSG%"=="" set "MSG=update blog"
git add .
git commit -m "%MSG%"
git push