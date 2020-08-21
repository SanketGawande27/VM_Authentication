# VM_Authentication

     I wrote a script to get the failure login Attempts on VM machine. I get the details of Username,IPAddress, and Count of Failure Login Attempts.
            After Executing a Script it creates a text file. It creates a text file 'failrecords.txt' contents the username, IPAddress, 
            and count of failure Attempts who are failed to login. All the records is sorted and send it to text file 
            and shows the records that the user who are failed to login in whith in 30 min. 
            VM_Authentication script Assess the auth.log file that contents the login and session records of our system. 
            The scripts counts the failure login Attempts and sent it to failrecords.txt file with uername, IPAddress and Count of Failed Attempts who are 
            continously failed to login in within a time span.
            
            
      Output file shows like:      
     
     
*************************************************************************************
| 	  FailureCount	      	|	IpAddress		      |	Username	
*************************************************************************************
|		      4	              	|	192.168.43.225		|	root		
|		      5	              	|	192.168.43.126		|	sanket		
|		      5		              |	192.168.43.133		|	sanketSK		
|		      7		              |	192.168.43.133		|	sanketGawande   
*************************************************************************************
