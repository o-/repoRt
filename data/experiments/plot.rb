require 'yaml'
require 'descriptive_statistics'

RUN = ARGV[0]

res = YAML::load_file("./results-#{RUN}.yaml")

f_run = File.open("runtime-#{RUN}.csv", 'w')
f_gc  = File.open("gc_time-#{RUN}.csv", 'w')
f_cycles  = File.open("gc_cycles-#{RUN}.csv", 'w')

res.each do |data|
  new_runtime      = data[:new_runtime].collect {|r| r.to_f}
  baseline_runtime = data[:baseline_runtime].collect {|r| r.to_f}

  new_gc = data[:new_percent_gc_time].to_f * new_runtime.median
  baseline_gc = data[:baseline_percent_gc_time].to_f * baseline_runtime.median

  new_cycles = data[:new_gc_cycles].to_f
  baseline_cycles = data[:baseline_gc_cycles].to_f

  f_run.write("#{data[:benchmark]}, #{new_runtime.median}, #{new_runtime.variance}, #{baseline_runtime.median}, #{baseline_runtime.variance}\n")
  f_gc.write("#{data[:benchmark]}, #{new_gc}, #{baseline_gc}\n")
  f_cycles.write("#{data[:benchmark]}, #{new_cycles}, #{baseline_cycles}\n")
end

f_run.close
f_gc.close
f_cycles.close

`gnuplot -e 'set term png;set output "runtime-#{RUN}.png"; set datafile separator ",";set xtics rotate by -45;set style fill solid 1.00 border 0;set style histogram errorbars;set style data histogram;plot "runtime-#{RUN}.csv" using 2:3:xtic(1) title "new gc", "runtime-#{RUN}.csv" using 4:5:xtic(1) title "baseline"'`

`gnuplot -e 'set term png;set output "gc_time-#{RUN}.png"; set datafile separator ",";set xtics rotate by -45;set style fill solid 1.00 border 0;set style histogram;set style data histogram;plot "gc_time-#{RUN}.csv" using 2:xtic(1) title "new gc", "gc_time-#{RUN}.csv" using 3:xtic(1) title "baseline"'`

`gnuplot -e 'set logscale y;set term png;set output "gc_cycles-#{RUN}.png"; set datafile separator ",";set xtics rotate by -45;set style fill solid 1.00 border 0;set style histogram;set style data histogram;plot "gc_cycles-#{RUN}.csv" using 2:xtic(1) title "new gc", "gc_cycles-#{RUN}.csv" using 3:xtic(1) title "baseline"'`
