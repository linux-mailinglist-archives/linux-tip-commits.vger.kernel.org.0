Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1199F30F2A1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Feb 2021 12:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhBDLoI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Feb 2021 06:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhBDLoF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Feb 2021 06:44:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC2FC061573;
        Thu,  4 Feb 2021 03:43:25 -0800 (PST)
Date:   Thu, 04 Feb 2021 11:43:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612439003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0iWLTObXfB5bK1Si8U2J4dyQNZn/QbPdZ/bbfUKUMs=;
        b=zeILzLqAawFGdHXJhWaHb6oTyWuXZ2w5U8tRdh1NuZoxp8oxrfAbVgrM05keZZXQJxYGRY
        yEpSKENADRIJm7/4pFJu5ZQA+wLZxp/nCzs+HO2LC4uQM012ycTN93P8ZUTICFIzWDPOGD
        H3XNTcJRkf90SsLglFvw+ssA2oG83yHs3dpdvq+sKz2Qy+bpWo8IEkiegVB9xg8w/fLC2N
        yWcBqp8LGEu0HHooPl1WkvpsS1+GkiBSukA8Zx0PCh1celUQmS6U1mXYauYcBgiZFoYjsF
        /QNX8rWqSP8FQ7fW3sNNHPtB93rtT9Y0miRP52cQM+juGGFSN7d88AZX2JSjWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612439003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0iWLTObXfB5bK1Si8U2J4dyQNZn/QbPdZ/bbfUKUMs=;
        b=5EuhIPDqQ72Cm3ogBs+ozZaNm27oEg9SkKc/TC+hAem9F/73WwjDTVrBUmLkUWT2H7blsC
        W4JPxZUFyQJ/iQCg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/ptrace: Clean up
 PTRACE_GETREGS/PTRACE_PUTREGS regset selection
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <9daa791d0c7eaebd59c5bc2b2af1b0e7bebe707d.1612375698.git.luto@kernel.org>
References: <9daa791d0c7eaebd59c5bc2b2af1b0e7bebe707d.1612375698.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161243900203.23325.297811535672274452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f22fecaf39c30acce701ffc3e9875020ba31f1f5
Gitweb:        https://git.kernel.org/tip/f22fecaf39c30acce701ffc3e9875020ba3=
1f1f5
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 03 Feb 2021 10:09:58 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 04 Feb 2021 12:33:15 +01:00

x86/ptrace: Clean up PTRACE_GETREGS/PTRACE_PUTREGS regset selection

task_user_regset_view() has nonsensical semantics, but those semantics
appear to be relied on by existing users of PTRACE_GETREGSET and
PTRACE_SETREGSET.  (See added comments below for details.)

It shouldn't be used for PTRACE_GETREGS or PTRACE_SETREGS, though. A
native 64-bit ptrace() call and an x32 ptrace() call using GETREGS
or SETREGS wants the 64-bit regset views, and a 32-bit ptrace() call
(native or compat) should use the 32-bit regset.

task_user_regset_view() almost does this except that it will
malfunction if a ptracer is itself ptraced and the outer ptracer
modifies CS on entry to a ptrace() syscall.  Hopefully that has never
happened.  (The compat ptrace() code already hardcoded the 32-bit
regset, so this change has no effect on that path.)

Improve the situation and deobfuscate the code by hardcoding the
64-bit view in the x32 ptrace() and selecting the view based on the
kernel config in the native ptrace().

I tried to figure out the history behind this API. I na=C3=AFvely assumed
that PTRAGE_GETREGSET and PTRACE_SETREGSET were ancient APIs that
predated compat, but no. They were introduced by

  2225a122ae26 ("ptrace: Add support for generic PTRACE_GETREGSET/PTRACE_SETR=
EGSET")

in 2010, and they are simply a poor design.  ELF core dumps have the
ELF e_machine field and a bunch of register sets in ELF notes, and the
pair (e_machine, NT_XXX) indicates the format of the regset blob.  But
the new PTRACE_GET/SETREGSET API coopted the NT_XXX numbering without
any way to specify which e_machine was in effect.  This is especially
bad on x86, where a process can freely switch between 32-bit and
64-bit mode, and, in fact, the PTRAGE_SETREGSET call itself can cause
this switch to happen.  Oops.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/9daa791d0c7eaebd59c5bc2b2af1b0e7bebe707d.1612=
375698.git.luto@kernel.org
---
 arch/x86/kernel/ptrace.c | 46 ++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index bedca01..87a4143 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -704,6 +704,9 @@ void ptrace_disable(struct task_struct *child)
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static const struct user_regset_view user_x86_32_view; /* Initialized below.=
 */
 #endif
+#ifdef CONFIG_X86_64
+static const struct user_regset_view user_x86_64_view; /* Initialized below.=
 */
+#endif
=20
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
@@ -711,6 +714,14 @@ long arch_ptrace(struct task_struct *child, long request,
 	int ret;
 	unsigned long __user *datap =3D (unsigned long __user *)data;
=20
+#ifdef CONFIG_X86_64
+	/* This is native 64-bit ptrace() */
+	const struct user_regset_view *regset_view =3D &user_x86_64_view;
+#else
+	/* This is native 32-bit ptrace() */
+	const struct user_regset_view *regset_view =3D &user_x86_32_view;
+#endif
+
 	switch (request) {
 	/* read the word at location addr in the USER area. */
 	case PTRACE_PEEKUSR: {
@@ -749,28 +760,28 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
=20
 	case PTRACE_GETREGS:	/* Get all gp regs from the child. */
 		return copy_regset_to_user(child,
-					   task_user_regset_view(current),
+					   regset_view,
 					   REGSET_GENERAL,
 					   0, sizeof(struct user_regs_struct),
 					   datap);
=20
 	case PTRACE_SETREGS:	/* Set all gp regs in the child. */
 		return copy_regset_from_user(child,
-					     task_user_regset_view(current),
+					     regset_view,
 					     REGSET_GENERAL,
 					     0, sizeof(struct user_regs_struct),
 					     datap);
=20
 	case PTRACE_GETFPREGS:	/* Get the child FPU state. */
 		return copy_regset_to_user(child,
-					   task_user_regset_view(current),
+					   regset_view,
 					   REGSET_FP,
 					   0, sizeof(struct user_i387_struct),
 					   datap);
=20
 	case PTRACE_SETFPREGS:	/* Set the child FPU state. */
 		return copy_regset_from_user(child,
-					     task_user_regset_view(current),
+					     regset_view,
 					     REGSET_FP,
 					     0, sizeof(struct user_i387_struct),
 					     datap);
@@ -1152,28 +1163,28 @@ static long x32_arch_ptrace(struct task_struct *child,
=20
 	case PTRACE_GETREGS:	/* Get all gp regs from the child. */
 		return copy_regset_to_user(child,
-					   task_user_regset_view(current),
+					   &user_x86_64_view,
 					   REGSET_GENERAL,
 					   0, sizeof(struct user_regs_struct),
 					   datap);
=20
 	case PTRACE_SETREGS:	/* Set all gp regs in the child. */
 		return copy_regset_from_user(child,
-					     task_user_regset_view(current),
+					     &user_x86_64_view,
 					     REGSET_GENERAL,
 					     0, sizeof(struct user_regs_struct),
 					     datap);
=20
 	case PTRACE_GETFPREGS:	/* Get the child FPU state. */
 		return copy_regset_to_user(child,
-					   task_user_regset_view(current),
+					   &user_x86_64_view,
 					   REGSET_FP,
 					   0, sizeof(struct user_i387_struct),
 					   datap);
=20
 	case PTRACE_SETFPREGS:	/* Set the child FPU state. */
 		return copy_regset_from_user(child,
-					     task_user_regset_view(current),
+					     &user_x86_64_view,
 					     REGSET_FP,
 					     0, sizeof(struct user_i387_struct),
 					     datap);
@@ -1309,6 +1320,25 @@ void __init update_regset_xstate_info(unsigned int siz=
e, u64 xstate_mask)
 	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] =3D xstate_mask;
 }
=20
+/*
+ * This is used by the core dump code to decide which regset to dump.  The
+ * core dump code writes out the resulting .e_machine and the corresponding
+ * regsets.  This is suboptimal if the task is messing around with its CS.L
+ * field, but at worst the core dump will end up missing some information.
+ *
+ * Unfortunately, it is also used by the broken PTRACE_GETREGSET and
+ * PTRACE_SETREGSET APIs.  These APIs look at the .regsets field but have
+ * no way to make sure that the e_machine they use matches the caller's
+ * expectations.  The result is that the data format returned by
+ * PTRACE_GETREGSET depends on the returned CS field (and even the offset
+ * of the returned CS field depends on its value!) and the data format
+ * accepted by PTRACE_SETREGSET is determined by the old CS value.  The
+ * upshot is that it is basically impossible to use these APIs correctly.
+ *
+ * The best way to fix it in the long run would probably be to add new
+ * improved ptrace() APIs to read and write registers reliably, possibly by
+ * allowing userspace to select the ELF e_machine variant that they expect.
+ */
 const struct user_regset_view *task_user_regset_view(struct task_struct *tas=
k)
 {
 #ifdef CONFIG_IA32_EMULATION
