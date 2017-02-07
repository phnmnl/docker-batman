#!/bin/bash

cd /usr/local/bin

#download test data
mkdir runBATMAN
mkdir runBATMAN/BatmanInput
mkdir runBATMAN/BatmanInput/PureSpectraTemplate
mkdir runBATMAN/BatmanOnput
mkdir results
mkdir preResults

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/NMRdata.txt -O ./runBATMAN/BatmanInput/NMRdata.txt

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/batmanOptions.txt -O ./runBATMAN/BatmanInput/batmanOptions.txt

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/metabolitesList.csv -O ./runBATMAN/BatmanInput/metabolitesList.csv

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/multi_data_user.csv -O ./runBATMAN/BatmanInput/multi_data_user.csv

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/PureSpectraTemplate/L-Glutamic%20acid.txt -O "./runBATMAN/BatmanInput/PureSpectraTemplate/L-Glutamic acid.txt"

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/PureSpectraTemplate/L-Glutamine.txt -O ./runBATMAN/BatmanInput/PureSpectraTemplate/L-Glutamine.txt

#cp ./NMRdata.txt runBATMAN/BatmanInput
#cp ./batmanOptions.txt runBATMAN/BatmanInput
#cp ./multi_data_user.csv runBATMAN/BatmanInput
#cp ./metabolitesList.csv runBATMAN/BatmanInput
# run BATMAN
R -e "library(batman); bm<-batman()"

#Rscript /usr/local/bin/runBATMAN.R -i ./NMRdata.txt -o ./runResults -p ./batmanOptions.txt -u ./multi_data_user.csv -l ./metabolitesList.csv

#download results for comparison

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/results/specFit_1_rr_0.txt -O ./preResults/specFit_1_rr_0.txt

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/results/specFit_2_rr_0.txt -O ./preResults/specFit_2_rr_0.txt

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/results/specFit_3_rr_0.txt -O ./preResults/specFit_3_rr_0.txt

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/results/specFit_4_rr_0.txt -O ./preResults/specFit_4_rr_0.txt

wget https://raw.githubusercontent.com/jianlianggao/batman/develop/test_data/results/specFit_5_rr_0.txt -O ./preResults/specFit_5_rr_0.txt

#copy output files to specified folder for comparison
# find BATMAN output folder
found_subfolders=($(/bin/ls -R | grep '^[0-9]\{2\}_[A-Z,a-z]\{3\}_.*$'))
output_path="runBATMAN/BatmanOutput/$found_subfolders"
#output_path="results"


#run comparison

temp="$(diff "$output_path/specFit_1_rr_0.txt" "preResults/specFit_1_rr_0.txt")"

if [ ! -z "$temp" ]; then 
   echo "specFit_1_rr_0.txt are not equal"
   exit 1
else
   echo "specFit_1_rr_0.txt are equal"
fi

temp="$(diff "$output_path/specFit_2_rr_0.txt" "preResults/specFit_2_rr_0.txt")"

if [ ! -z "$temp" ]; then 
   echo "specFit_2_rr_0.txt are not equal"
   exit 1
else
   echo "specFit_2_rr_0.txt are equal"
fi

temp="$(diff "$output_path/specFit_3_rr_0.txt" "preResults/specFit_3_rr_0.txt")"

if [ ! -z "$temp" ]; then 
   echo "specFit_3_rr_0.txt are not equal"
   exit 1
else
   echo "specFit_3_rr_0.txt are equal"
fi

temp="$(diff "$output_path/specFit_4_rr_0.txt" "preResults/specFit_4_rr_0.txt")"

if [ ! -z "$temp" ]; then 
   echo "specFit_4_rr_0.txt are not equal"
   exit 1
else
   echo "specFit_4_rr_0.txt are equal"
fi

temp="$(diff "$output_path/specFit_5_rr_0.txt" "preResults/specFit_5_rr_0.txt")"

if [ ! -z "$temp" ]; then 
   echo "specFit_5_rr_0.txt are not equal"
   exit 1
else
   echo "specFit_5_rr_0.txt are equal"
fi

echo "All files created successfully"
