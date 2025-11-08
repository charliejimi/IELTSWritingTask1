@echo off
chcp 65001 > nul
setlocal

REM 設定你的 Git 專案路徑
set "GIT_PATH=C:\2025 Tasks\7. IELTS\自主訓練\日誌相關檔案\WritingTask1"

REM 進入 Git 專案路徑
cd /d "%GIT_PATH%"

echo.
echo --- 自動同步所有 TXT 檔案變更 ---
echo.
echo 正在偵測本地端的檔案變更 (包含新增、修改和刪除)...
git status -s
echo.
echo.
pause
echo.

REM 設定自動提交註解
set "COMMIT_MESSAGE=自動同步所有 TXT 檔案"

echo.
echo 正在將所有 TXT 檔案的變更加入暫存區 (包含刪除的檔案)...
git add -A *.txt

echo.
echo 正在提交變更...
git commit -m "%COMMIT_MESSAGE%"

echo.
echo 正在同步遠端倉庫...
git pull origin master

echo.
echo 正在推送至 GitHub...
git push -u origin master

echo.
echo =========================================================
echo.
echo             Git 同步與推送完成！
echo.
echo =========================================================
pause