from shutit_module import ShutItModule
import random
import string

class shutit_test(ShutItModule):

	def build(self, shutit):
		vagrant_image    = shutit.cfg[self.module_id]['vagrant_image']
		vagrant_provider = shutit.cfg[self.module_id]['vagrant_provider']
		shutit_branch    = shutit.cfg[self.module_id]['shutit_branch']
		module_name = 'shutit_test_' + ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(6))
		shutit.send('rm -rf /tmp/' + module_name + ' && mkdir -p /tmp/' + module_name + ' && cd /tmp/' + module_name)
		shutit.send('vagrant init ' + vagrant_image)
		shutit.send('vagrant up --provider virtualbox',timeout=99999)
		shutit.login(command='vagrant ssh')
		shutit.login(command='sudo su -',password='vagrant')

		shutit.install('git docker.io python-pip')
		shutit.send('git clone --depth=1 -b ' + shutit_branch + ' https://github.com/ianmiell/shutit && cd shutit')
		shutit.send('pip install .')
		shutit.send('cd ..')
		shutit.send('git clone https://github.com/ianmiell/shutit-test')
		shutit.send('cd shutit-test/test')
		shutit.pause_point('')
		shutit.send('./test.sh')

		shutit.logout()
		shutit.logout()
		return True

	def get_config(self, shutit):
		shutit.get_config(self.module_id,'vagrant_image',default='ubuntu/trusty64')
		shutit.get_config(self.module_id,'vagrant_provider',default='virtualbox')
		shutit.get_config(self.module_id,'shutit_branch',default='test')
		return True

def module():
	return shutit_test(
		'tk.shutit.shutit_test', 1845506479.0001,
		description='',
		maintainer='',
		delivery_methods=['bash'],
		depends=['shutit.tk.setup','shutit-library.virtualbox.virtualbox.virtualbox','tk.shutit.vagrant.vagrant.vagrant']
	)
