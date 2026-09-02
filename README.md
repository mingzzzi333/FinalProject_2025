[최초 실행방법]
   1) zookeeper 실행 (Kafka 모니터링 도구) 필수
     C:\dev\kafka_2.13-3.9.0\bin\windows\zookeeper-server-start.bat "C:\dev\kafka_2.13-3.9.0\config\zookeeper.properties"

   2) kafka를 실행 필수
     C:\dev\kafka_2.13-3.9.0\bin\windows\kafka-server-start.bat C:\dev\kafka_2.13-3.9.0\config\server.properties

   3) topic 생성 (producer와 consumer가 서로 주고 받는 채널)
C:\dev\kafka_2.13-3.9.0\bin\windows\kafka-topics.bat --create --topic stock --partitions 1 --replication-factor 1 --bootstrap-server localhost:9092

  4) producer 실행 테스트 DUPSocket
C:\dev\kafka_2.13-3.9.0\bin\windows\kafka-console-consumer.bat --topic stock --bootstrap-server localhost:9092 --from-beginning\

  5) consumer 실행 테스트
   C:\dev\kafka_2.13-3.9.0\bin\windows\kafka-console-consumer.bat --topic stock --bootstrap-server localhost:9092 --from-beginning
