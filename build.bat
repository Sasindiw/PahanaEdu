@echo off
echo Building PahanaEdu project...

REM Set Java home (update this to your Java installation)
set JAVA_HOME=C:\Program Files\Java\jdk-11

REM Set classpath with required libraries
set CLASSPATH=web\WEB-INF\lib\javax.servlet-api-4.0.1.jar;web\WEB-INF\lib\postgresql-42.7.3.jar;web\WEB-INF\lib\jstl-1.2.jar

REM Create output directory
if not exist "out\artifacts\PahanaEdu\WEB-INF\classes" mkdir "out\artifacts\PahanaEdu\WEB-INF\classes"

REM Compile all Java files
echo Compiling Java files...
"%JAVA_HOME%\bin\javac" -cp "%CLASSPATH%" -d "out\artifacts\PahanaEdu\WEB-INF\classes" src\com\pahanaedu\*.java src\com\pahanaedu\dao\*.java src\com\pahanaedu\filters\*.java src\com\pahanaedu\model\*.java src\com\pahanaedu\service\*.java src\com\pahanaedu\servlets\*.java src\com\pahanaedu\util\*.java

if %ERRORLEVEL% EQU 0 (
    echo Compilation successful!
    echo Copying web files...
    xcopy /E /I /Y "web\*" "out\artifacts\PahanaEdu\"
    echo Build complete!
) else (
    echo Compilation failed!
)

pause
