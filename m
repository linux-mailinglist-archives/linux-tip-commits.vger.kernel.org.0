Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA136444A77
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Nov 2021 22:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhKCVvX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Nov 2021 17:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhKCVvX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Nov 2021 17:51:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31484C061714;
        Wed,  3 Nov 2021 14:48:46 -0700 (PDT)
Date:   Wed, 03 Nov 2021 21:48:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635976123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZ1ThKKV6+L5ZvB+T+QMPLsypQGTp0xWXbjjY4y9Bks=;
        b=e+CtlNwlajVAPuSpwyCJsinVE/+Nk8g7O7ZpLAWPWDYRUUKmvLs3kMwsHJKYHNZ3amqEV+
        GiMeTVk6zfz8G8PSBq8CLYc4//u9TKHkiLrm5HZ8MxfMPaNXXcwx6kob+uUNQB9MTh+9dN
        bfcxW3mS3clyov2NKwCWb/SiUo2kEb4p0tE5FPNSbD5oUiRlBymWaDV5U/81x8ZMbrpD3Y
        UO+E6wlZTZ2/raQfUGOR61MHB8E1AvYheX2CNf2k8QQkjSOmI5mxg9XwW3KGDkerdDid9i
        +AuLnY2dbJBnJheAczTyMCmd2KTL9XToK8ogCiL9WUhhrhDdqxIKSYsum15uww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635976123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZ1ThKKV6+L5ZvB+T+QMPLsypQGTp0xWXbjjY4y9Bks=;
        b=THxykxH315xX/RqWmnQk4XKoWnJEZhjesLeOzCloZSbN7KTVTJIBkggP96ezcrExOVo3Xw
        mXHBhIlBTfgXdMAw==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Optimize out sigframe xfeatures when in init state
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211102224750.FA412E26@davehans-spike.ostc.intel.com>
References: <20211102224750.FA412E26@davehans-spike.ostc.intel.com>
MIME-Version: 1.0
Message-ID: <163597612165.626.15614463658086299478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     30d02551ba4f681cfa605cedacf231b8641169f0
Gitweb:        https://git.kernel.org/tip/30d02551ba4f681cfa605cedacf231b8641169f0
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 02 Nov 2021 15:47:50 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Nov 2021 22:42:35 +01:00

x86/fpu: Optimize out sigframe xfeatures when in init state

tl;dr: AMX state is ~8k.  Signal frames can have space for this
~8k and each signal entry writes out all 8k even if it is zeros.
Skip writing zeros for AMX to speed up signal delivery by about
4% overall when AMX is in its init state.

This is a user-visible change to the sigframe ABI.

== Hardware XSAVE Background ==

XSAVE state components may be tracked by the processor as being
in their initial configuration.  Software can detect which
features are in this configuration by looking at the XSTATE_BV
field in an XSAVE buffer or with the XGETBV(1) instruction.

Both the XSAVE and XSAVEOPT instructions enumerate features s
being in the initial configuration via the XSTATE_BV field in the
XSAVE header,  However, XSAVEOPT declines to actually write
features in their initial configuration to the buffer.  XSAVE
writes the feature unconditionally, regardless of whether it is
in the initial configuration or not.

Basically, XSAVE users never need to inspect XSTATE_BV to
determine if the feature has been written to the buffer.
XSAVEOPT users *do* need to inspect XSTATE_BV.  They might also
need to clear out the buffer if they want to make an isolated
change to the state, like modifying one register.

== Software Signal / XSAVE Background ==

Signal frames have historically been written with XSAVE itself.
Each state is written in its entirety, regardless of being in its
initial configuration.

In other words, the signal frame ABI uses the XSAVE behavior, not
the XSAVEOPT behavior.

== Problem ==

This means that any application which has acquired permission to
use AMX via ARCH_REQ_XCOMP_PERM will write 8k of state to the
signal frame.  This 8k write will occur even when AMX was in its
initial configuration and software *knows* this because of
XSTATE_BV.

This problem also exists to a lesser degree with AVX-512 and its
2k of state.  However, AVX-512 use does not require
ARCH_REQ_XCOMP_PERM and is more likely to have existing users
which would be impacted by any change in behavior.

== Solution ==

Stop writing out AMX xfeatures which are in their initial state
to the signal frame.  This effectively makes the signal frame
XSAVE buffer look as if it were written with a combination of
XSAVEOPT and XSAVE behavior.  Userspace which handles XSAVEOPT-
style buffers should be able to handle this naturally.

For now, include only the AMX xfeatures: XTILE and XTILEDATA in
this new behavior.  These require new ABI to use anyway, which
makes their users very unlikely to be broken.  This XSAVEOPT-like
behavior should be expected for all future dynamic xfeatures.  It
may also be extended to legacy features like AVX-512 in the
future.

Only attempt this optimization on systems with dynamic features.
Disable dynamic feature support (XFD) if XGETBV1 is unavailable
by adding a CPUID dependency.

This has been measured to reduce the *overall* cycle cost of
signal delivery by about 4%.

Fixes: 2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: "Chang S. Bae" <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/r/20211102224750.FA412E26@davehans-spike.ostc.intel.com

---
 Documentation/x86/xstate.rst      |  9 +++++++-
 arch/x86/include/asm/fpu/xcr.h    | 12 ++++++++++-
 arch/x86/include/asm/fpu/xstate.h |  7 ++++++-
 arch/x86/kernel/cpu/cpuid-deps.c  |  1 +-
 arch/x86/kernel/fpu/xstate.h      | 37 ++++++++++++++++++++++++++++--
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index 65de3f0..5cec7fb 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -63,3 +63,12 @@ kernel sends SIGILL to the application. If the process has permission then
 the handler allocates a larger xstate buffer for the task so the large
 state can be context switched. In the unlikely cases that the allocation
 fails, the kernel sends SIGSEGV.
+
+Dynamic features in signal frames
+---------------------------------
+
+Dynamcally enabled features are not written to the signal frame upon signal
+entry if the feature is in its initial configuration.  This differs from
+non-dynamic features which are always written regardless of their
+configuration.  Signal handlers can examine the XSAVE buffer's XSTATE_BV
+field to determine if a features was written.
diff --git a/arch/x86/include/asm/fpu/xcr.h b/arch/x86/include/asm/fpu/xcr.h
index 79f95d3..9656a5b 100644
--- a/arch/x86/include/asm/fpu/xcr.h
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_FPU_XCR_H
 
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
+#define XCR_XFEATURE_IN_USE_MASK	0x00000001
 
 static inline u64 xgetbv(u32 index)
 {
@@ -20,4 +21,15 @@ static inline void xsetbv(u32 index, u64 value)
 	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
 }
 
+/*
+ * Return a mask of xfeatures which are currently being tracked
+ * by the processor as being in the initial configuration.
+ *
+ * Callers should check X86_FEATURE_XGETBV1.
+ */
+static inline u64 xfeatures_in_use(void)
+{
+	return xgetbv(XCR_XFEATURE_IN_USE_MASK);
+}
+
 #endif /* _ASM_X86_FPU_XCR_H */
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 0f8b90a..cd3dd17 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -92,6 +92,13 @@
 #define XFEATURE_MASK_FPSTATE	(XFEATURE_MASK_USER_RESTORE | \
 				 XFEATURE_MASK_SUPERVISOR_SUPPORTED)
 
+/*
+ * Features in this mask have space allocated in the signal frame, but may not
+ * have that space initialized when the feature is in its init state.
+ */
+#define XFEATURE_MASK_SIGFRAME_INITOPT	(XFEATURE_MASK_XTILE | \
+					 XFEATURE_MASK_USER_DYNAMIC)
+
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index cb2fdd1..c881bca 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -76,6 +76,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{}
 };
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index e18210d..86ea7c0 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -4,6 +4,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm/fpu/xstate.h>
+#include <asm/fpu/xcr.h>
 
 #ifdef CONFIG_X86_64
 DECLARE_PER_CPU(u64, xfd_state);
@@ -199,6 +200,32 @@ static inline void os_xrstor_supervisor(struct fpstate *fpstate)
 }
 
 /*
+ * XSAVE itself always writes all requested xfeatures.  Removing features
+ * from the request bitmap reduces the features which are written.
+ * Generate a mask of features which must be written to a sigframe.  The
+ * unset features can be optimized away and not written.
+ *
+ * This optimization is user-visible.  Only use for states where
+ * uninitialized sigframe contents are tolerable, like dynamic features.
+ *
+ * Users of buffers produced with this optimization must check XSTATE_BV
+ * to determine which features have been optimized out.
+ */
+static inline u64 xfeatures_need_sigframe_write(void)
+{
+	u64 xfeaures_to_write;
+
+	/* In-use features must be written: */
+	xfeaures_to_write = xfeatures_in_use();
+
+	/* Also write all non-optimizable sigframe features: */
+	xfeaures_to_write |= XFEATURE_MASK_USER_SUPPORTED &
+			     ~XFEATURE_MASK_SIGFRAME_INITOPT;
+
+	return xfeaures_to_write;
+}
+
+/*
  * Save xstate to user space xsave area.
  *
  * We don't use modified optimization because xrstor/xrstors might track
@@ -220,10 +247,16 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	 */
 	struct fpstate *fpstate = current->thread.fpu.fpstate;
 	u64 mask = fpstate->user_xfeatures;
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
+	u32 lmask;
+	u32 hmask;
 	int err;
 
+	/* Optimize away writing unnecessary xfeatures: */
+	if (fpu_state_size_dynamic())
+		mask &= xfeatures_need_sigframe_write();
+
+	lmask = mask;
+	hmask = mask >> 32;
 	xfd_validate_state(fpstate, mask, false);
 
 	stac();
