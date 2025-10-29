Return-Path: <linux-tip-commits+bounces-7036-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3536C19673
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FC164E61B4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73E326D5D;
	Wed, 29 Oct 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="30GwPtrh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ooeJChKY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DBB2701CE;
	Wed, 29 Oct 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730574; cv=none; b=XfN0tzQjvdPvkqMEWRksd97Se7w9jt54PutEoR1VNGD3AS8KN3DbkHTQcBUtEFFQJ1UiPUFtMN4YeKeezw6irtagdCB+zHitv2OuS08+tzZ8RyG5mVsSTbW9QI/z3IgOcKvp6QMcXJj4lHLLjfR/lTYeS36jsnScVUQfceJZvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730574; c=relaxed/simple;
	bh=uR41ejQTRxcTxPHUWsz5khEgpbnqg1j1oIJsbvY6ClU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GoaH9YA5KWE0nOJ04xFEM+x0E0fxDm16Ty9Y24EgTyWBFs8bwpsASc2XZo4KEo+JjL/ZiPJwcYKBrCG19wej1z2Tfx+j27OFbi9wXFk2NfLUo8So8/av01hllof5l12Fv24YWiVRYgOPgda7uaVueOOVTxVlkK4eVOBWd8KeO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=30GwPtrh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ooeJChKY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730569;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iT9oRHDbouaLWlIeGk+18s9vLkODbVtzFTOXK+cnxGA=;
	b=30GwPtrhvZtkDzF+giesc1PT3BWCzm2TEL6OL+MHbFDqHjYGIWcGA6BPPz9agG/70j0g5h
	watZ5yKH0aZkIrlkaVFWbMH+l5lg8cYMfTfumS2pL6+usBIaVWv2VhKLxDGyX2oaipw+0g
	lFx+4Ly2Jv3BrVy3RwG7dufGyIbdvF+nhFuoMWQ+XvDBNwmd4p9NWZobYN5b/pWY/OlNam
	NmAquuNJqkoPzxOUihS2FUkrcFOWLdTVTm+ceIjVrPakxSYXIijRd/bR9uL2DwwF+QPj4Z
	s3CImkb1k2KrTV0yDnxCGDlAJUYpdW9iEHj8zNJNWzHs7nEp+YcuIoOEW7VEJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730569;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iT9oRHDbouaLWlIeGk+18s9vLkODbVtzFTOXK+cnxGA=;
	b=ooeJChKY75rpnPBCtEAGwccvwtR0lV2a3wA515QQ652c1Z3GJRlGnaWLB71fG7jHyS5RZB
	UmA57z2F/DCkUECw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] unwind_user/x86: Teach FP unwind about start of function
Cc: Jens Remus <jremus@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
References: <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173056798.2601451.4875591031189190119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ae25884ad749e7f6e0c3565513bdc8aa2554a425
Gitweb:        https://git.kernel.org/tip/ae25884ad749e7f6e0c3565513bdc8aa255=
4a425
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 24 Oct 2025 12:31:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:58 +01:00

unwind_user/x86: Teach FP unwind about start of function

When userspace is interrupted at the start of a function, before we
get a chance to complete the frame, unwind will miss one caller.

X86 has a uprobe specific fixup for this, add bits to the generic
unwinder to support this.

Suggested-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251024145156.GM4068168@noisy.programming.kic=
ks-ass.net
---
 arch/x86/events/core.c             | 40 +-----------------------------
 arch/x86/include/asm/unwind_user.h | 12 +++++++++-
 arch/x86/include/asm/uprobes.h     |  9 +++++++-
 arch/x86/kernel/uprobes.c          | 32 +++++++++++++++++++++++-
 include/linux/unwind_user_types.h  |  1 +-
 kernel/unwind/user.c               | 39 +++++++++++++++++++++-------
 6 files changed, 84 insertions(+), 49 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 745caa6..0cf68ad 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2845,46 +2845,6 @@ static unsigned long get_segment_base(unsigned int seg=
ment)
 	return get_desc_base(desc);
 }
=20
-#ifdef CONFIG_UPROBES
-/*
- * Heuristic-based check if uprobe is installed at the function entry.
- *
- * Under assumption of user code being compiled with frame pointers,
- * `push %rbp/%ebp` is a good indicator that we indeed are.
- *
- * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
- * If we get this wrong, captured stack trace might have one extra bogus
- * entry, but the rest of stack trace will still be meaningful.
- */
-static bool is_uprobe_at_func_entry(struct pt_regs *regs)
-{
-	struct arch_uprobe *auprobe;
-
-	if (!current->utask)
-		return false;
-
-	auprobe =3D current->utask->auprobe;
-	if (!auprobe)
-		return false;
-
-	/* push %rbp/%ebp */
-	if (auprobe->insn[0] =3D=3D 0x55)
-		return true;
-
-	/* endbr64 (64-bit only) */
-	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
-		return true;
-
-	return false;
-}
-
-#else
-static bool is_uprobe_at_func_entry(struct pt_regs *regs)
-{
-	return false;
-}
-#endif /* CONFIG_UPROBES */
-
 #ifdef CONFIG_IA32_EMULATION
=20
 #include <linux/compat.h>
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind=
_user.h
index b166e10..c4f1ff8 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_UNWIND_USER_H
=20
 #include <asm/ptrace.h>
+#include <asm/uprobes.h>
=20
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=3D  2*(ws),			\
@@ -10,6 +11,12 @@
 	.fp_off		=3D -2*(ws),			\
 	.use_fp		=3D true,
=20
+#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
+	.cfa_off	=3D  1*(ws),			\
+	.ra_off		=3D -1*(ws),			\
+	.fp_off		=3D 0,				\
+	.use_fp		=3D false,
+
 static inline int unwind_user_word_size(struct pt_regs *regs)
 {
 	/* We can't unwind VM86 stacks */
@@ -22,4 +29,9 @@ static inline int unwind_user_word_size(struct pt_regs *reg=
s)
 	return sizeof(long);
 }
=20
+static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+{
+	return is_uprobe_at_func_entry(regs);
+}
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 1ee2e51..362210c 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -62,4 +62,13 @@ struct arch_uprobe_task {
 	unsigned int			saved_tf;
 };
=20
+#ifdef CONFIG_UPROBES
+extern bool is_uprobe_at_func_entry(struct pt_regs *regs);
+#else
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
+
 #endif	/* _ASM_UPROBES_H */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index a563e90..7be8e36 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1791,3 +1791,35 @@ bool arch_uretprobe_is_alive(struct return_instance *r=
et, enum rp_check ctx,
 	else
 		return regs->sp <=3D ret->stack;
 }
+
+/*
+ * Heuristic-based check if uprobe is installed at the function entry.
+ *
+ * Under assumption of user code being compiled with frame pointers,
+ * `push %rbp/%ebp` is a good indicator that we indeed are.
+ *
+ * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
+ * If we get this wrong, captured stack trace might have one extra bogus
+ * entry, but the rest of stack trace will still be meaningful.
+ */
+bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	struct arch_uprobe *auprobe;
+
+	if (!current->utask)
+		return false;
+
+	auprobe =3D current->utask->auprobe;
+	if (!auprobe)
+		return false;
+
+	/* push %rbp/%ebp */
+	if (auprobe->insn[0] =3D=3D 0x55)
+		return true;
+
+	/* endbr64 (64-bit only) */
+	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
+		return true;
+
+	return false;
+}
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_ty=
pes.h
index 938f7e6..412729a 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -39,6 +39,7 @@ struct unwind_user_state {
 	unsigned int				ws;
 	enum unwind_user_type			current_type;
 	unsigned int				available_types;
+	bool					topmost;
 	bool					done;
 };
=20
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 6428715..39e2707 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -26,14 +26,12 @@ get_user_word(unsigned long *word, unsigned long base, in=
t off, unsigned int ws)
 	return get_user(*word, addr);
 }
=20
-static int unwind_user_next_fp(struct unwind_user_state *state)
+static int unwind_user_next_common(struct unwind_user_state *state,
+				   const struct unwind_user_frame *frame)
 {
-	const struct unwind_user_frame frame =3D {
-		ARCH_INIT_USER_FP_FRAME(state->ws)
-	};
 	unsigned long cfa, fp, ra;
=20
-	if (frame.use_fp) {
+	if (frame->use_fp) {
 		if (state->fp < state->sp)
 			return -EINVAL;
 		cfa =3D state->fp;
@@ -42,7 +40,7 @@ static int unwind_user_next_fp(struct unwind_user_state *st=
ate)
 	}
=20
 	/* Get the Canonical Frame Address (CFA) */
-	cfa +=3D frame.cfa_off;
+	cfa +=3D frame->cfa_off;
=20
 	/* stack going in wrong direction? */
 	if (cfa <=3D state->sp)
@@ -53,19 +51,41 @@ static int unwind_user_next_fp(struct unwind_user_state *=
state)
 		return -EINVAL;
=20
 	/* Find the Return Address (RA) */
-	if (get_user_word(&ra, cfa, frame.ra_off, state->ws))
+	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
 		return -EINVAL;
=20
-	if (frame.fp_off && get_user_word(&fp, cfa, frame.fp_off, state->ws))
+	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
 		return -EINVAL;
=20
 	state->ip =3D ra;
 	state->sp =3D cfa;
-	if (frame.fp_off)
+	if (frame->fp_off)
 		state->fp =3D fp;
+	state->topmost =3D false;
 	return 0;
 }
=20
+static int unwind_user_next_fp(struct unwind_user_state *state)
+{
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+	struct pt_regs *regs =3D task_pt_regs(current);
+
+	if (state->topmost && unwind_user_at_function_start(regs)) {
+		const struct unwind_user_frame fp_entry_frame =3D {
+			ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
+		};
+		return unwind_user_next_common(state, &fp_entry_frame);
+	}
+
+	const struct unwind_user_frame fp_frame =3D {
+		ARCH_INIT_USER_FP_FRAME(state->ws)
+	};
+	return unwind_user_next_common(state, &fp_frame);
+#else
+	return -EINVAL;
+#endif
+}
+
 static int unwind_user_next(struct unwind_user_state *state)
 {
 	unsigned long iter_mask =3D state->available_types;
@@ -118,6 +138,7 @@ static int unwind_user_start(struct unwind_user_state *st=
ate)
 		state->done =3D true;
 		return -EINVAL;
 	}
+	state->topmost =3D true;
=20
 	return 0;
 }

