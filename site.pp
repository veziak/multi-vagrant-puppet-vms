node default {
# Test message
  notify { "Debug output on ${hostname} node.": }

  file { "/tmp/inetd.conf":
    content => 'ssssss',
  }

  include ntp, git
}

node 'node01.example.com', 'node02.example.com' {
# Test message
  notify { "Debug output on ${hostname} node.": }
  file { "/tmp/inetd.conf":
    content => 'aaaa'
  }

  include ntp, git 
}