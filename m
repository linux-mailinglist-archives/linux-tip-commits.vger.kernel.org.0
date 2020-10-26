Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C733298D33
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775648AbgJZMwg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:52:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39786 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773153AbgJZMwg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:36 -0400
Date:   Mon, 26 Oct 2020 12:52:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D07BTUtXAAqFJ/yVn4j4XVPbG8EpEZMoSdtT1WWy9lY=;
        b=bEZc7pnUqEHlL/y3BC/lNUTZo1omhB5EQIsvPUzmn21jwvyGak2FwRQAyYt/9f+X2l3qoW
        m/yN1Cp6ZDoxatmbIS8EH7UcAq7dkqAxIlg6k2wGz+VdLTYDCn3RvUDZo1leaUxahk3XpM
        MMPOEBa8MHXJmWXfwL7ZEzCkYmboB3ZUzrsVuhluCWYU4O/9tZmOxDIUNYSCrLHT+I2Llo
        2A4sGCcq3zNsDdbCiPUWO86L3Mn3ceO7hEd4Nm2adbAXJRESc0/FMn849Mi6szsR9WXbdi
        dzTa1tB+YBxTproVIJvVkZGH/bqrxU0zVY3u4RQPes1lsID/6tV4GveeuyZSRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D07BTUtXAAqFJ/yVn4j4XVPbG8EpEZMoSdtT1WWy9lY=;
        b=l+zIiODEWNfBCwJmH+vCIUKRXmNddC//jKGvtrEV04oB8b2lMfQeIOqRAONHfBhFcqhfiI
        E3V4PVEOp3W5bMCA==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Reclaim TIF_IA32 and TIF_X32
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-11-krisman@collabora.com>
References: <20201004032536.1229030-11-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675230.397.11778455770674178750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8d71d2bf6efec3032208958c483a247f529ffb16
Gitweb:        https://git.kernel.org/tip/8d71d2bf6efec3032208958c483a247f529ffb16
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:36 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:47 +01:00

x86: Reclaim TIF_IA32 and TIF_X32

Now that these flags are no longer used, reclaim those TIF bits.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201004032536.1229030-11-krisman@collabora.com

---
 arch/x86/include/asm/thread_info.h | 4 ----
 arch/x86/kernel/process_64.c       | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 44733a4..a12b964 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -91,7 +91,6 @@ struct thread_info {
 #define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
-#define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_SLD			18	/* Restore split lock detection on context switch */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
@@ -101,7 +100,6 @@ struct thread_info {
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
-#define TIF_X32			30	/* 32-bit native x86-64 binary */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
@@ -120,7 +118,6 @@ struct thread_info {
 #define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
-#define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
@@ -129,7 +126,6 @@ struct thread_info {
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
-#define _TIF_X32		(1 << TIF_X32)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d6efaf6..ad582f9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -640,9 +640,7 @@ void set_personality_64bit(void)
 	/* inherit personality from parent */
 
 	/* Make sure to be in 64bit mode */
-	clear_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_ADDR32);
-	clear_thread_flag(TIF_X32);
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
@@ -659,8 +657,6 @@ void set_personality_64bit(void)
 static void __set_personality_x32(void)
 {
 #ifdef CONFIG_X86_X32
-	clear_thread_flag(TIF_IA32);
-	set_thread_flag(TIF_X32);
 	if (current->mm)
 		current->mm->context.flags = 0;
 
@@ -681,8 +677,6 @@ static void __set_personality_x32(void)
 static void __set_personality_ia32(void)
 {
 #ifdef CONFIG_IA32_EMULATION
-	set_thread_flag(TIF_IA32);
-	clear_thread_flag(TIF_X32);
 	if (current->mm) {
 		/*
 		 * uprobes applied to this MM need to know this and
