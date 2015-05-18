hadoop jar /usr/hdp/2.2.0.0-2041/hadoop-mapreduce/hadoop-streaming-2.6.0.2.2.0.0-2041.jar \
-D mapred.map.tasks=2 \
-D mapred.reduce.tasks=15 \
-D stream.map.output.field.separator=, \
-D stream.reduce.input.field.separator=, \
-file /home/rstudio/knn/mapper.R -mapper "Rscript /home/rstudio/knn/mapper.R 5" \
-file /home/rstudio/knn/reducer.R -reducer "Rscript /home/rstudio/knn/reducer.R" \
-input /tmp/knn/* -output /tmp/knn2

hadoop fs -cat /tmp/knn2/* > dist_calc.csv