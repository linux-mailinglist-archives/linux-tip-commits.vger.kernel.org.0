Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9820459EAA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Nov 2021 09:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhKWI5K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Nov 2021 03:57:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhKWI5H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Nov 2021 03:57:07 -0500
Date:   Tue, 23 Nov 2021 08:53:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637657638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86XwV19cLaTqgz/ogideYa3jgrtxwxVRZp/IC3UB2vc=;
        b=lczDf3gXya9ujvB+VMHrM36Fna54kBINe7D8t9hitnpahNUK9KVd9X9wdnOyjU+EtuY9sY
        s6C82/l4bN1ZtJF7iECkAZsyZwcKaptncxQ8MRl9VMxgiKTaRfk5BGL57prPsjS3hQ6Zrp
        NivYN7rx3cmIeGL0LiNlBxWbjrhILqWoWw7WjnektuZCAqxN0fMmjfnt0EAEFuQXdKmzKT
        1hc9LeWa7Dfr+NaGNKQfyBfUmjMSaB0TXT4A4w55EJqqXMdPE+AiFJwx4G8++DSw3ePr5R
        32CtiVL5zSdYViaIfKtaMlOTTgoUJUmq7EACTnp/Sm2h0k9RwwG2p0UG0TmiQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637657638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86XwV19cLaTqgz/ogideYa3jgrtxwxVRZp/IC3UB2vc=;
        b=ZLooa74KJKjN08gniMbZuS/EYGhvzTE3aMGMQNTdV+OdwTh80rXXzkeKG7+dQWes8zw/jP
        CFudoGG2rqNKUICA==
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/csum: Fix compilation error for UM
Cc:     kernel test robot <lkp@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211118175239.1525650-1-eric.dumazet@gmail.com>
References: <20211118175239.1525650-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Message-ID: <163765763802.11128.3296594000945475918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6b2ecb61bb106d3688b315178831ff40d1008591
Gitweb:        https://git.kernel.org/tip/6b2ecb61bb106d3688b315178831ff40d1008591
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Thu, 18 Nov 2021 09:52:39 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Nov 2021 09:45:32 +01:00

x86/csum: Fix compilation error for UM

load_unaligned_zeropad() is not yet universal.

ARCH=um SUBARCH=x86_64 builds do not have it.

When CONFIG_DCACHE_WORD_ACCESS is not set, simply continue
the bisection with 4, 2 and 1 byte steps.

Fixes: df4554cebdaa ("x86/csum: Rewrite/optimize csum_partial()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211118175239.1525650-1-eric.dumazet@gmail.com
---
 arch/x86/lib/csum-partial_64.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 5ec3562..1eb8f2d 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -92,6 +92,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		buff += 8;
 	}
 	if (len & 7) {
+#ifdef CONFIG_DCACHE_WORD_ACCESS
 		unsigned int shift = (8 - (len & 7)) * 8;
 		unsigned long trail;
 
@@ -101,6 +102,31 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq $0,%[res]"
 			: [res] "+r" (temp64)
 			: [trail] "r" (trail));
+#else
+		if (len & 4) {
+			asm("addq %[val],%[res]\n\t"
+			    "adcq $0,%[res]"
+				: [res] "+r" (temp64)
+				: [val] "r" ((u64)*(u32 *)buff)
+				: "memory");
+			buff += 4;
+		}
+		if (len & 2) {
+			asm("addq %[val],%[res]\n\t"
+			    "adcq $0,%[res]"
+				: [res] "+r" (temp64)
+				: [val] "r" ((u64)*(u16 *)buff)
+				: "memory");
+			buff += 2;
+		}
+		if (len & 1) {
+			asm("addq %[val],%[res]\n\t"
+			    "adcq $0,%[res]"
+				: [res] "+r" (temp64)
+				: [val] "r" ((u64)*(u8 *)buff)
+				: "memory");
+		}
+#endif
 	}
 	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 	if (unlikely(odd)) { 
