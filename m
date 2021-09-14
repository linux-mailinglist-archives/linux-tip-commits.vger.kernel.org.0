Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152A040B7C6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhINTUo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhINTUo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:44 -0400
Date:   Tue, 14 Sep 2021 19:19:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qbyS1uGcxTt2tsO8kda0E/Wk219wEa7i9CVvoJjWQwA=;
        b=F6ULo5mXU54Y1oGuYtZkn9wV+Jjph7zvoGpSIT/XdoWG4FlXIzdRdX53bdGDsRU8alGDVg
        3TyynwcO6iim4dtTNPJys3rO3h5HertET4tBpW03Zh0BamE7wGtGS2F46d1Ja8m8uh/vjk
        NytregW/ygcux4ibKHCcUOvKFRpH9IUw+icNH7FxRz7bRIbOiZ98tP1OhTLEgb/RmZEXB7
        BVWUdm2Li5uWLdX99JkojipwWeuWJaAbyQvvhZcXAQCN3oVTg/ZyCXqny26oXE+nHydu3Z
        K/FPzoEOixFoKchcLRcN5Cpt3LNerOM3mTPPITkI5WdqELXTkO3VNRKuixAQnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qbyS1uGcxTt2tsO8kda0E/Wk219wEa7i9CVvoJjWQwA=;
        b=BRMrvlAp7OyaPCy5sPnkq5AYklhQVl/xQtWhU+kA46hXGs/hxPVIO0Ly4Yl6xcqXP/bFcw
        KgXuoEQxGnTtXRDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Change return code of
 check_xstate_in_sigframe() to boolean
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132526.024024598@linutronix.de>
References: <20210908132526.024024598@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164716469.25758.8633420234882203762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     be0040144152ed834c369a7830487e5ee4f27080
Gitweb:        https://git.kernel.org/tip/be0040144152ed834c369a7830487e5ee4f27080
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:04 +02:00

x86/fpu/signal: Change return code of check_xstate_in_sigframe() to boolean

__fpu_sig_restore() only needs success/fail information and no detailed
error code.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132526.024024598@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 912d770..2bd4d51 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -23,8 +23,8 @@ static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
  */
-static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
-					   struct _fpx_sw_bytes *fx_sw)
+static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
+					    struct _fpx_sw_bytes *fx_sw)
 {
 	int min_xstate_size = sizeof(struct fxregs_state) +
 			      sizeof(struct xstate_header);
@@ -32,7 +32,7 @@ static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	unsigned int magic2;
 
 	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
-		return -EFAULT;
+		return false;
 
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
@@ -48,10 +48,10 @@ static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	 * in the memory layout.
 	 */
 	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
-		return -EFAULT;
+		return false;
 
 	if (likely(magic2 == FP_XSTATE_MAGIC2))
-		return 0;
+		return true;
 setfx:
 	trace_x86_fpu_xstate_check_failed(&current->thread.fpu);
 
@@ -59,7 +59,7 @@ setfx:
 	fx_sw->magic1 = 0;
 	fx_sw->xstate_size = sizeof(struct fxregs_state);
 	fx_sw->xfeatures = XFEATURE_MASK_FPSSE;
-	return 0;
+	return true;
 }
 
 /*
@@ -324,7 +324,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
 
-		if (check_xstate_in_sigframe(buf_fx, &fx_sw_user))
+		if (!check_xstate_in_sigframe(buf_fx, &fx_sw_user))
 			return false;
 
 		fx_only = !fx_sw_user.magic1;
