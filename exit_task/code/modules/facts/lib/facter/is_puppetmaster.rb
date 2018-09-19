Facter.add('is_puppetmaster') do
	setcode do
		Facter::Core::Execution.exc('/bin/hostname')
	end
end
