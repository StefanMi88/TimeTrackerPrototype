@echo off
mvn clean compile
pause 
mvn package
cd *\target
java -jar timetracker-app-1.0-SNAPSHOT-jar-with-dependencies.jar
pause 