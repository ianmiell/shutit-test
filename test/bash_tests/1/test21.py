from shutit import shutit_module
import time

class test21(shutit_module.ShutItModule):

	def build(self, shutit):
		shutit.send('ping -c 1 -t 1 shutit.tk',follow_on_commands={'.*0 packets received.*':'echo error > /tmp/shutittk_pingres','.*1 packets received.*':'echo ok > /tmp/shutittk_pingres','.*Unknown host.*':'echo unknown > /tmp/shutittk_pingres'},check_exit=False)
		shutit.send('ping -c 1 -t 1 asdasd',follow_on_commands={'.*0 packets received.*':'echo error > /tmp/bogus_pingres','.*1 packets received.*':'echo ok > /tmp/bogus_pingres','.*Unknown host.*':'echo unknown > /tmp/bogus_pingres'},check_exit=False)
		#shutit.send('ping -c 1 -t 1 bbc.co.uk',follow_on_commands={'.*0 packets received.*':'echo error > /tmp/bbc_pingres','.*1 packets received.*':'echo ok > /tmp/bbc_pingres','.*Unknown host.*':'echo unknown > /tmp/bbc_pingres'},check_exit=False)
		output=shutit.send_and_get_output('cat /tmp/*pingres')
		assert output == '''ok
unknown
error'''
		return True

def module():
	return test21(
		'tk.shutit.test21', 1845506479.0001339683,
		description='',
		maintainer='',
		delivery_methods=['bash'],
		depends=['shutit.tk.setup']
	)
