# encoding: utf-8


module Safe

##[sig(Integer, Bool, Integer, Address)]
##
## Struct.new( :Voter,
##  weight:   0,
##  voted:    false,
##  vote:     0,
##  delegate: '0x0000' )

  struct :Voter, {
    weight:   0,
    voted:    false,
    vote:     0,
    delegate: '0x0000' }

### -or-
# struct :Voter,
#   weight:   0,
#   voted:    false,
#   vote:     0,
#   delegate: '0x0000'

end # module Safe
