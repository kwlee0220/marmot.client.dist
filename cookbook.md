# Cookbook

## Table of Contents
* [원격에서 Marmot 서버를 접속하는 방법](#connect_marmot)
* [Marmot 서버에 등록된 데이터 세트 목록을 얻는 방법](#list_dataset_all)
* [지정된 경로의 데이터 세트를 접근하는 방법](#get_dataset)
* [데이터 세트에 저장된 레코드들을 접근하는 방법](#read_rset)
* [RecordSet에 포함된 레코드들을 접근하는 다른 방법들](#get_record_misc)
* [RecordSet에 포함된 레코드들을 데이터 세트에 저장하는 방법](#append_rset)
* [데이터 세트의 경로명 변경 방법](#rename_ds)
* [Empty 레코드 세트를 생성하는 방법](#new_empty_rset)
* [단일 레코드로부터 레코드 세트를 생성하는 방법](#new_single_rset)
* [List&lt;Record>에서 레코드 세트를 생성하는 방법](#new_list_rset)
* [Shapefile을 읽어 RecordSet 객체를 만드는 방법](#shp_to_rset)
* [RecordSet에 포함된 레코드들을 Shapefile로 export하는 방법](#rset_to_shp)

## <a name="connect_marmot"></a> 원격에서 Marmot 서버를 접속하는 방법
원격에서 Marmot 서버를 접속하기 위해서는 서버가 수행되는 호스트의 IP 주소와 서버가 사용하는
포트 번호를 사전에 알고 있어야 한다.  또한 Marmot 서버에 접속한다는 의미는
서버 proxy에 해당하는 MarmotClient 객체를 초기화시키는 것을 의미하며 아래와 같은 방법으로
초기화시킨다.

<pre><code>import marmot.command.MarmotCommands;
import marmot.remote.RemoteMarmotConnector;
import marmot.remote.robj.MarmotClient;

String host = "localhost"; // Marmot 서버 IP 주소
int port = 9999;           // Marmot 서버 포트 번호

// 원격 MarmotServer에 접속.
RemoteMarmotConnector connector = new RemoteMarmotConnector();
MarmotClient marmot = connector.connect(host, port);
</code></pre>

## <a name="list_dataset_all"></a> Marmot 서버에 등록된 데이터 세트 목록을 얻는 방법 
<pre><code>import marmot.DataSet;

List<DataSet> dsList = marmot.getDataSetAll();
for ( DataSet ds: dsList ) {
   System.out.println("DataSet name: " + ds.getId());
   System.out.println("Schema: " + ds.getRecordSchema());
}
</code></pre>

## <a name="get_dataset"></a> 지정된 경로의 데이터 세트를 접근하는 방법 
<pre><code>import marmot.DataSet;

try {
   // 주어진 경로의 데이터 세트가 존재하지 않는 경우는 DataSetNotFoundException 예외 발생
   DataSet ds = marmot.getDataSet("교통/지하철/서울역사");
}
catch ( DataSetNotFoundException e ) {
   System.out.println(e);
}

// 주어진 경로의 데이터 세트가 존재하지 않는 경우는 null을 반환
DataSet ds2 = marmot.getDataSetOrNull("교통/지하철/서울역사");
if ( ds2 == null ) {
   System.out.println("dataset not found");
}
</code></pre>
## <a name="read_rset"></a> 데이터 세트에 저장된 레코드들을 접근하는 방법
데이터 세트에 저장된 레코드를 접근하는 방법은 데이터 세트를 읽어 레코드 세트 객체를
얻고, 레코드 세트를 포함된 레코드를 읽는 순서를 따른다.
먼저 데이터 세트에서 레코드 세트를 읽는 방법은 다음과 같이 `DataSet` 객체의 `read()` 메소드를 사용한다.

<pre><code>import marmot.DataSet;
import marmot.RecordSet;

DataSet ds = ......;  // 데이터 세트는 이미 가지고 있다고 가정
RecordSet rset = ds.read();
</code></pre>

주어진 RecordSet에 포함된 모든 레코드에 접근하는 방법은 두가지가 있다.

### `next()` 메소드를 호출하는 방법
`next()` 메소드를 사용하면 인자로 제공되는 레코드 객체에 RecordSet에 포함된 레코드를 읽는다.
이렇게 성공적으로 다음 레코드를 읽은 경우는 `true`, 더 이상의 레코드가 없는 경우는 `false`가 반환된다.
이 방법을 사용하기 위해서는 읽을 레코드를 저장할 레코드 객체를 제공해야 하는데 일반적으로
`DefaultRecord`객체를 사용한다. 이 방법은 `nextCopy` 메소드를 사용하는 방법과 달리 오직 하나의
레코드 객체를 재사용하기 때문에 다수의 레코드로 구성된 RecordSet을 읽는 경우 레코드 객체의 생성/제거가
발생하지 않아 보다 효율적이므로 일반적으로 권장되는 방법이다.

<pre><code>import marmot.support.DefaultRecord;

RecordSet rset = ......;
Record record = DefaultRecord.of(rset.getRecordSchema());
while ( rset.next(record) ) {
   System.out.println(record);   // 읽은 레코드 객체 활용
}
</code></pre>

### `nextCopy()` 메소드를 호출하는 방법
`nextCopy()` 메소드를 호출하면 `next()` 와 달리 RecordSet에 다음 레코드 객체를 바로 반환하기 때문에
미리 레코드를 객체를 만들어야 하는 번거로움은 없으나, 각 레코드 접근시마다 레코드 객체를 생성하는
부하가 있을 수 있다. 만일 RecordSet에서 더 이상 읽은 레코드가 없는 경우는 `null`을 반환한다.

<pre><code>RecordSet rset = ......;

Record record;
while ( (record = nextCopy()) != null ) {
   System.out.println(record);   // 읽은 레코드 객체 활용
}
</code></pre>

###  RecordSet 활용시 주의사항
`RecordSet`을 더 이상 사용하지 않게 되면 반드시 `close()` 메소드를 호출하여야 한다.
그렇지 않으면 RecordSet 수행을 위해 할당된 여러 자원의 반환이 수행되지 않을 수 있다.
`RecordSet`은 `AutoCloseable` 인터페이스를 지원하기 때문에 아래와 같이 `try` 문과 함께 사용하면
`try` block에서 나가는 경우 자동적으로 `close()` 메소드가 호출된다.
<pre><code>try ( RecordSet rset = ...... ) {
   ...... // rset을 활용하는 문장들.
}
</code></pre>

`try` 문을 사용할 수 없는 경우, `RecordSets`에서 지원하는 `autoClose()` 메소드를 사용하면
해당 RecordSet을 끝까지 읽는 경우 자동적으로 close되도록 할 수 있다.
<pre><code>import marmot.rset.RecordSets;

RecordSet rset = ......;
rset = RecordSets.autoClose(rset);

Record record = DefaultRecord.of(rset.getRecordSchema());
while ( rset.next(record) ) { // rset.next() 가 `false`를 반환하는 순간 자동적을 `close()`가 호출됨
   ...
}
</code></pre>

### `java.util.function.Consumer` 인터페이스를 통한 데이터 세트내 레코드 접근
데이터 세트는 Consumer 인터페이스를 활용하여 데이터 세트에 저장된 레코드를 차례대로
접근할 수 있는 인터페이스를 제공한다. 이것을 사용하면 RecordSet를 직접적으로 사용하지 않고
저장된 모든 레코드를 접근할 수 있어, 별도로 `RecordSet.close()`를 잊지 않고 호출해야 하는
번거로움을 해결해준다.
<pre><code>DataSet ds = ......;  // 데이터세트는 이미 가지고 있다고 가정
ds.apply(rset -> rset.forEach(System.out::println));
</code></pre>

## RecordSet에 포함된 레코드들을 접근하는 다른 방법들 <a name="get_record_misc"></a>

### RecordSet 에 포함된 레코드를을` java.util.List<Record>`로 변환하는 방법
<pre><code>RecordSet rset = ......;
List&lt;Record> list = rset.toList();

for ( Record record: list ) {
   System.out.println(record);   // 읽은 레코드 객체 활용
}
</code></pre>

### RecordSet 에 포함된 레코드를을 `java.util.stream.Stream<Record>`로 변환하는 방법
<pre><code>RecordSet rset = ......;
Stream&lt;Record> strm = rset.stream();

strm.forEach(System.out::println);
</code></pre>

### RecordSet 에 포함된 레코드를을 `utils.stream.FStream<Record>`로 변환하는 방법
<pre><code>RecordSet rset = ......;
FStream&lt;Record> strm = rset.fstream();

strm.forEach(System.out::println);
</code></pre>

이 방법은 RecordSet에 포함된 모든 레코드를 읽어 리스트로 만들기 때문에, 다수의 레코드로
구성된 RecordSet인 경우 메모리 부족 상황이 발생할 수도 있다.

## RecordSet에 포함된 레코드들을 데이터 세트에 저장하는 방법 <a name="append_rset"></a>

데이터 세트는 레코드 세트 단위로 레코드를 저장시킬 수 있다.
<pre><code>RecordSet rset = ......; // 레코드 세트가 이미 준비되었다고 가정함.
DataSet ds = ......;	 // 저장 대상이 되는 데이터 세트 객체를 갖고 있다고 가정함.

ds.append(rset);
</code></pre>

## 데이터 세트의 경로명 변경 방법 <a name="rename_ds"></a>
<pre><code>DataSet ds = ......;	 // 저장 대상이 되는 데이터 세트 객체를 갖고 있다고 가정함.

ds.rename("tmp/new_name");
</code></pre>

## <a name="new_empty_rset"></a>Empty 레코드 세트를 생성하는 방법
<pre><code>import marmot.rset.RecordSets;

RecordSchema schema = ......; // 생성할 레코드 세트의 스키마가 준비되었다고 가정함.
RecordSet rset = RecordSets.empty(schema);
</code></pre>

## <a name="new_single_rset"></a> 단일 레코드로부터 레코드 세트를 생성하는 방법
<pre><code>import marmot.rset.RecordSets;

Record rec = ......;	 // 대상 레코드가 준비되었다고 가정함.
RecordSet rset = RecordSets.from(rec);
</code></pre>

## <a name="new_list_rset"></a> List&lt;Record>에서 레코드 세트를 생성하는 방법
<pre><code>import marmot.rset.RecordSets;

List&lt;Record> recList = ......;	 // 대상 레코드 리스트가 준비되었다고 가정함.
RecordSet rset = RecordSets.from(recList);
</code></pre>

## <a name="shp_to_rset"></a>Shapefile을 읽어 RecordSet 객체를 만드는 방법
<pre><code>import marmot.geo.geotools.ShapefileRecordSet;

File shpFile = new File("/home/kwlee/data/xxx.shp");
RecordSet rset = ShapefileRecordSet.builder()
                                   .file(shpFile)
                                   .charset("euck-kr")
                                   .validate(false)
                                   .build();
</code></pre>
`charset()` 메소드를 호출하지 않는 경우는 default로 'EUC-KR' 문자열을 사용한다.
`validate()` 메소드를 이용하여 shapefile 적재시 Geometry 객체의 유효성을 검사하도록
할 수 있다 (기본값은 `false`임).

## <a name="rset_to_shp"></a>RecordSet에 포함된 레코드들을 Shapefile로 export하는 방법
<pre><code>import marmot.geo.geotools.ShapefileRecordSetWriter;
import marmot.geo.geotools.ShapefileRecordSet;

RecordSet rset = ......;	// assume 'rset' points to a RecordSet object
ShapefileRecordSetWriter writer = ShapefileRecordSetWriter.into(OUTPUT)
															.srid(ds.getSRID())
															.charset("euc-kr");
writer.write(rset);
rset.clse();
</code></pre>
DataSet의 레코드들을 이용하여 shapefile을 만드는 경우는 `ShapefileRecordSetWriter::write(DataSet)`
메소드를 사용할 수 있다.
