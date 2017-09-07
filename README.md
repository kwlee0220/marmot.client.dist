## Marmot 클라이언트 배포판 설치 방법

### 1. 설치 사전 조건
* Oracle Java를 (Java8 이상) 설치되어 있어야 한다.

### 2. 클라이언트 실행파일 설치 절차
1. Home 디렉토리 아래에 'marmot'이라는 디렉토리를 생성한다.
<pre><code>$ cd
$ mkdir marmot
</code></pre>
https://github.com/kwlee0220/marmot.client.dist
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
<pre><code>export MARMOT_HOST=[marmot server IP]
export MARMOT_PORT=[marmot server port]
export MARMOT_CLIENT_HOME=$HOME/marmot/marmot.client.dist
export PATH=$PATH:$HOME/bin:$MARMOT_HOME/bin
</code></pre>

6. `$HOME/marmot/marmot.client.dist/bin` 디렉토리에 있는 클라이언트 스크립트들 중 `mc_dir`을 수행시켜 서버 접속 여부를 확인한다.
<pre><code>$ cd $HOME/marmot/marmot.client.dist/bin
$ mc_dir
</code></pre>
