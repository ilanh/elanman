setup:
	ansible-playbook -i managers elanman.yaml
short:
	ansible-playbook -i managers -e "short=true" elanman.yaml