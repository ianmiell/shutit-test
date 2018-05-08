from shutit import shutit_module

class test1(shutit_module.ShutItModule):

	def build(self, shutit):
		return True

def module():
		return test1(
			'bash_tests.test1.test1', 2010087968.0001,
			description='',
			maintainer='',
			delivery_methods=['ssh'],
			depends=['shutit.tk.setup']
		)
