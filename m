Return-Path: <linux-tip-commits+bounces-4360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76764A68ADB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713671B61573
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C525C6F8;
	Wed, 19 Mar 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="omOYYCHY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pj3/19G/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620725486B;
	Wed, 19 Mar 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382233; cv=none; b=tuU1Y5lY1vLeeB/nEclIuB5VwNfDcV6FpWsfjjemRc6D2OacKm++vDI06Ferf1Zh8EEBGdGmsYvv789cg9ZQtOVek8nkCVjiX1ygxCyajxDAHsry1OJJJWlxQpPuIlm2L+mqdT8GhIPS9+ErHvzbH8Dp1Z+aBVWQ0OmPfAk3H9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382233; c=relaxed/simple;
	bh=bB2bcnCuUDmK6np0zW1NcPtE44yO1TixeQejNEWcn9w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uiwSC6b9E4UlRvNRbjBC3XSAkJ/jb9IdVjjLwwIeVlA3SwCPxeIkNGRa/WpSZBg95fKv5iFm9oE8ZD8VJQ9vwZ+LS5ii8ii4bzu5P6QFf74vMLxjCirefvuhXKVAiC+Ec2E+V3kKz3Une9+Gn026xncEiB5Ofe+OYv7qPiQy/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=omOYYCHY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pj3/19G/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FI9svyybuT+ko0TVf7ocC1G2L1VYlkYxzO92GFYCCec=;
	b=omOYYCHY4TXDaPSZg6fIy0J8OvnTYQuyWbjGZ4dtCWEghB173A11s2PXfftNanjg59VqKe
	6BsnROJC22IIM8DMHRraM215awlGmGlLdGT8RgzwatTk8qqpF9Jpk71GIfqhm3oSL6YSMU
	ocgcm7bWgFs/TBfeKkcOfbF8w5I0FzKme1rBMXB+tSgHe9oMWujxygnj6JEFyX8Ue71qfd
	HOtpa4dfizAnF/N9NzYCCqT03wh/mrUTca+ycWNbRY2MvkWFIrFQZvMTUvVpPJKAc5MfF7
	6nSQ+zIuyfV3K/HKZa2ARGmc7L2hVIf87ssijjExitPYYT0LSHx6PN9nrnbwkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FI9svyybuT+ko0TVf7ocC1G2L1VYlkYxzO92GFYCCec=;
	b=Pj3/19G/AcgG4heXtDk82cOaIUv8+Y+GJcLNWMtFH71Tq8T2fnMXOLEQYXlAM6WSv0jZ1p
	tq6BhxPp24EJF4Cg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/syscall: Move sys_ni_syscall()
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
Message-ID: <174238222860.14745.8481515011884136017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9a93e29f16bbba90a63faad0abbc6dea3b2f0c63
Gitweb:        https://git.kernel.org/tip/9a93e29f16bbba90a63faad0abbc6dea3b2f0c63
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:18 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:17 +01:00

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
index 0f398a4..5452237 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1063,3 +1063,8 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 
 	return -EINVAL;
 }
+
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return -ENOSYS;
+}

