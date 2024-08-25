Return-Path: <linux-tip-commits+bounces-2117-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B995E491
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 19:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0191C208AF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD99156C63;
	Sun, 25 Aug 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aj/jQH4B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GosxqwSd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6BBE6F;
	Sun, 25 Aug 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724606926; cv=none; b=SCjoys032En8xmDWuNSWB7HHtiYPUMVsEwueBbFGDRTOMR6hvp/FZ3vSfKg9L8XnluaaBkARtzr7HcgeDF+wvYjfobwNbKZK8DWkZBB/M2b3pzoGt2nMDJE4p88qjNfkKzdX/IWaY1sWrnmQe0epne2ElJJvAzTXwKgI6LVoa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724606926; c=relaxed/simple;
	bh=u1MP966MnMybKvy9fVYLnREgry69HzUKTccYTd+3aVE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bSRVq/D6KGbzboVzmSB1qEwNur8ezVgyzOjb3TdEXRSDDV0AUNJv1FeFpX8lQKZXkv/m07O294cqD973DdT8Y8TKNEoIFRuXDOc6m2Hx3shSGBDdx5PUpNdpBjoQ6d0rxsOYtXepC90I7Da4jWdHKPhsBqyGRnJlLtp6IqeL6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aj/jQH4B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GosxqwSd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 17:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724606923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRUI/aPNE/KF0+qMq3J/fxcCsbjy3J+AogSFJy1KQQQ=;
	b=Aj/jQH4BNpC/0hsM5kuzF6q5oCQD4kgLBPzBW1v3HGB2tjtRD+dbaczVpISyhB7kCq+WOr
	BtCDlbL8yDyMWMyERDxqBndYoUSqKCnJeTH9kCsW8lCCybfzPPMVFaLm46uJUzo1iqR4s3
	FUdEGLSTtuUkrKoNLePqCRzS/tzvTcWSXkL1D8dZlls4kbjpp5QmYHymivBqzXnu9Mo2GD
	zf5wXvw3W63eAY/riiPcPyA7v3ZuFTem/Ygm0rX+AZQtNAzIHHwVJP1MgJ93MyowYeISHV
	JQNYETYewFmPrwzTrm+SATNcxtF9M63TZUEkVjdcT3VbumOxlWFrHfa1FUWQxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724606923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRUI/aPNE/KF0+qMq3J/fxcCsbjy3J+AogSFJy1KQQQ=;
	b=GosxqwSd+Tob4C8gNFlFdpal5WaGvT7JzzMJxKsFFW6ebTPdmy9bFMLO29o5orLcmmc1mi
	IUOKsvIuhre8YkDg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/entry: Set FRED RSP0 on return to userspace
 instead of context switch
Cc: Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Xin Li (Intel)" <xin@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240822073906.2176342-4-xin@zytor.com>
References: <20240822073906.2176342-4-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172460692214.2215.327817940155797017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     fe85ee391966c4cf3bfe1c405314e894c951f521
Gitweb:        https://git.kernel.org/tip/fe85ee391966c4cf3bfe1c405314e894c951f521
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Thu, 22 Aug 2024 00:39:06 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 19:23:00 +02:00

x86/entry: Set FRED RSP0 on return to userspace instead of context switch

The FRED RSP0 MSR points to the top of the kernel stack for user level
event delivery. As this is the task stack it needs to be updated when a
task is scheduled in.

The update is done at context switch. That means it's also done when
switching to kernel threads, which is pointless as those never go out to
user space. For KVM threads this means there are two writes to FRED_RSP0 as
KVM has to switch to the guest value before VMENTER.

Defer the update to the exit to user space path and cache the per CPU
FRED_RSP0 value, so redundant writes can be avoided.

Provide fred_sync_rsp0() for KVM to keep the cache in sync with the actual
MSR value after returning from guest to host mode.

[ tglx: Massage change log ]

Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240822073906.2176342-4-xin@zytor.com
---
 arch/x86/include/asm/entry-common.h |  3 +++
 arch/x86/include/asm/fred.h         | 21 ++++++++++++++++++++-
 arch/x86/include/asm/switch_to.h    |  5 +----
 arch/x86/kernel/fred.c              |  3 +++
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index db97082..77d2055 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -8,6 +8,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
+#include <asm/fred.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
@@ -63,6 +64,8 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) || unlikely(ti_work))
 		arch_exit_work(ti_work);
 
+	fred_update_rsp0();
+
 #ifdef CONFIG_COMPAT
 	/*
 	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 66d7dbe..25ca00b 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -36,6 +36,7 @@
 
 #ifdef CONFIG_X86_FRED
 #include <linux/kernel.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/ptrace.h>
 
@@ -87,12 +88,30 @@ void cpu_init_fred_exceptions(void);
 void cpu_init_fred_rsps(void);
 void fred_complete_exception_setup(void);
 
+DECLARE_PER_CPU(unsigned long, fred_rsp0);
+
+static __always_inline void fred_sync_rsp0(unsigned long rsp0)
+{
+	__this_cpu_write(fred_rsp0, rsp0);
+}
+
+static __always_inline void fred_update_rsp0(void)
+{
+	unsigned long rsp0 = (unsigned long) task_stack_page(current) + THREAD_SIZE;
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && (__this_cpu_read(fred_rsp0) != rsp0)) {
+		wrmsrns(MSR_IA32_FRED_RSP0, rsp0);
+		__this_cpu_write(fred_rsp0, rsp0);
+	}
+}
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
 static inline void cpu_init_fred_exceptions(void) { }
 static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
-static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
+static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
+static inline void fred_sync_rsp0(unsigned long rsp0) { }
+static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index e9ded14..7524854 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -70,12 +70,9 @@ static inline void update_task_stack(struct task_struct *task)
 #ifdef CONFIG_X86_32
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
-	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) && cpu_feature_enabled(X86_FEATURE_XENPV))
 		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
-	}
 #endif
 }
 
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 266c69e..8d32c3f 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -21,6 +21,9 @@
 
 #define FRED_STKLVL(vector, lvl)	((lvl) << (2 * (vector)))
 
+DEFINE_PER_CPU(unsigned long, fred_rsp0);
+EXPORT_PER_CPU_SYMBOL(fred_rsp0);
+
 void cpu_init_fred_exceptions(void)
 {
 	/* When FRED is enabled by default, remove this log message */

