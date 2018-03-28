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

		# python3 first - more likely to fail
		shutit.login(command='vagrant ssh')
		shutit.login(command='sudo su -',password='vagrant')
		shutit.remove('python')
		shutit.install('python3 git docker.io python3-pip')
		shutit.send('git config --global user.email ian.miell@gmail.com')
		shutit.send('git config --global user.name "Ian Miell"')
		shutit.send_host_file('/root/.ssh/id_rsa.pub','/home/imiell/.ssh/id_rsa.pub')
		shutit.send_host_file('/root/.ssh/id_rsa','/home/imiell/.ssh/id_rsa')
		shutit.send('chmod 0400 /root/.ssh/id_rsa.pub')
		shutit.send('chmod 0400 /root/.ssh/id_rsa')
		shutit.multisend('git clone --depth=1 -b ' + shutit_branch + ' git@github.com:ianmiell/shutit && cd shutit',{'established':'yes'})
		shutit.send('pip3 install .')
		shutit.send('pip3 install coverage')
		shutit.send('cd ..')
		shutit.send('git clone git@github.com:ianmiell/shutit-test')
		shutit.send('cd shutit-test/test')
		#shutit.send('./bash_test.sh -l debug')
		shutit.send('./skeleton_test.sh -l debug')
		shutit.send('./docker_test.sh -l debug')
		shutit.send('./shutitfiles_test.sh')
		shutit.send('cd ..')
		shutit.send('mkdir -p python3')
		shutit.send('cd python3')
		shutit.send('find .. | grep coverage | grep -v coverage_html | xargs coverage combine')
		shutit.send('coverage html')
		shutit.send('git add ../python3')
		shutit.send('git commit -m "python3 test results" htmlcov')
		shutit.send('git push')
		shutit.logout()
		shutit.logout()

		# Then python 2
		shutit.send('vagrant destroy -f')
		shutit.send('vagrant up --provider virtualbox',timeout=99999)
		shutit.login(command='vagrant ssh')
		shutit.login(command='sudo su -',password='vagrant')
		shutit.install('git docker.io python-pip')
		shutit.send('git config --global user.email ian.miell@gmail.com')
		shutit.send('git config --global user.name "Ian Miell"')
		shutit.send_host_file('/root/.ssh/id_rsa.pub','/home/imiell/.ssh/id_rsa.pub')
		shutit.send_host_file('/root/.ssh/id_rsa','/home/imiell/.ssh/id_rsa')
		shutit.send('chmod 0400 /root/.ssh/id_rsa.pub')
		shutit.send('chmod 0400 /root/.ssh/id_rsa')
		shutit.multisend('git clone --depth=1 -b ' + shutit_branch + ' git@github.com:ianmiell/shutit && cd shutit',{'established':'yes'})
		shutit.send('pip install .')
		shutit.send('pip install coverage')
		shutit.send('cd ..')
		shutit.send('git clone git@github.com:ianmiell/shutit-test')
		shutit.send('cd shutit-test/test')
		shutit.send('./bash_test.sh -l debug')
		shutit.send('./skeleton_test.sh -l debug')
		shutit.send('./docker_test.sh -l debug')
		# Times out on Jenkins?
		#shutit.send('./shutitfiles_test.sh -l debug')
		shutit.send('cd ..')
		shutit.send('mkdir -p python2')
		shutit.send('cd python2')
		shutit.send('find .. | grep coverage | grep -v coverage_html | xargs coverage combine')
		shutit.send('coverage html')
		shutit.send('git add ../python2')
		shutit.send('git commit -m "python2 test results" htmlcov')
		shutit.send('git push')
		shutit.logout()
		shutit.logout()
		shutit.send('vagrant destroy -f')
		return True

	def get_config(self, shutit):
		shutit.get_config(self.module_id,'vagrant_image',default='ubuntu/xenial64')
		shutit.get_config(self.module_id,'vagrant_provider',default='virtualbox')
		shutit.get_config(self.module_id,'shutit_branch',default='master')
		return True

def module():
	return shutit_test(
		'tk.shutit.shutit_test', 1845506479.0001,
		description='',
		maintainer='',
		delivery_methods=['bash'],
		depends=['shutit.tk.setup','shutit-library.virtualbox.virtualbox.virtualbox','tk.shutit.vagrant.vagrant.vagrant']
	)
