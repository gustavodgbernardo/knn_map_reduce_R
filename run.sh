hadoop jar /usr/hdp/2.2.6.0-2800/hadoop-mapreduce/hadoop-streaming-2.6.0.2.2.6.0-2800.jar \
-D mapred.map.tasks=2 \
-D mapred.reduce.tasks=15 \
-D stream.map.output.field.separator=, \
-D stream.reduce.input.field.separator=, \
-file /tmp/knn_codigos/mapper.R -mapper "Rscript mapper.R 5" \
-file /tmp/knn_codigos/reducer.R -reducer "Rscript reducer.R" \
-input /tmp/knn/* -output /tmp/knn2

hadoop fs -cat /tmp/knn2/* > dist_calc.csv