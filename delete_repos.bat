@echo off
@REM gh auth refresh -h github.com -s delete_repo
set "organization=KenPowerClassroom"
set "pattern=programming-project-1-"  ; Adjust this to match the naming pattern of the repositories you want to delete

echo Finding and deleting repositories in %organization% matching pattern %pattern%...
for /f "delims=" %%i in ('gh repo list %organization% --limit 1000 --json nameWithOwner ^| jq -r ".[] | select(.nameWithOwner | test(\"%pattern%\")) | .nameWithOwner"') do (
    echo Deleting repository %%i...
    gh repo delete %%i --yes
)

echo Done deleting repositories.
pause

