Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB3D43B6D1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhJZQTO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbhJZQTJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:09 -0400
Date:   Tue, 26 Oct 2021 16:16:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJRbY/GrZ7D0Pun0Xwm1h1SywxjxEEgj3WjWF3CP5Kc=;
        b=wFDo+uCyyDDbp1mIds/72WotpppgujPAZBCwH42QbOTqi8hUUwYnWzFjp3Vo5oTMWFVrET
        ssBmLNzGZKvi50zhK0U6lbatBVTm5UpJsuohbFaSIFNWbG0/kFqkWzgus6MlAnTydU9AXo
        CXgBDFgQgAwiMw1lRm4axH2JW9MLhokoSt/wx5Hxpr4ABNaW+69U49tl+asVO6F9lxIgza
        Uy290eouSATBjXiZwjvFaqcP+GYRzmppzJbZiVx9UCJuuifAvzD7c+rXeQDPC0beujTiLt
        2BJYrOD1qECiTgC+V5AwE2Q+5h3UKsumyFEBBwOZXsgxJBJZtxN06nHYTFA+aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJRbY/GrZ7D0Pun0Xwm1h1SywxjxEEgj3WjWF3CP5Kc=;
        b=1bvQ5qololAWt4tn8oK+s7blBcafE8i8V6ZfHmdfx4TmN3/IOf/rtKxENlOhCJ+GQPGuk3
        bdU35w44F4E8lWAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/signal: Use fpu::__state_user_size for sigalt
 stack validation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-9-chang.seok.bae@intel.com>
References: <20211021225527.10184-9-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500418.626.11244235462470654228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     4b7ca609a33dd8696bcbd2f1ad949e26a591592f
Gitweb:        https://git.kernel.org/tip/4b7ca609a33dd8696bcbd2f1ad949e26a591592f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Oct 2021 15:55:12 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/signal: Use fpu::__state_user_size for sigalt stack validation

Use the current->group_leader->fpu to check for pending permissions to use
extended features and validate against the resulting user space size which
is stored in the group leaders fpu struct as well.

This prevents a task from installing a too small sized sigaltstack after
permissions to use dynamically enabled features have been granted, but
the task has not (yet) used a related instruction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-9-chang.seok.bae@intel.com
---
 arch/x86/kernel/signal.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 0111a6a..ec71e06 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -32,6 +32,7 @@
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/fpu/signal.h>
+#include <asm/fpu/xstate.h>
 #include <asm/vdso.h>
 #include <asm/mce.h>
 #include <asm/sighandling.h>
@@ -720,12 +721,15 @@ badframe:
 
 /* max_frame_size tells userspace the worst case signal stack size. */
 static unsigned long __ro_after_init max_frame_size;
+static unsigned int __ro_after_init fpu_default_state_size;
 
 void __init init_sigframe_size(void)
 {
+	fpu_default_state_size = fpu__get_fpstate_size();
+
 	max_frame_size = MAX_FRAME_SIGINFO_UCTXT_SIZE + MAX_FRAME_PADDING;
 
-	max_frame_size += fpu__get_fpstate_size() + MAX_XSAVE_PADDING;
+	max_frame_size += fpu_default_state_size + MAX_XSAVE_PADDING;
 
 	/* Userspace expects an aligned size. */
 	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
@@ -928,15 +932,38 @@ __setup("strict_sas_size", strict_sas_size);
  * sigaltstack they just continued to work. While always checking against
  * the real size would be correct, this might be considered a regression.
  *
- * Therefore avoid the sanity check, unless enforced by kernel config or
- * command line option.
+ * Therefore avoid the sanity check, unless enforced by kernel
+ * configuration or command line option.
+ *
+ * When dynamic FPU features are supported, the check is also enforced when
+ * the task has permissions to use dynamic features. Tasks which have no
+ * permission are checked against the size of the non-dynamic feature set
+ * if strict checking is enabled. This avoids forcing all tasks on the
+ * system to allocate large sigaltstacks even if they are never going
+ * to use a dynamic feature. As this is serialized via sighand::siglock
+ * any permission request for a dynamic feature either happened already
+ * or will see the newly install sigaltstack size in the permission checks.
  */
 bool sigaltstack_size_valid(size_t ss_size)
 {
+	unsigned long fsize = max_frame_size - fpu_default_state_size;
+	u64 mask;
+
 	lockdep_assert_held(&current->sighand->siglock);
 
+	if (!fpu_state_size_dynamic() && !strict_sigaltstack_size)
+		return true;
+
+	fsize += current->group_leader->thread.fpu.perm.__user_state_size;
+	if (likely(ss_size > fsize))
+		return true;
+
 	if (strict_sigaltstack_size)
-		return ss_size > get_sigframe_size();
+		return ss_size > fsize;
+
+	mask = current->group_leader->thread.fpu.perm.__state_perm;
+	if (mask & XFEATURE_MASK_USER_DYNAMIC)
+		return ss_size > fsize;
 
 	return true;
 }
