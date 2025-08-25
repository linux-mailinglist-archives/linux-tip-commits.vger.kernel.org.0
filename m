Return-Path: <linux-tip-commits+bounces-6359-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90332B33CB0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10963A9713
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FC2E5B0F;
	Mon, 25 Aug 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6bAmS5v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OWKpf4v2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C702E5B2B;
	Mon, 25 Aug 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117499; cv=none; b=ktir9ZfrPaiYRSij2gCx0s44xG+X3VqsxzqMH2RhXvjK2Q1uOAENRkusLk/ZfPgM98UvADMdHqTpL62Pa9xy/IFoOcjJYYFFGzTF/KHDvrBQ/03eedVGNVJ6Kfye42flEignVXacNqnW2C4k0qXVXgcvl1AKW96txgb5CY+mOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117499; c=relaxed/simple;
	bh=OBQmu7AnjRqb/veUXkOPfq92mB+7Q2izVcJduWSHsV4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ob+p6Pl+p5a3XozQlDM6zIJ+HrHkA8GkJdpWD9THe5cJsTgh5QpylzL+v1jW8zO+YGXSdV6dhYpaL18/p6Eh8Srf1mUMBGHk3y5/NpnV6Qs3n2/t73gKr7sgB7/8O/WalLVTkWx2itTrsf2ReS4JRPvIeGXkJKnpaF0FpsFsu7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6bAmS5v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OWKpf4v2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+aDd//kHvwu9QJwYOpYVeqWZti7sq45Dwzud0CqVYs=;
	b=u6bAmS5vR3F1PYuo7xPZC2fT3ukQXoftztgFXiUJ9RqIcLwTqeXSkEVmZ1t8uF45fMWLeM
	VpqH/SKI7JjL6ueA8YPlgdOELm2XxuBTrI2Vt/eVrAVuYDtnDd+6TD7gn4PqMbTl8/U5ox
	rpnYbAQrGCyaKthpzW0hF9H+O8+pV6C81bxZWgtkIGQwtY3t93fPOkKhh8+DodVUzotSO9
	foZdk2DLShaizhDU6LF8RF+1fGbZTrIg0XTAAo8yE6k7/e2TYScisKUQ+B21KHBT491/aE
	5c7NOJlpgoZN1qqAPzgveYUoEl0wsScbqwSfEMqqcv7sb0mtVp55AV17N9D1Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+aDd//kHvwu9QJwYOpYVeqWZti7sq45Dwzud0CqVYs=;
	b=OWKpf4v2v1g8wSCwbigSn+nqrpDMB+Bc7B1jtZ7Cr45TVsYq+4ZEYm6dJOzcYI4LVbGEvr
	SCz45vjFMIqKqkDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Fix uprobe syscall vs shadow stack
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250821123657.055790090@infradead.org>
References: <20250821123657.055790090@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749367.1420.2115283868610104933.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f349ec80865dfeaf8a33feae6b4a500db039c69c
Gitweb:        https://git.kernel.org/tip/f349ec80865dfeaf8a33feae6b4a500db03=
9c69c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 20 Aug 2025 14:28:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:22 +02:00

uprobes/x86: Fix uprobe syscall vs shadow stack

The uprobe syscall stores and strips the trampoline stack frame from
the user context, to make it appear similar to an exception at the
original instruction. It then restores the trampoline stack when it
can exit using sysexit.

Make sure to match the regular stack manipulation with shadow stack
operations such that regular and shadow stack don't get out of sync
and causes trouble.

This enables using the optimization when shadow stack is in use.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250821123657.055790090@infradead.org
---
 arch/x86/include/asm/shstk.h |  4 ++++-
 arch/x86/kernel/shstk.c      | 40 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/uprobes.c    | 17 +++++++--------
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index ba6f2fe..6723dbf 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -23,6 +23,8 @@ int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
 int shstk_update_last_frame(unsigned long val);
 bool shstk_is_enabled(void);
+int shstk_pop(u64 *val);
+int shstk_push(u64 val);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
@@ -35,6 +37,8 @@ static inline int setup_signal_shadow_stack(struct ksignal =
*ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
 static inline int shstk_update_last_frame(unsigned long val) { return 0; }
 static inline bool shstk_is_enabled(void) { return false; }
+static inline int shstk_pop(u64 *val) { return -ENOTSUPP; }
+static inline int shstk_push(u64 val) { return -ENOTSUPP; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
=20
 #endif /* __ASSEMBLER__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 2ddf233..2dd91a3 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -246,6 +246,46 @@ static unsigned long get_user_shstk_addr(void)
 	return ssp;
 }
=20
+int shstk_pop(u64 *val)
+{
+	int ret =3D 0;
+	u64 ssp;
+
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return -ENOTSUPP;
+
+	fpregs_lock_and_load();
+
+	rdmsrq(MSR_IA32_PL3_SSP, ssp);
+	if (val && get_user(*val, (__user u64 *)ssp))
+		ret =3D -EFAULT;
+	else
+		wrmsrq(MSR_IA32_PL3_SSP, ssp + SS_FRAME_SIZE);
+	fpregs_unlock();
+
+	return ret;
+}
+
+int shstk_push(u64 val)
+{
+	u64 ssp;
+	int ret;
+
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return -ENOTSUPP;
+
+	fpregs_lock_and_load();
+
+	rdmsrq(MSR_IA32_PL3_SSP, ssp);
+	ssp -=3D SS_FRAME_SIZE;
+	ret =3D write_user_shstk_64((__user void *)ssp, val);
+	if (!ret)
+		wrmsrq(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+
+	return ret;
+}
+
 #define SHSTK_DATA_BIT BIT(63)
=20
 static int put_shstk_data(u64 __user *addr, u64 data)
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index d513c97..ab6547b 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -804,7 +804,7 @@ SYSCALL_DEFINE0(uprobe)
 {
 	struct pt_regs *regs =3D task_pt_regs(current);
 	struct uprobe_syscall_args args;
-	unsigned long ip, sp;
+	unsigned long ip, sp, sret;
 	int err;
=20
 	/* Allow execution only from uprobe trampolines. */
@@ -831,6 +831,10 @@ SYSCALL_DEFINE0(uprobe)
=20
 	sp =3D regs->sp;
=20
+	err =3D shstk_pop((u64 *)&sret);
+	if (err =3D=3D -EFAULT || (!err && sret !=3D args.retaddr))
+		goto sigill;
+
 	handle_syscall_uprobe(regs, regs->ip);
=20
 	/*
@@ -855,6 +859,9 @@ SYSCALL_DEFINE0(uprobe)
 	if (args.retaddr - 5 !=3D regs->ip)
 		args.retaddr =3D regs->ip;
=20
+	if (shstk_push(args.retaddr) =3D=3D -EFAULT)
+		goto sigill;
+
 	regs->ip =3D ip;
=20
 	err =3D copy_to_user((void __user *)regs->sp, &args, sizeof(args));
@@ -1124,14 +1131,6 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe,=
 unsigned long vaddr)
 	struct mm_struct *mm =3D current->mm;
 	uprobe_opcode_t insn[5];
=20
-	/*
-	 * Do not optimize if shadow stack is enabled, the return address hijack
-	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
-	 * the entry uprobe is optimized and the shadow stack crashes the app.
-	 */
-	if (shstk_is_enabled())
-		return;
-
 	if (!should_optimize(auprobe))
 		return;
=20

