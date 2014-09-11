gnuplot -e 'set key bottom; set term png;set output "shootout_binary-trees.png";plot "shootout_binary-trees_new-gc_mmap.log","shootout_binary-trees_baseline.log";'
gnuplot -e 'set key bottom; set term png;set output "benchR_bin-packing.png";plot "benchR_bin-packing_new-gc_mmap.log","benchR_bin-packing_baseline.log";'
