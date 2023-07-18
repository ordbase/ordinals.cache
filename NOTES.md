# Notes


## Ordinal Inscriptions Object Database / Cache Format

the content blob gets stored in

`<inscribe_id-first[0..2] first two hexchars>/<inscribe_id[2..]>.<extension via meta data - content type>`


mapping table - content-type to (file) extension

- text/plain  -> .txt
- application/json -> .json
- image/png   -> .png


the metadata gets stored in txt with key/value pairs

`.meta.txt`

keys (follow the http header format e.g. a-z, 0–9, hyphen (-), or underscore (_))


```
title: Inscription 10368165
id: 0a7db35647ea795525796a0e50686b1519d0c809bc78a985f33c4e2419231ecbi0
address: bc1pwyc0l9l297prhwxxnfrwmht8hpsd04rx879c8yqcfj650zm39e4qd3pefu
output-value: 546
sat: 1669609551362699
content-length: 67 bytes
content-type: text/plain;charset=utf-8
timestamp: 2023-06-01 03:35:25 UTC
genesis-height: 792332
genesis-fee: 9891
genesis-transaction: 0a7db35647ea795525796a0e50686b1519d0c809bc78a985f33c4e2419231ecb
location: 0a7db35647ea795525796a0e50686b1519d0c809bc78a985f33c4e2419231ecb:0:0
output: 0a7db35647ea795525796a0e50686b1519d0c809bc78a985f33c4e2419231ecb:0
offset: 0
```