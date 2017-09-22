# Cookbook

## Table of Contents
1. [ RecordSet에 포함된 레코드들에 접근하는 방법](#1)
2. [RecordSet에 포함된 레코드들로 구성된 List를 만드는 방법](#2)
3. [Shapefile을 읽어 RecordSet 객체를 만드는 방법](#3)

## 1. RecordSet에 포함된 레코드들에 접근하는 방법 <a name="1"></a>
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

## 2. RecordSet에 포함된 레코드들로 구성된 List를 만드는 방법 <a name="2"></a>
<pre><code>RecordSet rset = ......;
List<Record> list = rset.toList();

for ( Record record: list ) {
   System.out.println(record);   // 읽은 레코드 객체 활용
}
</code></pre>

이 방법은 RecordSet에 포함된 모든 레코드를 읽어 리스트로 만들기 때문에, 다수의 레코드로
구성된 RecordSet인 경우 메모리 부족 상황이 발생할 수도 있다.

## 3. Shapefile을 읽어 RecordSet 객체를 만드는 방법 <a name="3"></a>
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

## 2. RecordSet 사용방법
`RecordSet`을 사용할 때, 그 사용을 마치면 반드시 `close()` 메소드를 호출하여야 한다.
그렇지 않으면 RecordSet 객체에 할당된 여러 자원의 반환이 수행되지 않을 수 있다.
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
