+++
date = '2026-11-04T14:30:44+07:00'
draft = true
title = 'Poof'
summary = 'Analyze network traffic and malware to decrypt an AES payload and recover the flag.'
aliases = ['/posts/poor/']
categories = ['Forensics']
+++

## Challenge

**Challenge name:** Poof

**Challenge description:** Yet another pcap, no usb traffic in this one so I’m lost. Can you help me out? :)

**Challenge file:** https://mega.nz/file/sk4TjJoA#EKaleZqsxyihM6clzcsvp04zfhdUGBu9ckVZ4HU7fWg

## Solution

At first I thought it will be the challenge that I have to solve the USB traffic however, when I opened it I saw many different protocols.



![pic1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*CJ9zhfB16a-sh1Uau0bE0w.png)



We have TCP, TLS, UDP and more type packets. Interesting it is not USB traffic that means they weren’t bluffing in the description. On searching further, I saw a HTTP packet with a GET method.



![pic2](https://miro.medium.com/v2/resize:fit:720/format:webp/1*g4tc0TjbccIpCxTDpR8QCg.png)



Great, we are on to something. This is a normal directory listing from the server and we have different files here. There are two interesting files, one is 82nvdkandf.bin and another one is kcaswqcd.ps1.



Let us download the file and check it.



![pic3](https://miro.medium.com/v2/resize:fit:720/format:webp/1*YX3pMtrBQG01ATFUD8ivxw.png)



Damn!! it is an obfuscated powershell script. So, we need to de-obfuscate it first after which will see what this script do.



![pic4](https://miro.medium.com/v2/resize:fit:720/format:webp/1*sAqvZqGRtQ06RlYX96FlHw.png)



And after de-obfuscating we can see that, they are encrypting the bin file with AES encryption method, and using the CBC binding for it. Great, we have the key and the initialization vector (iv) for decrypting.



There are some resources which will help you guys for learning this. Basically, this is mainly used for malware analysis. Sometimes, the malwares have the powershell script in it. Here are some of the resources I used to refer when I was learning on how to de-obfuscate powershell scripts.



Learn about obfuscation — TryHackMe Room

John’s video — https://youtu.be/1-FyyhpW-t8

The basic method is to de-obfuscate it and understand what does it means, let me explain.



```powershell
sEt-ITeM (‘VARIABlE:’+’V’+’s’+’52a’+’r’) ( [TyPe](“{0}{1}{2}” -f’t’,’ExT’,’.EncOdinG’)) ;
```



This is a powershell script which is highly obfuscated, the way we de-obfuscate is by writing it again. So let’s write it again. First it is written “set-Item” which is a command in powershell, then it mentions a variable and the variable name is “Vs52ar”, then it mentions a text which is in written in the form of array (that is the ‘type’ command), and it should be written in the order of 0,1,2 from the array ’t’,’ExT’,’.EncOdinG’ , so at zeroth position we have “t”, thus will write “t” first, at first position we have “Ext”, so will write “ext” and finally at second position we have “.Enc0dinG” (make sure you add the dot (.) too). And by doing this process we will get this



`set-Item variable:Vs52ar text.encoding`



Now that obfuscated script is de-obfuscated is actually humanly readable. We need to do that for the entire script given and at the end we will get our de-obfuscated script.



Once it is humanly readable we will get the key and the iv to decrypt that bin file, let us do that with our beloved chef



![pic5](https://miro.medium.com/v2/resize:fit:720/format:webp/1*UI_rMaYKrQp8lCq9yVFSBw.png)



So it is a window’s executable file, great let us download it. So, till this moment I thought that this file is not a harmful file and it is good go for run on my system, guess what? It is a malware and defender flagged it. But my main concern was where is the flag. I thought to look up to the file at VT, and there I got some information about this file, that is a trojan it’s score is 30/74 and more, but there were no information regarding flag.



At this moment I asked the admins, that am I on the write path or not, or I getting into a rabbit hole. I was happy that these admins were good and mentioned that I shouldn’t rely on online tools.



Thought it felt like a hint But it wasn’t. I looked up the sample in ghidra but I didn’t found any, and I was stuck in here for the next 4 hours. However, when I was surfing through net I got a tool which can be used in this that is dnspy. I looked up at my system if I have that tool or not, and I had it.



Lesson learnt, always update your toolkit, and always remember your tool. When I opened that file in dnspy, I found a piece of code, which was using the xor encryption.

![pic6](https://miro.medium.com/v2/resize:fit:720/format:webp/1*EJy-0rb25Qt5dFx5jfrhqw.png)

we have the XOR key and the xor bytes. I asked gpt to write a code to decrypt it.



```python
def xor_decrypt(data, key):

    return bytes([b ^ key for b in data])


# Encrypted byte array from the C# code

encrypted_data = [

    129, 149, 255, 125, 125, 125, 29, 244, 152, 76, 189, 25, 246, 45, 77, 246,

    47, 113, 246, 47, 105, 246, 15, 85, 114, 202, 55, 91, 76, 130, 209, 65, 28,

    1, 127, 81, 93, 188, 178, 112, 124, 186, 159, 143, 47, 42, 246, 47, 109,

    # ... (truncated for brevity)

    9, 27, 6, 42, 73, 14, 34, 76, 41, 34, 47, 78, 28, 17, 17, 4, 34, 28, 51,

    34, 52, 16, 13, 17, 73, 19, 9, 66, 66, 0, 93, 82, 28, 25, 25, 93, 82, 4, 125

]

# XOR key

key = 125

# Decrypting the data

decrypted_data = xor_decrypt(encrypted_data, key)

# Print the decrypted output as a string

print(decrypted_data.decode(errors='ignore'))
```

I ran this script and got the flag.

![pic7](https://miro.medium.com/v2/resize:fit:640/format:webp/1*azKVcPN7Yl2cmX0QqqkTcQ.png)

Trust me guys, this flag really gave me a confidence that yes I will be able to complete this CTF (sadly I wasn’t but its fine will try hard in the next one)
