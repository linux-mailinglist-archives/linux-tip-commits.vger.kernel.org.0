Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1137B907
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhELJYn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 05:24:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49934 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhELJYl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 05:24:41 -0400
Date:   Wed, 12 May 2021 09:23:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620811412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfVAuSOhyD+3RHq++pgOxElnVlkBerZacpttXIHit6Y=;
        b=bxeR/6dK3CGc60tFLCazWkQ5uYdAtGPQzqU8z/05IfIYPY51obVGxGVjIy2xoNne/mZfUI
        KWcWTOMOLN2gjG6fVJJv6QdhNPtOwdbL6BblVn3AhTCvGjie2rSC6I7Uq8yGBQHHUbX2Dh
        4Ot0PfjPKrhVzkDIOv/bsbKJM4RsEGjnAHZpDcCAzXookwb0DCiZgIi8pfsbwW+9razP4t
        BiAPsWnT8ODk3Uv/9KCAH4s8hHU7+fBGDKNXFgUtaAhBmK8cDcnN0NU6EZVVcaUK45VDZ1
        5tzlTiROUgqlP3faVgltvuk1mrKfVKFMmtsXf1E+poIGnA5pca6n72FaPiIZZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620811412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfVAuSOhyD+3RHq++pgOxElnVlkBerZacpttXIHit6Y=;
        b=T2tyRIAiF+180TidV9Oj45du5x0UYUYhiNlblDUJWmq7Om3GGtO9R1seuku4a9TBol+AJQ
        ol5If6i9bn1McnDQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Split PUSH_AND_CLEAR_REGS into two submacros
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510185316.3307264-6-hpa@zytor.com>
References: <20210510185316.3307264-6-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162081141225.29796.14095021239413369152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     29e9758966f47004bd7245e6adadcb708386f36a
Gitweb:        https://git.kernel.org/tip/29e9758966f47004bd7245e6adadcb708386f36a
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 11:53:14 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 10:49:15 +02:00

x86/entry: Split PUSH_AND_CLEAR_REGS into two submacros

PUSH_AND_CLEAR_REGS, as the name implies, performs two functions:
pushing registers and clearing registers. They don't necessarily have
to be performed in immediate sequence, although all current users
do. Split it into two macros for the case where that isn't desired;
the FRED enabling patchset will eventually make use of this.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510185316.3307264-6-hpa@zytor.com
---
 arch/x86/entry/calling.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 7436d4a..a4c061f 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,7 +63,7 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
+.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -90,7 +90,9 @@ For 32-bit we have the following conventions - kernel is built with
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
 	.endif
+.endm
 
+.macro CLEAR_REGS
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -112,6 +114,11 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
+	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+	CLEAR_REGS
+.endm
+
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
