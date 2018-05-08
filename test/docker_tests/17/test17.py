from shutit import shutit_module

class test17(shutit_module.ShutItModule):

	def build(self, shutit):
		return True

def module():
	return test17(
		'test.test17.test17.test17', 101210181.00395286,
		description='',
		maintainer='',
		depends=['shutit.tk.setup']
	)

