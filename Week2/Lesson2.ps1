#documentation

#PowerShell has built in Documentation. For this reason we will explore the Get-Help cmdlet. 

#First lets update our local help. 
Update-Help

#Next we will look at the help for a cmdlet. 
Get-Help Get-Item
#to get more info we use the -Full switch
Get-Help Get-Item -Full
#We can also use the -Online switch to view the online documentation. 
Get-Help Get-Item -Online

#There are also help topics that start with about. Lets look at the about topics. 
Get-Help about*
#There are a lot of about_ topics. Lets look at about_variables since we learned about variables last week. 
Get-Help about_Variables
#Since this gave us the local version. That can be hard to read for longer items. Lets look at it online. 





