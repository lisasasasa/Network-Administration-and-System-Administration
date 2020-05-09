### Shell script
#### 1) judge.sh 
- mktemp : add and delete a temporary file
> MY_TEMP_FILE=`mktemp`
> rm ${MY_TEMP_FILE}
or 
> MY_TEMP_DIR=`mktemp -d`
> rm -fr ${MY_TEMP_DIR}
