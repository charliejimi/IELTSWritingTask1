@echo off
chcp 65001 > nul
setlocal

REM 設定你的 Git 專案路徑
set "GIT_PATH=C:\2025 Tasks\7. IELTS\自主訓練\日誌相關檔案\WritingTask1"

REM 進入 Git 專案路徑
cd /d "%GIT_PATH%"

echo =========================================================
echo.
echo              Git Interactive Push Tool
echo.
echo =========================================================

echo.
set /p FILE_NAME="請輸入要更新的檔案名稱 (例如: file.txt): "
set /p COMMIT_MESSAGE="請輸入這次提交的註解: "

echo.
echo 您輸入的資訊:
echo 檔案: %FILE_NAME%
echo 註解: %COMMIT_MESSAGE%
echo.

echo 正在新增檔案 %FILE_NAME%...
git add "%FILE_NAME%"

echo 正在提交變更...
git commit -m "%COMMIT_MESSAGE%"

echo 正在同步遠端倉庫...
git pull origin master

echo 正在推送至 GitHub...
git push -u origin master

REM 獲取 Git 遠端倉庫 URL
for /f "tokens=*" %%a in ('git config --get remote.origin.url') do set "REPO_URL=%%a"

REM 移除 .git 後綴，並替換成 raw 路徑
set "RAW_URL=%REPO_URL:.git=/raw/%"

REM 獲取最新的 commit ID
for /f "tokens=*" %%b in ('git rev-parse HEAD') do set "COMMIT_ID=%%b"

echo.
echo =========================================================
echo.
echo         Git 同步與推送完成！
echo.
echo         以下是檔案的 Raw 連結：
echo.
echo         %RAW_URL%/%COMMIT_ID%/%FILE_NAME%
echo.
echo =========================================================
pause