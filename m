Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9383B2309
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFWWLq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFWWL2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C04C061787;
        Wed, 23 Jun 2021 15:09:01 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=geV62Lw6No0PaFwzwBsezVp+2ZVUpxY2xbQj94HS5OM=;
        b=3uxfyXcBRB3FFwmtnI2RRLIrr+mW465LQGUPn2aSTQ7BaoUEnyhUK0cd8z7xJKjHP4RwCw
        ajB7oEW4wAWCfzfWQqfq7OFpkksjKRAVfEzRzex9ii4TAF2FsDsmHS4ESp46ag6tVVUt0A
        qlTG3dQfF7wnj1uhL9F1c/aaCVLqCG0nlFErL/4ROnPP2kSLDIVqY5NB1eImwKwUcTuSZP
        muqrMcKgnocvWAqYyZ35u7+O82ZhMiDYKMimdO4JqOdG4xRFELn7czYLFZ8cJJoc9IhGR7
        VugImfkecQNCe6ou2c0leVd+DPRKa26YzJvC7gkDfk5WTAMnCdRPxHuP2yA3JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=geV62Lw6No0PaFwzwBsezVp+2ZVUpxY2xbQj94HS5OM=;
        b=e2r9FQMBhok1yg9B/kyy0Q76Kq1UddphEPxdm2ZIvXdzvcrA2/mNlBe2KuPj9fW5F7ipXU
        flC7mVBQqUcZfnDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove PKRU handling from switch_fpu_finish()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.708180184@linutronix.de>
References: <20210623121456.708180184@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613819.395.13867457026604346047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     954436989cc550dd91aab98363240c9c0a4b7e23
Gitweb:        https://git.kernel.org/tip/954436989cc550dd91aab98363240c9c0a4b7e23
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:54:49 +02:00

x86/fpu: Remove PKRU handling from switch_fpu_finish()

PKRU is already updated and the xstate is not longer the proper source
of information.

 [ bp: Use cpu_feature_enabled() ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.708180184@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 34 +++-------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 2a484f5..528a868 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -523,39 +523,13 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 
 /*
- * Load PKRU from the FPU context if available. Delay loading of the
- * complete FPU state until the return to userland.
+ * Delay loading of the complete FPU state until the return to userland.
+ * PKRU is handled separately.
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu)
 {
-	u32 pkru_val = init_pkru_value;
-	struct pkru_state *pk;
-
-	if (!static_cpu_has(X86_FEATURE_FPU))
-		return;
-
-	set_thread_flag(TIF_NEED_FPU_LOAD);
-
-	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
-		return;
-
-	/*
-	 * PKRU state is switched eagerly because it needs to be valid before we
-	 * return to userland e.g. for a copy_to_user() operation.
-	 */
-	if (!(current->flags & PF_KTHREAD)) {
-		/*
-		 * If the PKRU bit in xsave.header.xfeatures is not set,
-		 * then the PKRU component was in init state, which means
-		 * XRSTOR will set PKRU to 0. If the bit is not set then
-		 * get_xsave_addr() will return NULL because the PKRU value
-		 * in memory is not valid. This means pkru_val has to be
-		 * set to 0 and not to init_pkru_value.
-		 */
-		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
-		pkru_val = pk ? pk->pkru : 0;
-	}
-	__write_pkru(pkru_val);
+	if (cpu_feature_enabled(X86_FEATURE_FPU))
+		set_thread_flag(TIF_NEED_FPU_LOAD);
 }
 
 #endif /* _ASM_X86_FPU_INTERNAL_H */
