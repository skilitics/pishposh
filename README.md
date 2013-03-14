# PowerShell Wrapper

Usage

```Ruby
powershell 'Scripts/New-Organisation' do |cmd|
  cmd.working_directory = 'Scripts'
  cmd.execution_policy = :remote_signed
  cmd.script_parameters = {id: organization.id,
                           name: organization.name,
                           subdomain: organization.subdomain,
                           description: organization.description}
end
```