from shutit import shutit_module
import os

class test23(shutit_module.ShutItModule):

	def build(self, shutit):
		shutit.send_host_dir('/','configs')
		shutit.send('ls -R /configs')
		if shutit.send_and_get_output('ls /configs | grep build.cnf | wc -l') != '1':
			shutit.fail('wrong number of files') # pragma: no cover
		shutit.send_host_dir('/contents',os.path.abspath(os.curdir + '/../..'))
		shutit.send('ls -R /contents')
		#shutit.pause_point('look around')
		return True

def module():
	return test23(
		'docker_tests.test23.test23', 319863921.0001,
		description='',
		maintainer='',
		delivery_methods=['docker'],
		depends=['shutit.tk.setup']
	)
