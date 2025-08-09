@echo off
echo Deploying PahanaEdu to Tomcat...

REM Set Tomcat path (update this to your Tomcat installation)
set TOMCAT_HOME=C:\apache-tomcat-9.0.107

REM Copy the artifact to Tomcat webapps
echo Copying application to Tomcat webapps...
xcopy /E /I /Y "out\artifacts\PahanaEdu" "%TOMCAT_HOME%\webapps\PahanaEdu"

echo Deployment complete!
echo Access the application at: http://localhost:8080/PahanaEdu/
pause 