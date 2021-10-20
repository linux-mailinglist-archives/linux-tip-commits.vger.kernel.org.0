Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E72434C72
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJTNrW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53044 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhJTNrA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:00 -0400
Date:   Wed, 20 Oct 2021 13:44:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgbxCbe3cWEMysitNbB2GHmA40748Wm2ej504kwUxpU=;
        b=lfcofn0Wk9nWiBEbz89gBbj5WtQFdeJJlQvcaPryELmopfDN9Wz2aNYYPdH+XFrdbXyKXe
        fzxHWFvoxI6I/KntyIaxn7xv6dSvtwg2LPogfV/z7Idmt4fUWPONG/Ug304DGPt4xEONgI
        BNCnJALyLXCF1akJ9KdUpaz48NTvgHr5P5CiQSr0/Dx+B+4o0nwhMA76GQQI2K1PCt58t+
        8mu+NgXuNy1ChUu7ZbZEtYD1yA0YHpku+M888lfRfpLg3unYq6uJNsWSUMhKvR4qIvdrrE
        lEXUM5G0gF1d87xSKj/hOENaBjheYH37kHHRPie/WvQMWqDg8YBluTVD+QMt6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgbxCbe3cWEMysitNbB2GHmA40748Wm2ej504kwUxpU=;
        b=18GO1PKBXrompkdHBQU3FyFekfEciWKTXpStW/FTHwS9p2nI3V/ZKpHTPpWgqb4DGnAZHW
        LennvOiljxVIcbDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Cleanup the on_boot_cpu clutter
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.665080855@linutronix.de>
References: <20211015011538.665080855@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748367.25758.11192446058755577164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     dc2f39fd1bf23eee644d409b84e8e435606997bf
Gitweb:        https://git.kernel.org/tip/dc2f39fd1bf23eee644d409b84e8e435606997bf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:01 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:26 +02:00

x86/fpu: Cleanup the on_boot_cpu clutter

Defensive programming is useful, but this on_boot_cpu debug is really
silly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.665080855@linutronix.de
---
 arch/x86/kernel/fpu/init.c   | 16 ----------------
 arch/x86/kernel/fpu/xstate.c |  9 ---------
 2 files changed, 25 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 64e2992..86bc975 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -192,11 +192,6 @@ static void __init fpu__init_task_struct_size(void)
  */
 static void __init fpu__init_system_xstate_size_legacy(void)
 {
-	static int on_boot_cpu __initdata = 1;
-
-	WARN_ON_FPU(!on_boot_cpu);
-	on_boot_cpu = 0;
-
 	/*
 	 * Note that xstate sizes might be overwritten later during
 	 * fpu__init_system_xstate().
@@ -216,15 +211,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_user_xstate_size = fpu_kernel_xstate_size;
 }
 
-/* Legacy code to initialize eager fpu mode. */
-static void __init fpu__init_system_ctx_switch(void)
-{
-	static bool on_boot_cpu __initdata = 1;
-
-	WARN_ON_FPU(!on_boot_cpu);
-	on_boot_cpu = 0;
-}
-
 /*
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
@@ -243,6 +229,4 @@ void __init fpu__init_system(struct cpuinfo_x86 *c)
 	fpu__init_system_xstate_size_legacy();
 	fpu__init_system_xstate();
 	fpu__init_task_struct_size();
-
-	fpu__init_system_ctx_switch();
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5a76df9..d6b5f22 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -379,15 +379,10 @@ static void __init print_xstate_offset_size(void)
  */
 static void __init setup_init_fpu_buf(void)
 {
-	static int on_boot_cpu __initdata = 1;
-
 	BUILD_BUG_ON((XFEATURE_MASK_USER_SUPPORTED |
 		      XFEATURE_MASK_SUPERVISOR_SUPPORTED) !=
 		     XFEATURES_INIT_FPSTATE_HANDLED);
 
-	WARN_ON_FPU(!on_boot_cpu);
-	on_boot_cpu = 0;
-
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return;
 
@@ -721,14 +716,10 @@ static void fpu__init_disable_system_xstate(void)
 void __init fpu__init_system_xstate(void)
 {
 	unsigned int eax, ebx, ecx, edx;
-	static int on_boot_cpu __initdata = 1;
 	u64 xfeatures;
 	int err;
 	int i;
 
-	WARN_ON_FPU(!on_boot_cpu);
-	on_boot_cpu = 0;
-
 	if (!boot_cpu_has(X86_FEATURE_FPU)) {
 		pr_info("x86/fpu: No FPU detected\n");
 		return;
