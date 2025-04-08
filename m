Return-Path: <linux-tip-commits+bounces-4777-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED6A81749
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 22:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC7C888DC5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 20:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F425485B;
	Tue,  8 Apr 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0+obKGn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/62W3yPo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70C244EA1;
	Tue,  8 Apr 2025 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145749; cv=none; b=F0uTID6OuKlAMU1FyWmjxgAluscv3luqb8rqoxuGLqOJwjhbvREhA4gUvnZ7DD8rrjlM+oBQy96M1k5wtGVbKFdDLAtEJEMYZSRPQZB+Fw+gufXMMIrnNSXOQUj877NxVakMsJ8QWhyfvTcldNl1Ok0eQdno/TkID4ZYxMNUdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145749; c=relaxed/simple;
	bh=J5qQaP4IGKiB45yKzlSZw0CAc2eUB8Kdf065jJzXhtE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F9x85byO8hHWjgVoWahcaIiS/9VCEyHkgbPG9Oa2Jm4nBT0qce/+bAcdblUxwNy5Cty2Lr0cTCN9rMd1kAr/4jqcA4Oip9LQCkFsYBCkydom/a5/i7fr74hP044WkGCKKO/OpmGxJKdGPVWaA+7uojsdzfMhByMujGWBHbynIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0+obKGn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/62W3yPo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 20:55:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744145743;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zyl+bPHErcWjxeLYNOEUamNFFcousmJp0wSNVnNNkWk=;
	b=M0+obKGnzuKSw+jQDtux2bEjx61ZnKzoqvVE/0nPhIcQQXWmW6JwIAVcukR1Ld9IUCM5vr
	JYf+KuSJxcrK8IkDjOR4bQTYgsIgHrIqRSB2bkHyT+mLUQEpbCvJCl0DpCsQnR/Cs6ZGRg
	bKYLg7W6sTyTAL25dQ+7N2CYtT2ETL4jAfrI6sqTDbcE0FwkNwLN6bXtAlSE+oEgDTh2FN
	oJtJ81mKyqOlC9Pi3bsHmda851B2Ss2nJUYev7pjNevNdoL1tISW09MPAzNThxgiN13KQB
	pzV+3GgryX9rQ+OD4Ps46cjQ5laZvRn1t+15SJUgTprMGGFhmKF3UGoRGKUsNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744145743;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zyl+bPHErcWjxeLYNOEUamNFFcousmJp0wSNVnNNkWk=;
	b=/62W3yPovEmk82z0GuqO5HtcpvYy5xkHFbNqw31SJA+uv/+rvCJNWZ2h/SYMW2MvCMe08v
	rnQXpN/bZen25EBA==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] genirq/generic-chip: Fix incorrect lock guard conversions
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C514f94c5891c61ac0a4a7fdad113e75db1eea367=2E17441?=
 =?utf-8?q?35467=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C514f94c5891c61ac0a4a7fdad113e75db1eea367=2E174413?=
 =?utf-8?q?5467=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174414573357.31282.17815254049625566388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     771487050f83b030090079133b192de6e3cf5909
Gitweb:        https://git.kernel.org/tip/771487050f83b030090079133b192de6e3cf5909
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 08 Apr 2025 20:07:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 08 Apr 2025 22:49:02 +02:00

genirq/generic-chip: Fix incorrect lock guard conversions

When booting BeagleBone Black:

    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4398 lockdep_hardirqs_on_prepare+0x23c/0x280
    DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0-rc1-boneblack-00004-g195298c3b116 #209 NONE
    Hardware name: Generic AM33XX (Flattened Device Tree)
    Call trace:
     _raw_spin_unlock_irq from irq_map_generic_chip+0x144/0x190
     irq_map_generic_chip from irq_domain_associate_locked+0x68/0x164
     irq_domain_associate_locked from irq_create_fwspec_mapping+0x34c/0x43c
     irq_create_fwspec_mapping from irq_create_of_mapping+0x64/0x8c
     irq_create_of_mapping from irq_of_parse_and_map+0x54/0x7c
     irq_of_parse_and_map from dmtimer_clkevt_init_common+0x54/0x15c
     dmtimer_clkevt_init_common from dmtimer_systimer_init+0x41c/0x5b8
     dmtimer_systimer_init from timer_probe+0x68/0xf0
     timer_probe from start_kernel+0x4a4/0x6bc
     start_kernel from 0x0
    irq event stamp: 0
    hardirqs last  enabled at (0): [<00000000>] 0x0
    hardirqs last disabled at (0): [<00000000>] 0x0
    softirqs last  enabled at (0): [<00000000>] 0x0
    softirqs last disabled at (0): [<00000000>] 0x0
    ---[ end trace 0000000000000000 ]---

and:

    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 0 at init/main.c:1022 start_kernel+0x4e8/0x6bc
    Interrupts were enabled early
    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W           6.15.0-rc1-boneblack-00004-g195298c3b116 #209 NONE
    Tainted: [W]=WARN
    Hardware name: Generic AM33XX (Flattened Device Tree)
    Call trace:
     unwind_backtrace from show_stack+0x10/0x14
     show_stack from dump_stack_lvl+0x6c/0x90
     dump_stack_lvl from __warn+0x70/0x1b0
     __warn from warn_slowpath_fmt+0x1d4/0x1ec
     warn_slowpath_fmt from start_kernel+0x4e8/0x6bc
     start_kernel from 0x0
    irq event stamp: 0
    hardirqs last  enabled at (0): [<00000000>] 0x0
    hardirqs last disabled at (0): [<00000000>] 0x0
    softirqs last  enabled at (0): [<00000000>] 0x0
    softirqs last disabled at (0): [<00000000>] 0x0
    ---[ end trace 0000000000000000 ]---

Fix this by correcting two misconversions of
raw_spin_{,un}lock_irq{save,restore}() to lock guards.

Fixes: 195298c3b11628a6 ("genirq/generic-chip: Convert core code to lock guards")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/514f94c5891c61ac0a4a7fdad113e75db1eea367.1744135467.git.geert+renesas@glider.be

---
 kernel/irq/generic-chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 8014bfe..bf59e37 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -330,7 +330,7 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 				goto err;
 		}
 
-		scoped_guard (raw_spinlock, &gc_lock)
+		scoped_guard (raw_spinlock_irqsave, &gc_lock)
 			list_add_tail(&gc->list, &gc_list);
 		/* Calc pointer to the next generic chip */
 		tmp += gc_sz;
@@ -467,7 +467,7 @@ int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 
 	/* We only init the cache for the first mapping of a generic chip */
 	if (!gc->installed) {
-		guard(raw_spinlock_irq)(&gc->lock);
+		guard(raw_spinlock_irqsave)(&gc->lock);
 		irq_gc_init_mask_cache(gc, dgc->gc_flags);
 	}
 

