Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D7A2A957B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Nov 2020 12:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgKFLdW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 06:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgKFLdV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 06:33:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64559C0613CF;
        Fri,  6 Nov 2020 03:33:21 -0800 (PST)
Date:   Fri, 06 Nov 2020 11:33:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604662399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlEqeO7COPc8YVrB7/iHncGzMAau6M6QIoK5iyoUq20=;
        b=PsTc1oLBTB0on8KZOjj9qUMSggWexV7gFZtkhQ2PM+YzuXN5neoywEi59MbBQ/T5ITGvyp
        QRMSf/BII4/PFVjOEucMFgixTBDqmL0r0Vwm660vk+/CWp+PLp46spFmdkiRnPfK5nCIPL
        CNwLajWT6+PvceSoW3hqd5a42BQmjXPsiCZbp8crVrgPE+dSGeNSxoJ9cC3sfKT6wCrMKL
        zmCnFCCGE5t6PPiCCqSOqTxjRH4iSNKHxvpEGYViHe2L7Fb2qalhql+AhEdKN9kBcY1Kg+
        WVzeid2fUIyIYspcELrBGeQbxsXNNeGLTIqMsbXDdSk+wWKAPP4RXORJYF1T4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604662399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlEqeO7COPc8YVrB7/iHncGzMAau6M6QIoK5iyoUq20=;
        b=iAnjAnz1qLAKf3zcVCFqSZJMfhkhyNZyVWQeOwOolUOD7jVMhLqJ3XQXWdaPInoMsQENDG
        4fstqidDhmsVWLCQ==
From:   "tip-bot2 for Anand K Mistry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
Cc:     Anand K Mistry <amistry@google.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201105163246.v2.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
References: <20201105163246.v2.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
MIME-Version: 1.0
Message-ID: <160466239867.397.14457746329220725421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1978b3a53a74e3230cd46932b149c6e62e832e9a
Gitweb:        https://git.kernel.org/tip/1978b3a53a74e3230cd46932b149c6e62e832e9a
Author:        Anand K Mistry <amistry@google.com>
AuthorDate:    Thu, 05 Nov 2020 16:33:04 +11:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 05 Nov 2020 21:43:34 +01:00

x86/speculation: Allow IBPB to be conditionally enabled on CPUs with always-on STIBP

On AMD CPUs which have the feature X86_FEATURE_AMD_STIBP_ALWAYS_ON,
STIBP is set to on and

  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED

At the same time, IBPB can be set to conditional.

However, this leads to the case where it's impossible to turn on IBPB
for a process because in the PR_SPEC_DISABLE case in ib_prctl_set() the

  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED

condition leads to a return before the task flag is set. Similarly,
ib_prctl_get() will return PR_SPEC_DISABLE even though IBPB is set to
conditional.

More generally, the following cases are possible:

1. STIBP = conditional && IBPB = on for spectre_v2_user=seccomp,ibpb
2. STIBP = on && IBPB = conditional for AMD CPUs with
   X86_FEATURE_AMD_STIBP_ALWAYS_ON

The first case functions correctly today, but only because
spectre_v2_user_ibpb isn't updated to reflect the IBPB mode.

At a high level, this change does one thing. If either STIBP or IBPB
is set to conditional, allow the prctl to change the task flag.
Also, reflect that capability when querying the state. This isn't
perfect since it doesn't take into account if only STIBP or IBPB is
unconditionally on. But it allows the conditional feature to work as
expected, without affecting the unconditional one.

 [ bp: Massage commit message and comment; space out statements for
   better readability. ]

Fixes: 21998a351512 ("x86/speculation: Avoid force-disabling IBPB based on STIBP and enhanced IBRS.")
Signed-off-by: Anand K Mistry <amistry@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20201105163246.v2.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid
---
 arch/x86/kernel/cpu/bugs.c | 51 +++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d3f0db4..581fb72 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1254,6 +1254,14 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static bool is_spec_ib_user_controlled(void)
+{
+	return spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
+		spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
+		spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
+		spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP;
+}
+
 static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
@@ -1261,16 +1269,26 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return 0;
+
 		/*
-		 * Indirect branch speculation is always disabled in strict
-		 * mode. It can neither be enabled if it was force-disabled
-		 * by a  previous prctl call.
+		 * With strict mode for both IBPB and STIBP, the instruction
+		 * code paths avoid checking this task flag and instead,
+		 * unconditionally run the instruction. However, STIBP and IBPB
+		 * are independent and either can be set to conditionally
+		 * enabled regardless of the mode of the other.
+		 *
+		 * If either is set to conditional, allow the task flag to be
+		 * updated, unless it was force-disabled by a previous prctl
+		 * call. Currently, this is possible on an AMD CPU which has the
+		 * feature X86_FEATURE_AMD_STIBP_ALWAYS_ON. In this case, if the
+		 * kernel is booted with 'spectre_v2_user=seccomp', then
+		 * spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP and
+		 * spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED.
 		 */
-		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
+		if (!is_spec_ib_user_controlled() ||
 		    task_spec_ib_force_disable(task))
 			return -EPERM;
+
 		task_clear_spec_ib_disable(task);
 		task_update_spec_tif(task);
 		break;
@@ -1283,10 +1301,10 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return -EPERM;
-		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+
+		if (!is_spec_ib_user_controlled())
 			return 0;
+
 		task_set_spec_ib_disable(task);
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
 			task_set_spec_ib_force_disable(task);
@@ -1351,20 +1369,17 @@ static int ib_prctl_get(struct task_struct *task)
 	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 	    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 		return PR_SPEC_ENABLE;
-	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
-		return PR_SPEC_DISABLE;
-	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
-	    spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP) {
+	else if (is_spec_ib_user_controlled()) {
 		if (task_spec_ib_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ib_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
-	} else
+	} else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+		return PR_SPEC_DISABLE;
+	else
 		return PR_SPEC_NOT_AFFECTED;
 }
 
