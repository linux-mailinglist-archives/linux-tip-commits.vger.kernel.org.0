Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D403B236E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhFWWPI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhFWWOL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:14:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3E5C061153;
        Wed, 23 Jun 2021 15:09:40 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5EWmVd0+smdN9HOChSX2nVA1fkRYxLBVpMUpkMhQH0=;
        b=d/JYNaU5P9pqMPspJEyJKkBc4FB3PkaT6R+KKeINt1v3MvP0JkzaSTQTIvXCOe9jqPFQQa
        3KYE2yS3rfPo/swGWjpJFPkzMKyIKTULYU5WQyMg18lZBNonDv3ajijJaRR1aRFlQRGQaI
        CJ+ncOaGUJuXekAXcUPDW6drdh4extE6Ile68a+Xe0fB5y2lo4vSa0XHjnqcLROi3BReb3
        xzmcIFmbPHL+ai9dtsDonf7MGJNlQHaSjKH29cIOquDwnkjSMccpYyVLlJsoZlI/8x6BY+
        ocIE5BPfLm+wTwjA1R/YVg0mV8zy97GuOnl7a7Zzz7t5CEyrCA887nCqYIOGMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5EWmVd0+smdN9HOChSX2nVA1fkRYxLBVpMUpkMhQH0=;
        b=GzFO2em1LfXzSxjXB29KxyQnHMbDAqSv2B2CLx8xV60k4wEiU0eZLeAn0qZDRx6UNYh7jL
        xI9UY35POOVSkyBQ==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Simplify PTRACE_GETREGS code
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.408457100@linutronix.de>
References: <20210623121452.408457100@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617793.395.65698642676508191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     3a3351126ee8f1f1c86c4c79c60a650c1da89733
Gitweb:        https://git.kernel.org/tip/3a3351126ee8f1f1c86c4c79c60a650c1da89733
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 23 Jun 2021 14:01:38 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Simplify PTRACE_GETREGS code

ptrace() has interfaces that let a ptracer inspect a ptracee's register state.
This includes XSAVE state.  The ptrace() ABI includes a hardware-format XSAVE
buffer for both the SETREGS and GETREGS interfaces.

In the old days, the kernel buffer and the ptrace() ABI buffer were the
same boring non-compacted format.  But, since the advent of supervisor
states and the compacted format, the kernel buffer has diverged from the
format presented in the ABI.

This leads to two paths in the kernel:
1. Effectively a verbatim copy_to_user() which just copies the kernel buffer
   out to userspace.  This is used when the kernel buffer is kept in the
   non-compacted form which means that it shares a format with the ptrace
   ABI.
2. A one-state-at-a-time path: copy_xstate_to_kernel().  This is theoretically
   slower since it does a bunch of piecemeal copies.

Remove the verbatim copy case.  Speed probably does not matter in this path,
and the vast majority of new hardware will use the one-state-at-a-time path
anyway.  This ensures greater testing for the "slow" path.

This also makes enabling PKRU in this interface easier since a single path
can be patched instead of two.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.408457100@linutronix.de
---
 arch/x86/kernel/fpu/regset.c | 24 +++---------------------
 arch/x86/kernel/fpu/xstate.c |  6 +++---
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index a50c0a9..d60e77d 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -77,32 +77,14 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
 	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
 
-	if (!boot_cpu_has(X86_FEATURE_XSAVE))
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	xsave = &fpu->state.xsave;
-
 	fpu__prepare_read(fpu);
 
-	if (using_compacted_format()) {
-		copy_xstate_to_kernel(to, xsave);
-		return 0;
-	} else {
-		fpstate_sanitize_xstate(fpu);
-		/*
-		 * Copy the 48 bytes defined by the software into the xsave
-		 * area in the thread struct, so that we can copy the whole
-		 * area to user using one user_regset_copyout().
-		 */
-		memcpy(&xsave->i387.sw_reserved, xstate_fx_sw_bytes, sizeof(xstate_fx_sw_bytes));
-
-		/*
-		 * Copy the xstate memory layout.
-		 */
-		return membuf_write(&to, xsave, fpu_user_xstate_size);
-	}
+	copy_xstate_to_kernel(to, &fpu->state.xsave);
+	return 0;
 }
 
 int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9cf84c5..4203247 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1069,11 +1069,11 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 }
 
 /*
- * Convert from kernel XSAVES compacted format to standard format and copy
- * to a kernel-space ptrace buffer.
+ * Convert from kernel XSAVE or XSAVES compacted format to UABI
+ * non-compacted format and copy to a kernel-space ptrace buffer.
  *
  * It supports partial copy but pos always starts from zero. This is called
- * from xstateregs_get() and there we check the CPU has XSAVES.
+ * from xstateregs_get() and there we check the CPU has XSAVE.
  */
 void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 {
