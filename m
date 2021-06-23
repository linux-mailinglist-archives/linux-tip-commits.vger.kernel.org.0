Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB52D3B2306
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFWWLm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFWWLY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:24 -0400
Date:   Wed, 23 Jun 2021 22:09:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8Gj09o/ueaaBiBS5p4XWwcA7rzzOgIuoAr2XGfslbU=;
        b=VkJEsb4RyP1K5CW0hAbMHvYigIvwu9JxhD84kAFDJKRtrMDECm/GswLa5OmHFkZq4UmjMM
        xFMsDePpshVyxV7dq0l12olepMV52k09kkLxxPZGfIFUVCs6TGb+b8/TXDsv0IXqrUIWQg
        NZsN9LkyjD4dsbzcVcQ556Azz+apve0VWdum5SrNMXUDVZtpHAEdxZT+NAuuD7waa2VeME
        2YDdiXKQHuLCYn55Xez4d01r+K7B+beRTlAabddENeadbKJILGDBorL2xgytZv6l804eth
        7tQOVAgBUbpOQyhwWLXPN0S8ScNW29p5mhSMbp/75USHYauPRZwvBHcZqAb8dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8Gj09o/ueaaBiBS5p4XWwcA7rzzOgIuoAr2XGfslbU=;
        b=IDPd03qZeQJ30pxGEBLsRpm4mTl/Zmxt1ZeDNq+NnlOmjze+FqbGxSJ3G5sDHlHWXfjZD4
        DNl3TINZnEQZVuCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename __fpregs_load_activate() to
 fpregs_restore_userregs()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.018867925@linutronix.de>
References: <20210623121456.018867925@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614524.395.17075159464260599808.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     727d01100e15b18c67f05fb697779ad2a6c99b63
Gitweb:        https://git.kernel.org/tip/727d01100e15b18c67f05fb697779ad2a6c99b63
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:14 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:23:40 +02:00

x86/fpu: Rename __fpregs_load_activate() to fpregs_restore_userregs()

Rename it so that it becomes entirely clear what this function is
about. It's purpose is to restore the FPU registers to the state which was
saved in the task's FPU memory state either at context switch or by an in
kernel FPU user.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.018867925@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 6 ++----
 arch/x86/kernel/fpu/core.c          | 2 +-
 arch/x86/kernel/fpu/signal.c        | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index dabbb70..f7688f6 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -465,10 +465,8 @@ static inline void fpregs_activate(struct fpu *fpu)
 	trace_x86_fpu_regs_activated(fpu);
 }
 
-/*
- * Internal helper, do not use directly. Use switch_fpu_return() instead.
- */
-static inline void __fpregs_load_activate(void)
+/* Internal helper for switch_fpu_return() and signal frame setup */
+static inline void fpregs_restore_userregs(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index aa7e808..6babf18 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -402,7 +402,7 @@ void switch_fpu_return(void)
 	if (!static_cpu_has(X86_FEATURE_FPU))
 		return;
 
-	__fpregs_load_activate();
+	fpregs_restore_userregs();
 }
 EXPORT_SYMBOL_GPL(switch_fpu_return);
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index fd4b58d..b12665c 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -188,7 +188,7 @@ retry:
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		__fpregs_load_activate();
+		fpregs_restore_userregs();
 
 	pagefault_disable();
 	ret = copy_fpregs_to_sigframe(buf_fx);
