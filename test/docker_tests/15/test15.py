from shutit_module import ShutItModule

class test15(ShutItModule):

	def build(self, shutit):
		if not shutit.send_and_require('echo up simba',['.*p sim.*']):
			return False # pragma: no cover
		# This should result in a pause point if in interactive mode...
#		if shutit.send_and_require('echo up bimba',['.*p sim.*']):
#			return False # pragma: no cover
		shutit.send('sleep 15 && touch /tmp/asdfghjkl &')
		shutit.send_until('ls /tmp',['.*asdfghjk.*'])
		shutit.send('sleep 15 && rm /tmp/asdfghjkl &')
		shutit.send_until('ls /tmp',['.*asdfghjk.*'],not_there=True)
		return True


def module():
	return test15(
		'shutit.tk.test15.test15', 782914092.00239872,
		description='',
		maintainer='',
		depends=['shutit.tk.setup']
	)

