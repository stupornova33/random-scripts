#extract a specific region of a specific fasta sequence  (ie nucleotides or amino acids 45-120)
#takes a fasta file, where the fasta sequences are contained on one line.
#must give the arguments in order after script 


file="$1"
seqname="$2"
start="$3"
end="$4"

str=`grep -A1 $seqname $file | tail -n 1`

echo ${str:$start:$end}
