# Marmot 클라이언트 주요 명령어

## mc_dir
지정된 디렉토리에 저장된 dataset 리스트를 출력한다.
<pre><code>mc_dir [옵션들] <대상 디렉토리 경로>
  -host &ltIP 주소>: 접속 대상 marmot 서버 호스트 주소
  -port &lt포트 번호>: 접속 대상 marmot 서버 포트번호
  -l: 단순 dataset 이름 외에도 타입, 인덱스 여부 등 상세 정보 출력
  -r: 대상 디렉토리 외에도 모든 하위 디렉토리에 저장된 dataset 출력
  -h: 명령어 사용법 출력
</code></pre>
만일 **대상 디렉토리 경로**가 지정되지 않은 경우는" `mc_dir -r /`"을 수행시킨 것으로 간주된다.

## mc_list
지정된 dataset에 포함된 레코드들을 출력한다.
<pre><code>mc_list [옵션들] <대상 dataset 경로>
  -host &ltIP 주소>: 접속 대상 marmot 서버 호스트 주소
  -port &lt포트 번호>: 접속 대상 marmot 서버 포트번호
  -limit &lt숫자>: 출력할 최대 레코드 수
  -project &lt컬럼이름리스트>: 출력할 컬럼 이름들
  -delim &lt구분자>: 출력시 컬럼 사이의 구분자 지정
  -g:  공간 정보 출력
  -h: 명령어 사용법 출력
</code></pre>
`/교통/지하철/서울역사` 데이터세트의 모든 레코드를 출력하려면 다음과 같은 명령을 실행한다.
>`$ mc_list /교통/지하철/서울역사`

`/교통/지하철/서울역사` 데이터세트의 처음 10개의 레코드들에서 역사이름(kor_sub_nm)와
환승여부(trnsit_yn)만 출력하려면 다음과 같다.
>`$ mc_list /교통/지하철/서울역사 -limit 10 -project 'kor_sub_nm,trnsit_yn'`

## mc_schema
지정된 dataset의 스키마 정보를 출력한다.
<pre><code>mc_schema [옵션들] <대상 dataset 경로>
  -host &ltIP 주소>: 접속 대상 marmot 서버 호스트 주소
  -port &lt포트 번호>: 접속 대상 marmot 서버 포트번호
  -h: 명령어 사용법 출력
</code></pre>
데이터세트 `/교통/지하철/서울역사` 의 스키마 정보를 출력하려면 다음과 같다.
>`$ mc_schema /교통/지하철/서울역사`

## mc_delete
지정된 dataset를 삭제한다.
만일 `-r` 옵션이 주어진 경우는 인자는 대상 디렉토리 경로명으로 간주되고,
해당 디렉토리 아래에 있는 모든 데이터세트를 삭제한다.
<pre><code>mc_delete [옵션들] <대상 dataset 경로 또는 대상 디렉토리>
  -host &ltIP 주소>: 접속 대상 marmot 서버 호스트 주소
  -port &lt포트 번호>: 접속 대상 marmot 서버 포트번호
  -r: 대상 경로의 디렉토리에 속한 모든 데이터세트 삭제하려는 경우
</code></pre>
데이터세트 `/교통/지하철/서울역사` 의 스키마 정보를 출력하려면 다음과 같다.
>`$ mc_delete /교통/지하철/서울역사`

디렉토리 `/교통/지하철`에 속한 모든 데이터세트들을 삭제하려면 다음과 같다.
>`$ mc_delete -r /교통/지하철/서울역사`

## mc_export_shapefile
지정된 dataset를 shapefile 형식으로 export 시킨다.
만일 `-r` 옵션이 주어진 경우는 인자는 대상 디렉토리 경로명으로 간주되고,
해당 디렉토리 아래에 있는 모든 데이터세트를 삭제한다.
<pre><code>mc_delete [옵션들] <대상 dataset 경로 또는 대상 디렉토리>
  -host &ltIP 주소>: 접속 대상 marmot 서버 호스트 주소
  -port &lt포트 번호>: 접속 대상 marmot 서버 포트번호
  -output &lt출력 shp 파일>: 생성될 shp 파일의 경로명. 본 옵션은 반드시 지정되어야 한다.
  -charset &ltcharset 이름>: 문자열 세트 이름. (default: euc-kr)
  -sample &lt샘플링 비율>: 지정된 dataset에 포함된 레코드들 중 export될 비율. (default: 1)
  -start &lt갯수>: export될 첫번째 레코드의 순번. (default: 0)
  -stop &lt갯수>: 마지막으로 exprot될 레코드의 순번. (default: MAX_LONG)
  -create_index: shp 파일 생성 중 공간 인덱스 생성할 경우.
  -use_seq_col: shp 파일 생성시 생성될 컬럼이름을 dataset의 해당 컬럼 이름을 사용하지 않고,
          컬럼 순번으로 컬럼 이름을 사용하게 할 경우. 컬럼 이름에 한글이 포함되는 경우 사용.
  -f: 생성될 경로명과 동일 파일이 있는 경우, 생성 이전에 해당 파일을 삭제하려는 경우.
  -h: 명령어 사용법 출력
</code></pre>
데이터세트 `/교통/지하철/서울역사`를 shapefile로 export하려면 다음과 같다.
>`$ mc_export_shapefile /교통/지하철/서울역사 -output ~/tmp/xxx.shp`

데이터세트 `/교통/지하철/서울역사`에서 5번째부터 14번째까지의 레코드만 utf-8 문자열 형식으로 export하려면 다음과 같다.
>`$ mc_export_shapefile /교통/지하철/서울역사 -output ~/tmp/xxx.shp -start 5 -stop 15 -charset utf-8`
