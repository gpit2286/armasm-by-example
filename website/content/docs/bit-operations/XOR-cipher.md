---
title: "Program 13: XOR Cipher"
weight: 5
type: programs

description: |
    I need you to login to my account to check some permissions on some files. I've 
    encrypted the password using an XOR and with the key 214. 

    The input is in the template file. 

source: https://github.com/gpit2286/armasm-by-example/tree/master/13-xor-cipher
youtube_id: "GcZ0d6ZJVeM" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/13-xor-cipher/template
output: "hunter2"
---

 
## Basic Cryptography 

Cryptography is an art that has always fascinated me. How do you take a message, 
encrypt it, and send it to someone else to read without allowing anyone else to read 
it. With the exclusive OR, you can do basic encryption that is similar to a ROT13 
or the little coder wheels that used to be in cereal boxes.[^1]

The way that this works is you first take a message you want to encrypt. For this 
instance, try using: "ABC". If you take this and convert it into the numerical 
representation, it turns into: 

```text
    A       B         C 
01000001 01000010 01000011
```

From here you need to find a secret number. Depending on how complex you want to 
make this, it can be any size. If the key is shorter than the message, you just 
repeat the key over and over. For this, use the magic number -2. (0b11111110) 
Perform the XOR: 

```text
        A       B        C
    01000001 01000010 01000011
XOR 11111110 11111110 11111110
===============================
    10111111 10111100 10111101
```

The magic happens when you XOR the result with the same key. 

```text
    10111111 10111100 10111101
XOR 11111110 11111110 11111110
===============================
    01000001 01000010 01000011
```



[^1]: I don't personally remember these. But from everyone older than me, they all 
talk about them. So it's either a conspiracy involving almost everyone I know or true. 

