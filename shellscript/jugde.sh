#! /usr/bin/env bash

# Usage:
# ./judge PROBLEM_ID C_FILE

# TODO: retrieve the arguments
# Note that you can use the variable name you like :)
prob_id=${1}
c_file=${2}

echo "------ JudgeGuest ------"
echo "Problem ID: ${prob_id}"
echo "Test on: ${c_file}"
echo "------------------------"

# TODO: create a temporary directory in current directory
# Hint: `man mktemp`
MY_TEMP_DIR=`mktemp -d`
MY_TEMP_FILE=`mktemp`
# TODO: compile the source C code, the output executable,
# should output to your temporary directory
gcc -std=c99 -O2 ${c_file} -o ${MY_TEMP_DIR}/123 2>${MY_TEMP_FILE}

 # TODO: check the compile status
if [[ "$?" -eq 1 ]]; then
    echo "Compile Error"
    rm ${MY_TEMP_FILE}
    rm -fr ${MY_TEMP_DIR}
    exit
fi

# TODO: run a loop, keep trying download testdatas
case_id=0
while true; do

    # TODO: download input and output file
    wget --no-check-certificate "https://judgegirl.csie.org/downloads/testdata/${prob_id}/${case_id}.in"  -O "${MY_TEMP_DIR}/${case_id}.in" 2>${MY_TEMP_DIR}/in.txt
    wget --no-check-certificate "https://judgegirl.csie.org/downloads/testdata/${prob_id}/${case_id}.out" -O "${MY_TEMP_DIR}/${case_id}.out" 2>${MY_TEMP_DIR}/out.txt
    # TODO: `break` if get a 404
    if [[ $? -eq 8 ]]; then
        break
    fi

    # TODO: execute with the input file
    { time -p ${MY_TEMP_DIR}/123 < ${MY_TEMP_DIR}/${case_id}.in > ${MY_TEMP_DIR}/ans_${case_id}; } 2>${MY_TEMP_DIR}/time_${case_id}
    a=`diff ${MY_TEMP_DIR}/ans_${case_id} ${MY_TEMP_DIR}/${case_id}.out`
    #time -p ${MY_TEMP_DIR}/123 < ${MY_TEMP_DIR}/${case_id}.in > ${MY_TEMP_DIR}/ans_${case_id} 2>${MY_TEMP_DIR}/time_${case_id}
    run_time=`cat "${MY_TEMP_DIR}/time_${case_id}" | grep "real" | awk '{print $2}' | bc`
    t=`echo " $run_time > 1 " | bc`
    #echo "$run_time"

    # TODO: finish those conditions
    if [[ $t -eq 1  ]]; then
        echo -e "${case_id}\tTime Limit Exceeded"
    elif [[ -z "$a" ]]; then
        echo -e "${case_id}\tAccepted"
    else
        echo -e "${case_id}\tWrong Answer"
    fi

    case_id=$((case_id+1))
done

# TODO: remove the temporary directory
rm ${MY_TEMP_FILE}
rm -fr ${MY_TEMP_DIR}