Return-Path: <linux-tip-commits+bounces-4265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C11A64A6C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B178E1887946
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA123FC61;
	Mon, 17 Mar 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1esXPA1T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ixikrki"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755A23F403;
	Mon, 17 Mar 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207691; cv=none; b=n2pRhKNC16YVLlMOpzG3aJSwHYr4JnEkTz0bMhGOIfFW7WbWvKfcy8UltMPkeY67yvjOTOnd8jrnd9DpT8LVu0Tvnw48sg24/fxJVkfaK0Wp4FijNZGBhvuB8tqwNoc96eiUYSMIteNVi/fCiS8hCmDpG2tyuOqUZeDlwn1YE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207691; c=relaxed/simple;
	bh=omiyoLQPQbHlk3LUS4T9lKF2GplzHE/y0doSm2TKmng=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M8cedQrkwgIMryMeN6nvsNn5wJ0vJyegU9pbRSJRibRRArbERQVgtc50RRP9s0CQuyF2c6tswvIIRp7897A9mMnRkKBrcw1RJ5gIV7qXZ7eR7uag86h03sWsd0cy2IQSsu9/UN/6kNDebjTLXQzvZXslMjaLs6UrN2Wo2m8NvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1esXPA1T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7ixikrki; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdIfdHu18j8EpbwM+W//r7bj2Jqh/tNbD1e+okpkshc=;
	b=1esXPA1TghhLfti6smWIb0uPAEcLVD3g3EsbKgyzhliVIhxxirv+KrW+wj1JJRFU6xdxmk
	c9UODn2veWDFLWOHVeGuJ+Iv4DFSV7zvZ5Zj8dnhmGq2+MOfzCk29cmd9/e8neGEd71jJd
	pABZ2IRpYiwI5nXTrv11z1qV5B4eLIpTZ47SgSb0XQBWcYvQQrpH+X0F/3nXcJhGJzpw25
	LhTlnH8Rlh/jZO4Tq2HRnFiI3J9fDkQ7pEeDVJl7JdBbbtxiVHzM7RCFVifWtEch1d7lY7
	W3gd4QaCR6/Cw7DSWpVhkBU8aZlD//jol9AUVrDzCn+PqYnwdFMbniJUI7ZgIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdIfdHu18j8EpbwM+W//r7bj2Jqh/tNbD1e+okpkshc=;
	b=7ixikrkiotPM/7rXB+vDm35tPgtV8BcXjsxaHaJgbHJMvproy2FsOpZ/Z4Uqikk+oleg61
	56hsu14ntkCSSUAA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] s390: Rely on generic printing of preemption model
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-7-bigeasy@linutronix.de>
References: <20250314160810.2373416-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220768744.14745.11827032035008557038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b70f50be0c74bd9498fba9d33cc548722a2ec879
Gitweb:        https://git.kernel.org/tip/b70f50be0c74bd9498fba9d33cc548722a2ec879
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:40 +01:00

s390: Rely on generic printing of preemption model

die() invokes later show_regs() -> show_regs_print_info() which prints
the current preemption model.
Remove it from the initial line.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20250314160810.2373416-7-bigeasy@linutronix.de
---
 arch/s390/kernel/dumpstack.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 1ecd058..911b95c 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -198,13 +198,8 @@ void __noreturn die(struct pt_regs *regs, const char *str)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-	printk("%s: %04x ilc:%d [#%d] ", str, regs->int_code & 0xffff,
+	printk("%s: %04x ilc:%d [#%d]", str, regs->int_code & 0xffff,
 	       regs->int_code >> 17, ++die_counter);
-#ifdef CONFIG_PREEMPT
-	pr_cont("PREEMPT ");
-#elif defined(CONFIG_PREEMPT_RT)
-	pr_cont("PREEMPT_RT ");
-#endif
 	pr_cont("SMP ");
 	if (debug_pagealloc_enabled())
 		pr_cont("DEBUG_PAGEALLOC");

