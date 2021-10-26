Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2143B6D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhJZQTT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhJZQTL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:11 -0400
Date:   Tue, 26 Oct 2021 16:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Wr3qccRr8M5P+f1AnkLhT5aAVUH3gaiqqEQepV+NdE=;
        b=M4Jbd4zZuig4DI29/qqaWSoDVX4VMquHGr5SY1d3/SbJeYnSd697OvS1koP4DegMYUNG26
        Rm9wPsd8ayoX8nVniDr9igUD99Tls+5xqyO8eYykZnBHzxoYMkIhTqVnDfc+wI1TPvtM9N
        UPGw+1RFy25KfZXySiENYa1dp27Wb14b3j893llXKakXmoOQCLmVX1YVvs/U0J7iz7G9Bd
        6pziPmaDGs54pdr3yrgQxqs9+Qu7va4rcer/yyLxRxRx4taVIRKzpvLt3Itwrp1gjqwUgL
        OSKnrkeBilPsG9Io698LrjWYXXk95BTeAs0ToTbpCz9Ue22UVba+rVhr+x8C4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Wr3qccRr8M5P+f1AnkLhT5aAVUH3gaiqqEQepV+NdE=;
        b=s2cy5QmcAGNCp18YL3ql4snHund5/bwg4MkyLVqDK3N8T8B7RQbUr3L5Ocd7eCwH6rX6+s
        sWPdZH8ksPtJjdAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add fpu_state_config::legacy_features
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-6-chang.seok.bae@intel.com>
References: <20211021225527.10184-6-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500630.626.6169708152104186956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c33f0a81a2cf3920465309ce683534751bb86485
Gitweb:        https://git.kernel.org/tip/c33f0a81a2cf3920465309ce683534751bb86485
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Oct 2021 15:55:09 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/fpu: Add fpu_state_config::legacy_features

The upcoming prctl() which is required to request the permission for a
dynamically enabled feature will also provide an option to retrieve the
supported features. If the CPU does not support XSAVE, the supported
features would be 0 even when the CPU supports FP and SSE.

Provide separate storage for the legacy feature set to avoid that and fill
in the bits in the legacy init function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-6-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/types.h |  7 +++++++
 arch/x86/kernel/fpu/init.c       |  9 ++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c3ec562..595122f 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -503,6 +503,13 @@ struct fpu_state_config {
 	 * be requested by user space before usage.
 	 */
 	u64 default_features;
+	/*
+	 * @legacy_features:
+	 *
+	 * Features which can be reported back to user space
+	 * even without XSAVE support, i.e. legacy features FP + SSE
+	 */
+	u64 legacy_features;
 };
 
 /* FPU state configuration information */
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 7074154..621f4b6 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -193,12 +193,15 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	 * Note that the size configuration might be overwritten later
 	 * during fpu__init_system_xstate().
 	 */
-	if (!cpu_feature_enabled(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
 		size = sizeof(struct swregs_state);
-	else if (cpu_feature_enabled(X86_FEATURE_FXSR))
+	} else if (cpu_feature_enabled(X86_FEATURE_FXSR)) {
 		size = sizeof(struct fxregs_state);
-	else
+		fpu_user_cfg.legacy_features = XFEATURE_MASK_FPSSE;
+	} else {
 		size = sizeof(struct fregs_state);
+		fpu_user_cfg.legacy_features = XFEATURE_MASK_FP;
+	}
 
 	fpu_kernel_cfg.max_size = size;
 	fpu_kernel_cfg.default_size = size;
