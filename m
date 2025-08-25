Return-Path: <linux-tip-commits+bounces-6362-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27BB33CB9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A80165844
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186E2E7BA4;
	Mon, 25 Aug 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbB9IMX3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NChsJi/F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC82E717C;
	Mon, 25 Aug 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117502; cv=none; b=k5cNFYn5+vm987f5arF2dlSBgn0D0u9U5VlmzNmww8JBw2YR+P8g9p+5zR/oLU3VTSV6xA9jBbKMOn0d+ucYhVrb5gZul0ptEaM7F4LXp/oDsxkq+ZERADbbSPonmdTPzcE78kyKz8mymXOpETJHGO0pdPHNy8pxIG7FeW6Vqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117502; c=relaxed/simple;
	bh=7u7RlDmYTPzoij2uqcIIu80vGJAdeO8MsEYdIU2+1Oc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EE2BX0S6ZLAb+U/mqfGOoYzVc4qL7wnmKGdEQEA74alIsJfqQfHUTwkzz+Xyv2hNEHxTTlCRH9PgXIDlYVR5nMOFUEXuCzE9RijD689CPCrjfwTmZi8cbcSEt6RJrlbjgCc5Y76KAObnTtBPxd6gaYq4S5v8sCsUcYQ5SpTtjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbB9IMX3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NChsJi/F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNnq/qTTPD5wWpR+fl8hx1MoE7Yg2Tu8kkAHFLq2OKE=;
	b=KbB9IMX3KdqxnN+ki4G2a8P2rPUKndZFicBUAkmsxLS5dp6zPKmv6B7OWkC2ydCE+xsjlL
	vQ/5/C2ESUOw9owL3N+4g1czsSm5I6j/4rB+CAzkggze9e6OIlGFnMNYoYBUAVD/TOCSza
	q0lOD60L41FtqStK9iONEbtaawd0ilhrxUgG6r+8AEQ7XKaAqWM2GXrODJaIH5CzK8XrQi
	tEek1sb3fpCBfiI5oT6sXKaRlScyhoVLsKnI7nV5cP4A4kwe4c3b6kNGpPA3GQ8sEQxoTW
	/pWzS3tl3wrEMSAJR5NYVQdSQQHmyqcm8YqN3Rp/8R0qOCEtAh7F04/U6XJuSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNnq/qTTPD5wWpR+fl8hx1MoE7Yg2Tu8kkAHFLq2OKE=;
	b=NChsJi/F1k1DDOuh2CkcMCOqHYHTU3yW4PQIfw79ZtE8vIUzZ6DozN+1FZkGHTOA3QwZn5
	Hpt2ptZoBN487zCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Add struct uretprobe_syscall_args
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250821123656.705837806@infradead.org>
References: <20250821123656.705837806@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749715.1420.1733296782168225470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     985e820b72e0a89746f51c072ed10caf78890244
Gitweb:        https://git.kernel.org/tip/985e820b72e0a89746f51c072ed10caf788=
90244
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 20 Aug 2025 12:28:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:21 +02:00

uprobes/x86: Add struct uretprobe_syscall_args

Like uprobe_syscall_args; keep things consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250821123656.705837806@infradead.org
---
 arch/x86/kernel/uprobes.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 209ce74..580989d 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -311,6 +311,12 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe,=
 struct insn *insn, bool
=20
 #ifdef CONFIG_X86_64
=20
+struct uretprobe_syscall_args {
+	unsigned long r11;
+	unsigned long cx;
+	unsigned long ax;
+};
+
 asm (
 	".pushsection .rodata\n"
 	".global uretprobe_trampoline_entry\n"
@@ -324,8 +330,8 @@ asm (
 	"uretprobe_syscall_check:\n"
 	"popq %r11\n"
 	"popq %rcx\n"
-
-	/* The uretprobe syscall replaces stored %rax value with final
+	/*
+	 * The uretprobe syscall replaces stored %rax value with final
 	 * return address, so we don't restore %rax in here and just
 	 * call ret.
 	 */
@@ -366,7 +372,8 @@ static unsigned long trampoline_check_ip(unsigned long tr=
amp)
 SYSCALL_DEFINE0(uretprobe)
 {
 	struct pt_regs *regs =3D task_pt_regs(current);
-	unsigned long err, ip, sp, r11_cx_ax[3], tramp;
+	struct uretprobe_syscall_args args;
+	unsigned long err, ip, sp, tramp;
=20
 	/* If there's no trampoline, we are called from wrong place. */
 	tramp =3D uprobe_get_trampoline_vaddr();
@@ -377,15 +384,15 @@ SYSCALL_DEFINE0(uretprobe)
 	if (unlikely(regs->ip !=3D trampoline_check_ip(tramp)))
 		goto sigill;
=20
-	err =3D copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax=
));
+	err =3D copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
 	if (err)
 		goto sigill;
=20
 	/* expose the "right" values of r11/cx/ax/sp to uprobe_consumer/s */
-	regs->r11 =3D r11_cx_ax[0];
-	regs->cx  =3D r11_cx_ax[1];
-	regs->ax  =3D r11_cx_ax[2];
-	regs->sp +=3D sizeof(r11_cx_ax);
+	regs->r11 =3D args.r11;
+	regs->cx  =3D args.cx;
+	regs->ax  =3D args.ax;
+	regs->sp +=3D sizeof(args);
 	regs->orig_ax =3D -1;
=20
 	ip =3D regs->ip;
@@ -401,21 +408,21 @@ SYSCALL_DEFINE0(uretprobe)
 	 */
 	if (regs->sp !=3D sp || shstk_is_enabled())
 		return regs->ax;
-	regs->sp -=3D sizeof(r11_cx_ax);
+	regs->sp -=3D sizeof(args);
=20
 	/* for the case uprobe_consumer has changed r11/cx */
-	r11_cx_ax[0] =3D regs->r11;
-	r11_cx_ax[1] =3D regs->cx;
+	args.r11 =3D regs->r11;
+	args.cx  =3D regs->cx;
=20
 	/*
 	 * ax register is passed through as return value, so we can use
 	 * its space on stack for ip value and jump to it through the
 	 * trampoline's ret instruction
 	 */
-	r11_cx_ax[2] =3D regs->ip;
+	args.ax  =3D regs->ip;
 	regs->ip =3D ip;
=20
-	err =3D copy_to_user((void __user *)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
+	err =3D copy_to_user((void __user *)regs->sp, &args, sizeof(args));
 	if (err)
 		goto sigill;
=20

