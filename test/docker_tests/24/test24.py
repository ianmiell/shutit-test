from shutit_module import ShutItModule

class test24(ShutItModule):


	def build(self, shutit):
		# Cover code that was not coveraged
		# Use centos, to exercise that one
		shutit.install('notexists',note='this should fail')
		shutit.install('less',note='this should be installed already')
		shutit.install('less',note='def now')
		shutit.remove('less',note='def now')
		shutit.send_and_get_output('ls',preserve_newline=True)
		shutit.get_memory()
		shutit.multisend('ls',{},expect='test24')
		shutit.send_until('pwd','.*',debug_command='echo ok',pause_point_on_fail=False)
		return True

def module():
	return test24(
		'23.test24.test24', 1440297589.0001124938241,
		description='',
		maintainer='',
		delivery_methods=['docker'],
		depends=['shutit.tk.setup']
	)
