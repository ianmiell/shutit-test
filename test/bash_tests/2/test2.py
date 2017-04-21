from shutit_module import ShutItModule

class test2(ShutItModule):


	def build(self, shutit):
		shutit.send('cd /space/git/git-101-tutorial')
		shutit.send('./run.sh -l CRITICAL',{'/tmp/x':'ls'})
		return True

def module():
		return test2(
			'bash_tests.test2.test2', 2010087968.0001,
			description='',
			maintainer='',
			delivery_methods=['bash'],
			depends=['shutit.tk.setup']
		)
