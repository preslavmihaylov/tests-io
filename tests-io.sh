#!/bin/bash

PWD=$(dirname "$0")

# check if program exists
if ! which $1 >/dev/null; then
    echo "program $1 not found"
    exit
fi

OUTPUT_DIR=${PWD}/output
INPUT_DIR=${PWD}/input

# traverse all files which match pattern test-input-{some number}
for INPUT_FILE in $(ls ${INPUT_DIR} | grep "test-[0-9]\+$"); do 
    OUTPUT_FILE=$OUTPUT_DIR/${INPUT_FILE}.out
    EXPECTED_FILE=${INPUT_DIR}/${INPUT_FILE}.exp
    INPUT_FILE=${INPUT_DIR}/${INPUT_FILE}

    # if directory doesn't exist, create it
    if ! [ -d $OUTPUT_DIR ]; then
        mkdir $OUTPUT_DIR
    fi
    

    # Execute program with stdin=INPUT_FILE, stdout=OUTPUT_FILE
    $1 < $INPUT_FILE > $OUTPUT_FILE

    # store contents of files in variables
    OUTPUT=$(<$OUTPUT_FILE)
    EXPECTED=$(<$EXPECTED_FILE)

    # color the output nicely
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    CYAN='\033[0;36m'
    NC='\033[0m'

    # see if test passed
    if [[ $OUTPUT == $EXPECTED ]]; then
        echo -e "${GREEN}Test $INPUT_FILE passed${NC}"
    else
        # if not, print a user-friendly message for differences
        echo -e "${RED}Test $INPUT_FILE failed${NC}"
       
        echo -e "${CYAN}Actual:${NC} "
        printf "$OUTPUT\n"
        
        echo -e "\n${CYAN}Expected:${NC} "

        # if output file is empty, print "(empty)" instead
        if [ -z $EXPECTED ]; then
            printf "(empty)\n\n"
        else
            printf "$EXPECTED\n\n"
        fi
    fi
done
