This is to test the changes to azure-spring-boot which is now pointed/acquiring a token for the graph.microsoft.com api instead of the graph.windows.net.
This can easily be accomplished by downloading the entire repo.  Once downloaded, you will want to move the test-local.bat file up one directory.  Furthermore, the root directory of the azure-spring-boot should be called azure-spring-boot-master.
So this would result in a top level folder with the following content:
test-local.bat
azure-spring-boot-master

This test scenario utilizes the azure-active-directory-spring-boot-backend-sample.  You will want to update the application.properties file found in "azure-spring-boot-master\azure-spring-boot-samples\azure-active-directory-spring-boot-backend-sample\src\main\resources" with your client id, client secret, and tenant id.

Now you should be able to run the test-local.bat script.  What this script does, is it will locally install various packages (jar/pom) with a group id of com.test.  The packages installed locally are:
- azure-spring-boot-bom (pom only)
- azure-spring-boot-parent (pom only)
- azure-spring-boot
- azure-spring-boot-starter
- azure-active-directory-spring-boot-starter

Once done, it will then clean+build+run the azure-active-directory-spring-boot-backend-sample.
You can try out this sample by going to localhost:8080.