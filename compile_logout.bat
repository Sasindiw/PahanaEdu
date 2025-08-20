@echo off
echo Compiling LogoutServlet...

REM Set Java home (update this to your Java installation)
set JAVA_HOME=C:\Program Files\Java\jdk-11

REM Set classpath with required libraries
set CLASSPATH=web\WEB-INF\lib\javax.servlet-api-4.0.1.jar

REM Create output directory
if not exist "out\artifacts\PahanaEdu\WEB-INF\classes\com\pahanaedu\servlets" mkdir "out\artifacts\PahanaEdu\WEB-INF\classes\com\pahanaedu\servlets"

REM Compile LogoutServlet
echo Compiling LogoutServlet.java...
"%JAVA_HOME%\bin\javac" -cp "%CLASSPATH%" -d "out\artifacts\PahanaEdu\WEB-INF\classes" src\com\pahanaedu\servlets\LogoutServlet.java

if %ERRORLEVEL% EQU 0 (
    echo LogoutServlet compiled successfully!
    echo You can now deploy the application and logout should work.
) else (
    echo Compilation failed! Please check your Java installation.
)

pause
