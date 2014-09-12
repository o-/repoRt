require 'yaml'
require 'descriptive_statistics'

RUN = ARGV[0]

res = YAML::load_file("./results-#{RUN}.yaml")

f_run = File.open("runtime-#{RUN}.csv", 'w')

res.each do |data|
  new_runtime      = data[:new_runtime].collect {|r| r.to_f}
  baseline_runtime = data[:baseline_runtime].collect {|r| r.to_f}
  f_run.write("#{data[:benchmark]}, #{new_runtime.median}, #{new_runtime.variance}, #{baseline_runtime.median}, #{baseline_runtime.variance}\n")
end

f_run.close

`gnuplot -e 'set term png;set output "runtime-#{RUN}.png"; set datafile separator ",";set xtics rotate by -45;set style fill solid 1.00 border 0;set style histogram errorbars;set style data histogram;plot "runtime.csv" using 2:3:xtic(1) title "new gc", "runtime-#{RUN}.csv" using 4:5:xtic(1) title "baseline"'`
