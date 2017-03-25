from shutit_module import ShutItModule

class test23(ShutItModule):


	def build(self, shutit):
		shutit.send_host_dir('/configs','configs')
		shutit.send('ls -R /configs')
		return True

def module():
	return test23(
		'docker_tests.test23.test23', 319863921.0001,
		description='',
		maintainer='',
		delivery_methods=['docker'],
		depends=['shutit.tk.setup']
	)
