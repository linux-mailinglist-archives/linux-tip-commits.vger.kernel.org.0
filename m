Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546EF3B234B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhFWWN1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhFWWMR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:17 -0400
Date:   Wed, 23 Jun 2021 22:09:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIX3Rc+KIT2L5Z1FNyxJAHWspJojjdmh3WZGtlhmqZo=;
        b=1GA9jmuL6DNMAFrBa6URMG3a+OpW6VhuF51gukdBg/QJbwEJzgnGfbhU27Nb6f/zxJT1s2
        rEv0L+gSYZKyJhHIwwMYYYYGldAyZb1eiyaQb6XTcNHXNh8XUV5TGJjG2ND5SUYvMuwRtF
        GTODjc4LXgKPCVQ/lBRhvYLtTpLLTGbdQ9XRI4mclaCfcibhGgQMGKXyv1fGaUYfoU1elI
        dJv2TqZ7RYOUtBG1aKrrEchS3VAaZYtZywB5w/B7q39xEo4hxRXSnuNafadoyyHaMbeiGj
        ePirq4onMdTc3btdGf85zzopGgLjXk/cKjWPbER4Uc8ntLRgTPR+AHGMQ7+cfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIX3Rc+KIT2L5Z1FNyxJAHWspJojjdmh3WZGtlhmqZo=;
        b=A7niPolDI6TchCxv4LMbMUsalSPBr2giPjnYOyDekKWplK7gayFAcM2arv3tay5HzEYAOQ
        A1gIex21Xy1YzYCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Get rid of fpu__get_supported_xfeatures_mask()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121451.816404717@linutronix.de>
References: <20210623121451.816404717@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448618328.395.18020586563303994105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ce38f038ede735fd425ebda10d1758420a669a87
Gitweb:        https://git.kernel.org/tip/ce38f038ede735fd425ebda10d1758420a669a87
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Get rid of fpu__get_supported_xfeatures_mask()

This function is really not doing what the comment advertises:

 "Find supported xfeatures based on cpu features and command-line input.
  This must be called after fpu__init_parse_early_param() is called and
  xfeatures_mask is enumerated."

fpu__init_parse_early_param() does not exist anymore and the function just
returns a constant.

Remove it and fix the caller and get rid of further references to
fpu__init_parse_early_param().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121451.816404717@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  1 -
 arch/x86/kernel/cpu/common.c        |  5 ++---
 arch/x86/kernel/fpu/init.c          | 11 -----------
 arch/x86/kernel/fpu/xstate.c        |  4 +++-
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 16bf4d4..58f2082 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -45,7 +45,6 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system(struct cpuinfo_x86 *c);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
-extern u64 fpu__get_supported_xfeatures_mask(void);
 
 /*
  * Debugging facility:
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index dcbb11f..f875dea 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1715,9 +1715,8 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 }
 
 /*
- * clearcpuid= was already parsed in fpu__init_parse_early_param.
- * But we need to keep a dummy __setup around otherwise it would
- * show up as an environment variable for init.
+ * clearcpuid= was already parsed in cpu_parse_early_param().  This dummy
+ * function prevents it from becoming an environment variable for init.
  */
 static __init int setup_clearcpuid(char *arg)
 {
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 95aa109..64e2992 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -216,17 +216,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_user_xstate_size = fpu_kernel_xstate_size;
 }
 
-/*
- * Find supported xfeatures based on cpu features and command-line input.
- * This must be called after fpu__init_parse_early_param() is called and
- * xfeatures_mask is enumerated.
- */
-u64 __init fpu__get_supported_xfeatures_mask(void)
-{
-	return XFEATURE_MASK_USER_SUPPORTED |
-	       XFEATURE_MASK_SUPERVISOR_SUPPORTED;
-}
-
 /* Legacy code to initialize eager fpu mode. */
 static void __init fpu__init_system_ctx_switch(void)
 {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a64f61a..5e825ff 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -868,7 +868,9 @@ void __init fpu__init_system_xstate(void)
 			xfeatures_mask_all &= ~BIT_ULL(i);
 	}
 
-	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
+	xfeatures_mask_all &= XFEATURE_MASK_USER_SUPPORTED |
+			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+
 	/* Store it for paranoia check at the end */
 	xfeatures = xfeatures_mask_all;
 
