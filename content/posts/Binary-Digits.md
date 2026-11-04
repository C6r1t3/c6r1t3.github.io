+++
date = '2026-11-05T06:02:59+07:00'
draft = false
title = 'Binary Digits'
summary = 'Recover hidden image data from a binary digit file using CyberChef.'
categories = ['Forensics']
platforms = ['picoCTF 2026']
tags = ['For', 'Easy', 'picoCTF 2026']
difficulty = 'Easy'
+++

## Challenge

**Name:** Binary Digits

**Category:** Forensics

**Difficulty:** Easy

This file doesn't look like much... just a bunch of `1`s and `0`s. But maybe it's not just random noise. Can you recover anything meaningful from this?

**Challenge file:** [digits.bin](https://challenge-files.cylabacademy.net/library/819e05da202722f7847eab5c0efdedc194be8a2bc19e6b436d057c8514ae70bc/digits.bin)

![Binary Digits challenge page](/images/writeups/binary-digits/challenge.png)

## Initial Analysis

After downloading the challenge file, the content appears to be a long sequence of `1`s and `0`s. It does not look like ordinary text, but the pattern strongly suggests that the digits may be binary data represented as text.

Rather than manually process the file, I used [CyberChef](https://gchq.github.io/CyberChef/) to decode the binary stream and inspect the resulting bytes.

## Investigation

### 1. Download the challenge file

I downloaded `digits.bin` from the [challenge file link](https://challenge-files.cylabacademy.net/library/819e05da202722f7847eab5c0efdedc194be8a2bc19e6b436d057c8514ae70bc/digits.bin).

![Downloading digits.bin](/images/writeups/binary-digits/download.png)

### 2. Decode the binary data with CyberChef

I opened [CyberChef](https://gchq.github.io/CyberChef/) and configured the recipe as follows:

1. Drag `digits.bin` into the **Input** panel.
2. Search for the **From Binary** operation.
3. Drag **From Binary** into the **Recipe** panel.
4. Set **Byte length** to `8`.
5. Add **Render Image** after **From Binary**.
6. Leave **Input format** set to `Raw`.

The `From Binary` operation converts every group of eight binary digits into one byte. The `Render Image` operation then displays those bytes as an image.

![CyberChef recipe and rendered output](/images/writeups/binary-digits/cyberchef.png)

## Solution

The key is recognizing that the file contains binary digits and processing them in 8-bit groups. After the conversion, the output is valid image data. Rendering it reveals the flag embedded in the image.

The final CyberChef recipe is:

```text
From Binary (Byte length: 8)
Render Image (Input format: Raw)
```

## Flag

```text
academy{h1dd3n_1n_th3_b1n4ry_5a7375c5}
```

## Lessons Learned

- A stream of `1`s and `0`s may be encoded binary data rather than random text.
- Grouping binary data into bytes requires the correct byte length.
- Rendering decoded bytes as an image can reveal information that is not visible as plain text.
- CyberChef is useful for quickly testing common decoding and visualization workflows.

## References

- [CyberChef](https://gchq.github.io/CyberChef/)
- [Challenge file](https://challenge-files.cylabacademy.net/library/819e05da202722f7847eab5c0efdedc194be8a2bc19e6b436d057c8514ae70bc/digits.bin)
