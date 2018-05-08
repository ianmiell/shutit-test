from shutit import shutit_module

class test9(shutit_module.ShutItModule):

	def build(self, shutit):
		return True

def module():
	return test9(
		'shutit.tk.test9.test9', 782914092.009,
		description='',
		maintainer='',
		depends=['shutit.tk.setup']
	)

