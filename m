Return-Path: <linux-tip-commits+bounces-7418-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BDAC73B00
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1F4E2EB7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA634330D26;
	Thu, 20 Nov 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9h+/NZO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="msgZvy7y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359F3321A2;
	Thu, 20 Nov 2025 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637605; cv=none; b=eSO6J6k4i0Xm6mf5uwGSHoURLxKDYhWl3GeTGlnRBlTJ91gg4zhBXTGFvpyBZL7F/51cFYDJYiBIdQJCCHR+E6T4vM3eiGzPlpOZIhmPpL23TodnZLvHY5lC2nBPHbme9JSidZDLgQmLuAUSvbjp31gtWhpgTMczPpHRretUw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637605; c=relaxed/simple;
	bh=LA/aW0yYro5MkvLFJUSm/SrVcKvYfLDPPsShUDCn6jo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ljj5O9wTGG4z1UW3WeTVMGgZDEB3SjveGcITdbaQ/nnmkpogooISC2K/opP6jHrHh1zyT20bZXUXDDGnLtiZdniYa/nqZBDZauLyLFXOpyjLyyYiTtw97dcMKI0amPWrhGlekE7dH+X7AIoRIyCFGakSQUYuLr8DebSw4g1jrEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9h+/NZO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=msgZvy7y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qbuaxDKz4S9maHyR70LAe6Hn6IEwr5ukipUNyABaf4=;
	b=L9h+/NZOi7MYK74JqfFb3hRrJMrO1pMKarXG7tsQ03LLZNNxbd42zV9Tqi26WJVYNd6IRO
	ct+j0V6QRj/WCcrBOCLBeQu2tu9onB/uxNCmRPabVmkofF25IG9lCiVD/tb/n8STYeOhQo
	17ka6hAFAGQD/I0o3I6xjPBDx/o7yLNFdrRTcrYUjvAMlrTKubxb+mYTycU5J8g0ko9ON/
	XK2hwxWdvqx7qTrguPHkePwmKc3szvsOvpULmBXbc8FKEijAmUbY9WQQ78sxfSc/E+28QZ
	uGhe4A29DW+UXbJBnnSkkxH7jit9qWQ/ZDnI8wdZXH3z0tlQboadNV1105M9Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qbuaxDKz4S9maHyR70LAe6Hn6IEwr5ukipUNyABaf4=;
	b=msgZvy7y4eCXy3lvxb/S3nypy+zAwlZB4B8n7Up1qF84csKwu36AVDht1oLhfYHsfm89cV
	AoTIlXxAp4Vb7JCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Convert mm CID mask to a bitmap
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.642866767@linutronix.de>
References: <20251119172549.642866767@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363759926.498.308824715197104345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     472931e757fb3dfad1f78ce6f5abd821155433b2
Gitweb:        https://git.kernel.org/tip/472931e757fb3dfad1f78ce6f5abd821155=
433b2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:55 +01:00

sched/mmcid: Convert mm CID mask to a bitmap

This is truly a bitmap and just conveniently uses a cpumask because the
maximum size of the bitmap is nr_cpu_ids.

But that prevents to do searches for a zero bit in a limited range, which
is helpful to provide an efficient mechanism to consolidate the CID space
when the number of users decreases.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Link: https://patch.msgid.link/20251119172549.642866767@linutronix.de
---
 include/linux/mm_types.h |  9 +++++----
 kernel/sched/core.c      |  2 +-
 kernel/sched/sched.h     |  6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 67a7bdf..bafb81b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1342,13 +1342,13 @@ static inline cpumask_t *mm_cpus_allowed(struct mm_st=
ruct *mm)
 }
=20
 /* Accessor for struct mm_struct's cidmask. */
-static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
+static inline unsigned long *mm_cidmask(struct mm_struct *mm)
 {
 	unsigned long cid_bitmap =3D (unsigned long)mm_cpus_allowed(mm);
=20
 	/* Skip mm_cpus_allowed */
 	cid_bitmap +=3D cpumask_size();
-	return (struct cpumask *)cid_bitmap;
+	return (unsigned long *)cid_bitmap;
 }
=20
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
@@ -1363,7 +1363,7 @@ static inline void mm_init_cid(struct mm_struct *mm, st=
ruct task_struct *p)
 	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
-	cpumask_clear(mm_cidmask(mm));
+	bitmap_zero(mm_cidmask(mm), num_possible_cpus());
 }
=20
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_stru=
ct *p)
@@ -1384,7 +1384,8 @@ static inline void mm_destroy_cid(struct mm_struct *mm)
=20
 static inline unsigned int mm_cid_size(void)
 {
-	return 2 * cpumask_size();	/* mm_cpus_allowed(), mm_cidmask(). */
+	/* mm_cpus_allowed(), mm_cidmask(). */
+	return cpumask_size() + bitmap_size(num_possible_cpus());
 }
=20
 #else /* CONFIG_SCHED_MM_CID */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f6bbfa1..9a114b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10402,7 +10402,7 @@ void sched_mm_cid_exit_signals(struct task_struct *t)
 	guard(preempt)();
 	t->mm_cid.active =3D 0;
 	if (t->mm_cid.cid !=3D MM_CID_UNSET) {
-		cpumask_clear_cpu(t->mm_cid.cid, mm_cidmask(mm));
+		clear_bit(t->mm_cid.cid, mm_cidmask(mm));
 		t->mm_cid.cid =3D MM_CID_UNSET;
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a17f04f..31f2e43 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3559,7 +3559,7 @@ static inline bool __mm_cid_get(struct task_struct *t, =
unsigned int cid, unsigne
=20
 	if (cid >=3D max_cids)
 		return false;
-	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
+	if (test_and_set_bit(cid, mm_cidmask(mm)))
 		return false;
 	t->mm_cid.cid =3D t->mm_cid.last_cid =3D cid;
 	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
@@ -3582,7 +3582,7 @@ static inline bool mm_cid_get(struct task_struct *t)
 		return true;
=20
 	/* Try the first zero bit in the cidmask. */
-	return __mm_cid_get(t, cpumask_first_zero(mm_cidmask(mm)), max_cids);
+	return __mm_cid_get(t, find_first_zero_bit(mm_cidmask(mm), num_possible_cpu=
s()), max_cids);
 }
=20
 static inline void mm_cid_select(struct task_struct *t)
@@ -3603,7 +3603,7 @@ static inline void switch_mm_cid(struct task_struct *pr=
ev, struct task_struct *n
 {
 	if (prev->mm_cid.active) {
 		if (prev->mm_cid.cid !=3D MM_CID_UNSET)
-			cpumask_clear_cpu(prev->mm_cid.cid, mm_cidmask(prev->mm));
+			clear_bit(prev->mm_cid.cid, mm_cidmask(prev->mm));
 		prev->mm_cid.cid =3D MM_CID_UNSET;
 	}
=20

