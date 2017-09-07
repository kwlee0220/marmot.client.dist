## Marmot 클라이언트 배포판 설치 방법

### 1. 설치 사전 조건
* Oracle Java를 (Java8 이상) 설치되어 있어야 한다.

### 2. 클라이언트 라이브러리 설치 절차
1. Home 디렉토리 아래에 'marmot'이라는 디렉토리를 생성한다.
<pre><code>$ cd
$ mkdir marmot
</code></pre>

2. 압축을 풀어 생성된 디렉토리를 생성된 곳을 이동시킨다.
<pre><code>$ cd marmot</code></pre>

3. GitHub에서 Marmot client 배포판을 download한다.
	* URL 주소: `https://github.com/kwlee0220/marmot.client.dist`

4. Download받은 zip 파일 (`marmot.client.dist-master.zip`)의 압축을 풀고, 디렉토리 이름을 `marmot.client.dist`로 변경한다.
<pre><code>$ unzip marmot.client.dist-master.zip
$ mv marmot.client.dist-master marmot.client.dist
</code></pre>

5. 환경변수를 설정한다. 로그인 때마다 동일한 작업을 반복하지 않기 위해 설정명령을
	`.bash_profile` 또는 `.bashrc` 등에 기록할 수 있다.
<pre><code>export MARMOT_HOST=<marmot server IP>
export MARMOT_PORT=<marmot server port>
export MARMOT_CLIENT_HOME=$HOME/marmot/marmot.client.dist
export PATH=$PATH:$HOME/bin:$MARMOT_HOME/bin
</code></pre>

7. '$HOME/marmot/marmot.client.dist/bin' 디렉토리로 이동하고, jar 파일에 대한 symbolic link를 생성한다.
<pre><code>$ cd $HOME/marmot/marmot.server.dist/bin
$ ln -s marmot-1.1-all.jar marmot.jar
</code></pre>


### 3. Marmot 서버 구동

1. 데이터베이스 포맷 및 시스템 내부 카다로그 생성
>`$ format_catalog`

2.서버 구동
> `$ remote_marmot`
