## Marmot 클라이언트 배포판 설치 방법

### 1. 설치 사전 조건
* Oracle Java가 (Java8 이상) 설치되어 있어야 한다. OpenJDK는 지원하지 않는다.
* [Marmot 서버](https://github.com/kwlee0220/marmot.server.dist)를 사용할 수 있어야 한다.

### 2. 클라이언트 실행파일 설치 절차
Home 디렉토리 아래에 'marmot'이라는 디렉토리를 생성한다.
<pre><code>$ cd
$ mkdir marmot
</code></pre>

압축을 풀어 생성된 디렉토리를 생성된 곳을 이동시킨다.
<pre><code>$ cd marmot</code></pre>

GitHub에서 Marmot client 배포판을 download한다.
* URL 주소: `https://github.com/kwlee0220/marmot.client.dist`

Download받은 zip 파일 (`marmot.client.dist-master.zip`)의 압축을 풀고, 디렉토리 이름을 `marmot.client.dist`로 변경한다.
<pre><code>$ unzip marmot.client.dist-master.zip
$ mv marmot.client.dist-master marmot.client.dist
</code></pre>

서버의 접속 정보를 설정할 환경변수를 설정한다. 로그인 때마다 동일한 작업을 반복하지 않기 위해 설정명령을
`.bash_profile` 또는 `.bashrc` 등에 기록할 수 있다.
<pre><code>export MARMOT_HOST=[marmot server IP]
export MARMOT_PORT=[marmot server port]
export MARMOT_CLIENT_HOME=$HOME/marmot/marmot.client.dist

export PATH=$PATH:$MARMOT_CLIENT_HOME/bin/linux
</code></pre>

`$HOME/marmot/marmot.client.dist/bin/linux` 디렉토리에 있는 클라이언트 스크립트들 중 `mc_dir` 또는
`mc_explorer`을 수행시켜 서버 접속 여부를 확인한다.
>`$ mc_dir`
>`$ mc_explorer`

[Marmot 서버 배포본](https://github.com/kwlee0220/marmot.server.dist) 에 기술된 샘플 공간 데이터 파일을
적재한다.
