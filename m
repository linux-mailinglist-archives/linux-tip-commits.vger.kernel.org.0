Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323BF40C8C4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbhIOPu7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbhIOPus (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:48 -0400
Date:   Wed, 15 Sep 2021 15:49:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdj8DWWYHCnHLZOLlJE9C0unvR2ZERSrxd5nRbwv/jM=;
        b=cK9d2xvW5C4Bchv5XWzXUdkqGfQuubXt+l+SvVxSd7x70ASrAZV/sI+rV8RMo3w5aGHNht
        yv3Zm4i+9EuMLP3gqB1XvCv9kzr//VS8Hz9Y8eUAEmWh95hSAX6gFew1CoUqViAMjWNepS
        +tj4hi/xarU7Tf0YFiOKqqmlIuylu7JaebAGe+jDwk66D0BE9MCQWZoJ3qilXVjxg1DqqY
        GTZQJd6ha6esTIEJtsl2JUbT79gVqqFitIdVmVOb4n0EPRT0E7V/SRUFY8usXzU91C9FtI
        tnXcJarlYcK89RQKm3hQ4xMaRkulfaZPJ85xNxU1vLVOrrriQWmK3m+z0NZsGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdj8DWWYHCnHLZOLlJE9C0unvR2ZERSrxd5nRbwv/jM=;
        b=ETR7r+j7HI7s3WdwNiuPlx5SsPvnBYzOqe9hrTm+n5ubwABGUZ4ASxH4twmAWgAFTef/Iv
        4eZf1J2CrwcDluDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86: Always inline ip_within_syscall_gap()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.188166492@infradead.org>
References: <20210624095148.188166492@infradead.org>
MIME-Version: 1.0
Message-ID: <163172096831.25758.17985225721075369216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c6b01dace2cd7f6b3e9174d4d1411755608486f1
Gitweb:        https://git.kernel.org/tip/c6b01dace2cd7f6b3e9174d4d1411755608486f1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:47 +02:00

x86: Always inline ip_within_syscall_gap()

vmlinux.o: warning: objtool: vc_switch_off_ist()+0x20: call to ip_within_syscall_gap.isra.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095148.188166492@infradead.org
---
 arch/x86/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index b94f615..7036631 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -181,7 +181,7 @@ static inline bool any_64bit_mode(struct pt_regs *regs)
 #define current_user_stack_pointer()	current_pt_regs()->sp
 #define compat_user_stack_pointer()	current_pt_regs()->sp
 
-static inline bool ip_within_syscall_gap(struct pt_regs *regs)
+static __always_inline bool ip_within_syscall_gap(struct pt_regs *regs)
 {
 	bool ret = (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
 		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack);
