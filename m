Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C009F2FE398
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Jan 2021 08:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAUHQ2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Jan 2021 02:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbhAUHPX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Jan 2021 02:15:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D23C061575;
        Wed, 20 Jan 2021 23:14:42 -0800 (PST)
Date:   Thu, 21 Jan 2021 07:14:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611213280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhSh/HQgdN2lB7/EZd4gRNSdAORZpzmyu4+TIebLNY8=;
        b=Um1EJA3dPP+CiPWRe6fDf6FinFU4NWe9rq8Hyay6pERPXNtPwEccZ4wggwH9oBjzxyYP4U
        Vcskd7WrRLZODTr1NYHzpongoMGcuAZMACYZ1UVVuqqLZFFyMzl+zAGkO0iWCrVPpfznpo
        KZ/Dru0oUOJm4gEYXrK8UXskcd54+xPXoHj8ZfACHFPhHnqnPQQJj1RQNZ2L8MqwKOlOwV
        Mg3QiZ0sJE8LiK3pltERr9haoG3HUQWGr6P5ukZsP99m1PIXJAh42FONsYR9MVkqFiThmB
        RBovyuAW8B8PguTfUWaX2Hhz1Ltq38ry/umJEIzmwcdGy4VBz8pQRY9BOsT2QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611213280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhSh/HQgdN2lB7/EZd4gRNSdAORZpzmyu4+TIebLNY8=;
        b=RXj5TaUagGHYePH1fU0VySk7d12MR8mlMTh5IFM1ptDeyDMfmqKjPAkEF9UXxtvA0BG6XI
        9Tsts0WD5YM/piDA==
From:   "tip-bot2 for Andrea Righi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YAAvk0UQelq0Ae7+@xps-13-7390>
References: <YAAvk0UQelq0Ae7+@xps-13-7390>
MIME-Version: 1.0
Message-ID: <161121327995.414.14890124942899525500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     e6d92b6680371ae1aeeb6c5eb2387fdc5d9a2c89
Gitweb:        https://git.kernel.org/tip/e6d92b6680371ae1aeeb6c5eb2387fdc5d9a2c89
Author:        Andrea Righi <andrea.righi@canonical.com>
AuthorDate:    Thu, 14 Jan 2021 12:48:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Jan 2021 08:11:52 +01:00

x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y

With CONFIG_PREEMPTION disabled, arch/x86/entry/thunk_64.o is just an
empty object file.

With the newer binutils (tested with 2.35.90.20210113-1ubuntu1) the GNU
assembler doesn't generate a symbol table for empty object files and
objtool fails with the following error when a valid symbol table cannot
be found:

  arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table

To prevent this from happening, build thunk_$(BITS).o only if
CONFIG_PREEMPTION is enabled.

  BugLink: https://bugs.launchpad.net/bugs/1911359

Fixes: 320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lore.kernel.org/r/YAAvk0UQelq0Ae7+@xps-13-7390
---
 arch/x86/entry/Makefile   | 3 ++-
 arch/x86/entry/thunk_32.S | 2 --
 arch/x86/entry/thunk_64.S | 4 ----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 08bf95d..83c98da 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -21,12 +21,13 @@ CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
 
-obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
+obj-y				:= entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
+obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
 
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index f1f96d4..5997ec0 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,10 +29,8 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 496b11e..9d543c4 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -31,14 +31,11 @@ SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
-#ifdef CONFIG_PREEMPTION
 SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %r11
 	popq %r10
@@ -53,4 +50,3 @@ SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	ret
 	_ASM_NOKPROBE(__thunk_restore)
 SYM_CODE_END(__thunk_restore)
-#endif
