Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38383437EE6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 21:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhJVT6y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhJVT6u (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 15:58:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EB7C061243;
        Fri, 22 Oct 2021 12:56:32 -0700 (PDT)
Date:   Fri, 22 Oct 2021 19:56:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634932591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wgWuXb4Xp+NpekkTPYrvo5P+nigeqvMYrAaYrLXGDIM=;
        b=3zn7B6ASEp/o0HryzBUJOtFq0tZRpShrmMzuotE4xVVN0CAroJA+EQFxh4wKk7f6SasY+s
        6ypbKD+Sbs1zNu7dhvEGgxpMcrafgQSNDhipdUkSv7zK0wps0lkiIsS0FHIGWN8CLpNJ+s
        kX3nUNKnx0eu381BnroM1m5LMQZ9FBdGFRP9uWdbCadHxWWa0Lnlg0oGGTmiX01nfS5Fej
        jeJlIfivFf7fauC0EWhXov8T6xRIzLWuYyyYfEwS1KsNQXJkgF6RqZQuTB91pNlVs5/RY+
        asZqtfMygV/Ryf9KONf39s9laORavefOTmtqeTMq6oUL7yN9GP7I+vRhmJr85w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634932591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wgWuXb4Xp+NpekkTPYrvo5P+nigeqvMYrAaYrLXGDIM=;
        b=NYzVabZql9NDpXRC+e5XkNLGNKJ8JIyMEL1f3wQEwCd/0/D+5qBXrShUqpk0tKT3G9NLZD
        i1A/TYd7clbmiWDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Cleanup size calculations
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211014230739.241223689@linutronix.de>
References: <20211014230739.241223689@linutronix.de>
MIME-Version: 1.0
Message-ID: <163493259027.626.1725088714660205738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     cd9ae761744912a96d7fd968b9c0173594e3f6be
Gitweb:        https://git.kernel.org/tip/cd9ae761744912a96d7fd968b9c0173594e3f6be
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 01:09:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 19:37:53 +02:00

x86/fpu/xstate: Cleanup size calculations

The size calculations are partially unreadable gunk. Clean them up.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211014230739.241223689@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 82 +++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4cfd3bc..c5582bd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -527,7 +527,7 @@ static void __init __xstate_dump_leaves(void)
  * that our software representation matches what the CPU
  * tells us about the state's size.
  */
-static void __init check_xstate_against_struct(int nr)
+static bool __init check_xstate_against_struct(int nr)
 {
 	/*
 	 * Ask the CPU for the size of the state.
@@ -557,7 +557,9 @@ static void __init check_xstate_against_struct(int nr)
 	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_LBR))) {
 		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
 		XSTATE_WARN_ON(1);
+		return false;
 	}
+	return true;
 }
 
 /*
@@ -569,38 +571,44 @@ static void __init check_xstate_against_struct(int nr)
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
  */
-static void __init do_extra_xstate_size_checks(void)
+static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 {
-	int paranoid_xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
+	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
 
 	for_each_extended_xfeature(i, xfeatures_mask_all) {
-		check_xstate_against_struct(i);
+		if (!check_xstate_against_struct(i))
+			return false;
 		/*
 		 * Supervisor state components can be managed only by
 		 * XSAVES.
 		 */
-		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
-			XSTATE_WARN_ON(xfeature_is_supervisor(i));
+		if (!compacted && xfeature_is_supervisor(i)) {
+			XSTATE_WARN_ON(1);
+			return false;
+		}
 
 		/* Align from the end of the previous feature */
 		if (xfeature_is_aligned(i))
-			paranoid_xstate_size = ALIGN(paranoid_xstate_size, 64);
+			size = ALIGN(size, 64);
 		/*
-		 * The offset of a given state in the non-compacted
-		 * format is given to us in a CPUID leaf.  We check
-		 * them for being ordered (increasing offsets) in
-		 * setup_xstate_features(). XSAVES uses compacted format.
+		 * In compacted format the enabled features are packed,
+		 * i.e. disabled features do not occupy space.
+		 *
+		 * In non-compacted format the offsets are fixed and
+		 * disabled states still occupy space in the memory buffer.
 		 */
-		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
-			paranoid_xstate_size = xfeature_uncompacted_offset(i);
+		if (!compacted)
+			size = xfeature_uncompacted_offset(i);
 		/*
-		 * The compacted-format offset always depends on where
-		 * the previous state ended.
+		 * Add the feature size even for non-compacted format
+		 * to make the end result correct
 		 */
-		paranoid_xstate_size += xfeature_size(i);
+		size += xfeature_size(i);
 	}
-	XSTATE_WARN_ON(paranoid_xstate_size != fpu_kernel_xstate_size);
+	XSTATE_WARN_ON(size != kernel_size);
+	return size == kernel_size;
 }
 
 /*
@@ -653,7 +661,7 @@ static unsigned int __init get_xsaves_size_no_independent(void)
 	return size;
 }
 
-static unsigned int __init get_xsave_size(void)
+static unsigned int __init get_xsave_size_user(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	/*
@@ -684,31 +692,33 @@ static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
-	unsigned int possible_xstate_size;
-	unsigned int xsave_size;
+	unsigned int user_size, kernel_size;
 
-	xsave_size = get_xsave_size();
+	/* Uncompacted user space size */
+	user_size = get_xsave_size_user();
 
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size = get_xsaves_size_no_independent();
+	/*
+	 * XSAVES kernel size includes supervisor states and
+	 * uses compacted format.
+	 *
+	 * XSAVE does not support supervisor states so
+	 * kernel and user size is identical.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		kernel_size = get_xsaves_size_no_independent();
 	else
-		possible_xstate_size = xsave_size;
+		kernel_size = user_size;
 
-	/* Ensure we have the space to store all enabled: */
-	if (!is_supported_xstate_size(possible_xstate_size))
+	/* Ensure we have the space to store all enabled features. */
+	if (!is_supported_xstate_size(kernel_size))
 		return -EINVAL;
 
-	/*
-	 * The size is OK, we are definitely going to use xsave,
-	 * make it known to the world that we need more space.
-	 */
-	fpu_kernel_xstate_size = possible_xstate_size;
-	do_extra_xstate_size_checks();
+	if (!paranoid_xstate_size_valid(kernel_size))
+		return -EINVAL;
+
+	fpu_kernel_xstate_size = kernel_size;
+	fpu_user_xstate_size = user_size;
 
-	/*
-	 * User space is always in standard format.
-	 */
-	fpu_user_xstate_size = xsave_size;
 	return 0;
 }
 
