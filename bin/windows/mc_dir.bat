@echo off

java -cp %MARMOT_CLIENT_HOME%/bin/marmot.client.jar marmot.command.ListDataSetsMain ^
-host %MARMOT_HOST% -port %MARMOT_PORT% %*
