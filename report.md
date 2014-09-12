# Src

The main repository is found at https://github.com/o-/Rexperiments

The new GC implementation resides in the branch new_gc, all data is based on 1c25a79d07666f649b04d07a9854928b37d1872a.

The baseline is svn commit 66436 (8276bb2108dcf6093f508b21e7e1f73d6d4213f6).

# Recording

For tools see: https://github.com:o-/benchR (run-experiments, run-experiment.rb)

# Benchmarks

The following two sources are used for benchmarks:

* benchR:  https://github.com/allr/benchR.git
* benchmarks: https://github.com/rbenchmark/benchmarks.git

# Results

## Runtime

Overall Wall time

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/runtime-mmap.png)

## GC Time

Time spent in GC

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_time-mmap.png)

## GC Cycles

Number of GCs (minor & full)

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_cycles-mmap.png)
