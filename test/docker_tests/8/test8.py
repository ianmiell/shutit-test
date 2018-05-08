from shutit import shutit_module

class test8(shutit_module.ShutItModule):

	def build(self, shutit):
		shutit.add_line_to_file(['asd'],'/tmp/asd')
		shutit.add_line_to_file('asd2','/tmp/asd2')
		shutit.add_line_to_file('asd2','/tmp/asd2')
		shutit.add_line_to_file(['asd3','asd4'],'/tmp/asd2')
		res = shutit.send_and_get_output("""wc -l /tmp/asd2 | awk '{print $1}'""")
		if res != '3':
			shutit.fail('expected 3') # pragma: no cover
		return True

def module():
	return test8(
		'shutit.tk.test8.test8', 782914092.008,
		description='',
		maintainer='',
		depends=['shutit.tk.setup']
	)

