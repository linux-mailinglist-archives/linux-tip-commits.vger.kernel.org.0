Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A77434C66
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhJTNrE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhJTNqw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20DCC06174E;
        Wed, 20 Oct 2021 06:44:37 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udohcrWfhH8/3hGHK1nVfVczNHLqT9+IwhJSptnREWA=;
        b=RGgy7muxeFTi7iWXHJaeYQ8vY6COGCI+asi7R4zV+gExteJ6UbIn+qFHLLOGl19Yr8Zg17
        oBCZJAmhIe1i6S1Ap8oTtCsCEwPzcclwsusA0AxQJanKbPCI/os0tdviGyKz7XuDNerpO3
        35C1rTYHoRlJ+YRnJCMhYNVVicwECwkq1oiXr9Td0tIudLrA+CiIWzLwawv3W91BNGn3tt
        dRwJnsm9uWolTWgeqj4toccuehGO9BN9gK8Oo4UmC9yfltezezH0l5OPcdiYkzyLUwvEhq
        4vc9SGcOB09RK2y2rebUM9/1ASiKOVc95VoUzcd6UHjnV0pzPPtezC7NQDP+sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udohcrWfhH8/3hGHK1nVfVczNHLqT9+IwhJSptnREWA=;
        b=AKn6qsIgGunTbFMk/qDCaNC8Ww2UDeJN9I9pNngeO32qJnQU7bV7JLHGAbPQs5rfsZv39n
        CaOsHuvDWdqYFuBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Clean up CPU feature tests
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.401510559@linutronix.de>
References: <20211015011539.401510559@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747551.25758.3748133875700365209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     d06241f52cfe4a0580856ef2cfac90dc7f752cae
Gitweb:        https://git.kernel.org/tip/d06241f52cfe4a0580856ef2cfac90dc7f752cae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:27 +02:00

x86/fpu: Clean up CPU feature tests

Further disintegration of internal.h:

Move the CPU feature tests to a core header and remove the unused one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.401510559@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 18 ------------------
 arch/x86/kernel/fpu/core.c          |  1 +
 arch/x86/kernel/fpu/internal.h      | 11 +++++++++++
 arch/x86/kernel/fpu/regset.c        |  2 ++
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 398c87c..5da7528 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -51,24 +51,6 @@ extern void fpu__resume_cpu(void);
 # define WARN_ON_FPU(x) ({ (void)(x); 0; })
 #endif
 
-/*
- * FPU related CPU feature flag helper routines:
- */
-static __always_inline __pure bool use_xsaveopt(void)
-{
-	return static_cpu_has(X86_FEATURE_XSAVEOPT);
-}
-
-static __always_inline __pure bool use_xsave(void)
-{
-	return static_cpu_has(X86_FEATURE_XSAVE);
-}
-
-static __always_inline __pure bool use_fxsr(void)
-{
-	return static_cpu_has(X86_FEATURE_FXSR);
-}
-
 extern union fpregs_state init_fpstate;
 extern void fpstate_init_user(union fpregs_state *state);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e6087a6..e9b51c7 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -17,6 +17,7 @@
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
 
+#include "internal.h"
 #include "xstate.h"
 
 #define CREATE_TRACE_POINTS
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index 036f84c..a8aac21 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -2,6 +2,17 @@
 #ifndef __X86_KERNEL_FPU_INTERNAL_H
 #define __X86_KERNEL_FPU_INTERNAL_H
 
+/* CPU feature check wrappers */
+static __always_inline __pure bool use_xsave(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_XSAVE);
+}
+
+static __always_inline __pure bool use_fxsr(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_FXSR);
+}
+
 /* Init functions */
 extern void fpu__init_prepare_fx_sw_frame(void);
 
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 66ed317..ccf0c59 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -10,6 +10,8 @@
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
 
+#include "internal.h"
+
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
  * as the "regset->n" for the xstate regset will be updated based on the feature
