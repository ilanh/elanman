# elanman
eLan Manager for WHM servers  
# What is it
It's a tool that creates your private tool based on the data that you provide in your answer file.

## What does this playbook do
If you install ansible on a linux machine, clone this project and run the following commands:  
`cp managers.sample managers`  
`ansible-playbook -i managers elanman.yaml`  
After a few minutes you will end up with the following playbook:  
https://github.com/ilanh/myelanman  
In ~/myelanman/  
The layout and variables in the generated playbook are taken from:  
https://raw.githubusercontent.com/ilanh/elanman/master/roles/common/files/answers.sample.yaml  

If you cahnge ~/myelanman/answer.yaml (copied on first run to an empty directory) and re run the playbook command from this project,  
The content of ~/myelanman/ will change accordinly.

## Answer file structure  
The configurable options are at:  
https://raw.githubusercontent.com/ilanh/elanman/master/roles/common/vars/defaultobjects.yaml  


The whole playbook is will be organized with the following guides:  
* You define how your servers are organized in brands, regions, roles and logical groups  
* In the answer file there are configuration sections like firewall ports  
* In the sections there are configuration objects like 'tcp in ports'  
* For each object there are several possible values like '22,80,443' and '22,53,2087'  
* The values are assigned to brands, regions roles and logical groups  
  
using the data  
main vars, templates and tasks in the target playbook are generated with the relevant values for each group 
