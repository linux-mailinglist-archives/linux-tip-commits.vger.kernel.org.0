Return-Path: <linux-tip-commits+bounces-5134-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C1AA036A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827FC3B056F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 06:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E70274FE7;
	Tue, 29 Apr 2025 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHI5IqZH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HptT/39q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C82749C5;
	Tue, 29 Apr 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908407; cv=none; b=LjSWTbZ0NAyxqUNdYbltN6RpXRqOg0ItdYaohfbwgv6KJmNyrlgxSF8ldqtucv/olUeY8TOrWeFGDgTn7CLDR0nKWi6oj2r2q74Ijw4wLNXLEYSY1wRc5YBNZGVchwoIHNXUfwoMXLXjnFUnR+i0boeuDa2DmlEgsD/mXcHwh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908407; c=relaxed/simple;
	bh=3iVu7+tTT8Gvmt0QJt/DmkfY+NZPjNaOC/KGL1a8Pmg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WG44ckYp0zRYdklAA4ql3TZiQy0q9GBPyNGDy79wqS2IXi6fAl2+ffvKk/RbENl4ddnNE3fU3HtN6Gr/FA7djfARl+xr6IwYIYguo7v2BiS1qvE8y4ls49/s8/PhhOMms+Sfl9ZqXr1dHJ2zTEQWWkAfBB2gnHjgEOyhRdDPJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHI5IqZH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HptT/39q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Apr 2025 06:33:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745908404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJHm+u5b6jQcx+fXi4PW4N4Y+DdOrABspo9C7Hak+r0=;
	b=dHI5IqZH+CLgJVQMgjZGTmFIPplghEzDF8GC3kqk6cTBpNpH855uahMpiZ17WZSBZV1Ctd
	0McdDjh5+C+uP+4H+A4C8Ys1sftUI6p5uumqs28VoKNrYH4Llv/gA5K6RJyr3iQRtq3QQY
	S2yjRCiTBQx/gz7Bj4lXQ5GNbIkIss+GsghQlkoOEQd+fKCr1VfZZ4EoXcEdCuwAJlt5TA
	9ePA6CLTnG8dQIIfvWdCGfYI3eH1bGd6ttWCovQml56Y/PqXhRUi52nF8ykGWfBT7YEATZ
	/ymPgrjMPnkt6x7gQ+44KquSLH9Z0J1nNhV3JYfJIcHBkIZa36or+ITi9pCjyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745908404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJHm+u5b6jQcx+fXi4PW4N4Y+DdOrABspo9C7Hak+r0=;
	b=HptT/39qUoSq5Yloohpk22yxmzj2pvRcvMMF7/f1Jrh8NZltPlx5tKa6qsLysB9Uf8QuMn
	Cy8BRqkl7QPuBIAQ==
From: "tip-bot2 for Charlie Jenkins" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] riscv: entry: Convert ret_from_fork() to C
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250320-riscv_optimize_entry-v6-1-63e187e26041@rivosinc.com>
References: <20250320-riscv_optimize_entry-v6-1-63e187e26041@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174590840374.22196.13222665858567689095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     f955aa8723a65759e920d4de8e5d076cef412afc
Gitweb:        https://git.kernel.org/tip/f955aa8723a65759e920d4de8e5d076cef412afc
Author:        Charlie Jenkins <charlie@rivosinc.com>
AuthorDate:    Thu, 20 Mar 2025 10:29:21 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Apr 2025 08:27:10 +02:00

riscv: entry: Convert ret_from_fork() to C

Move the main section of ret_from_fork() to C to allow inlining of
syscall_exit_to_user_mode().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/all/20250320-riscv_optimize_entry-v6-1-63e187e26041@rivosinc.com

---
 arch/riscv/include/asm/asm-prototypes.h |  1 +
 arch/riscv/kernel/entry.S               | 15 ++++++---------
 arch/riscv/kernel/process.c             | 14 ++++++++++++--
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index cd627ec..733ff60 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -52,6 +52,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
 
+asmlinkage void ret_from_fork(void *fn_arg, int (*fn)(void *), struct pt_regs *regs);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
 asmlinkage void do_irq(struct pt_regs *regs);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 33a5a9f..b2dc5e7 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -319,17 +319,14 @@ SYM_CODE_END(handle_kernel_stack_overflow)
 ASM_NOKPROBE(handle_kernel_stack_overflow)
 #endif
 
-SYM_CODE_START(ret_from_fork)
+SYM_CODE_START(ret_from_fork_asm)
 	call schedule_tail
-	beqz s0, 1f	/* not from kernel thread */
-	/* Call fn(arg) */
-	move a0, s1
-	jalr s0
-1:
-	move a0, sp /* pt_regs */
-	call syscall_exit_to_user_mode
+	move a0, s1 /* fn_arg */
+	move a1, s0 /* fn */
+	move a2, sp /* pt_regs */
+	call ret_from_fork
 	j ret_from_exception
-SYM_CODE_END(ret_from_fork)
+SYM_CODE_END(ret_from_fork_asm)
 
 #ifdef CONFIG_IRQ_STACKS
 /*
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 7c244de..7b0a0bf 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -17,7 +17,9 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <linux/personality.h>
+#include <linux/entry-common.h>
 
+#include <asm/asm-prototypes.h>
 #include <asm/unistd.h>
 #include <asm/processor.h>
 #include <asm/csr.h>
@@ -36,7 +38,7 @@ unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
-extern asmlinkage void ret_from_fork(void);
+extern asmlinkage void ret_from_fork_asm(void);
 
 void noinstr arch_cpu_idle(void)
 {
@@ -206,6 +208,14 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+asmlinkage void ret_from_fork(void *fn_arg, int (*fn)(void *), struct pt_regs *regs)
+{
+	if (unlikely(fn))
+		fn(fn_arg);
+
+	syscall_exit_to_user_mode(regs);
+}
+
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
@@ -242,7 +252,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.riscv_v_flags = 0;
 	if (has_vector() || has_xtheadvector())
 		riscv_v_thread_alloc(p);
-	p->thread.ra = (unsigned long)ret_from_fork;
+	p->thread.ra = (unsigned long)ret_from_fork_asm;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }

