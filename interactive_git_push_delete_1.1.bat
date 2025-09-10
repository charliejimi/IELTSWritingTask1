@echo off
chcp 65001 > nul
setlocal

REM 設定你的 Git 專案路徑
set "GIT_PATH=C:\2025 Tasks\7. IELTS\自主訓練\日誌相關檔案\WritingTask1"

REM 進入 Git 專案路徑
cd /d "%GIT_PATH%"

:MENU
cls
echo =========================================================
echo.
echo              Git Interactive Sync Tool
echo.
echo =========================================================
echo.
echo 請選擇操作模式：
echo.
echo   1. 僅新增/更新單一檔案並取得連結 (預設)
echo.
echo   2. 自動同步所有本地變更 (刪除命令) 
echo.
set /p ACTION="請輸入選項 [1-2] (直接按 Enter 執行預設選項 1): "

REM --- 修改重點 ---
REM 如果使用者直接按 Enter (ACTION 為空)，就跳到預設的 :SYNC_SINGLE
if "%ACTION%"=="" set ACTION=1

if "%ACTION%"=="1" goto :SYNC_SINGLE 
if "%ACTION%"=="2" goto :SYNC_ALL

echo.
echo 無效的選項，請重新輸入。
pause
goto :MENU

:SYNC_ALL
echo.
echo --- 模式 1: 自動同步所有變更 ---
echo.
echo 正在偵測本地端的檔案變更...
git status -s
echo.
echo (上方列表顯示了所有已變更[M]、新增[A]、刪除[D]的檔案)
echo.
pause
echo.
set /p COMMIT_MESSAGE="請為 [所有] 變更輸入一個提交註解: "

echo.
echo 正在將所有變更加入暫存區...
REM 使用 "git add ." 會自動包含新增、修改和已刪除的檔案
git add .
goto :COMMIT_AND_PUSH

:SYNC_SINGLE
echo.
echo --- 模式 2: 新增/更新單一檔案 ---
echo.
set /p FILE_NAME="請輸入要 [新增/更新] 的檔案名稱: "
set /p COMMIT_MESSAGE="請輸入這次提交的註解: "
echo.
echo 正在將 %FILE_NAME% 加入暫存區...
git add "%FILE_NAME%"
goto :COMMIT_AND_PUSH

:COMMIT_AND_PUSH
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
echo         Git 同步與推送完成！
echo.
echo =========================================================

REM 如果是單檔模式，才顯示 Raw 連結
if "%ACTION%"=="1" (
    for /f "tokens=*" %%a in ('git config --get remote.origin.url') do set "REPO_URL=%%a"
    set "RAW_URL=%REPO_URL:.git=/raw/%"
    for /f "tokens=*" %%b in ('git rev-parse HEAD') do set "COMMIT_ID=%%b"
    echo.
    echo         以下是檔案的 Raw 連結：
    echo.
    echo         %RAW_URL%/%COMMIT_ID%/%FILE_NAME%
    echo.
    echo =========================================================
)

pause