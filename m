Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469B33B234F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFWWNd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFWWMR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:17 -0400
Date:   Wed, 23 Jun 2021 22:09:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qaT5FIoqjad+G9GK3EoZpgbolUbnbjrANSnlq9qfrdc=;
        b=uCyM7HxWSufkb44qdMCPoim3A6dhCGAGYKLJ3G3NGBKtmq0ESjFmYkapyecDcBI+AEt3Uj
        8xan2WR8K6OWEdruLQtHHY1frU3IOCW83JqpY9jdWhrdmyEVIyYsXAFpPiRO2D8QGnk+GI
        pS6/mWwSPfY/2DoJKGpPxiRDVbo3gBZDfXJhsJQFgSsQKlfQMfF6RavXK3eAu7DwHFJ/BM
        t/iOGC0iGkb1VJajJlolIRvr7mcdK82SCxlmVGMcP4I5sM5Acsyc0+cYmi5iDo9nmOkUsO
        Uqu1/bzQ4bvPRIrvEl2K2Faie87VC2i3MZ4Cd/Jv870vfT488NXmmSR7+bvP3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qaT5FIoqjad+G9GK3EoZpgbolUbnbjrANSnlq9qfrdc=;
        b=9ddieqUndIE5eRLRP9UKMRHru7ec/FRiqd7nQkJprjx1iBaY/lOO8uwJZKWKE0vjphyPlw
        VFDoMZViFPmgl+Ag==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Mark various FPU state variables __ro_after_init
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121451.611751529@linutronix.de>
References: <20210623121451.611751529@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448618488.395.2557966179476192939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ce578f16348b003675c928a1992498b33b515f18
Gitweb:        https://git.kernel.org/tip/ce578f16348b003675c928a1992498b33b515f18
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:45 +02:00

x86/fpu: Mark various FPU state variables __ro_after_init

Nothing modifies these after booting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20210623121451.611751529@linutronix.de
---
 arch/x86/kernel/fpu/init.c   |  4 ++--
 arch/x86/kernel/fpu/xstate.c | 14 +++++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 701f196..95aa109 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -89,7 +89,7 @@ static void fpu__init_system_early_generic(struct cpuinfo_x86 *c)
 /*
  * Boot time FPU feature detection code:
  */
-unsigned int mxcsr_feature_mask __read_mostly = 0xffffffffu;
+unsigned int mxcsr_feature_mask __ro_after_init = 0xffffffffu;
 EXPORT_SYMBOL_GPL(mxcsr_feature_mask);
 
 static void __init fpu__init_system_mxcsr(void)
@@ -135,7 +135,7 @@ static void __init fpu__init_system_generic(void)
  * This is inherent to the XSAVE architecture which puts all state
  * components into a single, continuous memory block:
  */
-unsigned int fpu_kernel_xstate_size;
+unsigned int fpu_kernel_xstate_size __ro_after_init;
 EXPORT_SYMBOL_GPL(fpu_kernel_xstate_size);
 
 /* Get alignment of the TYPE. */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d822ce7..bcb9f56 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -61,17 +61,21 @@ static short xsave_cpuid_features[] __initdata = {
  */
 u64 xfeatures_mask_all __read_mostly;
 
-static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
  * it is always in standard format for user mode. This is the user
  * mode standard format size used for signal and ptrace frames.
  */
-unsigned int fpu_user_xstate_size;
+unsigned int fpu_user_xstate_size __ro_after_init;
 
 /*
  * Return whether the system supports a given xfeature.
