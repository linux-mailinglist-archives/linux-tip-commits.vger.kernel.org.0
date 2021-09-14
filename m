Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2F40B7D5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhINTUz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhINTUu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0EAC061574;
        Tue, 14 Sep 2021 12:19:31 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:19:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdPgAdfBR7E9CncrdDdAhyeo2fJ2w1PbAeQ0hGR7Z84=;
        b=ksx9E6u8ekIxZyUkPhbMiIdyget8qk3MyKd46eE/RdZtczdWGGsJejYxsafSQN3vfPbVnC
        hgJkk5iNBSK1DtcBVWv6X7/1Wc+jKAt6vsJPzMmeNkNTrjW84JsRD3B9+vpzT9DAO3YEZO
        Us61n1nlafCl4ev1ZdQQ1wUa9THuau70WbyURYmDP8b8/9dR1cQ7cTBTNR4ej+nzW+iV3T
        5o7u4Ns8MJMDw20eaTneitp2UWTHUg6HgDkG6g4FmZDibTZfPnQw+W9B8R2c7p/D38gz7H
        frgxhGGWKGihaPI9iSqmwlysf+4OqjwfqwylcfdmC6E8MvmoRt31ryG5ocYsqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdPgAdfBR7E9CncrdDdAhyeo2fJ2w1PbAeQ0hGR7Z84=;
        b=i2qlvv1iJFhnzz1o0hp+kQ8/tyL/7ArmcMJkA7Lw6XAYZHFr6GnqsgJ2a8ekuVvlqHGMqh
        sj/qrhXr4dkDvABw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Move xstate clearing out of
 copy_fpregs_to_sigframe()
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.679356300@linutronix.de>
References: <20210908132525.679356300@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164716939.25758.6732472654287211248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     fcfb7163329ce832aafef31f26345ef5e8642a17
Gitweb:        https://git.kernel.org/tip/fcfb7163329ce832aafef31f26345ef5e8642a17
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:03 +02:00

x86/fpu/signal: Move xstate clearing out of copy_fpregs_to_sigframe()

When the direct saving of the FPU registers to the user space sigframe
fails, copy_fpregs_to_sigframe() attempts to clear the user buffer.

The most likely reason for such a fail is a page fault. As
copy_fpregs_to_sigframe() is invoked with pagefaults disabled the chance
that __clear_user() succeeds is minuscule.

Move the clearing out into the caller which replaces the
fault_in_pages_writeable() in that error handling path.

The return value confusion will be cleaned up separately.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.679356300@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5ca3ce9..c4abbd9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -136,18 +136,12 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 {
-	int err;
-
 	if (use_xsave())
-		err = xsave_to_user_sigframe(buf);
-	else if (use_fxsr())
-		err = fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
+		return xsave_to_user_sigframe(buf);
+	if (use_fxsr())
+		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
-		err = fnsave_to_user_sigframe((struct fregs_state __user *) buf);
-
-	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
-		err = -EFAULT;
-	return err;
+		return fnsave_to_user_sigframe((struct fregs_state __user *) buf);
 }
 
 /*
@@ -218,9 +212,9 @@ retry:
 	fpregs_unlock();
 
 	if (ret) {
-		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
+		if (!__clear_user(buf_fx, fpu_user_xstate_size))
 			goto retry;
-		return -EFAULT;
+		return -1;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
