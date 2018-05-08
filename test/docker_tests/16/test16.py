from shutit import shutit_module

class test16(shutit_module.ShutItModule):

	def build(self, shutit):
		shutit.login()
		shutit.login(command='bash')
		shutit.send('ls',note='We are listing files')
		shutit.logout()
		shutit.logout()
		return True

def module():
	return test16(
		'shutit.test16.test16.test16', 210790650.002938762,
		description='',
		maintainer='',
		depends=['shutit.tk.setup']
	)

