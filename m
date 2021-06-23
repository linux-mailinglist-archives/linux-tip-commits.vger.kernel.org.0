Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855493B236A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFWWO5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhFWWOB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:14:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402AC061151;
        Wed, 23 Jun 2021 15:09:37 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+8Zk9Uhm7tt9TJ7sAHUa09FhCJbssG/LxUd+ItZyxY=;
        b=gzBRXmHA94jWRwl6eUGPhz+PPImbWpOjADbSLuKehogB8ZKcweXIKb1ZKmJ1LRTYegHsvg
        Wm8tcCLw4IX0TMqjB6ZTOtoJs/ws63aAPEFM4bg3iozUjlpIvVSqb35Wlp7AYtu/8UsK9N
        xsbGlgLIddn4WAObc+f+cAxm9M4RGltTm2DbgZNGmN3AyvPvTRBnNMb19mny8qQjYY9iC3
        bLzgtNMMA+J89giCHpTb0kAisYdXMup3EGeJXUiQVyjxCYk2Z5DbsKZ0xAfdQTCkxwajwt
        f0+DmN+EedHd2waGqSl74xdbNFovcgQNOXcpM1dOwnBPFeWmU7Nsx4Ulqc6q0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+8Zk9Uhm7tt9TJ7sAHUa09FhCJbssG/LxUd+ItZyxY=;
        b=J7eVJsym48At0hK/dxEcg+xvuZVsvkWtJb4hek2H1c2NhJOWXE+P83V4iQjPB2bbXxZpuS
        Z2ML0oduotXJ0TDg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Clean up fpregs_set()
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.710467587@linutronix.de>
References: <20210623121452.710467587@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617534.395.10153901603325365763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     da53f60bb86e60830932926cf1093953a811912c
Gitweb:        https://git.kernel.org/tip/da53f60bb86e60830932926cf1093953a811912c
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 23 Jun 2021 14:01:41 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Clean up fpregs_set()

fpregs_set() has unnecessary complexity to support short or nonzero-offset
writes and to handle the case in which a copy from userspace overwrites
some of the target buffer and then fails.  Support for partial writes is
useless -- just require that the write has offset 0 and the correct size,
and copy into a temporary kernel buffer to avoid clobbering the state if
the user access fails.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.710467587@linutronix.de
---
 arch/x86/kernel/fpu/regset.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 5610f77..7041b14 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -304,31 +304,32 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	struct user_i387_ia32_struct env;
 	int ret;
 
-	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
+	/* No funny business with partial or oversized writes is permitted. */
+	if (pos != 0 || count != sizeof(struct user_i387_ia32_struct))
+		return -EINVAL;
 
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return fpregs_soft_set(target, regset, pos, count, kbuf, ubuf);
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
-		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &fpu->state.fsave, 0,
-					  -1);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
+	if (ret)
+		return ret;
 
-	if (pos > 0 || count < sizeof(env))
-		convert_from_fxsr(&env, target);
+	fpu__prepare_write(fpu);
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
-	if (!ret)
-		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
+	if (cpu_feature_enabled(X86_FEATURE_FXSR))
+		convert_to_fxsr(&fpu->state.fxsave, &env);
+	else
+		memcpy(&fpu->state.fsave, &env, sizeof(env));
 
 	/*
-	 * update the header bit in the xsave header, indicating the
+	 * Update the header bit in the xsave header, indicating the
 	 * presence of FP.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
+	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
 		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FP;
-	return ret;
+
+	return 0;
 }
 
 #endif	/* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
