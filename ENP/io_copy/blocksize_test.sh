#!/bin/bash

fileSize=1000000000
maxBlockSize=10000000

blocksize=2;
until [ $blocksize -gt $maxBlockSize ]
do

  ./io_creat "testfile_$blocksize" "$fileSize"

  mytime="$( ( time  ./iocopymalloc "$blocksize" < "testfile_$blocksize" > output ) 2>&1 >/dev/null)"
  echo "$blocksize, $mytime"

  rm "testfile_$blocksize"

  ((blocksize=blocksize*2))
done

# output:
# 2:
# real	20m29.672s
# user	4m15.006s
# sys	16m10.533s
# 4:
# real	9m19.621s
# user	2m1.350s
# sys	7m16.616s
# 8:
# real	5m45.194s
# user	1m7.634s
# sys	4m35.898s
# 16:
# real	2m53.611s
# user	0m33.936s
# sys	2m18.670s
# 32:
# real	1m26.300s
# user	0m17.093s
# sys	1m8.580s
# 64:
# real	0m45.005s
# user	0m8.433s
# sys	0m35.073s
# 128:
# real	0m24.163s
# user	0m4.255s
# sys	0m17.903s
# 256:
# real	0m14.022s
# user	0m2.107s
# sys	0m9.742s
# 512:
# real	0m8.520s
# user	0m1.053s
# sys	0m5.135s
# 1024:
# real	0m6.000s
# user	0m0.532s
# sys	0m2.986s
# 2048:
# real	0m4.576s
# user	0m0.258s
# sys	0m1.979s
# 4096:
# real	0m3.911s
# user	0m0.151s
# sys	0m1.397s
# 8192:
# real	0m3.662s
# user	0m0.064s
# sys	0m1.229s
# 16384:
# real	0m3.552s
# user	0m0.052s
# sys	0m1.110s
# 32768:
# real	0m3.446s
# user	0m0.013s
# sys	0m1.080s
# 65536:
# real	0m3.462s
# user	0m0.015s
# sys	0m1.066s
# 131072:
# real	0m3.487s
# user	0m0.007s
# sys	0m1.058s
# 262144:
# real	0m3.378s
# user	0m0.003s
# sys	0m1.046s
# 524288:
# real	0m3.474s
# user	0m0.005s
# sys	0m1.061s
# 1048576:
# real	0m3.566s
# user	0m0.004s
# sys	0m1.174s
# 2097152:
# real	0m3.579s
# user	0m0.003s
# sys	0m1.182s
# 4194304:
# real	0m3.661s
# user	0m0.003s
# sys	0m1.282s
