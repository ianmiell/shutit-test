from shutit_module import ShutItModule

class test3(ShutItModule):

	def build(self, shutit):
		s1=shutit.create_session()
		s1out=s1.send_and_get_output('echo $$')
		s2=shutit.create_session()
		s2out=s2.send_and_get_output('echo $$')
		assert s1out != s2out
		return True

def module():
		return test3(
			'bash_tests.test3.test3', 2010087968.00011256,
			description='',
			maintainer='',
			delivery_methods=['bash'],
			depends=['shutit.tk.setup']
		)
