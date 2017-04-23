from shutit_module import ShutItModule

class test1(ShutItModule):

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
