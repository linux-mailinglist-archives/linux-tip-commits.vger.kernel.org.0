Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7354E2F3DD5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436901AbhALVhU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48316 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436723AbhALUMy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:12:54 -0500
Date:   Tue, 12 Jan 2021 20:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkCJyEiRbTLg4uc3/PpmQgQhPIgjI5nAt8LH/Pr86l8=;
        b=z5/ScDi2UtSIjtaa1hEcMwuRCF0xf5U4CnKds7lYDZGpAJ0dHPvwMrR8+6tVsPlvt8/Umf
        SxDI3a60caPxt37RdfMOCIv/1nS0CocQQI4uJ8HUsivtIdsHM+Ni28rdXVDO7CuDpZ26ph
        ZVCbMYyJv0DFdYcD9Ti6JQqQHipvUo1tjGUfvNTr7kAaqKk4h0IBTLmq0wWOKkscsQfYfe
        UYpOqdY5BdkauXFQTnu0CXDAA6Qw4DHFD5FSdDvqDjQqU7TFX4GK229v9KmUGyHZBc70nU
        pV6pVh49QH1Sp4RLtklPwSDU68nxsurP81QaACIHlW9DdxH2DVOQKmM3a3sxTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkCJyEiRbTLg4uc3/PpmQgQhPIgjI5nAt8LH/Pr86l8=;
        b=vfvOdmWivgO07Cf5Jq6sg+PpBmRtXh/cQxJ1FartAcZcyB4NWX4zgrjZT7Xm88XnXXWCg3
        kuj7VSOlzsenI1Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: __always_inline __{rd,wr}msr()
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <bf3gV+BW7kGEsB@hirez.programming.kicks-ass.net>
References: <bf3gV+BW7kGEsB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161048232936.414.13129849390143250864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     66a425011c61e71560c234492d204e83cfb73d1d
Gitweb:        https://git.kernel.org/tip/66a425011c61e71560c234492d204e83cfb73d1d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 07 Jan 2021 11:14:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:10:59 +01:00

x86: __always_inline __{rd,wr}msr()

When the compiler choses to not inline the trivial MSR helpers:

  vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xce: call to __wrmsr.constprop.14() leaves .noinstr.text section

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Link: https://lore.kernel.org/r/X/bf3gV+BW7kGEsB@hirez.programming.kicks-ass.net

---
 arch/x86/include/asm/msr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 0b4920a..e16cccd 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -86,7 +86,7 @@ static inline void do_trace_rdpmc(unsigned int msr, u64 val, int failed) {}
  * think of extending them - you will be slapped with a stinking trout or a frozen
  * shark will reach you, wherever you are! You've been warned.
  */
-static inline unsigned long long notrace __rdmsr(unsigned int msr)
+static __always_inline unsigned long long __rdmsr(unsigned int msr)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -98,7 +98,7 @@ static inline unsigned long long notrace __rdmsr(unsigned int msr)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
+static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
 {
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
