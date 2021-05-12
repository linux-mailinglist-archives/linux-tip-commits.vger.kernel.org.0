Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9055737B908
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhELJYo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 05:24:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhELJYm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 05:24:42 -0400
Date:   Wed, 12 May 2021 09:23:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620811413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LudlT9g8K5DXfikipCI2o0FQTA4mDhOHf7zYptcOqJs=;
        b=aYPMnIUgCf+tjVPUfRmdpLJTsF4E52WdAP2TrEEb1MNqt29C5cT70t5xpVvbbwTriBD030
        CaAWImp5D/humA0ecHk4hFPDhYbKxQthvss0J9MSMj8jY7g54CNZxp0Qe27F+CiJodjhwY
        rTKzF8XUpylet842/u39/6GWlK+Aj4zWiyJBukkEjzG1Rv8FdtmsKCvyQtyTK+96l/f2Yo
        LQ/Dzb1W1/a1Fg9nOOJZl+ikYF82DBUuPOF7uCR5/dQBDi99TetDHQq/+wL9r2THtUrl0I
        K+m+oRXVd8uHbPScfsEdE6JYrFgDy1ssOohdOgGxvmEjmLtJ3WbRjFlRvX8zJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620811413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LudlT9g8K5DXfikipCI2o0FQTA4mDhOHf7zYptcOqJs=;
        b=3gE15fm+VlNCKoAk+45fJH6+sZ5rn1clwiP2zThjwrvwdQZhmO+MyKXy//yxgFoUkK9Ax0
        0S5xCbujfNHQLiBQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/syscall: Maximize MSR_SYSCALL_MASK
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510185316.3307264-5-hpa@zytor.com>
References: <20210510185316.3307264-5-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162081141265.29796.17924251937158616566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     6de4ac1d03f75248974a398110b15af0bfe65a11
Gitweb:        https://git.kernel.org/tip/6de4ac1d03f75248974a398110b15af0bfe65a11
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 11:53:13 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 10:49:15 +02:00

x86/syscall: Maximize MSR_SYSCALL_MASK

It is better to clear as many flags as possible when we do a system
call entry, as opposed to the other way around. The fewer flags we
keep, the lesser the possible interference between the kernel and user
space.

The flags changed are:

 - CF, PF, AF, ZF, SF, OF: these are arithmetic flags which affect
   branches, possibly speculatively. They should be cleared for the same
   reasons we now clear all GPRs on entry.

 - RF: suppresses a code breakpoint on the subsequent instruction. It is
   probably impossible to enter the kernel with RF set, but if it is
   somehow not, it would break a kernel debugger setting a breakpoint on
   the entry point. Either way, user space should not be able to control
   kernel behavior here.

 - ID: this flag has no direct effect (it is a scratch bit only.)
   However, there is no reason to retain the user space value in the
   kernel, and the standard should be to clear unless needed, not the
   other way around.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510185316.3307264-5-hpa@zytor.com
---
 arch/x86/kernel/cpu/common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1b756c..6cf6975 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1773,10 +1773,16 @@ void syscall_init(void)
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
 #endif
 
-	/* Flags to clear on syscall */
+	/*
+	 * Flags to clear on syscall; clear as much as possible
+	 * to minimize user space-kernel interference.
+	 */
 	wrmsrl(MSR_SYSCALL_MASK,
-	       X86_EFLAGS_TF|X86_EFLAGS_DF|X86_EFLAGS_IF|
-	       X86_EFLAGS_IOPL|X86_EFLAGS_AC|X86_EFLAGS_NT);
+	       X86_EFLAGS_CF|X86_EFLAGS_PF|X86_EFLAGS_AF|
+	       X86_EFLAGS_ZF|X86_EFLAGS_SF|X86_EFLAGS_TF|
+	       X86_EFLAGS_IF|X86_EFLAGS_DF|X86_EFLAGS_OF|
+	       X86_EFLAGS_IOPL|X86_EFLAGS_NT|X86_EFLAGS_RF|
+	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
 
 #else	/* CONFIG_X86_64 */
