Return-Path: <linux-tip-commits+bounces-6371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB40BB33CCD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE2F20548B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487702ECE8D;
	Mon, 25 Aug 2025 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgJ7Mtri";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xRvN7VMw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFD2EC56B;
	Mon, 25 Aug 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117513; cv=none; b=hlcQCHRUGnp+QJGGo9ikOqsT7SfdHToZDdLZ8qWECeN+AVQRQp73KDq89u3hY1kX0X2+rOSRRJZHklhE4lcQ/ECqDNSKM26zjZME0LsfrF9NizTg9IiCL7nxUv83GdCTx00yxyNSFAMQQb4AqM5FEh3Ep72cYPW6hB/Bo4EoBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117513; c=relaxed/simple;
	bh=TbY3Bc/wPhyzjqkcftNftiQz091FEPHL03F70sViIlQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lTmb5oYKMsHmZqg5EiONGGtb5WdvsqxprKZrrqee5XsLHqaQSOMh2nhsOz8myA3eNGkEhDExef1k4FqZWfvWy8KDNo0dnrxY0ikvSMETbmMFNlipGy2Zjn+HykFEIhBIA0uuWtIocxdh5aEJMmBYYkpCJaY77FXgsvSZ5zIe7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgJ7Mtri; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xRvN7VMw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:25:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsCVBzyxz8EPyRKZVg8xM7Xedf7ixQ/LD2/fdOdlra4=;
	b=FgJ7MtriE9wSlopG7ydtAqSMYdoX7tILFOohv1NgpcAf6H/ZXjjMdtcU2arh8m1pvkmyul
	7vWSUp4pEHdP6SG6+tIGfD3Ba4MJFX/bYinoGwW1nUbTPDMDwvd9A5ZprE6TfQEcyOmysw
	t/+gfge43z3sduCsbJhTPQen4yI5OkmVGszCYPT4RPmxeh4uqKBouOHiJ4+DH18IYqRSZz
	gV2ErD1clKYNs00Btpm4rzqPigUg69TJyou3ssHVHWc1XXtS8QtA12Vkw8QPtniV9NiCKo
	QR2QFTbElI4IL99sV4egvawZ9OA5OFMIGR4p87Ib8+BOkn1PGRLdZCSvbgiahA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsCVBzyxz8EPyRKZVg8xM7Xedf7ixQ/LD2/fdOdlra4=;
	b=xRvN7VMwZco03gIOFQxmb6hoAquu+bkx/YYjbrJM8WXE26jKsYEsR9levOS0p5ZMfoCUSi
	80OvgoCn7PAWeJAQ==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Rename arch_uretprobe_trampoline function
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-3-jolsa@kernel.org>
References: <20250720112133.244369-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611750793.1420.3089393067775717711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0f07b7919d679050d354d3279faa74bdc7ce17a0
Gitweb:        https://git.kernel.org/tip/0f07b7919d679050d354d3279faa74bdc7c=
e17a0
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:18 +02:00

uprobes: Rename arch_uretprobe_trampoline function

We are about to add uprobe trampoline, so cleaning up the namespace.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250720112133.244369-3-jolsa@kernel.org
---
 arch/x86/kernel/uprobes.c | 2 +-
 include/linux/uprobes.h   | 2 +-
 kernel/events/uprobes.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6d38383..77050e5 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -338,7 +338,7 @@ extern u8 uretprobe_trampoline_entry[];
 extern u8 uretprobe_trampoline_end[];
 extern u8 uretprobe_syscall_check[];
=20
-void *arch_uprobe_trampoline(unsigned long *psize)
+void *arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
 	struct pt_regs *regs =3D task_pt_regs(current);
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 516217c..01112f2 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -224,7 +224,7 @@ extern bool arch_uprobe_ignore(struct arch_uprobe *aup, s=
truct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
-extern void *arch_uprobe_trampoline(unsigned long *psize);
+extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1cbfe3c..dd4dd15 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1726,7 +1726,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol=
_area *area)
 	return ret;
 }
=20
-void * __weak arch_uprobe_trampoline(unsigned long *psize)
+void * __weak arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
=20
@@ -1758,7 +1758,7 @@ static struct xol_area *__create_xol_area(unsigned long=
 vaddr)
 	init_waitqueue_head(&area->wq);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
-	insns =3D arch_uprobe_trampoline(&insns_size);
+	insns =3D arch_uretprobe_trampoline(&insns_size);
 	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
=20
 	if (!xol_add_vma(mm, area))

