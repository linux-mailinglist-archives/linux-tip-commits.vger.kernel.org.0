Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05500373AFC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 May 2021 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhEEMTx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 5 May 2021 08:19:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhEEMTq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 5 May 2021 08:19:46 -0400
Date:   Wed, 05 May 2021 12:18:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620217129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fgabuEnzvGMU84AiG91WffGwF4MQTQdFsOWx7Wc+1Vs=;
        b=yGN0tRdeI78x9fn5x2wq9MdUezpKsw6pRr+4q/NAwKBPrhOGNIcze/dPA63eZDzGB2G9of
        4VnW2g6CUZe0tGNW6dcx8rHN2pEofvHEyCsZHrGn26xwvZ0W1OK02dMUJpDDmAvfVj96/Q
        pXDOfK58wTlaBagTZHughXQH/emDt/67V538PlublnW28reS8+fcC0TYH4Ri/jeNPXh1cn
        2T9j22dN9YiLRmiIyOULpCUPR1T1aenswoOhCm8C/5Hjd1hQNTznx3qFKwz6rn9XzJBwOT
        B+P4BOI3EpbS09NyEOVLHVQlKPKopwnSIVugWDSQa6ZnmuQNikMYxEdTE6UWdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620217129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fgabuEnzvGMU84AiG91WffGwF4MQTQdFsOWx7Wc+1Vs=;
        b=IVy5KniQ/1LbIfXQ7DmQoutmTlVsOA0R3ClgkuLn9rBF/IjCxO87R1hDvoDQ2Rxbha4fer
        Ba4iU52BdgGl4xDQ==
From:   "tip-bot2 for Linus Torvalds" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Use alternative to generate the
 TASK_SIZE_MAX constant
Cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162021712859.29796.15613638722168867162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     025768a966a3dde8455de46d1f121a51bacb6a77
Gitweb:        https://git.kernel.org/tip/025768a966a3dde8455de46d1f121a51bacb6a77
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Tue, 04 May 2021 14:07:53 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 May 2021 08:52:31 +02:00

x86/cpu: Use alternative to generate the TASK_SIZE_MAX constant

We used to generate this constant with static jumps, which certainly
works, but generates some quite unreadable and horrid code, and extra
jumps.

It's actually much simpler to just use our alternative_asm()
infrastructure to generate a simple alternative constant, making the
generated code much more obvious (and straight-line rather than "jump
around to load the right constant").

Acked-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
---
 arch/x86/include/asm/page_64.h       | 33 +++++++++++++++++++++++++++-
 arch/x86/include/asm/page_64_types.h | 23 ++-----------------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cf..ca840fe 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -56,6 +56,39 @@ static inline void clear_page(void *page)
 
 void copy_page(void *to, void *from);
 
+#ifdef CONFIG_X86_5LEVEL
+/*
+ * User space process size.  This is the first address outside the user range.
+ * There are a few constraints that determine this:
+ *
+ * On Intel CPUs, if a SYSCALL instruction is at the highest canonical
+ * address, then that syscall will enter the kernel with a
+ * non-canonical return address, and SYSRET will explode dangerously.
+ * We avoid this particular problem by preventing anything
+ * from being mapped at the maximum canonical address.
+ *
+ * On AMD CPUs in the Ryzen family, there's a nasty bug in which the
+ * CPUs malfunction if they execute code from the highest canonical page.
+ * They'll speculate right off the end of the canonical space, and
+ * bad things happen.  This is worked around in the same way as the
+ * Intel problem.
+ *
+ * With page table isolation enabled, we map the LDT in ... [stay tuned]
+ */
+static inline unsigned long task_size_max(void)
+{
+	unsigned long ret;
+
+	alternative_io("movq %[small],%0","movq %[large],%0",
+			X86_FEATURE_LA57,
+			"=r" (ret),
+			[small] "i" ((1ul << 47)-PAGE_SIZE),
+			[large] "i" ((1ul << 56)-PAGE_SIZE));
+
+	return ret;
+}
+#endif	/* CONFIG_X86_5LEVEL */
+
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 64297ea..a8d4ad8 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -55,30 +55,13 @@
 
 #ifdef CONFIG_X86_5LEVEL
 #define __VIRTUAL_MASK_SHIFT	(pgtable_l5_enabled() ? 56 : 47)
+/* See task_size_max() in <asm/page_64.h> */
 #else
 #define __VIRTUAL_MASK_SHIFT	47
+#define task_size_max()		((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
 #endif
 
-/*
- * User space process size.  This is the first address outside the user range.
- * There are a few constraints that determine this:
- *
- * On Intel CPUs, if a SYSCALL instruction is at the highest canonical
- * address, then that syscall will enter the kernel with a
- * non-canonical return address, and SYSRET will explode dangerously.
- * We avoid this particular problem by preventing anything
- * from being mapped at the maximum canonical address.
- *
- * On AMD CPUs in the Ryzen family, there's a nasty bug in which the
- * CPUs malfunction if they execute code from the highest canonical page.
- * They'll speculate right off the end of the canonical space, and
- * bad things happen.  This is worked around in the same way as the
- * Intel problem.
- *
- * With page table isolation enabled, we map the LDT in ... [stay tuned]
- */
-#define TASK_SIZE_MAX	((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
-
+#define TASK_SIZE_MAX		task_size_max()
 #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
 
 /* This decides where the kernel will search for a free chunk of vm
