## Marmot 클라이언트 배포판 설치 방법

### 1. 설치 사전 조건
* Oracle Java (Java8 이상)가 설치되어 있어야 한다. OpenJDK는 지원하지 않는다.
* [Marmot 서버](https://github.com/kwlee0220/marmot.server.dist)를 사용할 수 있어야 한다.

### 2. 클라이언트 실행파일 설치 절차

GitHub에서 Marmot client 배포판을 download하여 압축을 풀고, 이때 생성된 디렉토리의
이름을 `marmot.client.dist`로 변경한다.
* URL 주소: `https://github.com/kwlee0220/marmot.client.dist`

압축이 풀린 디렉토리의 위치는 임의의 위치이어도 무관하나, 본 문서에서는 `$HOME/marmot/marmot.client.dist`
(windows 인 경우는 `C:\marmot\marmot.client.dist`)로 가정한다.
* Linux인 경우 압축이 별도의 디렉토리하에 풀리지 않는 경우도 있다.
	이때는 `marmot.client.dist` 디렉토리 생성하고 이 디렉토리에서 압축을 해제한다.

생성된 `marmot.client.dist` 하위의 bin 디렉토리로 이동하고, jar 파일에 대한 symbolic link를 생성한다.
>`$ ln -s marmot.client-1.1-all.jar marmot.client.jar` *(Linux 경우)*</br>
> `C:\marmot\marmot.client.dist\bin> mklink marmot.client.jar marmot.client-1.1-all.jar` *(Windows 경우)*

서버의 접속 정보를 설정할 환경변수를 설정한다. Linux의 경우는 로그인 때마다 동일한 작업을
반복하지 않기 위해 설정명령을 `.bash_profile` 또는 `.bashrc` 등에 기록할 수 있다.
<pre><code>export MARMOT_HOST=[marmot server IP]
export MARMOT_PORT=[marmot server port]
export MARMOT_CLIENT_HOME=$HOME/marmot/marmot.client.dist

export PATH=$PATH:$MARMOT_CLIENT_HOME/bin/linux
</code></pre>
Windows의 경우는 `PATH` 환경변수의 값으로 `$MARMOT_CLIENT_HOME/bin/windows`을 설정한다.

`$HOME/marmot/marmot.client.dist/bin/linux` 디렉토리에 있는 클라이언트 스크립트들 중 `mc_dir` 또는
`mc_explorer`을 수행시켜 서버 접속 여부를 확인한다.
>`$ mc_dir` </br>
>`$ mc_explorer`

[Marmot 서버 배포본](https://github.com/kwlee0220/marmot.server.dist) 에 기술된 샘플 공간 데이터 파일을
적재한다.
