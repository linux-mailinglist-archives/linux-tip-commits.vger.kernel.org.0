Return-Path: <linux-tip-commits+bounces-4268-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117EA64A8C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A583AEE8E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B62417C9;
	Mon, 17 Mar 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="au2H4ihi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pB6zTD6H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB323716B;
	Mon, 17 Mar 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207699; cv=none; b=OU+YoBLBqGdZOWVPePlHvUg00D5iUpp0rPDX41bKV+Bk8SCMVyh6eUUDYfwLocITLcfdyruqCGCQcssuUfI2JjBiF5O+q0NJG5p4OQjBghEmqUAj0oB2COeAE3qadDaP8pOOQcU6uN6RXKOLFKz4FIg1/r7908fn160sh0vTB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207699; c=relaxed/simple;
	bh=v7nlKEVKRD6yfUHYEXAVMW5eGSYCUFD0u+wWa90WDCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wo5+MeMX2S0dru7Ba76KJc7QcpaqJ00Vc8qlzeF25lQa7XpQvs04BpoXjHd5N5zPcq/bywTpYuBrjRtntJBTSCYQWjpCaDjLp+chNCtfwcpafv4hfaO89bbb/XbWQX/CrdMOPNt14rWlTgE79NtdMB/DYkPEwWF9+Lu8wAot8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=au2H4ihi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pB6zTD6H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSXGSJYgEZcy56X8qJBu9zf/Gfr1mFxVWQQNgbEtBC0=;
	b=au2H4ihigsUAs4W+EQRszcV0fZjekTPDS6hkk5CVNAnMMcnC3c8RbZMlhoHbop9YBUu/CA
	9OScrVJKx7fxa3MwxOrp8tEbuosmPj4L7SQ2lS/+IxKJhIzEkd1qUjbk9dA2OXuXjF7kGq
	iWG36TZYmeBa5YePqo/cIRCVTniAGpYfQtz8C5+s/HOI1NYOSisLEQFU5tfsJITv1qtp98
	ysgVvCMt/3HWUUUnZkblK2ctM7b/LcNaQxsOiF27Ge9tlna1EbXe9q+3PUXpjnb65hjg0A
	cezu0zCMSrKauC/RDQXBNvpt7r9WikTyNAg4dT9DZh1qn5vC+vV86761mQC2Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSXGSJYgEZcy56X8qJBu9zf/Gfr1mFxVWQQNgbEtBC0=;
	b=pB6zTD6HDQJGT5Ex6iQBE1iyMG4g+ja9AdjzmnvacApbKlM/VibiNiIFN9lOilstG5CTx/
	xVsKEeDQLtrlTQBw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm: Rely on generic printing of preemption model
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-4-bigeasy@linutronix.de>
References: <20250314160810.2373416-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220769543.14745.8305339314525226619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     03288138baa522d143a208c2b7ab2931f26ef07f
Gitweb:        https://git.kernel.org/tip/03288138baa522d143a208c2b7ab2931f26ef07f
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:39 +01:00

arm: Rely on generic printing of preemption model

__die() invokes later __show_regs() -> show_regs_print_info() which
prints the current preemption model.
Remove it from the initial line.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20250314160810.2373416-4-bigeasy@linutronix.de
---
 arch/arm/kernel/traps.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 6ea6459..afbd2eb 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -258,13 +258,6 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 	barrier();
 }
 
-#ifdef CONFIG_PREEMPT
-#define S_PREEMPT " PREEMPT"
-#elif defined(CONFIG_PREEMPT_RT)
-#define S_PREEMPT " PREEMPT_RT"
-#else
-#define S_PREEMPT ""
-#endif
 #ifdef CONFIG_SMP
 #define S_SMP " SMP"
 #else
@@ -282,8 +275,8 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP S_ISA "\n",
-	         str, err, ++die_counter);
+	pr_emerg("Internal error: %s: %x [#%d]" S_SMP S_ISA "\n",
+		 str, err, ++die_counter);
 
 	/* trap and error numbers are mostly meaningless on ARM */
 	ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);

