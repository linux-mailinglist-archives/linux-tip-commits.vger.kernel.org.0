Return-Path: <linux-tip-commits+bounces-6364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E72B33CBC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D251B2212C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79492E888B;
	Mon, 25 Aug 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3NY2Ink6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nN7xIbNr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6762DECB9;
	Mon, 25 Aug 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117504; cv=none; b=ICeFKuc+Mq01W0yfCN9uwcm5qNTYYDZ2MhIBS5qxx0PNsZZZR2dqzvQWjTX5i8e9LCdcwDj0H7LEoRECpCIqLpCjuMfXP8IFjDoK9q6cWpontSHkVHeAOHwpVcYocG3iPxHA7RmaC730ne1jYXW0wK4NsN+jRfYMz2Kh0nAxR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117504; c=relaxed/simple;
	bh=l163MSlGK5HWIbGC3mPkuNj4Pk56v8bLQj7ACS7kcsc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U/qOPaNyJ1V4w/0oAXsxMRx9gTwXxwFT00ebIYYfKwH2oc8FQNkSAyDyCP2Qf6E7srdr1jDfjDH4ro3lkgCe79cQ6Efvnr34CFeN5FvAOCYMV5qR2PKZLD99NRldXbDRdzu+rbeq2o8IEK8vePbyM9RMhdTsnFc5ZD7rDjSmXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3NY2Ink6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nN7xIbNr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+hDNOWRKMS6ioLXYNI5QsDz4Va0isDnqMYTHrR3CAQ=;
	b=3NY2Ink62rYzwnaZpekLrsbIbjrLw22TttJ/f4RigeGDhZTLzehm2WYV0Af3IT0ol22zk9
	FHImMfFtBf73Z6fIoP0NLPjHEn5+Hab/HkMAwkKC0d04YfbN1K1ze6U6H+r/sDLwC+oNC9
	Ek6UjGevO041sjJvTKuNvsuf4SwPXqzNjoD9kuMwv7JmRUD7N7eD7NPyXA5AMjFpPZR90c
	Bt2ZH+d4Jas1kt+KVvis0w8+sbAVuxwZ22ORqNahU9zWiBp8Z0eYGZXzh9lm8xRyvE0Kov
	WOQZHehD5MS17Y2snzm1z2AGof0Sde8BJqDR67MElT+g1cx7CzskrITMi/l2cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+hDNOWRKMS6ioLXYNI5QsDz4Va0isDnqMYTHrR3CAQ=;
	b=nN7xIbNrPZaXUfvjB9exIW27AfUxE8rL5jASd1gH1lVrOgSdCal+QMWseGWFyQSKKpR7po
	SFxlitAhupI6lKDw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Add uprobe syscall to speed up uprobe
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-10-jolsa@kernel.org>
References: <20250720112133.244369-10-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749944.1420.4808224997954239768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     56101b69c9190667f473b9f93f8b6d8209aaa816
Gitweb:        https://git.kernel.org/tip/56101b69c9190667f473b9f93f8b6d8209a=
aa816
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:20 +02:00

uprobes/x86: Add uprobe syscall to speed up uprobe

Adding new uprobe syscall that calls uprobe handlers for given
'breakpoint' address.

The idea is that the 'breakpoint' address calls the user space
trampoline which executes the uprobe syscall.

The syscall handler reads the return address of the initial call
to retrieve the original 'breakpoint' address. With this address
we find the related uprobe object and call its consumers.

Adding the arch_uprobe_trampoline_mapping function that provides
uprobe trampoline mapping. This mapping is backed with one global
page initialized at __init time and shared by the all the mapping
instances.

We do not allow to execute uprobe syscall if the caller is not
from uprobe trampoline mapping.

The uprobe syscall ensures the consumer (bpf program) sees registers
values in the state before the trampoline was called.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-10-jolsa@kernel.org
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +-
 arch/x86/kernel/uprobes.c              | 139 ++++++++++++++++++++++++-
 include/linux/syscalls.h               |   2 +-
 include/linux/uprobes.h                |   1 +-
 kernel/events/uprobes.c                |  17 +++-
 kernel/sys_ni.c                        |   1 +-
 6 files changed, 161 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls=
/syscall_64.tbl
index 92cf0fe..ced2a1d 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,7 @@
 333	common	io_pgetevents		sys_io_pgetevents
 334	common	rseq			sys_rseq
 335	common	uretprobe		sys_uretprobe
+336	common	uprobe			sys_uprobe
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	sys_pidfd_send_signal
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6c4dcbd..d18e1ae 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -752,6 +752,145 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
 	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
 		destroy_uprobe_trampoline(tramp);
 }
+
+static bool __in_uprobe_trampoline(unsigned long ip)
+{
+	struct vm_area_struct *vma =3D vma_lookup(current->mm, ip);
+
+	return vma && vma_is_special_mapping(vma, &tramp_mapping);
+}
+
+static bool in_uprobe_trampoline(unsigned long ip)
+{
+	struct mm_struct *mm =3D current->mm;
+	bool found, retry =3D true;
+	unsigned int seq;
+
+	rcu_read_lock();
+	if (mmap_lock_speculate_try_begin(mm, &seq)) {
+		found =3D __in_uprobe_trampoline(ip);
+		retry =3D mmap_lock_speculate_retry(mm, seq);
+	}
+	rcu_read_unlock();
+
+	if (retry) {
+		mmap_read_lock(mm);
+		found =3D __in_uprobe_trampoline(ip);
+		mmap_read_unlock(mm);
+	}
+	return found;
+}
+
+/*
+ * See uprobe syscall trampoline; the call to the trampoline will push
+ * the return address on the stack, the trampoline itself then pushes
+ * cx, r11 and ax.
+ */
+struct uprobe_syscall_args {
+	unsigned long ax;
+	unsigned long r11;
+	unsigned long cx;
+	unsigned long retaddr;
+};
+
+SYSCALL_DEFINE0(uprobe)
+{
+	struct pt_regs *regs =3D task_pt_regs(current);
+	struct uprobe_syscall_args args;
+	unsigned long ip, sp;
+	int err;
+
+	/* Allow execution only from uprobe trampolines. */
+	if (!in_uprobe_trampoline(regs->ip))
+		goto sigill;
+
+	err =3D copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
+	if (err)
+		goto sigill;
+
+	ip =3D regs->ip;
+
+	/*
+	 * expose the "right" values of ax/r11/cx/ip/sp to uprobe_consumer/s, plus:
+	 * - adjust ip to the probe address, call saved next instruction address
+	 * - adjust sp to the probe's stack frame (check trampoline code)
+	 */
+	regs->ax  =3D args.ax;
+	regs->r11 =3D args.r11;
+	regs->cx  =3D args.cx;
+	regs->ip  =3D args.retaddr - 5;
+	regs->sp +=3D sizeof(args);
+	regs->orig_ax =3D -1;
+
+	sp =3D regs->sp;
+
+	handle_syscall_uprobe(regs, regs->ip);
+
+	/*
+	 * Some of the uprobe consumers has changed sp, we can do nothing,
+	 * just return via iret.
+	 */
+	if (regs->sp !=3D sp) {
+		/* skip the trampoline call */
+		if (args.retaddr - 5 =3D=3D regs->ip)
+			regs->ip +=3D 5;
+		return regs->ax;
+	}
+
+	regs->sp -=3D sizeof(args);
+
+	/* for the case uprobe_consumer has changed ax/r11/cx */
+	args.ax  =3D regs->ax;
+	args.r11 =3D regs->r11;
+	args.cx  =3D regs->cx;
+
+	/* keep return address unless we are instructed otherwise */
+	if (args.retaddr - 5 !=3D regs->ip)
+		args.retaddr =3D regs->ip;
+
+	regs->ip =3D ip;
+
+	err =3D copy_to_user((void __user *)regs->sp, &args, sizeof(args));
+	if (err)
+		goto sigill;
+
+	/* ensure sysret, see do_syscall_64() */
+	regs->r11 =3D regs->flags;
+	regs->cx  =3D regs->ip;
+	return 0;
+
+sigill:
+	force_sig(SIGILL);
+	return -1;
+}
+
+asm (
+	".pushsection .rodata\n"
+	".balign " __stringify(PAGE_SIZE) "\n"
+	"uprobe_trampoline_entry:\n"
+	"push %rcx\n"
+	"push %r11\n"
+	"push %rax\n"
+	"movq $" __stringify(__NR_uprobe) ", %rax\n"
+	"syscall\n"
+	"pop %rax\n"
+	"pop %r11\n"
+	"pop %rcx\n"
+	"ret\n"
+	".balign " __stringify(PAGE_SIZE) "\n"
+	".popsection\n"
+);
+
+extern u8 uprobe_trampoline_entry[];
+
+static int __init arch_uprobes_init(void)
+{
+	tramp_mapping_pages[0] =3D virt_to_page(uprobe_trampoline_entry);
+	return 0;
+}
+
+late_initcall(arch_uprobes_init);
+
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77f45e5..66c06fc 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,8 @@ asmlinkage long sys_ioperm(unsigned long from, unsigned=
 long num, int on);
=20
 asmlinkage long sys_uretprobe(void);
=20
+asmlinkage long sys_uprobe(void);
+
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
 asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 				unsigned long off, unsigned long len,
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b40d33a..b6b077c 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -239,6 +239,7 @@ extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, vo=
id *dst, int len);
 extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
+extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vad=
dr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2cd7a4c..eb07e60 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2771,6 +2771,23 @@ out:
 	rcu_read_unlock_trace();
 }
=20
+void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
+{
+	struct uprobe *uprobe;
+	int is_swbp;
+
+	guard(rcu_tasks_trace)();
+
+	uprobe =3D find_active_uprobe_rcu(bp_vaddr, &is_swbp);
+	if (!uprobe)
+		return;
+	if (!get_utask())
+		return;
+	if (arch_uprobe_ignore(&uprobe->arch, regs))
+		return;
+	handler_chain(uprobe, regs);
+}
+
 /*
  * Perform required fix-ups and disable singlestep.
  * Allow pending signals to take effect.
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index c00a869..bf5d05c 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -392,3 +392,4 @@ COND_SYSCALL(setuid16);
 COND_SYSCALL(rseq);
=20
 COND_SYSCALL(uretprobe);
+COND_SYSCALL(uprobe);

