> Importing data from SQL to Logstash and Opensearch

1.  Create mysql deployment

[[https://kubernetes.io/docs/tasks/run-application/run-single-instance-stateful-application]{.underline}](https://kubernetes.io/docs/tasks/run-application/run-single-instance-stateful-application)

2.  Installing logstash deployment with service and configmap

[[https://stackoverflow.com/questions/57675710/installing-logstash-on-kubernetes-and-sending-logs-to-aws-elasticsearch]{.underline}](https://stackoverflow.com/questions/57675710/installing-logstash-on-kubernetes-and-sending-logs-to-aws-elasticsearch)

3.  Disabling ssl in output to opensearch

[[https://forum.opensearch.org/t/logstash-setting/197]{.underline}](https://forum.opensearch.org/t/logstash-setting/197)

ssl =\> true ssl_certificate_verification =\> false

4.  Check connection to opensearch

https://code.dblock.org/2023/08/08/changing-the-default-admin-password-in-opensearch.html

curl \--insecure -u admin:admin https://localhost:9200

**{**

\"name\" : \"b09419b98216\",

\"cluster_name\" : \"docker-cluster\",

\"cluster_uuid\" : \"SYUzvRvqT06ld8IdvE5okQ\",

\"version\" : **{**

\"distribution\" : \"opensearch\",

\"number\" : \"2.9.0\",

\"build_type\" : \"tar\",

\"build_hash\" : \"1164221ee2b8ba3560f0ff492309867beea28433\",

\"build_date\" : \"2023-07-18T21:22:48.164885046Z\",

\"build_snapshot\" : false,

\"lucene_version\" : \"9.7.0\",

\"minimum_wire_compatibility_version\" : \"7.10.0\",

\"minimum_index_compatibility_version\" : \"7.0.0\"

**}**,

\"tagline\" : \"The OpenSearch Project: https://opensearch.org/\"

**}**

****

5.  Connect sql database with logstash

[[https://medium.com/@amin.mirzaee/logstash-pipeline-from-sql-server-to-elastic-search-17c05a6b4a1e]{.underline}](https://medium.com/@amin.mirzaee/logstash-pipeline-from-sql-server-to-elastic-search-17c05a6b4a1e)

6.  Creating jdbc connection for mysql and create mysql db

[[https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html]{.underline}](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html)

7.  Allow root privileges if needed

[[https://kubernetes.io/docs/tasks/configure-pod-container/security-context/]{.underline}](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

8.  Create pv and pvc. Create storage, put driver for mysql there and
    > map it to pod

[[https://www.youtube.com/watch?v=s_ZXpuLnjJE]{.underline}](https://www.youtube.com/watch?v=s_ZXpuLnjJE)

Output:

![](./image1.png){width="6.5in" height="3.7777777777777777in"}

Common errors and issues during installation

\[ERROR\] 2023-09-12 09:56:08.635 \[\[main\]-pipeline-manager\]
javapipeline - Pipeline error {:pipeline_id=\>\"main\",
:exception=\>#\<LogStash::PluginLoadingError: unable to load
./logstash-core/lib/jars/mssql-jdbc-12.4.1.jre11.jar

output {

opensearch {

hosts =\> \[ \"https://opensearch-cluster-master:9200\" \]

index =\> \"SQLindex\"

user =\> \"admin\"

password =\> \"admin\"

doc_as_upsert =\> true

document_id =\> \"%{id}\"

ssl =\> false

ssl_certificate_verification =\> false

}

}

azure-storage-account-f2d24a1f33ad54dfa87ad0e-secret

Client with IP address \'104.42.116.102\' is not allowed to access the
server. To enable access, use the Azure Management Portal or run
sp_set_firewall_rule on the master database to create a firewall rule
for this IP address or address range. It may take up to five minutes for
this change to take effect. ClientConnectio

input {

jdbc {

jdbc_connection_string =\>
\"jdbc:sqlserver://aks-vega-sqlserver.database.windows.net:1433;databaseName=acctest-db-d;integratedSecurity=false;\"

jdbc_user =\> \"adminVegaAks\"

jdbc_password =\> \"1234!VegaPass\"

jdbc_driver_library =\> \"/tmp/mssql-jdbc-12.4.1.jre11.jar\"

jdbc_driver_class =\> \"com.microsoft.sqlserver.jdbc.SQLServerDriver\"

statement =\> \"SELECT TOP(1000) \* FROM data.Table WITH(NOLOCK) WHERE
Id \> :sql_last_value ORDER BY Id ASC\"

tracking_column =\> \"id\"

tracking_column_type =\> \"numeric\"

use_column_value =\> true

last_run_metadata_path =\> \"./Log/.logstash_jdbc_last_run\"

schedule =\> \"\*/30 \* \* \* \* \*\"

}

}

\[INFO \] 2023-09-13 06:53:37.886 \[\[main\]-pipeline-manager\]
javapipeline - Pipeline Java execution initialization time
{\"seconds\"=\>0.78}

Loading class \`com.mysql.jdbc.Driver\'. This is deprecated. The new
driver class is \`com.mysql.cj.jdbc.Driver\'. The driver is
automatically registered via the SPI and manual loading of the driver
class is generally unnecessary.

\[ERROR\] 2023-09-13 06:53:38.551 \[\[main\]-pipeline-manager\] jdbc -

java.sql.SQLSyntaxErrorException: Unknown database \'Persons\'

\[ERROR\] 2023-09-13 07:11:00.254
\[Ruby-0-Thread-20@\[main\]\|input\|Jdbc\|scheduler_worker-00:
/usr/share/logstash/vendor/bundle/jruby/2.6.0/gems/rufus-scheduler-3.9.1/lib/rufus/scheduler/jobs_core.rb:315\]
jdbc - Scheduler intercepted an error: {:exception=\>Errno::ENOENT,
:message=\>\"No such file or directory - ./Log/.logstash_jdbc_last_run\"

Prakticno deployment, cron, service, kako odraditi deploy funkcija.
