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

## Challenge Overview

This challenge provides a file containing what appears to be nothing more than a long sequence of `1`s and `0`s. The objective is to determine whether the binary data contains anything meaningful.

**Challenge file:** [digits.bin](https://challenge-files.cylabacademy.net/library/819e05da202722f7847eab5c0efdedc194be8a2bc19e6b436d057c8514ae70bc/digits.bin)

## Initial Analysis

The file does not present an obvious file signature or readable text. However, the data is composed entirely of binary digits, which suggests that it may represent bytes encoded as text rather than random noise.

To decode it without modifying the original file, I used [CyberChef](https://gchq.github.io/CyberChef/), a browser-based tool for data analysis and transformation.

## Investigation

First, download `digits.bin` from the challenge link.

Next, open [CyberChef](https://gchq.github.io/CyberChef/) and follow these steps:

1. Drag `digits.bin` into the **Input** panel.
2. Search for the **From Binary** operation.
3. Drag **From Binary** into the **Recipe** panel.
4. Set **Byte length** to `8`.
5. The operation converts the binary digit stream into byte data.
6. Add the **Render Image** operation to the recipe.

The decoded bytes render as an image. The image contains the flag rather than ordinary file content, confirming that the original sequence was a visual payload encoded as binary.

## Solution

The important detail is to decode the input in groups of eight bits. Using a byte length other than `8` produces incorrect output, while the correct setting reveals valid byte data that can then be rendered as an image.

The complete CyberChef recipe is:

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
