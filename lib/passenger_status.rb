module PassengerStatus
	#Passenger Status
	def self.passgener_stat
		pass_stat = Hash.new
		status = `rvmsudo passenger-status`
		unless $?.success?
			return("Error executing commmand")
			exit 1
		end

		status =~ /max\s+=\s+(\d+)/
		pass_stat[:max] = $1

		status =~ /count\s+=\s+(\d+)/
		pass_stat[:count] = $1

		status =~ /active\s+=\s+(\d+)/
		pass_stat[:active] = $1

		status =~ /inactive\s+=\s+(\d+)/
		pass_stat[:inactive] = $1

		status =~ /(Waiting on global queue:)\s+(\d+)/ 
		pass_stat[:queued] = $2

		status =~ /\Sessions:\s+(\d+)/
		pass_stat[:sessions] = $1
	 
		status =~ /\Processed:\s+(\d+)/
		pass_stat[:processed] = $1

		return(pass_stat)
	end

	#Passenger Memory Stats
	def self.passenger_memory
		
		pass_mem = Hash.new
		mem_status = `rvmsudo passenger-memory-stats`
		unless $?.success?
			return("Error executing commmand")
			exit 1
		end
		#There must be a better way

		#PassengerWatchdog
		mem_status =~ /(^.*?PassengerWatchdog)/
		watch_dog = $1.scan(/([0-9]+.[0-9])+/)
		watch_vm = watch_dog[1]
		watch_private = watch_dog[2]
		pass_mem[:PassengerWatchdog] = {:vm_size=>watch_vm,:private=>watch_private}

		#PassengerHelperAgent
		mem_status =~ /(^.*?PassengerHelperAgent)/
		helper_agent = $1.scan(/([0-9]+.[0-9])+/)
		helper_vm = helper_agent[1]
		helper_private = helper_agent[2]
		pass_mem[:PassengerHelperAgent] = {:vm_size=>helper_vm,:private=>helper_private}
		#Passenger spawn server
		mem_status =~ /(^.*?Passenger spawn server)/
		spawn_server = $1.scan(/([0-9]+.[0-9])+/)
		spawn_vm = spawn_server[1]
		spawn_private = spawn_server[2]
		pass_mem[:PassengerSpawnServer] = {:vm_size=>spawn_vm,:private=>spawn_private}

		#PassengerLoggingAgent
		mem_status =~ /(^.*?PassengerLoggingAgent)/
		logging_agent = $1.scan(/([0-9]+.[0-9])+/)
		logging_vm = logging_agent[1]
		logging_private = logging_agent[2]
		pass_mem[:PassengerSpawnServer] = {:vm_size=>spawn_vm,:private=>spawn_private}
		
		#Rack
		#Assume only one application is running
		mem_status =~ /(^.*?Rack)/
		rack = $1.scan(/([0-9]+.[0-9])+/)
		rack_vm = rack[1]
		rack_private = rack[2]
		pass_mem[:Rack] = {:vm_size=>rack_vm,:private=>rack_private}
		return(pass_mem)

	end
end





