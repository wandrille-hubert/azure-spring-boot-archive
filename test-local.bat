REM Author: wahube
@echo off

if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )


REM push azure-spring-boot-pom package to local maven repo
call mvn install:install-file -Dfile=azure-spring-boot-master\azure-spring-boot-bom\pom.xml -DgroupId=com.test -DartifactId=azure-spring-boot-bom -Dversion=2.1.7 -Dpackaging=pom -DpomFile=azure-spring-boot-master\azure-spring-boot-bom\pom.xml


REM push azure-spring-boot-parent package to local maven repo
call mvn install:install-file -Dfile=azure-spring-boot-master\azure-spring-boot-parent\pom.xml -DgroupId=com.test -DartifactId=azure-spring-boot-parent -Dversion=2.1.7 -Dpackaging=pom -DpomFile=azure-spring-boot-master\azure-spring-boot-parent\pom.xml



REM clean and build azure-spring-boot
call mvn clean package -f azure-spring-boot-master\azure-spring-boot\pom.xml -Dmaven.test.skip=true -Dcheckstyle.skip -Dfindbugs.skip=true


REM push azure-spring-boot package to local maven repo
call mvn install:install-file -Dfile=azure-spring-boot-master\azure-spring-boot\target\azure-spring-boot-2.1.7.jar -DgroupId=com.test -DartifactId=azure-spring-boot -Dversion=2.1.7 -Dpackaging=jar -DpomFile=azure-spring-boot-master\azure-spring-boot\pom.xml



REM clean and build azure-spring-boot-starter
call mvn clean package -f azure-spring-boot-master\azure-spring-boot-starters\azure-spring-boot-starter\pom.xml 

REM push azure-spring-boot-starter package to local maven repo
call mvn install:install-file -DgroupId=com.test -DartifactId=azure-spring-boot-starter -Dversion=2.1.7 -Dpackaging=jar -DpomFile=azure-spring-boot-master\azure-spring-boot-starters\azure-spring-boot-starter\pom.xml -Dfile=azure-spring-boot-master\azure-spring-boot-starters\azure-spring-boot-starter\target\azure-spring-boot-starter-2.1.7.jar




REM clean and build azure-active-directory-spring-boot-starter
call mvn clean package -f azure-spring-boot-master\azure-spring-boot-starters\azure-active-directory-spring-boot-starter\pom.xml 

REM push azure-active-directory-spring-boot-starter package to local maven repo
call mvn install:install-file -Dfile=azure-spring-boot-master\azure-spring-boot-starters\azure-active-directory-spring-boot-starter\target\azure-active-directory-spring-boot-starter-2.1.7.jar -DgroupId=com.test -DartifactId=azure-active-directory-spring-boot-starter -Dversion=2.1.7 -Dpackaging=jar -DpomFile=azure-spring-boot-master\azure-spring-boot-starters\azure-active-directory-spring-boot-starter\pom.xml





REM clean and build sample backend proj
call mvn clean install -f azure-spring-boot-master\azure-spring-boot-samples\azure-active-directory-spring-boot-backend-sample\pom.xml

REM run sample backend proj
cd azure-spring-boot-master\azure-spring-boot-samples\azure-active-directory-spring-boot-backend-sample
call mvn spring-boot:run

