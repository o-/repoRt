# Src

The main repository is found at https://github.com/o-/Rexperiments

The new GC implementation resides in the branch new_gc, all data is based on 1c25a79d07666f649b04d07a9854928b37d1872a.

The baseline is svn commit 66436 (8276bb2108dcf6093f508b21e7e1f73d6d4213f6).

# Methodology

* Used scripts: https://github.com:o-/benchR (run-experiments, run-experiment.rb, run-suite)
* Intel(R) Core(TM) i5 CPU M 520  @ 2.40GHz
* 8 GB Ram
* Linux 3.14-2-amd64
* gcc (Debian 4.9.1-4) 4.9.1

# Benchmarks

The following two sources are used for benchmarks:

* benchR:  https://github.com/allr/benchR.git
* benchmarks: https://github.com/rbenchmark/benchmarks.git

# General Remarks

* Performance of both GCs comparable
* Directly using mmap to get aligned pages is slow
* posix_memalign is not usable (on linux) since it overcommits by roughly x2
* Heapsize is similar. New gc saves 2 pointers per object, but has more overhead. The overhead is due to the fact that in baseline gc the sizebuckets are powers-of-two of payload sizes, whereas in the new gc sizebuckets are powers-of-two bytesizes. The new GC sizebuckets align badly with list objects (36 bytes) and vectors of size 2 (36 bytes) both ending up in 64 byte space.

# Results: Comparing Heapsize

Overall Heapsize of the R process sequentially running a suite of benchmarks (megabytes vs. seconds).

![](https://raw.githubusercontent.com/o-/repoRt/master/data/memusg/memusg.png)

We see that the new gc using posix memalign terminates faster than baseline R, but uses twice as much memory. The memory available to the runtime is exactly the same in the posix memalign and the mmap version. This shows the potential performance of the new gc, but highlights the need for a two level memory manager to get large chunks of aligned memory from the OS.

Additionally we see the new gc (in the mmap version) using slightly more memory as baseline, even though we save two pointers per object. The reason is, that power of two byte-size buckets do not align well to actual R vectors. A better solution for heap segmentation would be required, or maybe differently sized objects should be allocated on the same page.

# Results: Comparing Runtime and GC time

## Runtime

Overall Wall time

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/runtime-mmap.png)

### Posix Memalign version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/runtime-posix-memalign.png)

## GC Time

Time spent in GC.

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_time-mmap.png)

Huge difference in nbody would need to be analyzed.

### Posix Memalign version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_time-posix-memalign.png)

## GC Cycles (logscale)

Number of GCs (minor & full)

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_cycles-mmap.png)

### Posix Memalign version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_cycles-posix-memalign.png)


