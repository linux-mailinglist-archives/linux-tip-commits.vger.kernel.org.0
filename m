Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15E835834E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Apr 2021 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHMbL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Apr 2021 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHMbL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Apr 2021 08:31:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08855C061760;
        Thu,  8 Apr 2021 05:31:00 -0700 (PDT)
Date:   Thu, 08 Apr 2021 12:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617885058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51ls2iPxJi2SsBXM8FunGtXV6mURpzyfDVukkNrBJWI=;
        b=E/znGtMbtmqCrEwTd9ugvuZcEijKwpiknE6t4GtVvmg8mMWdEeVcQXjiUy20R+65UKHs31
        mGVkF41MtdfqnYYapr0/A8KdBeNbqp+EXHJ9EGvda5zrp/aTx2EJZlqtKx7owhFlCZkHRW
        ce3o1/ogx8bI8nwgVgVh1/BC5ChX7kuV3w9ZYy/oNy2SxGnBa9nvwyXe4ZHYJpK+k1cXu6
        OTg+fupQ+4Xso3o5s6pDtjBjYBWCMrBCppAWCZplbVdqFRoSyTisKuHX0r4EbRNppY0zDE
        1rf9KWORsoLCpqkDdvPNh3QxdvufvR2wY+ARpVgM97czGXqBRTN6MiogsTMjDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617885058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51ls2iPxJi2SsBXM8FunGtXV6mURpzyfDVukkNrBJWI=;
        b=WTkCzd19jn3ZJ3icOilRE2uIlXV9MWjQ6Hc6yfDROe9fVJ56a6Qr06iQCIEOFcdi5xcoks
        YZXD7s++lxju0KBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Resort and comment Intel models
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YE+HhS8i0gshHD3W@hirez.programming.kicks-ass.net>
References: <YE+HhS8i0gshHD3W@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161788505782.29796.12752205613327973872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     53375a5a218e7ea0ac18087946b5391f749b764f
Gitweb:        https://git.kernel.org/tip/53375a5a218e7ea0ac18087946b5391f749b764f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 Mar 2021 17:12:53 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 08 Apr 2021 14:22:10 +02:00

x86/cpu: Resort and comment Intel models

The INTEL_FAM6 list has become a mess again. Try and bring some sanity
back into it.

Where previously we had one microarch per year and a number of SKUs
within that, this no longer seems to be the case. We now get different
uarch names that share a 'core' design.

Add the core name starting at skylake and reorder to keep the cores
in chronological order. Furthermore, Intel marketed the names {Amber,
Coffee, Whiskey} Lake, but those are in fact steppings of Kaby Lake, add
comments for them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/YE+HhS8i0gshHD3W@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/intel-family.h | 50 +++++++++++++++-------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9abe842..b15262f 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -32,7 +32,9 @@
  *		_EP	- 2 socket server parts
  *		_EX	- 4+ socket server parts
  *
- * The #define line may optionally include a comment including platform names.
+ * The #define line may optionally include a comment including platform or core
+ * names. An exception is made for kabylake where steppings seem to have gotten
+ * their own names :-(
  */
 
 /* Wildcard match for FAM6 so X86_MATCH_INTEL_FAM6_MODEL(ANY) works */
@@ -69,35 +71,39 @@
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_D		0x56
 
-#define INTEL_FAM6_SKYLAKE_L		0x4E
-#define INTEL_FAM6_SKYLAKE		0x5E
-#define INTEL_FAM6_SKYLAKE_X		0x55
-#define INTEL_FAM6_KABYLAKE_L		0x8E
-#define INTEL_FAM6_KABYLAKE		0x9E
+#define INTEL_FAM6_SKYLAKE_L		0x4E	/* Sky Lake             */
+#define INTEL_FAM6_SKYLAKE		0x5E	/* Sky Lake             */
+#define INTEL_FAM6_SKYLAKE_X		0x55	/* Sky Lake             */
 
-#define INTEL_FAM6_CANNONLAKE_L		0x66
+#define INTEL_FAM6_KABYLAKE_L		0x8E	/* Sky Lake             */
+/*                 AMBERLAKE_L		0x8E	   Sky Lake -- s: 9     */
+/*                 COFFEELAKE_L		0x8E	   Sky Lake -- s: 10    */
+/*                 WHISKEYLAKE_L	0x8E       Sky Lake -- s: 11,12 */
 
-#define INTEL_FAM6_ICELAKE_X		0x6A
-#define INTEL_FAM6_ICELAKE_D		0x6C
-#define INTEL_FAM6_ICELAKE		0x7D
-#define INTEL_FAM6_ICELAKE_L		0x7E
-#define INTEL_FAM6_ICELAKE_NNPI		0x9D
+#define INTEL_FAM6_KABYLAKE		0x9E	/* Sky Lake             */
+/*                 COFFEELAKE		0x9E	   Sky Lake -- s: 10-13 */
 
-#define INTEL_FAM6_TIGERLAKE_L		0x8C
-#define INTEL_FAM6_TIGERLAKE		0x8D
+#define INTEL_FAM6_COMETLAKE		0xA5	/* Sky Lake             */
+#define INTEL_FAM6_COMETLAKE_L		0xA6	/* Sky Lake             */
 
-#define INTEL_FAM6_COMETLAKE		0xA5
-#define INTEL_FAM6_COMETLAKE_L		0xA6
+#define INTEL_FAM6_CANNONLAKE_L		0x66	/* Palm Cove */
 
-#define INTEL_FAM6_ROCKETLAKE		0xA7
+#define INTEL_FAM6_ICELAKE_X		0x6A	/* Sunny Cove */
+#define INTEL_FAM6_ICELAKE_D		0x6C	/* Sunny Cove */
+#define INTEL_FAM6_ICELAKE		0x7D	/* Sunny Cove */
+#define INTEL_FAM6_ICELAKE_L		0x7E	/* Sunny Cove */
+#define INTEL_FAM6_ICELAKE_NNPI		0x9D	/* Sunny Cove */
 
-#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F
+#define INTEL_FAM6_LAKEFIELD		0x8A	/* Sunny Cove / Tremont */
 
-/* Hybrid Core/Atom Processors */
+#define INTEL_FAM6_ROCKETLAKE		0xA7	/* Cypress Cove */
 
-#define	INTEL_FAM6_LAKEFIELD		0x8A
-#define INTEL_FAM6_ALDERLAKE		0x97
-#define INTEL_FAM6_ALDERLAKE_L		0x9A
+#define INTEL_FAM6_TIGERLAKE_L		0x8C	/* Willow Cove */
+#define INTEL_FAM6_TIGERLAKE		0x8D	/* Willow Cove */
+#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Willow Cove */
+
+#define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
+#define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 
 /* "Small Core" Processors (Atom) */
 
