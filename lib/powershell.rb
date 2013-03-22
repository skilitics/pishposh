require 'active_support/core_ext/string/inflections'

class PowershellCommand
  attr_accessor :script, :working_directory, :execution_policy, :script_parameters

  def initialize(script = nil)
    @script = script
    @working_directory = '.'
  end

  def parameters
    params = []

    if execution_policy == :remote_signed
      params.push('-ExecutionPolicy', 'RemoteSigned')
    end

    params.join(' ')
  end

  def command
    params = []

    params.push("#{script.gsub(working_directory, '.')}.ps1")

    script_parameters.each do |param, value|
      switch_name = param.to_s.camelize(:upper)

      # The value is wrapped in single quotes. Any single quotes it contains are escaped with another single quote.
      escaped_value = "'#{value.gsub("'", "''")}'"

      params.push("-#{switch_name}", escaped_value)
    end

    params.join(' ')
  end

  def encoded_command
    utf16 = command.encode('UTF-16LE')
    Base64.strict_encode64(utf16)
  end

  def execute
    full_command = "powershell #{parameters} -EncodedCommand #{encoded_command}"
    #full_command = "powershell #{parameters} #{command}"

    Dir.chdir working_directory do
      system(full_command)
    end
  end
end

def powershell(script)
  command = PowershellCommand.new(script)

  if block_given?
    yield command
  end

  command.execute
end