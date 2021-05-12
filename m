Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E908037B909
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhELJYo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 05:24:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49952 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhELJYm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 05:24:42 -0400
Date:   Wed, 12 May 2021 09:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620811414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LkfIJsJoBgZL+0qB4Yb95N6MsfQNyW0ywHEHa5X7JE=;
        b=wAduOBRH34kUjBdcZV0CkOGIa/78gnFbUkEc+pacTIqPOe9sp/yixhuI8qZgVOME8QUrUO
        ksRiX1zQ726fgWW0VGKjVh3vDd8uh37FR0Z25pzy0QdkTIKvqfLmkvYaMGMzKzEHAqM3fJ
        o7M6AWa85myMtFyZTnEYD9YZ1H43PiBPfykbKVjV/anQQtu4qu1Yow76QyDQ39+2Tj/PIp
        CJbjS5CP2Lt9r1hlHY3IiFyfa1saCRU3op/t9eNERHinjb+9fi2M7Th0r6pTmiX2p4vGX0
        RMLypJGIVxr53UW8aRnRQpabkf5Nw6tKPDo0K2F+wCuXHw+s0Nfc58RUq9qxNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620811414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LkfIJsJoBgZL+0qB4Yb95N6MsfQNyW0ywHEHa5X7JE=;
        b=ufG2mp+ULsIClBOQe7B5y4S5ehBDuF0LzBa0DT7sx9OjoboAuTGODOgpAs+2RoZSI8fGWn
        U8+Rp3KTLfDxxIAA==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Reverse arguments to do_syscall_64()
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510185316.3307264-3-hpa@zytor.com>
References: <20210510185316.3307264-3-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162081141344.29796.12089537584987370591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     3e5e7f7736b05d5fdf2cc4e0ba4f2d8bc42c630d
Gitweb:        https://git.kernel.org/tip/3e5e7f7736b05d5fdf2cc4e0ba4f2d8bc42c630d
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 11:53:11 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 10:49:14 +02:00

x86/entry: Reverse arguments to do_syscall_64()

Reverse the order of arguments to do_syscall_64() so that the first
argument is the pt_regs pointer. This is not only consistent with
*all* other entry points from assembly, but it actually makes the
compiled code slightly better.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510185316.3307264-3-hpa@zytor.com
---
 arch/x86/entry/common.c        | 2 +-
 arch/x86/entry/entry_64.S      | 4 ++--
 arch/x86/include/asm/syscall.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7b2542b..00da0f5 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -36,7 +36,7 @@
 #include <asm/irq_stack.h>
 
 #ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+__visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
 {
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a16a529..1d9db15 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -107,8 +107,8 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
 	/* IRQs are off. */
-	movq	%rax, %rdi
-	movq	%rsp, %rsi
+	movq	%rsp, %rdi
+	movq	%rax, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	/*
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7cbf733..4e20054 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -160,7 +160,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-void do_syscall_64(unsigned long nr, struct pt_regs *regs);
+void do_syscall_64(struct pt_regs *regs, unsigned long nr);
 void do_int80_syscall_32(struct pt_regs *regs);
 long do_fast_syscall_32(struct pt_regs *regs);
 
