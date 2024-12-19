@echo off
set mainSolution=Penguin.sln
set sonarQubeProjectKey=Penguin
set token=%1
set buildTag=main

if NOT "%~2"=="" (
	set buildTag=%2
)

set sonarParameters=/v:%buildTag% /key:%sonarQubeProjectKey% /d:sonar.login=%token% /d:sonar.cs.opencover.reportsPaths=**/TestResults/coverage.opencover.xml /d:sonar.host.url=http://192.168.1.103:9001/

dotnet sonarscanner begin %sonarParameters%
dotnet build
dotnet test /p:CollectCoverage=true /p:CoverletOutput=TestResults/ /p:CoverletOutputFormat=opencover --no-build
dotnet sonarscanner end /d:sonar.login=%token%