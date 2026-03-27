# elanman
eLan Manager for WHM servers
# What is it
It's a tool that creates your private tool based on the data that you provide in your answer file.

## What does this playbook do
If you install ansible on a linux machine, clone this project and run the following commands:

### Quick Start
```bash
cp managers.sample managers
make setup
```

After a few minutes you will end up with the following playbook:
https://github.com/ilanh/myelanman
In ~/myelanman/
The layout and variables in the generated playbook are taken from:
https://raw.githubusercontent.com/ilanh/elanman/master/roles/common/files/answers.sample.yaml

### Sample Commands

#### Full setup (complete answer file)
```bash
make setup
```
Equivalent to: `ansible-playbook -i managers elanman.yaml`

#### Quick test with minimal configuration
```bash
make short
```
Equivalent to: `ansible-playbook -i managers -e "short=true" elanman.yaml`
This uses the minimal example (1 region, 1 brand, 1 node) for testing.

### Customization
If you change ~/myelanman/answer.yaml (copied on first run to an empty directory) and re-run the playbook command from this project, the content of ~/myelanman/ will change accordingly.

To customize from your own answer file, edit `~/myelanman/answer.yaml` with your server configuration and re-run `make setup`.

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
