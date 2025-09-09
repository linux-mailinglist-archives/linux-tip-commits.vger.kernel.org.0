Return-Path: <linux-tip-commits+bounces-6540-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9816B4F4B7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789C11C25FF8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82833472E;
	Tue,  9 Sep 2025 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3hQ08YAK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EF54OqdQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11C334721;
	Tue,  9 Sep 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419801; cv=none; b=BeG6joRRhFWy6KMZhNSeunyOP2yKuwa6NhAS+TUb6MA2t7gGnQLiede5wtEmgusIw6QWXZSPGddhq4Pc/MaY0nAef7Nwzsz8SGVSgJTEYM38su6/5U5xmLvVdeyq/sJunP8G8HhwkOiFV0ZSXd5+zPd0y1SHALH5wOoZrx+D8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419801; c=relaxed/simple;
	bh=ZpyqmiC40ldkjRGX3fADN1vsciccfqjyLP8hJRTcf+o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R6o7znqxjLtA0tvuZ1wUUPvNDcFB80gtYbsx+6TpjlgSSieEN2HqNxN6MxYDb/7I504QsLLBWdaBi9l5q4FdnDa3VtDsljsLFZ1ibDgd2gf7aWxw2J7UM32nz96jENFNyp/FypM9Pe/PMwUCmcnJjuxwSwV+Ag4xAdK+on4t5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3hQ08YAK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EF54OqdQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 12:09:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757419797;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKuU83a+Mz+NZ8SuF8Wuapxhsm4UuLYA1FkVBoZH5sM=;
	b=3hQ08YAKZgVuaSyB3ZETnoTiGj1b3PZrGp6IGS5JIfGfvM9Dx2NCPRDk1NOfwMWSz7kNIq
	Jj7YWX7FNuU6PoC7jhuIabfFDPAth1OaRUzSKvpDiAzVSgKJ7ZlgfrL5d1tC7qRhlmL5yS
	ofIJGMCNRXK0m+ntbCyDtdJjugJdyNQ7KYjDBPH6/H02dGDZgY2yfHbfscABDlWSaiyN1I
	3V45xJ//Hc3nkJQf75k62g/JdqE84nCiaegH+spCWWwEmrLMzyHx6fxjKiqAMiljAOth+w
	dMHbT3/ebZiAsN40xvAJhvkpOpDxAiQtWYUYGxHTjXM1wlFNKA3p1mtfTIVDRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757419797;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKuU83a+Mz+NZ8SuF8Wuapxhsm4UuLYA1FkVBoZH5sM=;
	b=EF54OqdQ1GLHammiUlG3JwFn4wbtWGKCJgcOKdheWhj3ptgn5xyXz8Xur2C11S017kDpD1
	43OMnjvHzJb6FHCg==
From: "tip-bot2 for Xiongfeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimers: Unconditionally update target CPU base
 after offline timer migration
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250805081025.54235-1-wangxiongfeng2@huawei.com>
References: <20250805081025.54235-1-wangxiongfeng2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741979600.1920.7864362737734843483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e895f8e29119c8c966ea794af9e9100b10becb88
Gitweb:        https://git.kernel.org/tip/e895f8e29119c8c966ea794af9e9100b10b=
ecb88
Author:        Xiongfeng Wang <wangxiongfeng2@huawei.com>
AuthorDate:    Tue, 05 Aug 2025 16:10:25 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 14:05:16 +02:00

hrtimers: Unconditionally update target CPU base after offline timer migration

When testing softirq based hrtimers on an ARM32 board, with high resolution
mode and NOHZ inactive, softirq based hrtimers fail to expire after being
moved away from an offline CPU:

CPU0				CPU1
				hrtimer_start(..., HRTIMER_MODE_SOFT);
cpu_down(CPU1)			...
				hrtimers_cpu_dying()
				  // Migrate timers to CPU0
				  smp_call_function_single(CPU0, returgger_next_event);
  retrigger_next_event()
    if (!highres && !nohz)
        return;

As retrigger_next_event() is a NOOP when both high resolution timers and
NOHZ are inactive CPU0's hrtimer_cpu_base::softirq_expires_next is not
updated and the migrated softirq timers never expire unless there is a
softirq based hrtimer queued on CPU0 later.

Fix this by removing the hrtimer_hres_active() and tick_nohz_active() check
in retrigger_next_event(), which enforces a full update of the CPU base.
As this is not a fast path the extra cost does not matter.

[ tglx: Massaged change log ]

Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU =
earlier")
Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250805081025.54235-1-wangxiongfeng2@huawe=
i.com
---
 kernel/time/hrtimer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 30899a8..e8c4793 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -787,10 +787,10 @@ static void retrigger_next_event(void *arg)
 	 * of the next expiring timer is enough. The return from the SMP
 	 * function call will take care of the reprogramming in case the
 	 * CPU was in a NOHZ idle sleep.
+	 *
+	 * In periodic low resolution mode, the next softirq expiration
+	 * must also be updated.
 	 */
-	if (!hrtimer_hres_active(base) && !tick_nohz_active)
-		return;
-
 	raw_spin_lock(&base->lock);
 	hrtimer_update_base(base);
 	if (hrtimer_hres_active(base))
@@ -2295,11 +2295,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 				     &new_base->clock_base[i]);
 	}
=20
-	/*
-	 * The migration might have changed the first expiring softirq
-	 * timer on this CPU. Update it.
-	 */
-	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
 	/* Tell the other CPU to retrigger the next event */
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
=20

