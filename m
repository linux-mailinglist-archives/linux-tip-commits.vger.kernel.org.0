Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736EC436560
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhJUPOs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhJUPOq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:46 -0400
Date:   Thu, 21 Oct 2021 15:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LfVWdQ3/k0FSbMyDll2wCF8RFkb9kpR39jcOMz64E7Y=;
        b=Fna/yV1tZGtVphQufl6jdq/t1y1+fyLtZxlLO01jw2Ak/APqtCOWtRq4Og2807njjHZM9/
        9/tWbhNnk70PpWjU5NxtypwoRSUui0NcOIOo8CMtoNnzH7KV47BCSonaDKUrNIrFJ79xjT
        w+NYLy9PU9pNE/BDMkMpBkx/B/x+anZ/fbfzcE+ME42KwSY2DCUj6fQSzDamp7k3ck2i2k
        JHXQ1U5g+kKHO8RF4m57xJcA7fpcKP+rUSdj5bJBZ8V3jhz7NnK7nop2g3OOSzPf83Yzqj
        401LN1a5D94yL/WcGc34CGTqybcxj7w+StNcTW2SkYhm+SIdiCpM7lcGHJgGjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LfVWdQ3/k0FSbMyDll2wCF8RFkb9kpR39jcOMz64E7Y=;
        b=vmYj5xes/zKcOSI8fJ2mnvrjlszFLpxZIH+Chr7NeWU8v3r9v0WCYWuTsuDlUVFalZdw9r
        UxKu5wWEG11r1pCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add size and mask information to fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.921388806@linutronix.de>
References: <20211013145322.921388806@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482914864.25758.10748789820683816518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     248452ce21aeb08da2d2af23d88f890886bd379f
Gitweb:        https://git.kernel.org/tip/248452ce21aeb08da2d2af23d88f890886bd379f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:46 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 13:51:42 +02:00

x86/fpu: Add size and mask information to fpstate

Add state size and feature mask information to the fpstate container. This
will be used for runtime checks with the upcoming support for dynamically
enabled features and dynamically sized buffers. That avoids conditionals
all over the place as the required information is accessible for both
default and extended buffers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.921388806@linutronix.de
---
 arch/x86/include/asm/fpu/types.h | 12 ++++++++++++
 arch/x86/kernel/fpu/core.c       |  6 ++++++
 arch/x86/kernel/fpu/init.c       |  9 +++++++++
 arch/x86/kernel/fpu/xstate.c     |  3 +++
 4 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 297e3b4..3a12e97 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -310,6 +310,18 @@ union fpregs_state {
 };
 
 struct fpstate {
+	/* @kernel_size: The size of the kernel register image */
+	unsigned int		size;
+
+	/* @user_size: The size in non-compacted UABI format */
+	unsigned int		user_size;
+
+	/* @xfeatures:		xfeatures for which the storage is sized */
+	u64			xfeatures;
+
+	/* @user_xfeatures:	xfeatures valid in UABI buffers */
+	u64			user_xfeatures;
+
 	/* @regs: The register state union for all supported formats */
 	union fpregs_state		regs;
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index c6df975..a8cc20e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -342,6 +342,12 @@ void fpstate_reset(struct fpu *fpu)
 {
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
+
+	/* Initialize sizes and feature masks */
+	fpu->fpstate->size		= fpu_kernel_xstate_size;
+	fpu->fpstate->user_size		= fpu_user_xstate_size;
+	fpu->fpstate->xfeatures		= xfeatures_mask_all;
+	fpu->fpstate->user_xfeatures	= xfeatures_mask_uabi();
 }
 
 #if IS_ENABLED(CONFIG_KVM)
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index cffbaf4..65d763f 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -212,6 +212,14 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	}
 
 	fpu_user_xstate_size = fpu_kernel_xstate_size;
+	fpstate_reset(&current->thread.fpu);
+}
+
+static void __init fpu__init_init_fpstate(void)
+{
+	/* Bring init_fpstate size and features up to date */
+	init_fpstate.size		= fpu_kernel_xstate_size;
+	init_fpstate.xfeatures		= xfeatures_mask_all;
 }
 
 /*
@@ -233,4 +241,5 @@ void __init fpu__init_system(struct cpuinfo_x86 *c)
 	fpu__init_system_xstate_size_legacy();
 	fpu__init_system_xstate();
 	fpu__init_task_struct_size();
+	fpu__init_init_fpstate();
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index ca72a3e..4beb010 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -720,6 +720,7 @@ static void __init fpu__init_disable_system_xstate(void)
 	xfeatures_mask_all = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
+	fpstate_reset(&current->thread.fpu);
 }
 
 /*
@@ -792,6 +793,8 @@ void __init fpu__init_system_xstate(void)
 	if (err)
 		goto out_disable;
 
+	fpstate_reset(&current->thread.fpu);
+
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
