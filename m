Return-Path: <linux-tip-commits+bounces-4231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D61A63523
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 12:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768BF188F6D5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 11:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7E1A3142;
	Sun, 16 Mar 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itvPfan1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIyrlNL1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04015442A;
	Sun, 16 Mar 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122903; cv=none; b=DmsRflPrlHks0cI70hfa4Z51O3NxgXFF2KVXoOuXaGrQqkOHXH9HJET010jUuYtfhcl33r1vDAnrNu7g8AJ0dQ5jzW7+tNO1U5/3GwpwCSowRV6y5UVrD6dBY1HKUy9gxvTDFGu74bCJ0y0U3zzFuOolarDeVy1qVSWNl1X2DnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122903; c=relaxed/simple;
	bh=FK2ii0J1Qumg0XfdFvUZWAwxXpEo3+1QV3vviGSaA6Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cwE/d7itaczkDbVGxKiQaHqEehUu4TQSkYx2FhDiCSOuq+SODNH6w6p6apNucOgo1ixj6qgRehxStRrF+B5uN3257BnIn3ql+reI97GvMwvhbuc9QUtlMeDXbaPXOt0BIboD0NQ4o3AkyQjF7QCsVV3gNYrM11pKNzhhyZpa0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itvPfan1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIyrlNL1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 16 Mar 2025 11:01:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742122899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltfbINI5/8UyA4zNlSkix+JEal0SGCJk9++ZP4MJcgI=;
	b=itvPfan1EO073LCqqystzryvgCNmdGFTiRtw3DYXe5hJyNjd3uIptsypfYiaq6DMgJ+2pB
	BV1RYq5E3SDP1XtlohpWOFRkExi1bKzFq66ptdnPqLhyrvJEsJKbhwb0cjtCfKde+jqr44
	l7oUzZ8DRKSRlKhRdk3DjnfXJVMfXCXW37sBDMrNKwfe5JzFqu11ewbLXg8cKl1Sbk9XKZ
	nKvw9ukgsU+/AStqMs00eCONrpczphYLT2A5M8LyeSfV14doJ0VinVr/xrVSMQ0ho/yt/o
	jOvdRnaJYmJ5Zp3Y/zbMdP20C3xrOd/y912Jzupvxcjw+HUFfLcfz4Uk/1gF/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742122899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltfbINI5/8UyA4zNlSkix+JEal0SGCJk9++ZP4MJcgI=;
	b=aIyrlNL17K6zAYLThVpPbg/GhfJicG3Q3SEchVlR2m5uPzE6mC76ppI8malLrTmkBdi6jt
	wf3upzMR8k3oCUAg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/syscall: Move sys_ni_syscall()
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314151220.862768-6-brgerst@gmail.com>
References: <20250314151220.862768-6-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174212289894.14745.11811231569858853677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7abd22188d76307aea7956cc7723f8ef20c1a606
Gitweb:        https://git.kernel.org/tip/7abd22188d76307aea7956cc7723f8ef20c1a606
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:18 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 16 Mar 2025 11:49:42 +01:00

x86/syscall: Move sys_ni_syscall()

Move sys_ni_syscall() to kernel/process.c, and remove the now empty
entry/common.c

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250314151220.862768-6-brgerst@gmail.com
---
 arch/x86/entry/Makefile   |  3 +---
 arch/x86/entry/common.c   | 38 +--------------------------------------
 arch/x86/kernel/process.c |  5 +++++-
 3 files changed, 5 insertions(+), 41 deletions(-)
 delete mode 100644 arch/x86/entry/common.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index e870f8a..72cae8e 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -7,16 +7,13 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
-CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
 
-CFLAGS_common.o			+= -fno-stack-protector
 CFLAGS_syscall_32.o		+= -fno-stack-protector
 CFLAGS_syscall_64.o		+= -fno-stack-protector
 
 obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
-obj-y				+= common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
deleted file mode 100644
index 5bd448c..0000000
--- a/arch/x86/entry/common.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * common.c - C code for kernel entry and exit
- * Copyright (c) 2015 Andrew Lutomirski
- *
- * Based on asm and ptrace code by many authors.  The code here originated
- * in ptrace.c and signal.c.
- */
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/sched/task_stack.h>
-#include <linux/entry-common.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/errno.h>
-#include <linux/ptrace.h>
-#include <linux/export.h>
-#include <linux/nospec.h>
-#include <linux/syscalls.h>
-#include <linux/uaccess.h>
-#include <linux/init.h>
-
-#include <asm/apic.h>
-#include <asm/desc.h>
-#include <asm/traps.h>
-#include <asm/vdso.h>
-#include <asm/cpufeature.h>
-#include <asm/fpu/api.h>
-#include <asm/nospec-branch.h>
-#include <asm/io_bitmap.h>
-#include <asm/syscall.h>
-#include <asm/irq_stack.h>
-
-SYSCALL_DEFINE0(ni_syscall)
-{
-	return -ENOSYS;
-}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6da6769..b5fb108 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1060,3 +1060,8 @@ long do_arch_prctl_common(int option, unsigned long arg2)
 
 	return -EINVAL;
 }
+
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return -ENOSYS;
+}

