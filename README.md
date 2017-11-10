# elanman
eLAN Manager for WHM servers  
# What is it
It's a tool that creates your private tool based on the data that you provide in your answer file.

## What does this playbook do
If you install ansible on a linux machine, clone this project and run the following commands:  
`cp managers.sample managers`  
`ansible-playbook -i managers elanman.yml`  
After a few minutes you will end up with the following playbook:  
https://github.com/ilanh/myelanman  
In ~/myelanman/  

If you cahnge ~/myelanman/answer.yml and re run the playbook command from this project,  
The content of ~/myelanman/ will change accordinly.

## Answer file structure  
The configurable options are at:  
https://raw.githubusercontent.com/ilanh/elanman/master/roles/common/vars/defaultobjects.yml  
Your answers will include:  
* Facts about your Organiztion  
* Values for the objects defined above  
* Roles that you want define differ  
* Assignments of values to roles/brands/regions/status

