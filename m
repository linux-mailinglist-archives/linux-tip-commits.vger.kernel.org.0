Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1531434C59
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhJTNqt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhJTNqr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96736C061746;
        Wed, 20 Oct 2021 06:44:33 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjSeZS3F0XpuGlKd865J/mPbfrJ6zfGql17srvs9z0U=;
        b=46Wiks3edhSARB3y2eWVLoVhXRG5WlPN+b94JqORVcfjillKNO+SNnI/ikLipDr3rCzlJS
        4uf6Yvim807t7LCxosdDYzheGUJ8UXeSoUUhnIp58uCKpJFXKHRG8DQoGIj1/3sZSODGqv
        okD+UwmpOIC5Ddk+8sii9R71sYSm+fGSbuXJ90TsZtqx6Yml2GgTRh/CYfzNwkNlTG6UV1
        VP+UkXRvPEry6YJ9psIILganyI8bC+49TnOPwX0qk6M9/Pzi8L3DhWjof2r6BUKD10n/hu
        oduQ45pCnGcfHi/2B01IxeeVyZMTLWTg4dv7goCM/a9K0U4FFh6FtRAzbfsM0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjSeZS3F0XpuGlKd865J/mPbfrJ6zfGql17srvs9z0U=;
        b=xmBX9j0EgAxB2vjOp2fp/MdzLrok4so1pxDifhFuu0FAaFiq3xvPfQCY3ne4QMd8Cpi3x0
        SqpZd7EyOK1kBUCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move mxcsr related code to core
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.740012411@linutronix.de>
References: <20211015011539.740012411@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747141.25758.4849805315316320966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     d9d005f32aac7362a1998f4b7fdf8874e91546bd
Gitweb:        https://git.kernel.org/tip/d9d005f32aac7362a1998f4b7fdf8874e91546bd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:28 +02:00

x86/fpu: Move mxcsr related code to core

No need to expose that to code which only needs the XCR0 accessors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.740012411@linutronix.de
---
 arch/x86/include/asm/fpu/xcr.h | 11 -----------
 arch/x86/kernel/fpu/init.c     |  1 +
 arch/x86/kernel/fpu/legacy.h   |  7 +++++++
 arch/x86/kernel/fpu/regset.c   |  1 +
 arch/x86/kernel/fpu/xstate.c   |  3 ++-
 arch/x86/kvm/svm/sev.c         |  2 +-
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xcr.h b/arch/x86/include/asm/fpu/xcr.h
index 1c7ab8d..79f95d3 100644
--- a/arch/x86/include/asm/fpu/xcr.h
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -2,17 +2,6 @@
 #ifndef _ASM_X86_FPU_XCR_H
 #define _ASM_X86_FPU_XCR_H
 
-/*
- * MXCSR and XCR definitions:
- */
-
-static inline void ldmxcsr(u32 mxcsr)
-{
-	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
-}
-
-extern unsigned int mxcsr_feature_mask;
-
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
 
 static inline u64 xgetbv(u32 index)
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 24873df..e77084a 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 
 #include "internal.h"
+#include "legacy.h"
 
 /*
  * Initialize the registers found in all CPUs, CR0 and CR4:
diff --git a/arch/x86/kernel/fpu/legacy.h b/arch/x86/kernel/fpu/legacy.h
index 2ff36b0..17c26b1 100644
--- a/arch/x86/kernel/fpu/legacy.h
+++ b/arch/x86/kernel/fpu/legacy.h
@@ -4,6 +4,13 @@
 
 #include <asm/fpu/types.h>
 
+extern unsigned int mxcsr_feature_mask;
+
+static inline void ldmxcsr(u32 mxcsr)
+{
+	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
+}
+
 /*
  * Returns 0 on success or the trap number when the operation raises an
  * exception.
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index a40150e..3d8ed45 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -12,6 +12,7 @@
 
 #include "context.h"
 #include "internal.h"
+#include "legacy.h"
 
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 246a7fe..f0305b2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -14,8 +14,9 @@
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
-#include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
+#include <asm/fpu/signal.h>
+#include <asm/fpu/xcr.h>
 
 #include <asm/tlbflush.h>
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c36b5fe..3c57bd0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -17,10 +17,10 @@
 #include <linux/misc_cgroup.h>
 #include <linux/processor.h>
 #include <linux/trace_events.h>
-#include <asm/fpu/internal.h>
 
 #include <asm/pkru.h>
 #include <asm/trapnr.h>
+#include <asm/fpu/xcr.h>
 
 #include "x86.h"
 #include "svm.h"
