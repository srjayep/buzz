require_relative 'buzz'

class BuzzMain
	def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
  end

  def execute!
    # your code here, assign a value to exitstatus
    Buzz.start @argv
    puts "SHIT #{@argv}"
    @kernel.exit(0)
  end
end