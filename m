Return-Path: <linux-tip-commits+bounces-7537-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F68C88129
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 05:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89BD84E870C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 04:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE7D313542;
	Wed, 26 Nov 2025 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g23NH89h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fYa5kEsx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76775312828;
	Wed, 26 Nov 2025 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131780; cv=none; b=QI5Dx0IV+KYtoR0uSqszBOSb5shFjVsQc8hUtlXO2+lr/6G6m5fvVeEn5cWzfx664+KbIn4Cz61+14JFA7et62gPwABJ2ExnEhxpCgnJEqzAev4Urb6cPI7RfYOhHfwtN9mTSHfNI71edcQzvLO5aVB9ca3r4uLF/nanI7KtJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131780; c=relaxed/simple;
	bh=A9V+OV1DKZWXsmdMtqyNGnzehmSsTFs3Nmig84cTj80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B2a/YF1odiBv+P1B4r4gXaQFV73B+rmfO9s1Q3NJqtUqNgWiP3fQG6GxHmqJaxEd2VKEWN7Dk8OHbd9lE8vYFIRim+tyb9ZOjnPed+wb7G8yTIHc677yVUmiIaDoY38yVGGQ2eDW0D0zLdeGDLC/9Wutm0gfAsxoQIrAsTTqEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g23NH89h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fYa5kEsx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 04:36:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764131776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmG3+lOxAAGroMgb9c4eXJT0WP/LFHUFe8xU6wXihYs=;
	b=g23NH89hphN0PyVOlXgwALAemeWHnKVdjukBlmvMtup1BXCQfbPaMGC3V+XWcoDrLzgBUl
	rzV+4zC/zQRCeZEd50SDGM78CrnPHeBRtxpV3buThI0P/2yRdwRQUy4DBgLoYeB4YrOUyR
	zZ+U6sev4Av+C6Oxp0V16kfvzFVzLafzYHyDUXblHbwhJOVcwCU2s4MLJEoL7OGf9OmerL
	MyX/5HmvXPA5qKy1ymEX3BGlXs72fCvbXev3siYzUe+eyuYSyqdnY9uWo8Wb7f6kEhNkOX
	GT/kKzLvx4pK6PXleHLsrc0hN9O35yUThAzHfvqXfg2P9ZomOIjpy4k4ymbavQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764131776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmG3+lOxAAGroMgb9c4eXJT0WP/LFHUFe8xU6wXihYs=;
	b=fYa5kEsxnj5wM6Mxbecd5V1jjM3E5YFwPHYXjp+/nol7IaLKwe4xKF5cQ0+n3XzsJBLvaB
	IlRh07lZ2JIpoLAQ==
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
Message-ID: <176413177548.498.8526175350484131287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     539115f08cf850b9fdc6526b31da0839ff6c1631
Gitweb:        https://git.kernel.org/tip/539115f08cf850b9fdc6526b31da0839ff6=
c1631
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Nov 2025 19:45:40 +01:00

sched/mmcid: Convert mm CID mask to a bitmap

This is truly a bitmap and just conveniently uses a cpumask because the
maximum size of the bitmap is nr_cpu_ids.

But that prevents to do searches for a zero bit in a limited range, which
is helpful to provide an efficient mechanism to consolidate the CID space
when the number of users decreases.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

