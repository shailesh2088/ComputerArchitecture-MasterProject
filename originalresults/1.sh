#!/bin/bash

#Script for setting up Simplescalar Executible Directories
echo "HELLO ${LOGNAME}"
echo "IDIR =  $IDIR"
echo "HOST = $HOST"
echo "TARGET = $TARGET"

#Simplescalar alpha binaries
cd $IDIR/simplesim-3.0
make config-alpha
cd /home/vijay/

#Script to input Cache details
il1size=2
il1bsize=32
il1assoc=1
il1repl=l
il1latcyc=1
declare -i il1temp=0
il1temp=$((il1bsize*il1assoc))
il1nsets=$((il1size*1024/il1temp))
il1config="il1:$il1nsets:$il1bsize:$il1assoc:$il1repl"
echo "il1config = $il1config"

dl1size=2
dl1bsize=32
dl1assoc=1
dl1repl=l
dl1latcyc=1
declare -i dl1temp=0
dl1temp=$((dl1bsize*dl1assoc))
dl1nsets=$((dl1size*1024/dl1temp))
dl1config="dl1:$dl1nsets:$dl1bsize:$dl1assoc:$dl1repl"
echo "dl1config = $dl1config"

dl2size=512
dl2bsize=128
dl2assoc=4
dl2repl=l
dl2latcyc=20
declare -i dl2temp=0
dl2temp=$((dl2bsize*dl2assoc))
dl2nsets=$((dl2size*1024/dl2temp))
dl2config="dl2:$dl2nsets:$dl2bsize:$dl2assoc:$dl2repl"
echo "dl2config = $dl2config"

declare -i first=100
declare -i next=5
echo "Memory Latencies: 1st: $first  next: $next"

#Script to compile the benchmarks
#$IDIR/bin/sslittle-na-sstrix-gcc -o filename /home/vijay/Hello.c

#Script to run Sim-Outorder program for L1 data and Instruction Cache and Unified L2 Cache
$IDIR/simplesim-3.0/sim-outorder -cache:il1 $il1config -cache:il1lat $il1latcyc -cache:dl1 $dl1config -cache:dl1lat $dl1latcyc -cache:il2 dl2 -cache:dl2 $dl2config -cache:dl2lat $dl2latcyc -mem:lat $first $next -redir:sim /home/vijay/Results/gzip.out -redir:prog /home/vijay/Results/gzip.prog -max:inst 50000000 $IDIR/cint2000eio/gzip.eio

$IDIR/simplesim-3.0/sim-outorder -cache:il1 $il1config -cache:il1lat $il1latcyc -cache:dl1 $dl1config -cache:dl1lat $dl1latcyc -cache:il2 dl2 -cache:dl2 $dl2config -cache:dl2lat $dl2latcyc -mem:lat $first $next -redir:sim /home/vijay/Results/gcc.out -redir:prog /home/vijay/Results/gcc.prog -max:inst 50000000 $IDIR/cint2000eio/gcc.eio

$IDIR/simplesim-3.0/sim-outorder -cache:il1 $il1config -cache:il1lat $il1latcyc -cache:dl1 $dl1config -cache:dl1lat $dl1latcyc -cache:il2 dl2 -cache:dl2 $dl2config -cache:dl2lat $dl2latcyc -mem:lat $first $next -redir:sim /home/vijay/Results/lucas.out -redir:prog /home/vijay/Results/lucas.prog -max:inst 50000000 $IDIR/cfp2000eio/lucas.eio

$IDIR/simplesim-3.0/sim-outorder -cache:il1 $il1config -cache:il1lat $il1latcyc -cache:dl1 $dl1config -cache:dl1lat $dl1latcyc -cache:il2 dl2 -cache:dl2 $dl2config -cache:dl2lat $dl2latcyc -mem:lat $first $next -redir:sim /home/vijay/Results/equake.out -redir:prog /home/vijay/Results/equake.prog -max:inst 50000000 $IDIR/cfp2000eio/equake.eio
