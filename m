Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23CC38AFD7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhETNZB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhETNYy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:24:54 -0400
Date:   Thu, 20 May 2021 13:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYDIVIZQFgKJxCLJ4MS4K3vpAX1H8Qzw6DAnmbXPlik=;
        b=VbCfcvyY30DMF6XC67AhtQLacby/Lvn8WBDNcGHtf2SoqwydAlCSRJh17USKeQ/CMYuPB2
        DYKFkrQeoJhfR0rvvc5+79aaUCp7O1f3kn8DNI3j5+utz6YPQUCr/LYRs7GkS+gReNDnTZ
        Mc4cmWOe1HOZkZ4Gf30GNlOoaC8w1hu+RXzpkLhWtW4SxaBULpHE4OUnA9JToHD8g2+iI/
        zsTa2hvbXNT5OlOjsvA9D0z6IJcaDYhK36478dd7MgzxtC1AE/4nRzOQJb82h4t1U9PiYQ
        Ykn7gys4AHrC3/FmphNhzeg/u4dxBBrjBRVnuMEoGHPS8aiB9Te1WKlBeUOMHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYDIVIZQFgKJxCLJ4MS4K3vpAX1H8Qzw6DAnmbXPlik=;
        b=OFFopeFE74zal7nbpSQoyp3yMCmkYKiFJdRKpMoDKoQYUxfR08pLtauvNbuE+4SxjJOH4j
        ErtQiIwqv+4FLNDA==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Sign-extend system calls on entry to int
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518191303.4135296-5-hpa@zytor.com>
References: <20210518191303.4135296-5-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162151701102.29796.14343051250816101090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0595494891723a1dcca5eaa8eeca8ab54ad953b9
Gitweb:        https://git.kernel.org/tip/0595494891723a1dcca5eaa8eeca8ab54ad953b9
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 18 May 2021 12:13:01 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:19:49 +02:00

x86/entry/64: Sign-extend system calls on entry to int

Right now, *some* code will treat e.g. 0x0000000100000001 as a system
call and some will not. Some of the code, notably in ptrace, will
treat 0x000000018000000 as a system call and some will not. Finally,
right now, e.g. 335 for x86-64 will force the exit code to be set to
-ENOSYS even if poked by ptrace, but 548 will not, because there is an
observable difference between an out of range system call and a system
call number that falls outside the range of the table.

This is visible to the user: for example, the syscall_numbering_64
test fails if run under strace, because as strace uses ptrace, it ends
up clobbering the upper half of the 64-bit system call number.

The architecture independent code all assumes that a system call is "int"
that the value -1 specifically and not just any negative value is used for
a non-system call. This is the case on x86 as well when arch-independent
code is involved. The arch-independent API is defined/documented (but not
*implemented*!) in <asm-generic/syscall.h>.

This is an ABI change, but is in fact a revert to the original x86-64
ABI. The original assembly entry code would zero-extend the system call
number;

Use sign extend to be explicit that this is treated as a signed number
(although in practice it makes no difference, of course) and to avoid
people getting the idea of "optimizing" it, as has happened on at least
two(!) separate occasions.

Do not store the extended value into regs->orig_ax, however: on x86-64, the
ABI is that the callee is responsible for extending parameters, so only
examining the lower 32 bits is fully consistent with any "int" argument to
any system call, e.g. regs->di for write(2). The full value of %rax on
entry to the kernel is thus still available.

[ tglx: Add a comment to the ASM code ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210518191303.4135296-5-hpa@zytor.com

---
 arch/x86/entry/entry_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1d9db15..a5f02d0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -108,7 +108,8 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 
 	/* IRQs are off. */
 	movq	%rsp, %rdi
-	movq	%rax, %rsi
+	/* Sign extend the lower 32bit as syscall numbers are treated as int */
+	movslq	%eax, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	/*
