Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA753AF2E7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Jun 2021 19:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhFUR5q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Jun 2021 13:57:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhFURzr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Jun 2021 13:55:47 -0400
Date:   Mon, 21 Jun 2021 17:53:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624298011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YH3f6MBaqyU4MYEEOYfekfCSOLt9UeEUXfvYCYqWqdI=;
        b=Y9qft6Mb00Mx+3gU6XUCpwxkF8t2cTyw3gzAPgmJISxilvS78kkuyHt56vaZVMgaDz9lgg
        WuDyqMRaQctRL/5HJf4fAZ/awNd64L43v0aFRluduAkdU0GpSX06bHUwfcLkynHpZpdOmk
        jgfFoc9AdJCz3yJK9wQEDHgtWhi2rYH0Vq9/HLkHsFeBm/LFO0w2R+VADi2aPmZR4bybJT
        vczUV5P1PggmMlck5dgrzFIQrXi6NPmj+CwPMxr7H+75jL3zgHt7ICPiqDvgGoDoLvNiZU
        u8G6RPzu6T3Q/J7//OhT7l3kICvB7+ndaQkwOw+5eEwpf3BRBMubaYiM+tTPVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624298011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YH3f6MBaqyU4MYEEOYfekfCSOLt9UeEUXfvYCYqWqdI=;
        b=+NIRJTGY520NQltVup6Qt4/rKcc09Mc41xilWDXPLeXCEmGDDUUQSyV3fDr4Ybkx4lz05+
        bEMr3a5nuhWV51CA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool/x86: Ignore __x86_indirect_alt_* symbols
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YNCgxwLBiK9wclYJ@hirez.programming.kicks-ass.net>
References: <YNCgxwLBiK9wclYJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162429800985.395.5319249290550367396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     31197d3a0f1caeb60fb01f6755e28347e4f44037
Gitweb:        https://git.kernel.org/tip/31197d3a0f1caeb60fb01f6755e28347e4f44037
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Jun 2021 16:13:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Jun 2021 17:26:57 +02:00

objtool/x86: Ignore __x86_indirect_alt_* symbols

Because the __x86_indirect_alt* symbols are just that, objtool will
try and validate them as regular symbols, instead of the alternative
replacements that they are.

This goes sideways for FRAME_POINTER=y builds; which generate a fair
amount of warnings.

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YNCgxwLBiK9wclYJ@hirez.programming.kicks-ass.net
---
 arch/x86/lib/retpoline.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 4d32cb0..ec9922c 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -58,12 +58,16 @@ SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
 2:	.skip	5-(2b-1b), 0x90
 SYM_FUNC_END(__x86_indirect_alt_call_\reg)
 
+STACK_FRAME_NON_STANDARD(__x86_indirect_alt_call_\reg)
+
 SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
 	ANNOTATE_RETPOLINE_SAFE
 1:	jmp	*%\reg
 2:	.skip	5-(2b-1b), 0x90
 SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
 
+STACK_FRAME_NON_STANDARD(__x86_indirect_alt_jmp_\reg)
+
 .endm
 
 /*
