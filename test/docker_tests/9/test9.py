from shutit_module import ShutItModule

class test9(ShutItModule):

	def build(self, shutit):
		return True

def module():
	return test9(
		'shutit.tk.test9.test9', 782914092.009,
		description='',
		maintainer='',
		depends=['shutit.tk.setup']
	)

