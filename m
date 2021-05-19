Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7EA3890A3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbhESOU7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 10:20:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242344AbhESOUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 10:20:55 -0400
Date:   Wed, 19 May 2021 14:19:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621433974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzFdTdhHzEZEd1l2lUGzVV5PdtTbtiknPKRXolbchoY=;
        b=p0mJVGwQDVjBIW6bEhrqPqGAhQ8kuxpH165MiQw/1ouaMd6ooha1idQVrewP0b0MjIXwQT
        0cd2XPlrEYCjGbQ6PcFP1aIuzUaaN4Ge+eESUsHHrB5Pcoy0U9eTZvYMxopjWsbv5mm4wT
        F3LUShN9POGkZY47bT59JEJZz2HZjAJAnh+gQVcY/bC6lS2TCsTAcZWboS6PC+cTGU5ulX
        g3M2Q3sz+N2Kz2H63JBKX57sPhyQZ6zbsSKdV6UqKsS2cUBDFU3II2omEvV1mY30cMeFjv
        ZqT299HzFhz4nTjCY1ecJCNYLih6PLwcT7O5hGuEEox+Xbse4jcYjKYjLK8fzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621433974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzFdTdhHzEZEd1l2lUGzVV5PdtTbtiknPKRXolbchoY=;
        b=lFzU5BP70HKxUYdxxFYP/6Y4ps1gfWnwVnrQG1tKFJeTpidtBCuwIAX7rtD/Lt959wgvLX
        wz03eY2AcxXlB5Bw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/signal: Introduce helpers to get the maximum
 signal frame size
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H.J. Lu" <hjl.tools@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518200320.17239-3-chang.seok.bae@intel.com>
References: <20210518200320.17239-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <162143397332.29796.12303584733926135644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     939ef713297df2cc910592305aa26af0e87f28ac
Gitweb:        https://git.kernel.org/tip/939ef713297df2cc910592305aa26af0e87f28ac
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 18 May 2021 13:03:16 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 May 2021 11:46:27 +02:00

x86/signal: Introduce helpers to get the maximum signal frame size

Signal frames do not have a fixed format and can vary in size when a number
of things change: supported XSAVE features, 32 vs. 64-bit apps, etc.

Add support for a runtime method for userspace to dynamically discover
how large a signal stack needs to be.

Introduce a new variable, max_frame_size, and helper functions for the
calculation to be used in a new user interface. Set max_frame_size to a
system-wide worst-case value, instead of storing multiple app-specific
values.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: H.J. Lu <hjl.tools@gmail.com>
Link: https://lkml.kernel.org/r/20210518200320.17239-3-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/signal.h |  2 +-
 arch/x86/include/asm/sigframe.h   |  2 +-
 arch/x86/kernel/cpu/common.c      |  3 ++-
 arch/x86/kernel/fpu/signal.c      | 19 ++++++++++-
 arch/x86/kernel/signal.c          | 59 ++++++++++++++++++++++++++++--
 5 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 7fb516b..8b6631d 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,6 +29,8 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size);
 
+unsigned long fpu__get_fpstate_size(void);
+
 extern void fpu__init_prepare_fx_sw_frame(void);
 
 #endif /* _ASM_X86_FPU_SIGNAL_H */
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index 84eab27..5b1ed65 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -85,4 +85,6 @@ struct rt_sigframe_x32 {
 
 #endif /* CONFIG_X86_64 */
 
+void __init init_sigframe_size(void);
+
 #endif /* _ASM_X86_SIGFRAME_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1b756c..9173dd4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -58,6 +58,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/sigframe.h>
 
 #include "cpu.h"
 
@@ -1332,6 +1333,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	fpu__init_system(c);
 
+	init_sigframe_size();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a4ec653..dbb304e 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -507,6 +507,25 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 	return sp;
 }
+
+unsigned long fpu__get_fpstate_size(void)
+{
+	unsigned long ret = xstate_sigframe_size();
+
+	/*
+	 * This space is needed on (most) 32-bit kernels, or when a 32-bit
+	 * app is running on a 64-bit kernel. To keep things simple, just
+	 * assume the worst case and always include space for 'freg_state',
+	 * even for 64-bit apps on 64-bit kernels. This wastes a bit of
+	 * space, but keeps the code simple.
+	 */
+	if ((IS_ENABLED(CONFIG_IA32_EMULATION) ||
+	     IS_ENABLED(CONFIG_X86_32)) && use_fxsr())
+		ret += sizeof(struct fregs_state);
+
+	return ret;
+}
+
 /*
  * Prepare the SW reserved portion of the fxsave memory layout, indicating
  * the presence of the extended state information in the memory layout
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index a06cb10..689a4b6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -212,6 +212,11 @@ do {									\
  * Set up a signal frame.
  */
 
+/* x86 ABI requires 16-byte alignment */
+#define FRAME_ALIGNMENT	16UL
+
+#define MAX_FRAME_PADDING	(FRAME_ALIGNMENT - 1)
+
 /*
  * Determine which stack to use..
  */
@@ -222,9 +227,9 @@ static unsigned long align_sigframe(unsigned long sp)
 	 * Align the stack pointer according to the i386 ABI,
 	 * i.e. so that on function entry ((sp + 4) & 15) == 0.
 	 */
-	sp = ((sp + 4) & -16ul) - 4;
+	sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
 #else /* !CONFIG_X86_32 */
-	sp = round_down(sp, 16) - 8;
+	sp = round_down(sp, FRAME_ALIGNMENT) - 8;
 #endif
 	return sp;
 }
@@ -663,6 +668,56 @@ badframe:
 	return 0;
 }
 
+/*
+ * There are four different struct types for signal frame: sigframe_ia32,
+ * rt_sigframe_ia32, rt_sigframe_x32, and rt_sigframe. Use the worst case
+ * -- the largest size. It means the size for 64-bit apps is a bit more
+ * than needed, but this keeps the code simple.
+ */
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+# define MAX_FRAME_SIGINFO_UCTXT_SIZE	sizeof(struct sigframe_ia32)
+#else
+# define MAX_FRAME_SIGINFO_UCTXT_SIZE	sizeof(struct rt_sigframe)
+#endif
+
+/*
+ * The FP state frame contains an XSAVE buffer which must be 64-byte aligned.
+ * If a signal frame starts at an unaligned address, extra space is required.
+ * This is the max alignment padding, conservatively.
+ */
+#define MAX_XSAVE_PADDING	63UL
+
+/*
+ * The frame data is composed of the following areas and laid out as:
+ *
+ * -------------------------
+ * | alignment padding     |
+ * -------------------------
+ * | (f)xsave frame        |
+ * -------------------------
+ * | fsave header          |
+ * -------------------------
+ * | alignment padding     |
+ * -------------------------
+ * | siginfo + ucontext    |
+ * -------------------------
+ */
+
+/* max_frame_size tells userspace the worst case signal stack size. */
+static unsigned long __ro_after_init max_frame_size;
+
+void __init init_sigframe_size(void)
+{
+	max_frame_size = MAX_FRAME_SIGINFO_UCTXT_SIZE + MAX_FRAME_PADDING;
+
+	max_frame_size += fpu__get_fpstate_size() + MAX_XSAVE_PADDING;
+
+	/* Userspace expects an aligned size. */
+	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
+
+	pr_info("max sigframe size: %lu\n", max_frame_size);
+}
+
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
 	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
