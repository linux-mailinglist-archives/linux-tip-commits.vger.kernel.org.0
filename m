Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A6538FDD3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhEYJat (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhEYJas (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 05:30:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A4C061574;
        Tue, 25 May 2021 02:29:19 -0700 (PDT)
Date:   Tue, 25 May 2021 09:29:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621934957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WK5p0oFZXk8lXiQYHQXKK5SZLwHQqdm4KDok6KEuO0=;
        b=RbbYEl3XKEXf9Lhpo1Dyld22d1r1hND9jCvw3ujICwuicxa4DLVDmzckUooEZQ+oS4A3Qy
        86dLvJadGj9dGmYDTUeXS8dwMv5WU4dN5BuCg0wDvJb5k+enN9i9vOqL7PVBxYYpON8tzj
        fwPvwHr6nw/lhmJ6FX90kME394ehxU0R/zdfKvhwCVWLK+sJiFWzhUX3O/nLfS0NB6uTfb
        sZkF5aS0gljaO/pBZxTWJ8dtn8/Cr3d2L1XbbdhX4i1LY1ZpxkO6UstG0qAj0wklVSUCtG
        AcMrqge5mnOsTheQe6RI7XQK6jryI9nQp5aEl0S9C/NsHrG0++KS+iIDicswSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621934957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WK5p0oFZXk8lXiQYHQXKK5SZLwHQqdm4KDok6KEuO0=;
        b=d8jIEK7CN1U44Uxl6Qc2wAkp3Dzo/Fe4qc8YPnvFbDXGNT7HHIXeunyqlh3O39xVjMjnE0
        5TZXlGQ9zSYuonBw==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Add and use NR_EXTERNAL_VECTORS and NR_SYSTEM_VECTORS
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210519212154.511983-3-hpa@zytor.com>
References: <20210519212154.511983-3-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162193495692.29796.16044979398265700094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     ff851003880de9d1111498877551ba16668c38ef
Gitweb:        https://git.kernel.org/tip/ff851003880de9d1111498877551ba16668c38ef
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 19 May 2021 14:21:48 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 May 2021 12:36:44 +02:00

x86/irq: Add and use NR_EXTERNAL_VECTORS and NR_SYSTEM_VECTORS

Add defines for the number of external vectors and number of system
vectors instead of requiring the use of (FIRST_SYSTEM_VECTOR -
FIRST_EXTERNAL_VECTOR) and (NR_VECTORS - FIRST_SYSTEM_VECTOR)
respectively. Clean up the usage sites.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20210519212154.511983-3-hpa@zytor.com

---
 arch/x86/include/asm/idtentry.h          | 4 ++--
 arch/x86/include/asm/irq_vectors.h       | 3 +++
 tools/arch/x86/include/asm/irq_vectors.h | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 73d45b0..c03a18c 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -504,7 +504,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	.align 8
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
-    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+    .rept NR_EXTERNAL_VECTORS
 	UNWIND_HINT_IRET_REGS
 0 :
 	.byte	0x6a, vector
@@ -520,7 +520,7 @@ SYM_CODE_END(irq_entries_start)
 	.align 8
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
-    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+    .rept NR_SYSTEM_VECTORS
 	UNWIND_HINT_IRET_REGS
 0 :
 	.byte	0x6a, vector
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index dc71b78..43dcb92 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -114,6 +114,9 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
+#define NR_EXTERNAL_VECTORS		(FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+#define NR_SYSTEM_VECTORS		(NR_VECTORS - FIRST_SYSTEM_VECTOR)
+
 /*
  * Size the maximum number of interrupts.
  *
diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
index dc71b78..43dcb92 100644
--- a/tools/arch/x86/include/asm/irq_vectors.h
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -114,6 +114,9 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
+#define NR_EXTERNAL_VECTORS		(FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+#define NR_SYSTEM_VECTORS		(NR_VECTORS - FIRST_SYSTEM_VECTOR)
+
 /*
  * Size the maximum number of interrupts.
  *
