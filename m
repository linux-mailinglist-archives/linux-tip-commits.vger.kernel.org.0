Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B003B2355
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhFWWNt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhFWWM2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0EC0611BD;
        Wed, 23 Jun 2021 15:09:18 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGvyjP4MiFHiWDmS2HIZb1Gd6K9o9vXFF+e+FFFnmcE=;
        b=lkbsuJp6cVe3vzY4sXjp4pG/8M/Oz7cCeaW0NlQU00csDNesrnlNH189AtCYwKxZOtcGTO
        vzNhXkygBtSaN/FzjsAXsdCRjIg+Nmqo9+LdkLAttcFHVc5hZQ3OYkL4NMgdB4zF1nrUFh
        v+1cR3aXCbxVVMjGPiJm2G3JROxgVbIrxQOmXWzzrHnvAMh410vo1D2I/TkFfFk97JpAeh
        LhotO8IZJaoPVe8aD54U7mZurWe19GnsObhmyiaqAGkRAjV174jE4AZ65rl4DDJFc8+6qk
        QlSpJCzwck71xn5RGDs6n2+XUOxuZ1qOLHL2rO9VX3qU/Gt9zPXW9Q8x0xibXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGvyjP4MiFHiWDmS2HIZb1Gd6K9o9vXFF+e+FFFnmcE=;
        b=mwLdh3swVxcK7fflEJSw9+cjdsx93h8md7NzJiibyp9uq6vBXFyDzued6WmrCDlrv5+1JN
        GhmbQv4rxsfHovBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename initstate copy functions
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.816581630@linutronix.de>
References: <20210623121454.816581630@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615608.395.13395229865099167018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b76411b1b568311bfd89d03acc587ffc1548c26f
Gitweb:        https://git.kernel.org/tip/b76411b1b568311bfd89d03acc587ffc1548c26f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:02 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:39:53 +02:00

x86/fpu: Rename initstate copy functions

Again this not a copy. It's restoring register state from kernel memory.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121454.816581630@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index c290ba2..4a59e0f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -303,7 +303,7 @@ void fpu__drop(struct fpu *fpu)
  * Clear FPU registers by setting them up from the init fpstate.
  * Caller must do fpregs_[un]lock() around it.
  */
-static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
+static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
 		os_xrstor(&init_fpstate.xsave, features_mask);
@@ -338,9 +338,9 @@ static void fpu__clear(struct fpu *fpu, bool user_only)
 		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
 		    xfeatures_mask_supervisor())
 			os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
-		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
+		restore_fpregs_from_init_fpstate(xfeatures_mask_user());
 	} else {
-		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+		restore_fpregs_from_init_fpstate(xfeatures_mask_all);
 	}
 
 	fpregs_mark_activate();
