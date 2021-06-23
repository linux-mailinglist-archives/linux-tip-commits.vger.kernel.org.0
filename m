Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CDF3B234D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhFWWNa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhFWWMR (ORCPT
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
        bh=GqjKEJyPmKau2Fik4RSJE7wewh5qpazD+oCMy7A21dE=;
        b=Q0FXG56kxfLjwlWWeBYHAphA/TuBepNem2FZWbX9v8Jlomug8dVuN5ewinGAXVf8znrfyE
        NtXPWp56SKJ97rEPhqSAwrfkbJ7aGfcDNgoeOeU5oeI5WAiTEt6drosWx3Ta6UqpwRQfpB
        YGq9U1CSA/YY4Xw+BQ5kO02gc/8c0qSWb6I4RZPDDUvXPdvK1SJjmImCCRz3mAwWWeTx1+
        9S0+5Bnm6iXlhcUUiVISV3Vf8vHwOr5ZxGj0JVEeG/T2BV/IzuMOaezjUb8v7M86KcE4j4
        C93CZBMCs6MslgT6lT5c2bbhYSNvkIrLHP5e8gOlYvdut+kmYNWL7f+rv3gv9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqjKEJyPmKau2Fik4RSJE7wewh5qpazD+oCMy7A21dE=;
        b=zetmFMaqCIwzQNhKQEyVpCrEc+LQqfpuUugD0ukgBIhqon9tl0yx70NysdfWWCxQvawkOW
        EAV8QpLXFM7rjqBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Make xfeatures_mask_all __ro_after_init
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121451.712803952@linutronix.de>
References: <20210623121451.712803952@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448618412.395.6928422174395166793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     4e8e4313cf81add679e1c57677d689c02e382a67
Gitweb:        https://git.kernel.org/tip/4e8e4313cf81add679e1c57677d689c02e382a67
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:45 +02:00

x86/fpu: Make xfeatures_mask_all __ro_after_init

Nothing has to modify this after init.

But of course there is code which unconditionally masks
xfeatures_mask_all on CPU hotplug. This goes unnoticed during boot
hotplug because at that point the variable is still RW mapped.

This is broken in several ways:

  1) Masking this in post init CPU hotplug means that any
     modification of this state goes unnoticed until actual hotplug
     happens.

  2) If that ever happens then these bogus feature bits are already
     populated all over the place and the system is in inconsistent state
     vs. the compacted XSTATE offsets. If at all then this has to panic the
     machine because the inconsistency cannot be undone anymore.

Make this a one-time paranoia check in xstate init code and disable
xsave when this happens.

Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121451.712803952@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bcb9f56..a64f61a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -59,7 +59,7 @@ static short xsave_cpuid_features[] __initdata = {
  * This represents the full set of bits that should ever be set in a kernel
  * XSAVE buffer, both supervisor and user xstates.
  */
-u64 xfeatures_mask_all __read_mostly;
+u64 xfeatures_mask_all __ro_after_init;
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
@@ -213,19 +213,8 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
  */
 void fpu__init_cpu_xstate(void)
 {
-	u64 unsup_bits;
-
 	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
 		return;
-	/*
-	 * Unsupported supervisor xstates should not be found in
-	 * the xfeatures mask.
-	 */
-	unsup_bits = xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
-	WARN_ONCE(unsup_bits, "x86/fpu: Found unsupported supervisor xstates: 0x%llx\n",
-		  unsup_bits);
-
-	xfeatures_mask_all &= ~XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 
@@ -825,6 +814,7 @@ void __init fpu__init_system_xstate(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	static int on_boot_cpu __initdata = 1;
+	u64 xfeatures;
 	int err;
 	int i;
 
@@ -879,6 +869,8 @@ void __init fpu__init_system_xstate(void)
 	}
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
+	/* Store it for paranoia check at the end */
+	xfeatures = xfeatures_mask_all;
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -896,8 +888,18 @@ void __init fpu__init_system_xstate(void)
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
 	setup_supervisor_only_offsets();
-	print_xstate_offset_size();
 
+	/*
+	 * Paranoia check whether something in the setup modified the
+	 * xfeatures mask.
+	 */
+	if (xfeatures != xfeatures_mask_all) {
+		pr_err("x86/fpu: xfeatures modified from 0x%016llx to 0x%016llx during init, disabling XSAVE\n",
+		       xfeatures, xfeatures_mask_all);
+		goto out_disable;
+	}
+
+	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		xfeatures_mask_all,
 		fpu_kernel_xstate_size,
