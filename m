Return-Path: <linux-tip-commits+bounces-4205-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B19A60DAF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 10:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445E2168A0E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398A1D6187;
	Fri, 14 Mar 2025 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZCCBRmq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i2TqOnj8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CF747F;
	Fri, 14 Mar 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945621; cv=none; b=lhp9/lCNld/V/EJBgWmxfOAymH9UyKA7jJmEiRlQoknUFUAeu5lWEs85RbL0MWN7O2j3PdgY1DwYcc0JGMD4dap8m2k5g/K2ekkgpbbwnQ7uWyVPMD8QntvYHKbOzMTQVkE5sh2pTyev/YpZILlZ7jMWxJwWmTN+ZfnIKQeCwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945621; c=relaxed/simple;
	bh=jLT/TJaZoDn6i71QAP8zgCRomWo51QKyhLV5C5LV0O0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h8vr6whXbyNrQJD5PfxRFN+x1RQMTeeQeZBhI7Sh9VEu6liqmfekqCLRuoT/jm3onjPMT7oVqo3ZVeC+4INIIxzYAhjS4B862ox3nPKnUq6MfCQXJtyUwKrea1D3LVAgi82jRteeb/I0LEyPgEQb9acJVLdOz4Dzu58+0nkuULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZCCBRmq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i2TqOnj8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 09:46:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741945617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKb0Hcpl/sQNMSOm2f70+vsRCmDzUMuU+OPiFVvafM4=;
	b=rZCCBRmq07TJeKZ916+OtG5u6I3g2jeSLy0GGr9TyFST+LeRKlHYloaoRoNSgbW+rRxIK9
	86r8POHU+8HoAhMyRZ0LYnSOb/ClPFCFfsW6X0d9uwHlaCyk2b3Nn0nlHawig0sYoKSmja
	r9EFG1bO8/1yDWgUCN+uXrD/w/lOSuQlnphkEUP/o5TujQ2XLVmvgpFIWjONoEf33qCpA8
	LmFQmkGYuvRHqJ3e2j1JnL7PXu0kQ1xVt/Knr463Kp++forP6ZwokFzNjcNUevrXSEkOQv
	4Sup4XcXeoONIcr2ohywtgF3MF+Fy5wN0JkR5fkBtft/xv77gVlTxe2qbQ3PoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741945617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKb0Hcpl/sQNMSOm2f70+vsRCmDzUMuU+OPiFVvafM4=;
	b=i2TqOnj8GuDHAKs9kCW672uwBaLTGVkO6YqRWkwkcdeKQDISdrKuiBsz25tdGWYr/GMv2Q
	Snh1pyuv3hi8TZBw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/syscall: Move sys_ni_syscall() to
 arch/x86/kernel/process.c
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313182236.655724-6-brgerst@gmail.com>
References: <20250313182236.655724-6-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174194561606.14745.15442404984813114424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     83d5563952e6634826f831a9b91c62c7cab4ca4d
Gitweb:        https://git.kernel.org/tip/83d5563952e6634826f831a9b91c62c7cab4ca4d
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 14:22:36 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Mar 2025 10:32:51 +01:00

x86/syscall: Move sys_ni_syscall() to arch/x86/kernel/process.c

Move sys_ni_syscall() to kernel/process.c, and remove the now empty
entry/common.c

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250313182236.655724-6-brgerst@gmail.com
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

