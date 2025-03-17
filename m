Return-Path: <linux-tip-commits+bounces-4263-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F07A64A3A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044957A4D0D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8D723F28D;
	Mon, 17 Mar 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aWcoq/xZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="znERo0zt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1D823E32E;
	Mon, 17 Mar 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207688; cv=none; b=Y+dMQ8Aeymc2fQzhJmH/r0149/eJ4nlWxnAN4P7/EWqTNeIroAhNi00NsCkXFFE6BbeQU2PydKgy5VZqLrN0h5tGI/frRPEShmcpa8mkcChNzyd14CoxdSFVX6o1M/L3NgNujYDdnVHY6vG7/bcGwMJsQBGiA/TW8UCxwPU40Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207688; c=relaxed/simple;
	bh=DJdQFd8uGkVBUXQbf6Vjf3AvTf+K/jN1mbPnnNy5GUI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dwms+ICbIl3Bdt+jQJJ50HpGBUKu0Hik8s3E1n6gwxFJD4aVwRWgnBE1THpmzJSeOqSrLB7AFYZgX169p4+hLTiFXhQqcIZcs7c3X5Q+1n9OohvBC6zE/5PIPjpCglkxQX+U951HEm9775EuYtrZ0lJfbGl/Krcfc4MODxMDDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aWcoq/xZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=znERo0zt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jknhy4bNehlLYcDgle6yg1dU90CtiVEk+/Yx2jziyfs=;
	b=aWcoq/xZAbRS5c6Hg5BRcNfq9zT/eFQbN1dOZn1ReS35wni/6I72K/szMN8FfR3fGlVo5v
	ejXGp5ou48+Sx1/4q9ia/KpUgBJGlBecDcfpEw/M2nSoA4W1wh0VqPE1JGIvOF0yboTkTl
	wJdWUc1uNeF+uUoVK6bFlDHzAdnrZDpJR5hweK91yjhREBS9HvV7umYNAx68kh0gzt03j9
	mlvCWXUCKyiwIdkRp1lxMGrOzFUhX8e71SB4M8otT70XRPidgnipTaOAHJYeXHIshPpuQ9
	DXX/fao9dMkOG3ELlMD0MzBAVdy8ahzo7eYdCHjHOZaLY6JGdWABfqAwXO7VBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jknhy4bNehlLYcDgle6yg1dU90CtiVEk+/Yx2jziyfs=;
	b=znERo0ztCPZQelm/uL+xetE9Ukt07XCg1c3kjEk/LY+tc7mpJvkfBj9+6k9xQ1Q/xJU198
	QdAizQcJIg+9XTAA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] xtensa: Rely on generic printing of preemption model
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-9-bigeasy@linutronix.de>
References: <20250314160810.2373416-9-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220768526.14745.9744193148003358940.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6966cd46f63205adc07ce4563ebbc3609e1c9fd7
Gitweb:        https://git.kernel.org/tip/6966cd46f63205adc07ce4563ebbc3609e1c9fd7
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:40 +01:00

xtensa: Rely on generic printing of preemption model

die() invokes later show_regs() -> show_regs_print_info() which prints
the current preemption model.

Remove it from the initial line.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Link: https://lore.kernel.org/r/20250314160810.2373416-9-bigeasy@linutronix.de
---
 arch/xtensa/kernel/traps.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 38092d2..44c07c4 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -629,15 +629,11 @@ DEFINE_SPINLOCK(die_lock);
 void __noreturn die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
-	const char *pr = "";
-
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	console_verbose();
 	spin_lock_irq(&die_lock);
 
-	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter, pr);
+	pr_info("%s: sig: %ld [#%d]\n", str, err, ++die_counter);
 	show_regs(regs);
 	if (!user_mode(regs))
 		show_stack(NULL, (unsigned long *)regs->areg[1], KERN_INFO);

