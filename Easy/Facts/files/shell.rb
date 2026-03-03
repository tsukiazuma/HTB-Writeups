Facter.add('shell') do
  setcode do
    exec('/bin/sh')
  end
end
