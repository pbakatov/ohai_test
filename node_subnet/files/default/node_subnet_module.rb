Ohai.plugin(:Hostname) do
  require "socket"
  require "ipaddr"

  provides "hostname", "ENV"
  
  def from_cmd_1(cmd1)
    so = shell_out(cmd1)
    so.stdout.split($/)[0]
  end
  
  def from_cmd_2(cmd2)
    so = shell_out(cmd2)
    so.stdout.split($/)[0]
  end 
  
    def resolve_fqdn
    hostname = from_cmd1("hostname")
    addrinfo = Socket.getaddrinfo(hostname, nil).first
    iaddr = IPAddr.new(addrinfo[3])
    Socket.gethostbyaddr(iaddr.hton)[0]
    rescue
    nil
  end
	
	
	def collect_hostname
    # Hostname is everything before the first dot
    if machinename
      machinename =~ /([^.]+)\.?/
      hostname $1
    elsif fqdn
      fqdn =~ /(.+?)\./
      hostname $1
    end
  end
  
    def collect_subnet
	 #10.17.163.245/21
	 subnet=from_cmd2("ip -o -f inet addr show | awk '/scope global/ {print $4}'")
	
    def parse_subnet
	 if subnet
	    subnet=~ ~ /(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\/21/
		ENV='DEV'
	 elsif 	subnet
  	    subnet=~ ~ /(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\/24/
		ENV='QA'
	 elsif 	subnet
        subnet=~ /(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\/28/
 		ENV='PRODUCTION'
    else
        ENV=is not defined
		end
	end
  end
end

  collect_data(:linux) do
    machinename from_cmd("hostname")
    fqdn resolve_fqdn
    collect_hostname
    collect_subnet
  end
