# Notes

## Todos

### ClassMethods 

- [ ] use module Kernel for "global" converter functions plus use Kernel (and NOT object) for generated-"global" convert function too!!

- [ ] Auto-add `struct` class methods also by default to Safe itself with extend.
Possible to call extend with ClassMethods on Safe itself?

Make this work "out-of-the-box":
``` ruby
module Safe

  struct :Vote,
    weight:   0,
    voted:    false,
    vote:     0,
    delegate: '0x0000'        

  enum :Color, :red, :green, :blue

end
```



### Enums

Add enums support to array and mapping for [].
Convert index to enum value.
Use index for arrays too or only for hash mapping?

### Safe Array

Note: In Solidity fixed arrays do NOT include / support the push method -
only [] and []= access.
