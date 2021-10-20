Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54C4434C55
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhJTNqs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhJTNqq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395CC06161C;
        Wed, 20 Oct 2021 06:44:31 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNMJo4gflRo1hufQA8L/YJ6My3GE1UQeUpv3h4wL6Wg=;
        b=Jmu1u346v+P1CE8KfCaA37rCgBWGj6XT1qlkaKBSfF9ZlDne1FPNceIXLNlhxd/WscMoIR
        KkbMZSX1LQ8oqzgHRthEuhBN04w486RJ1J/jMBAt/qO8WxAjllX+0+JVx1jmQLBSdcZMgv
        E3Z+mZZUS7VO6VJUq+gGlDTO39dWFdK5D56EBX9yv5ORUTN8U/r9L+2fP/WIWvDvZvMWyq
        C5ry+cu48z/c9Vp3zYN6qLyAVlvqD9bjLUTEeBMjD7B5rJGnuDc/xZlD1zVenUQe6Pt0nu
        YkGRLCjcRI/CUUA5/9aNHf0ggFS9TzIpznBLtr9WkuRXSxjX/C3Vu3GOnU3Tnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNMJo4gflRo1hufQA8L/YJ6My3GE1UQeUpv3h4wL6Wg=;
        b=FcwTIVy71tEec3GG0yLCpHzaLE1CJu5Q9IIe1qMcoRqL3Va8EiAEr1Y7KaI18SZx4sorJZ
        3IVV9t61GfEhDiBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Mop up the internal.h leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.948837194@linutronix.de>
References: <20211015011539.948837194@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473746866.25758.11966714138379782102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6415bb80926379310afd74800415f6ebf4bb5c31
Gitweb:        https://git.kernel.org/tip/6415bb80926379310afd74800415f6ebf4bb5c31
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:38 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:29 +02:00

x86/fpu: Mop up the internal.h leftovers

Move the global interfaces to api.h and the rest into the core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.948837194@linutronix.de
---
 arch/x86/include/asm/fpu/api.h      | 10 ++++++++++
 arch/x86/include/asm/fpu/internal.h | 18 ------------------
 arch/x86/kernel/fpu/init.c          |  1 +
 arch/x86/kernel/fpu/xstate.h        |  3 +++
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 17893af..c691f07 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -110,6 +110,16 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
 
 static inline void update_pasid(void) { }
 
+/* Trap handling */
+extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
+extern void fpu_sync_fpstate(struct fpu *fpu);
+
+/* Boot, hotplug and resume */
+extern void fpu__init_cpu(void);
+extern void fpu__init_system(struct cpuinfo_x86 *c);
+extern void fpu__init_check_bugs(void);
+extern void fpu__resume_cpu(void);
+
 #ifdef CONFIG_MATH_EMULATION
 extern void fpstate_init_soft(struct swregs_state *soft);
 #else
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 8f97d3e..8df83e8 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -23,22 +23,4 @@
 #include <asm/cpufeature.h>
 #include <asm/trace/fpu.h>
 
-/*
- * High level FPU state handling functions:
- */
-extern void fpu__clear_user_states(struct fpu *fpu);
-extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
-
-extern void fpu_sync_fpstate(struct fpu *fpu);
-
-/*
- * Boot time FPU initialization functions:
- */
-extern void fpu__init_cpu(void);
-extern void fpu__init_system_xstate(void);
-extern void fpu__init_cpu_xstate(void);
-extern void fpu__init_system(struct cpuinfo_x86 *c);
-extern void fpu__init_check_bugs(void);
-extern void fpu__resume_cpu(void);
-
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index e77084a..d420d29 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -12,6 +12,7 @@
 
 #include "internal.h"
 #include "legacy.h"
+#include "xstate.h"
 
 /*
  * Initialize the registers found in all CPUs, CR0 and CR4:
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index ae61baa..bb6d7d2 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -18,6 +18,9 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 extern void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
 				      u32 pkru_val, enum xstate_copy_mode copy_mode);
 
+extern void fpu__init_cpu_xstate(void);
+extern void fpu__init_system_xstate(void);
+
 /* XSAVE/XRSTOR wrapper functions */
 
 #ifdef CONFIG_X86_64
