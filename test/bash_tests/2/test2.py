from shutit_module import ShutItModule

class test2(ShutItModule):


	def build(self, shutit):
		shutit.send('git clone https://github.com/ianmiell/git-101-tutorial')
		shutit.send('pushd git-101-tutorial')
		orig_expect = shutit.get_default_shutit_pexpect_session_expect()
		new_expect = ':.*:.*# '
		shutit.set_default_shutit_pexpect_session_expect(new_expect)
		shutit.send('./run.sh -l DEBUG',check_exit=False)
		shutit.send('\x1D',nonewline=True,check_exit=False)
		shutit.send('\x1D',nonewline=True,check_exit=False)
		shutit.send('\x1D',nonewline=True,check_exit=False)
		shutit.send('\x1D',nonewline=True,check_exit=False)
		shutit.send('\x1D',nonewline=True,check_exit=False)
		shutit.send('\x1D',nonewline=True,check_exit=False)
		shutit.send('\x1D',nonewline=True,check_exit=False)
		shutit.send('\x1D',nonewline=True,check_exit=False,expect='test2.test2')
		shutit.send('popd')
		shutit.send('rm -rf git-101-tutorial')
		return True

def module():
		return test2(
			'bash_tests.test2.test2', 2010087968.0001,
			description='',
			maintainer='',
			delivery_methods=['bash'],
			depends=['shutit.tk.setup']
		)
