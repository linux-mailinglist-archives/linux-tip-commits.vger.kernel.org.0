Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64FC434C77
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJTNr0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhJTNrB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:01 -0400
Date:   Wed, 20 Oct 2021 13:44:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOjwZg4zVaj2zYi1pMF+VbI8PGN5fFcd32YxQ4ffHsI=;
        b=ZuyqJtDqpGGaCO/kKMyT/T/BOuS93/DeRZyTNXKJHELujWdQT81GjB5LKqdCjOQKuPU/9v
        HiFyIQEYAc+M9fRjKZ3KpFCKsx2Y/tl5ToY5BdP9ytxrGPbbi2BQjnnhxcf/VyjxqM+ReQ
        K0j9CuLUWhKBFQyiogvHqIhs3C8szuEe4mppIKVObK3WrKH4n6Cf+kqJHe3h3cm+Xoqgi0
        bomvR/Ncug8Ay1ZSz1Fh3T+xMVflia8/PCcOsXLYSIP1Z+i14vZ0ORdxzROQsQ7qmWYRli
        /PSk5VU6/9L7m/C7qBk/zA2Gqqb+pMzh7AAVj1Qp7SxzsEC+8looypf6Vaz76w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOjwZg4zVaj2zYi1pMF+VbI8PGN5fFcd32YxQ4ffHsI=;
        b=lzdHhTizNtg9Paz+9wJyg/W24hSXx5rmF0WYpu5zldyxCSUoT+ezUJoY+WsoYEtr80GCBv
        L7IfMo+XcKblRNBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Update stale comments
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.493570236@linutronix.de>
References: <20211015011538.493570236@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748569.25758.9188796380443901574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     d2d926482cdfbd5517826eca4e39dcd8757f04d3
Gitweb:        https://git.kernel.org/tip/d2d926482cdfbd5517826eca4e39dcd8757f04d3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:15:56 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:25 +02:00

x86/fpu: Update stale comments

copy_fpstate_to_sigframe() does not have a slow path anymore. Neither does
the !ia32 restore in __fpu_restore_sig().

Update the comments accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.493570236@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 51c4915..e257805 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -155,10 +155,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  *	buf == buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf != buf_fx for 32-bit frames with fxstate.
  *
- * Try to save it directly to the user frame with disabled page fault handler.
- * If this fails then do the slow path where the FPU state is first saved to
- * task's fpu->state and then copy it to the user frame pointed to by the
- * aligned pointer 'buf_fx'.
+ * Save it directly to the user frame with disabled page fault handler. If
+ * that faults, try to clear the frame which handles the page fault.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -334,12 +332,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	}
 
 	if (likely(!ia32_fxstate)) {
-		/*
-		 * Attempt to restore the FPU registers directly from user
-		 * memory. For that to succeed, the user access cannot cause page
-		 * faults. If it does, fall back to the slow path below, going
-		 * through the kernel buffer with the enabled pagefault handler.
-		 */
+		/* Restore the FPU registers directly from user memory. */
 		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
 						state_size);
 	}
