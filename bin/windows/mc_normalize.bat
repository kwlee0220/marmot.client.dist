@echo off

java -cp %MARMOT_CLIENT_HOME%/bin/marmot.client.jar ^
marmot.command.RemoteNormalizeProcessMain ^
-host %MARMOT_HOST% -port %MARMOT_PORT% %*
