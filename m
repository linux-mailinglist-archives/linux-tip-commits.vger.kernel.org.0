Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31C13B235E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFWWOM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhFWWMx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB975C061145;
        Wed, 23 Jun 2021 15:09:23 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486161;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OIiMrG0YpUkxOo1CTO/tzA4ts9ugpnMgcny0KXdkDU=;
        b=yT05Ohcsb+XTohwXstcZKGP03lxHXso+VntwQnlYrQAQziY0g/a9maMRch42v3a6uBzVTc
        l5o0//pcDyOoatEV+mVYuU2T0m5ZZo6smNv7O00lQWbOYTYbqLq7J1+g8S2gzwHMvy2uJN
        rwgy9cAdsae9IUrTq2A6muydGxTLZkWEyEu2QdxUGilrycOXfRbpuz0yalSvJeWg4mkH9x
        YuumQoficA+2ZaJbshwc0qWH8CQPQ5pBAfGHHm2istAT60qRrTQADlfxd7oZG/ucSLhpi4
        SzuM1AtgYxq+o28Q1q7ZJbjKGpTgR7nO6ujfjJxC0Wdc5+oS4Ljf+S9q1fTMJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486161;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OIiMrG0YpUkxOo1CTO/tzA4ts9ugpnMgcny0KXdkDU=;
        b=2DX0aNrnQhPQiT3xtP3ysFfuA3qO0DLALbjk8J2lgQb1YHOFoOfoyL+UGUAeRBmjA30dHQ
        U0lpO+4tESEj4IBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename xstate copy functions which are
 related to UABI
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.318485015@linutronix.de>
References: <20210623121454.318485015@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616075.395.12050105146268882331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1cc34413ff3f18c30e5df89fefd95cc0f3b3292e
Gitweb:        https://git.kernel.org/tip/1cc34413ff3f18c30e5df89fefd95cc0f3b3292e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:57 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:23:14 +02:00

x86/fpu: Rename xstate copy functions which are related to UABI

Rename them to reflect that these functions deal with user space format
XSAVE buffers.

      copy_kernel_to_xstate() -> copy_uabi_from_kernel_to_xstate()
      copy_user_to_xstate()   -> copy_sigframe_from_user_to_xstate()

Again a clear statement that these functions deal with user space ABI.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121454.318485015@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h | 4 ++--
 arch/x86/kernel/fpu/regset.c      | 2 +-
 arch/x86/kernel/fpu/signal.c      | 2 +-
 arch/x86/kernel/fpu/xstate.c      | 5 +++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 6611e06..00e1a2a 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -102,8 +102,8 @@ extern void __init update_regset_xstate_info(unsigned int size,
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index ddc290d..892aec1 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -166,7 +166,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	}
 
 	fpu_force_restore(fpu);
-	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
 out:
 	vfree(tmpbuf);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 430c66d..fd4b58d 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -422,7 +422,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
-		ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
+		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
 			goto out;
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4fca8a8..57674f8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1099,7 +1099,7 @@ static inline bool mxcsr_valid(struct xstate_header *hdr, const u32 *mxcsr)
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
  * and copy to the target thread. This is called from xstateregs_set().
  */
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 {
 	unsigned int offset, size;
 	int i;
@@ -1154,7 +1154,8 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
+				      const void __user *ubuf)
 {
 	unsigned int offset, size;
 	int i;
