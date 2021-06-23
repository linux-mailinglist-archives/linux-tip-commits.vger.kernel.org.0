Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50E13B2366
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFWWOp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFWWNp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:13:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C81C0617A8;
        Wed, 23 Jun 2021 15:09:31 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJIjIbpdXSUGURwsr2ClrWamHbcBp/3HOfY0DQHkcDs=;
        b=E7QdA7zexLtuAjNNuC+s2LWzO+F4EWtPFh6hH62xluVgd9JEQF7GGq4SOgwSu15zC5/SMS
        T8YwL8DRetxTrqr22gIIaeluM1AmFgOrG4c2OicBzzvGnhYpb5IAqhE76gyby76936YYuO
        9YvBhQpaIqqRWAQ5/1RYm67xGMOz34Q4AAjI4IpjRLWHTLsVDJhwsrteo5b6Qk0aJ3wbsg
        hs+QYp/8rXmXDhYKFltUoKcEMUKU2eatu49L/L6G0eVMRf2p2+2sF//mp1KDaXUN/td1bz
        9uq8eschPnNcYRscqk8ki7mHEkJ0nn1RlWQH1Q3m3HMxf88CP5e0sIogARX57w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJIjIbpdXSUGURwsr2ClrWamHbcBp/3HOfY0DQHkcDs=;
        b=EXqBQIasBNICfQBidBNy0uTMUwLqYCuHDNWRGZFi6SOSXKqtIrnoUthph2rU3y+wCivw9e
        qtln2WnUC21i7WAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Get rid of using_compacted_format()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.425493349@linutronix.de>
References: <20210623121453.425493349@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616902.395.11340261013461583078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     02b93c0b00df222b9ccf7a1fbd0eb59353d0a58c
Gitweb:        https://git.kernel.org/tip/02b93c0b00df222b9ccf7a1fbd0eb59353d0a58c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:48 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:47 +02:00

x86/fpu: Get rid of using_compacted_format()

This function is pointlessly global and a complete misnomer because it's
usage is related to both supervisor state checks and compacted format
checks. Remove it and just make the conditions check the XSAVES feature.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.425493349@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h |  1 -
 arch/x86/kernel/fpu/xstate.c      | 22 ++++------------------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 732ae79..6e5ba42 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -101,7 +101,6 @@ extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
-int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e17fde9..185cc5d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -449,20 +449,6 @@ int xfeature_size(int xfeature_nr)
 	return eax;
 }
 
-/*
- * 'XSAVES' implies two different things:
- * 1. saving of supervisor/system state
- * 2. using the compacted format
- *
- * Use this function when dealing with the compacted format so
- * that it is obvious which aspect of 'XSAVES' is being handled
- * by the calling code.
- */
-int using_compacted_format(void)
-{
-	return boot_cpu_has(X86_FEATURE_XSAVES);
-}
-
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
@@ -581,9 +567,9 @@ static void do_extra_xstate_size_checks(void)
 		check_xstate_against_struct(i);
 		/*
 		 * Supervisor state components can be managed only by
-		 * XSAVES, which is compacted-format only.
+		 * XSAVES.
 		 */
-		if (!using_compacted_format())
+		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
 			XSTATE_WARN_ON(xfeature_is_supervisor(i));
 
 		/* Align from the end of the previous feature */
@@ -593,9 +579,9 @@ static void do_extra_xstate_size_checks(void)
 		 * The offset of a given state in the non-compacted
 		 * format is given to us in a CPUID leaf.  We check
 		 * them for being ordered (increasing offsets) in
-		 * setup_xstate_features().
+		 * setup_xstate_features(). XSAVES uses compacted format.
 		 */
-		if (!using_compacted_format())
+		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
 			paranoid_xstate_size = xfeature_uncompacted_offset(i);
 		/*
 		 * The compacted-format offset always depends on where
