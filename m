Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8219540B7CE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhINTUu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35346 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhINTUr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:47 -0400
Date:   Tue, 14 Sep 2021 19:19:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bc232R7rmwgGegkLoWgxJiiK3P1hZI5ttoMdfS+p9+o=;
        b=nPDMn6dfozRKFXl8Q/DdTgrux4vNXvWp65WlHBcVaguN8Cerjggjv9zu/r9UWhaGXkbdZz
        4NHw+AbE1holwGcg0SqO1pVHap8Ild7A9T70H8xgMmaBzf8+Hp4DjJLoUIroxs32/bhUvF
        XUAJKsOY0NbEmcoe/E0GazMnrT7tlptZoLG3CTttdKkRWbR4jQtPvfgePIsIQlxON9bh7T
        ZOSuCcuuHTBOLTJ+m48DdwaL4iRc6U4Q3ro345DL0Zo4G5OptSbu3Ic1etyAjyHBQpf+lk
        eogF9hQVo+nXOKyBHwPR0laZfQErot50VkmV0lnm9fK8NlJLW3IMq8jxSorQng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bc232R7rmwgGegkLoWgxJiiK3P1hZI5ttoMdfS+p9+o=;
        b=nw08rz7igD3pba3ieRieD3eg/OGfApFAgvj2xvF0190VwBHDopVk5EaJEfgU57z+3k3h7i
        p9XOnlvqekqnUyDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Change return type of
 copy_fpregs_to_sigframe() helpers to boolean
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.794334915@linutronix.de>
References: <20210908132525.794334915@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164716781.25758.2102777588293339042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2af07f3a6e9fb81331421ca24b26a96180d792dd
Gitweb:        https://git.kernel.org/tip/2af07f3a6e9fb81331421ca24b26a96180d792dd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:03 +02:00

x86/fpu/signal: Change return type of copy_fpregs_to_sigframe() helpers to boolean

Now that copy_fpregs_to_sigframe() returns boolean the individual return
codes in the related helper functions do not make sense anymore. Change
them to return boolean success/fail.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.794334915@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 7ce396d..1d10fe9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -65,7 +65,7 @@ setfx:
 /*
  * Signal frame handlers.
  */
-static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
+static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
 {
 	if (use_fxsr()) {
 		struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
@@ -82,18 +82,19 @@ static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
 		if (__copy_to_user(buf, &env, sizeof(env)) ||
 		    __put_user(xsave->i387.swd, &fp->status) ||
 		    __put_user(X86_FXSR_MAGIC, &fp->magic))
-			return -1;
+			return false;
 	} else {
 		struct fregs_state __user *fp = buf;
 		u32 swd;
+
 		if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
-			return -1;
+			return false;
 	}
 
-	return 0;
+	return true;
 }
 
-static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
+static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
 {
 	struct xregs_state __user *x = buf;
 	struct _fpx_sw_bytes *sw_bytes;
@@ -131,7 +132,7 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 
 	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
 
-	return err;
+	return !err;
 }
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
@@ -218,10 +219,10 @@ retry:
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
-	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
+	if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
 		return false;
 
-	if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
+	if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate))
 		return false;
 
 	return true;
