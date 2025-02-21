Return-Path: <linux-tip-commits+bounces-3595-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0517A40235
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4284262C0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8D253F1B;
	Fri, 21 Feb 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+mCUHNU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+txEvG9g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCF253F0E;
	Fri, 21 Feb 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174090; cv=none; b=k7sj4aS/CEDFuicRJbneD9KroWU3nWIwtZnkRr+q9IAszSh+xOchfmqFId5P4UuYGlfSnQlN9zkYkCMBW68IiZ8wP4ttF6217GbRviTZ9OYrLsl32LbcVnZvOd0MaVWVA1DUAiW37rYURD1LnWVT4emkQeG31h1fcStDcA83vKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174090; c=relaxed/simple;
	bh=F+2mXn/OskVTzBjk5yK9ab14S50y8fgXX5zxyv4L0YI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tbS+tHvIcZlnYJKEzZoht1e9wj3gJbVOikkWoi56oya+J5afu2CrfSfGeOdf8NCLr1v4OeIBYWI3F/G5CEiKe5X6dL40SgwwK9ByX1eoq7zcxu0oUY1bO/lq0VwACNGC5GrTCEf/xAm0Ut4M2z+8s0jQJ89sl7eJ+lGc8PbRvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+mCUHNU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+txEvG9g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 21:41:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740174086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kux8FaM8Ss9lBgPZZChfrXBy8Sf/q3PJaez9CbFoRA=;
	b=L+mCUHNUQXrP8SXiA7p1XL1Xle6s3GFY9iJnwkCkms2NfgSpNJFWz3cKMZjBVg1T7NKUUx
	Wf5QcsvCMLYwwTrAwprl5eGb8U8jPpb8tNklrTTrIy9xeykCDmDIbPUjy8zN4suBVDitWC
	uYz/wecnyNa050Cv/WXrTINbasHF4pA/DLRMBat37E54AYEIJ+LY30vLx3HQjQArJ8bO/T
	pUeXPfULl0yIMjGs8o/4CgBkizULta8zAPDD2eKxROkuidXWpBvUz5WKN1xdBUZ9KqXcce
	wTyi/6spg/0UHgmgFqUnoni3rHsymXAa9sFYwSRtRu5bK+e5e2KuCWz8Twf7xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740174086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kux8FaM8Ss9lBgPZZChfrXBy8Sf/q3PJaez9CbFoRA=;
	b=+txEvG9gFuW4lnSRnv/GBhqauUZcgabbpo8SSlQGukKWZvPYZZs8TQQrwNDebB3PWzzDwR
	1D8wfWXFsmGleoCQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/arch_prctl: Simplify sys_arch_prctl()
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250202202323.422113-2-brgerst@gmail.com>
References: <20250202202323.422113-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174017408625.10177.12807335466708837050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2df1ad0d25803399056d439425e271802cd243f6
Gitweb:        https://git.kernel.org/tip/2df1ad0d25803399056d439425e271802cd243f6
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Sun, 02 Feb 2025 15:23:22 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 22:32:25 +01:00

x86/arch_prctl: Simplify sys_arch_prctl()

Use in_ia32_syscall() instead of a compat syscall entry.

No change in functionality intended.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250202202323.422113-2-brgerst@gmail.com
---
 arch/x86/entry/syscalls/syscall_32.tbl |  2 +-
 arch/x86/include/asm/proto.h           |  3 +--
 arch/x86/kernel/process.c              |  5 ++++-
 arch/x86/kernel/process_32.c           |  5 -----
 arch/x86/kernel/process_64.c           | 18 ------------------
 5 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4d0fb2f..6228309 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -396,7 +396,7 @@
 381	i386	pkey_alloc		sys_pkey_alloc
 382	i386	pkey_free		sys_pkey_free
 383	i386	statx			sys_statx
-384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
+384	i386	arch_prctl		sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq
 393	i386	semget			sys_semget
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 484f4f0..05224a6 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -15,7 +15,6 @@ void entry_SYSCALL_64(void);
 void entry_SYSCALL_64_safe_stack(void);
 void entry_SYSRETQ_unsafe_stack(void);
 void entry_SYSRETQ_end(void);
-long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
 #ifdef CONFIG_X86_32
@@ -41,6 +40,6 @@ void x86_configure_nx(void);
 
 extern int reboot_force;
 
-long do_arch_prctl_common(int option, unsigned long arg2);
+long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6da6769..0f398a4 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1043,7 +1043,7 @@ unsigned long __get_wchan(struct task_struct *p)
 	return addr;
 }
 
-long do_arch_prctl_common(int option, unsigned long arg2)
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
@@ -1058,5 +1058,8 @@ long do_arch_prctl_common(int option, unsigned long arg2)
 		return fpu_xstate_prctl(option, arg2);
 	}
 
+	if (!in_ia32_syscall())
+		return do_arch_prctl_64(current, option, arg2);
+
 	return -EINVAL;
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f..2bdab41 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -215,8 +215,3 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	return prev_p;
 }
-
-SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
-{
-	return do_arch_prctl_common(option, arg2);
-}
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 2264723..e067c61 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -980,24 +980,6 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	return ret;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
-{
-	long ret;
-
-	ret = do_arch_prctl_64(current, option, arg2);
-	if (ret == -EINVAL)
-		ret = do_arch_prctl_common(option, arg2);
-
-	return ret;
-}
-
-#ifdef CONFIG_IA32_EMULATION
-COMPAT_SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
-{
-	return do_arch_prctl_common(option, arg2);
-}
-#endif
-
 unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;

