Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9145143B6BF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhJZQTC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbhJZQTB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38727C061745;
        Tue, 26 Oct 2021 09:16:37 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635264995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRxHLxeE6yj3JsElylths2zrdLubdQrWtXjqCFG2m2M=;
        b=t8lt1ozi97CZAzee0JVOHR1Jxq3FSV8U2N1IQVWxpbfMse0CUNQPMsUb62d8NRC6lZfa5N
        jpbv8teijafylhrV5HEJ0VbnNT+KMBrsQF9V4xEAyKebtc8Tzg+RUIfXfpRhpTAGtVmAFL
        M2K7mUjVG2CpulwIyc3Tl09u9h0VVlhn3rgtNQbD9wrSacgaKvAlKFtdok5lxYl21mdQz+
        SeoKNFz2YLA6LvNZSRtbHh7SAg6TIJTzU37FJspgPISksC+pMBFfgw+d4IlsP5AaqWuy4n
        r5zNswzfy02aD7HX4T7OriQa6eTTxh1x5Leq515Ytrh61uY39xlhAi59QexZ8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635264995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRxHLxeE6yj3JsElylths2zrdLubdQrWtXjqCFG2m2M=;
        b=CUsGxF62hQq/P3YonN2lLWjVUNuVrSwgGeewSNcH48Kwj/G4UXwHdsBvbW9tojXbY9cfA6
        s0UAuTOUVMPOOHCg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Calculate the default sizes independently
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-22-chang.seok.bae@intel.com>
References: <20211021225527.10184-22-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499487.626.4563266865851615075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2ae996e0c1a38ca57a52438ab9deec6761dcba62
Gitweb:        https://git.kernel.org/tip/2ae996e0c1a38ca57a52438ab9deec6761dcba62
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:25 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:53:02 +02:00

x86/fpu: Calculate the default sizes independently

When dynamically enabled states are supported the maximum and default sizes
for the kernel buffers and user space interfaces are not longer identical.

Put the necessary calculations in place which only take the default enabled
features into account.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211021225527.10184-22-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3372da8..b0f6e9a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -781,35 +781,40 @@ static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
-	unsigned int user_size, kernel_size;
+	unsigned int user_size, kernel_size, kernel_default_size;
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
 
 	/* Uncompacted user space size */
 	user_size = get_xsave_size_user();
 
 	/*
 	 * XSAVES kernel size includes supervisor states and
-	 * uses compacted format.
+	 * uses compacted format when available.
 	 *
 	 * XSAVE does not support supervisor states so
 	 * kernel and user size is identical.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+	if (compacted)
 		kernel_size = get_xsaves_size_no_independent();
 	else
 		kernel_size = user_size;
 
-	/* Ensure we have the space to store all enabled features. */
-	if (!is_supported_xstate_size(kernel_size))
+	kernel_default_size =
+		xstate_calculate_size(fpu_kernel_cfg.default_features, compacted);
+
+	/* Ensure we have the space to store all default enabled features. */
+	if (!is_supported_xstate_size(kernel_default_size))
 		return -EINVAL;
 
 	if (!paranoid_xstate_size_valid(kernel_size))
 		return -EINVAL;
 
-	/* Keep it the same for now */
 	fpu_kernel_cfg.max_size = kernel_size;
-	fpu_kernel_cfg.default_size = kernel_size;
 	fpu_user_cfg.max_size = user_size;
-	fpu_user_cfg.default_size = user_size;
+
+	fpu_kernel_cfg.default_size = kernel_default_size;
+	fpu_user_cfg.default_size =
+		xstate_calculate_size(fpu_user_cfg.default_features, false);
 
 	return 0;
 }
@@ -894,15 +899,21 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
 	}
 
+	if (!cpu_feature_enabled(X86_FEATURE_XFD))
+		fpu_kernel_cfg.max_features &= ~XFEATURE_MASK_USER_DYNAMIC;
+
 	fpu_kernel_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED |
 			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 
 	fpu_user_cfg.max_features = fpu_kernel_cfg.max_features;
 	fpu_user_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED;
 
-	/* Identical for now */
+	/* Clean out dynamic features from default */
 	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
+	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
+
 	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
+	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
 
 	/* Store it for paranoia check at the end */
 	xfeatures = fpu_kernel_cfg.max_features;
@@ -913,6 +924,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	if (err)
 		goto out_disable;
 
+	/* Reset the state for the current task */
 	fpstate_reset(&current->thread.fpu);
 
 	/*
