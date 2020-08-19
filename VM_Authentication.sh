# /!bin/bash

 function getdata()
{
   setDelimiter=' '
   read -a arr <<<"$sortdata"
   #echo "${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]} ${arr[4]} ${arr[5]} ${arr[6]} ${arr[7]} ${arr[8]}"
   userName="${arr[5]}"
	ipAddress="${arr[7]}"
	
	if [ "${arr[5]}" == "$userName" ]&&[ "${arr[7]}" == "$ipAddress" ];
	then
	   temp=$userName 
	   a=`expr $a + 1`
	       
	else 
	   b=$a
	   a=0
           echo "$b"
	fi
	
        echo "$a $userName $ipAddress" >> login_records.txt
   }     
         
 counterror=$(cat /home/sanket/Desktop/Auth.log |  grep "Failed password" | wc -l )

 if [ counterror > 3 ];
 then
    echo "Failed Attempts :" $counterror
  else
     echo "Every things is Fine"
  fi
  
  #Get data from Auth.log file
  error="Failed password"
  file="/home/sanket/Desktop/Auth.log" 
  IFS= ':'
   while read f1 f2 f3 f4
   do 
    
   if [[ "$f4" == *"$error"* ]] ;
   then
     sortdata="$f4"
     getdata
   fi
   done<"$file"
  # echo "$sortdata"
  echo "Data is successfully send to a Login_record file"
  
 
	
