 #! /bin/bash
 

 validtime()
 {
  
    IFS=':' read -r -a t1 <<< "$stime"
    IFS=':' read -r -a t2 <<< "$etime"
    t1=("${t1[@]##0}")
    t2=("${t2[@]##0}")
    if (( t1[0] > t2[0] || ( t1[0] == t2[0] && t1[1] > t2[1]) ))
    then
  	if (( t1[1] < t2[1] ))
  	then
   	  (( t1[1] += 60 ))
   	  (( t1[0] -- ))
  	fi
    Hr=$(( t1[0]-t2[0] ))
    min=$(( t1[1] - t2[1] ))
   # echo $Hr
    #echo $min
    fi
}    
    
 data()
{   
       setDelimiter=' '
	if [[ "$username" == *"$userName"* ]]&&[[ "$ipaddress" == *"$ipAddress"* ]]&&[[ "$Hr" -le "00" ]]&&[[ "$min" -le "30" ]]
 	then
	   a=`expr $a + 1`
	elif [[ "$username" != *"$userName"* ]]||[[ "$ipaddress" != *"$ipAddress"* ]]||[[ "$Hr" -le "00" ]]||[[ "$min" -le "30" ]]
	then
	   if [[ $a -ge 3 ]]
	   then
	     echo "$a		$userName		$ipAddress">>failrecords.txt
	   fi
	   a=1
	   userName="$username"
	   ipAddress="$ipaddress"
	   etime=$stime
	fi
}
  

 
 
 #******************start of script****************# 
 
 #declaration
 error="Failed password"
 file="/home/sanket/Desktop/Auth.log"
 
 #count attempts
 counterror=$(cat /home/sanket/Desktop/Auth.log |  grep "Failed password" | wc -l )
 
 #check total failure attemts
 if [ counterror > 3 ];
 then
    echo "Failed Attempts :" $counterror
  else
     echo "Every things is Fine"
     exit
  fi
 
 #create a text file failrecords 
  touch failrecords.txt
  echo "FailureCount	   Username	   IpAddress ">>failrecords.txt
 
  #set username, ip address, and time
  #TOP=$(cat Auth.log | head -1)
  TOP=`head -1 $file`
  if [[ "$TOP" == *"$error"* ]]
	then 
	  attempts="$TOP"
	  array=($attempts)
	  userName="${arr[8]}"
	  ipAddress="${arr[10]}"
	  stime=${arr[2]}
	fi
	
   #set time	
   while IFS=" " read w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14
    do 
    	if [ "$w6" == "Failed" ]&&[ "$w7" == "password" ]
	 then
	     etime=$w3
	     stime=$w3
	     userName=$w9
             ipAddress=$w11
	      #validtime
	      #data
	       #echo "$a $etime $uname   $ip"
	     break
	  fi
    done <"$file"
    
    while IFS=" " read ww1 ww2 ww3 ww4 ww5 ww6 ww7 ww8 ww9 ww10 ww11 ww12 ww13 ww14
    do 
    	if [ "$ww6" == "Failed" ]&&[ "$ww7" == "password" ]
   	 then
   	    	  stime=$ww3
	    	  username=$ww9
                 ipaddress=$ww11
	    	   validtime
	   	   data
	       
	 fi
   done <"$file"
   
    if [ $a -ge 3 ];
     then 
         echo "$a		$userName		$ipAddress">>failrecords.txt
         echo "Done ...... "
         echo "Failure Attempts are send to Failrecords.txt file "
         fi
   
    
