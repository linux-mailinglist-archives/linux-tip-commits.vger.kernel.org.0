Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B217F38AFDE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhETNZH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbhETNZB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:25:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB37AC06175F;
        Thu, 20 May 2021 06:23:34 -0700 (PDT)
Date:   Thu, 20 May 2021 13:23:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Pl5o+lMKLG8cgepJD9f+w/yKB9h3TV9zlAzxKNKC+s=;
        b=2TWqV6igYQD0a6eFOwRIJnjp44wEieJ6HhgOxfwmGO1b9pxbpfp70XIXEsveskFeFJlfmz
        uF31QkhWzFIoX5XOYTubIsQlJGtx99tCPebtc2UrbH3XW+05OXpORIQoXC9DIEVIZr2Mhy
        JYIrqkRzw21tQDGV9oCbW5syUogKwsifqr6jmjAjTIF84X+HOYlLz2O08QUW0Pzs/Vb/H5
        hQVdzNTI1qGD19oJPzal6w0hJPvsoI3WSe64ayAO+Ns2xkWbmr8FavQdhD9ZZI5GUa/W0e
        WTYWTpncshQZqUhlgqnmhQn2HBhitcAwMQjs6G1BsHUNWEHOAknKKpiZKrnH4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Pl5o+lMKLG8cgepJD9f+w/yKB9h3TV9zlAzxKNKC+s=;
        b=Akl3qthwCyGJB/Fq10Sv3IldfyX3/VKgRkIWTy8vniLBhlTwf9pivXZz56xXwoUZekEO+R
        QgVeJQsPdZZgRrBw==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Treat out of range and gap system calls the same
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518191303.4135296-6-hpa@zytor.com>
References: <20210518191303.4135296-6-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162151701044.29796.5729253663236164364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     b337b4965e3a3e567f11828a9e3fe3fb3faefa47
Gitweb:        https://git.kernel.org/tip/b337b4965e3a3e567f11828a9e3fe3fb3faefa47
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 18 May 2021 12:13:02 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:19:49 +02:00

x86/entry: Treat out of range and gap system calls the same

The current 64-bit system call entry code treats out-of-range system
calls differently than system calls that map to a hole in the system
call table.

This is visible to the user if system calls are intercepted via ptrace or
seccomp and the return value (regs->ax) is modified: in the former case,
the return value is preserved, and in the latter case, sys_ni_syscall() is
called and the return value is forced to -ENOSYS.

The API spec in <asm-generic/syscalls.h> is very clear that only
(int)-1 is the non-system-call sentinel value, so make the system call
behavior consistent by calling sys_ni_syscall() for all invalid system
call numbers except for -1.

Although currently sys_ni_syscall() simply returns -ENOSYS, calling it
explicitly is friendly for tracing and future possible extensions, and
as this is an error path there is no reason to optimize it.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210518191303.4135296-6-hpa@zytor.com

---
 arch/x86/entry/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 00da0f5..f51bc17 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -52,6 +52,8 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
 					X32_NR_syscalls);
 		regs->ax = x32_sys_call_table[nr](regs);
 #endif
+	} else if (unlikely((int)nr != -1)) {
+		regs->ax = __x64_sys_ni_syscall(regs);
 	}
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
@@ -76,6 +78,8 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
+	} else if (unlikely((int)nr != -1)) {
+		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
 }
 
