Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44D1454800
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhKQODq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhKQODR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:03:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13AFC061570;
        Wed, 17 Nov 2021 06:00:18 -0800 (PST)
Date:   Wed, 17 Nov 2021 14:00:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Ef16M/7CHdwnceLzR8rK7T7gT1ep5/oalDyBk6cCTY=;
        b=IPX0D/TxPtlfRqMdMAOfmc894ts7Aa866qENIZ0YMEoZc3YgIlkUoJ/ufzITQ9BiawQpDd
        LCJ0/LuVaWVk/0LFLD8b64RAUJtf7n5lV9/8Q6HgLulNwA4XZKybOe1k2puqpsP7eyfydN
        RZaDhAV1LJEBNBZrhBkVekWm/JxPSs3Dn0yAs9ztrfWbNrNKVjJFONfHZexvADQ4ML7kB9
        WokoevT2bTcfxoA0ZI/NnOa03y/S8yx8mH/FrSfh02MkUTqq2tQovxYSaq59ZFLH4/sRdA
        +mAerKZ6wBx7cSDlkoxeTKAZaao8DJ8Y3vwwPhHMJ8HRrkJ6tV5qKQHSTt198w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Ef16M/7CHdwnceLzR8rK7T7gT1ep5/oalDyBk6cCTY=;
        b=TJe1eJMc+1tACTykABitgr+GXA4QRnxmVqbntm/Lxq5bT9W4SioAltvisU9/YK5BeZUabS
        IMDrYPy8qwhM2NAA==
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/csum: Rewrite/optimize csum_partial()
Cc:     Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112161950.528886-1-eric.dumazet@gmail.com>
References: <20211112161950.528886-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Message-ID: <163715761638.11128.11767566251032242193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d31c3c683ee668ba5d87c0730610442fd672525f
Gitweb:        https://git.kernel.org/tip/d31c3c683ee668ba5d87c0730610442fd672525f
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Fri, 12 Nov 2021 08:19:50 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:48:54 +01:00

x86/csum: Rewrite/optimize csum_partial()

With more NIC supporting CHECKSUM_COMPLETE, and IPv6 being widely
used.  csum_partial() is heavily used with small amount of bytes, and
is consuming many cycles.

IPv6 header size for instance is 40 bytes.

Another thing to consider is that NET_IP_ALIGN is 0 on x86, meaning
that network headers are not word-aligned, unless the driver forces
this.

This means that csum_partial() fetches one u16 to 'align the buffer',
then perform three u64 additions with carry in a loop, then a
remaining u32, then a remaining u16.

With this new version, we perform a loop only for the 64 bytes blocks,
then the remaining is bisected.

Tested on various cpus, all of them show a big reduction in
csum_partial() cost (by 50 to 80 %)

Before:
	4.16%  [kernel]       [k] csum_partial
After:
	0.83%  [kernel]       [k] csum_partial

If run in a loop 1,000,000 times:

Before:
	26,922,913      cycles                    # 3846130.429 GHz
	80,302,961      instructions              #    2.98  insn per cycle
	21,059,816      branches                  # 3008545142.857 M/sec
	     2,896      branch-misses             #    0.01% of all branches
After:
	17,960,709      cycles                    # 3592141.800 GHz
	41,292,805      instructions              #    2.30  insn per cycle
	11,058,119      branches                  # 2211623800.000 M/sec
	     2,997      branch-misses             #    0.03% of all branches

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Link: https://lore.kernel.org/r/20211112161950.528886-1-eric.dumazet@gmail.com
---
 arch/x86/lib/csum-partial_64.c | 162 +++++++++++++-------------------
 1 file changed, 67 insertions(+), 95 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index e7925d6..5ec3562 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/export.h>
 #include <asm/checksum.h>
+#include <asm/word-at-a-time.h>
 
 static inline unsigned short from32to16(unsigned a) 
 {
@@ -21,120 +22,92 @@ static inline unsigned short from32to16(unsigned a)
 }
 
 /*
- * Do a 64-bit checksum on an arbitrary memory area.
+ * Do a checksum on an arbitrary memory area.
  * Returns a 32bit checksum.
  *
  * This isn't as time critical as it used to be because many NICs
  * do hardware checksumming these days.
- * 
- * Things tried and found to not make it faster:
- * Manual Prefetching
- * Unrolling to an 128 bytes inner loop.
- * Using interleaving with more registers to break the carry chains.
+ *
+ * Still, with CHECKSUM_COMPLETE this is called to compute
+ * checksums on IPv6 headers (40 bytes) and other small parts.
+ * it's best to have buff aligned on a 64-bit boundary
  */
-static unsigned do_csum(const unsigned char *buff, unsigned len)
+__wsum csum_partial(const void *buff, int len, __wsum sum)
 {
-	unsigned odd, count;
-	unsigned long result = 0;
+	u64 temp64 = (__force u64)sum;
+	unsigned odd, result;
 
-	if (unlikely(len == 0))
-		return result; 
 	odd = 1 & (unsigned long) buff;
 	if (unlikely(odd)) {
-		result = *buff << 8;
+		if (unlikely(len == 0))
+			return sum;
+		temp64 += (*(unsigned char *)buff << 8);
 		len--;
 		buff++;
 	}
-	count = len >> 1;		/* nr of 16-bit words.. */
-	if (count) {
-		if (2 & (unsigned long) buff) {
-			result += *(unsigned short *)buff;
-			count--;
-			len -= 2;
-			buff += 2;
-		}
-		count >>= 1;		/* nr of 32-bit words.. */
-		if (count) {
-			unsigned long zero;
-			unsigned count64;
-			if (4 & (unsigned long) buff) {
-				result += *(unsigned int *) buff;
-				count--;
-				len -= 4;
-				buff += 4;
-			}
-			count >>= 1;	/* nr of 64-bit words.. */
 
-			/* main loop using 64byte blocks */
-			zero = 0;
-			count64 = count >> 3;
-			while (count64) { 
-				asm("addq 0*8(%[src]),%[res]\n\t"
-				    "adcq 1*8(%[src]),%[res]\n\t"
-				    "adcq 2*8(%[src]),%[res]\n\t"
-				    "adcq 3*8(%[src]),%[res]\n\t"
-				    "adcq 4*8(%[src]),%[res]\n\t"
-				    "adcq 5*8(%[src]),%[res]\n\t"
-				    "adcq 6*8(%[src]),%[res]\n\t"
-				    "adcq 7*8(%[src]),%[res]\n\t"
-				    "adcq %[zero],%[res]"
-				    : [res] "=r" (result)
-				    : [src] "r" (buff), [zero] "r" (zero),
-				    "[res]" (result));
-				buff += 64;
-				count64--;
-			}
+	while (unlikely(len >= 64)) {
+		asm("addq 0*8(%[src]),%[res]\n\t"
+		    "adcq 1*8(%[src]),%[res]\n\t"
+		    "adcq 2*8(%[src]),%[res]\n\t"
+		    "adcq 3*8(%[src]),%[res]\n\t"
+		    "adcq 4*8(%[src]),%[res]\n\t"
+		    "adcq 5*8(%[src]),%[res]\n\t"
+		    "adcq 6*8(%[src]),%[res]\n\t"
+		    "adcq 7*8(%[src]),%[res]\n\t"
+		    "adcq $0,%[res]"
+		    : [res] "+r" (temp64)
+		    : [src] "r" (buff)
+		    : "memory");
+		buff += 64;
+		len -= 64;
+	}
+
+	if (len & 32) {
+		asm("addq 0*8(%[src]),%[res]\n\t"
+		    "adcq 1*8(%[src]),%[res]\n\t"
+		    "adcq 2*8(%[src]),%[res]\n\t"
+		    "adcq 3*8(%[src]),%[res]\n\t"
+		    "adcq $0,%[res]"
+			: [res] "+r" (temp64)
+			: [src] "r" (buff)
+			: "memory");
+		buff += 32;
+	}
+	if (len & 16) {
+		asm("addq 0*8(%[src]),%[res]\n\t"
+		    "adcq 1*8(%[src]),%[res]\n\t"
+		    "adcq $0,%[res]"
+			: [res] "+r" (temp64)
+			: [src] "r" (buff)
+			: "memory");
+		buff += 16;
+	}
+	if (len & 8) {
+		asm("addq 0*8(%[src]),%[res]\n\t"
+		    "adcq $0,%[res]"
+			: [res] "+r" (temp64)
+			: [src] "r" (buff)
+			: "memory");
+		buff += 8;
+	}
+	if (len & 7) {
+		unsigned int shift = (8 - (len & 7)) * 8;
+		unsigned long trail;
 
-			/* last up to 7 8byte blocks */
-			count %= 8; 
-			while (count) { 
-				asm("addq %1,%0\n\t"
-				    "adcq %2,%0\n" 
-					    : "=r" (result)
-				    : "m" (*(unsigned long *)buff), 
-				    "r" (zero),  "0" (result));
-				--count; 
-				buff += 8;
-			}
-			result = add32_with_carry(result>>32,
-						  result&0xffffffff); 
+		trail = (load_unaligned_zeropad(buff) << shift) >> shift;
 
-			if (len & 4) {
-				result += *(unsigned int *) buff;
-				buff += 4;
-			}
-		}
-		if (len & 2) {
-			result += *(unsigned short *) buff;
-			buff += 2;
-		}
+		asm("addq %[trail],%[res]\n\t"
+		    "adcq $0,%[res]"
+			: [res] "+r" (temp64)
+			: [trail] "r" (trail));
 	}
-	if (len & 1)
-		result += *buff;
-	result = add32_with_carry(result>>32, result & 0xffffffff); 
+	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 	if (unlikely(odd)) { 
 		result = from32to16(result);
 		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
 	}
-	return result;
-}
-
-/*
- * computes the checksum of a memory block at buff, length len,
- * and adds in "sum" (32-bit)
- *
- * returns a 32-bit number suitable for feeding into itself
- * or csum_tcpudp_magic
- *
- * this function must be called with even lengths, except
- * for the last fragment, which may be odd
- *
- * it's best to have buff aligned on a 64-bit boundary
- */
-__wsum csum_partial(const void *buff, int len, __wsum sum)
-{
-	return (__force __wsum)add32_with_carry(do_csum(buff, len),
-						(__force u32)sum);
+	return (__force __wsum)result;
 }
 EXPORT_SYMBOL(csum_partial);
 
@@ -147,4 +120,3 @@ __sum16 ip_compute_csum(const void *buff, int len)
 	return csum_fold(csum_partial(buff,len,0));
 }
 EXPORT_SYMBOL(ip_compute_csum);
-
