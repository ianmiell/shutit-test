from shutit_module import ShutItModule

class test22(ShutItModule):


	def build(self, shutit):
		shutit.login('bash')
		shutit.logout()
		# This should not succeed, as login should fail.
		if shutit.login('nonsense',fail_on_fail=False):
			return False
		return True

def module():
	return test22(
		'test.test22.test22', 1565523721.0001,
		description='',
		maintainer='',
		delivery_methods=['docker'],
		depends=['shutit.tk.setup']
	)
