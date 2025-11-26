Return-Path: <linux-tip-commits+bounces-7534-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 387DEC8811D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 05:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 099FA355880
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 04:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14563126BC;
	Wed, 26 Nov 2025 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQyJ1evi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2Ggpaxk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6031195F;
	Wed, 26 Nov 2025 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131777; cv=none; b=u8Re8X5kKXn/JZTDC7zU5gF9Lhk20WrlFSn9avk9MSHYSf0n4ivsDSd0AWZ9j3tTVquiENmDzgfohdqW66okzOyyVznSLYihx15k79VWeszcoVzQy55ypB/LdeMIrZf0Od6gnI1I/mTgiAjSzqk1uemJxRmq0CUIfneume9doJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131777; c=relaxed/simple;
	bh=bIN/9yfxO76rT4b3ROxSV/0f3m0kK7Whq5KOi+dirzI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eDNlLkMSY8a/nwMTTZoKCyenMvfmpVkt6P44XlsoW2EDoa4zeoIO1h3ZS63Vl0URw4LVZvt1BJAMOTxvu0urunzh7hq6tO4+GIcC7+lDe/MiiQOojkpLgtgUdzEtE0yoPBX8xTA36CrOjsxzmmbwvbAJx7h5PDD3R+s2wXkuVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQyJ1evi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2Ggpaxk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 04:36:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764131774;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVIwPTIrocc4ohdUdBfXfKEmCu1xsyeFT6fp9JMY7No=;
	b=bQyJ1eviBgE63Q4gsGTng01CZEOtnIeqHS4DErfjtiq6DRCvUrCEHBngSEkank05HFG+hQ
	0euYjo9HaEr/vkpkiXWuEGULpSzdnxF16JDC5/9VX+izOZXzfVhsyo8ANcRHWmswKdh3i0
	iLatGiZ8/hv1v+A+uPLgqSdnpnK3gop/EAJDPMC49icc7FCTZGgKSjeHqQNmS5NwhfE2l8
	uYdJeNS6YjqW0YkJlIbjpDYRD5/6y1u4hWL1PdMZhU3OMTBtV9m8BevDxyiDdfXiWu1nbv
	CS/D7dYBQ2m4DXIrLd2TLgn8tW89fy2GmGOOvni0WqQgAgQqamwacqLvwdVIZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764131774;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVIwPTIrocc4ohdUdBfXfKEmCu1xsyeFT6fp9JMY7No=;
	b=s2GgpaxkJ+yaJxuPpU9vmqEXwhVZ3irw+aD6f1o3dJV3BAvW2ggvNscxk92NmzHXtE2lR/
	HsLBLaWpa8b4K8DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Move initialization out of line
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.769636491@linutronix.de>
References: <20251119172549.769636491@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176413177329.498.14476981011674582209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     bf070520e398679cd582b3c3e44107bf22c143ba
Gitweb:        https://git.kernel.org/tip/bf070520e398679cd582b3c3e44107bf22c=
143ba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Nov 2025 19:45:40 +01:00

sched/mmcid: Move initialization out of line

It's getting bigger soon, so just move it out of line to the rest of the
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.769636491@linutronix.de
---
 include/linux/mm_types.h | 15 +--------------
 kernel/sched/core.c      | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bafb81b..3b7d05e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1351,20 +1351,7 @@ static inline unsigned long *mm_cidmask(struct mm_stru=
ct *mm)
 	return (unsigned long *)cid_bitmap;
 }
=20
-static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
-{
-	int i;
-
-	for_each_possible_cpu(i) {
-		struct mm_cid_pcpu *pcpu =3D per_cpu_ptr(mm->mm_cid.pcpu, i);
-
-		pcpu->cid =3D MM_CID_UNSET;
-	}
-	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
-	raw_spin_lock_init(&mm->mm_cid.lock);
-	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
-	bitmap_zero(mm_cidmask(mm), num_possible_cpus());
-}
+void mm_init_cid(struct mm_struct *mm, struct task_struct *p);
=20
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_stru=
ct *p)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3fdf90a..34b6c31 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10431,6 +10431,20 @@ void sched_mm_cid_fork(struct task_struct *t)
 	WARN_ON_ONCE(!t->mm || t->mm_cid.cid !=3D MM_CID_UNSET);
 	t->mm_cid.active =3D 1;
 }
+
+void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
+{
+	struct mm_cid_pcpu __percpu *pcpu =3D mm->mm_cid.pcpu;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(pcpu, cpu)->cid =3D MM_CID_UNSET;
+
+	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
+	raw_spin_lock_init(&mm->mm_cid.lock);
+	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
+	bitmap_zero(mm_cidmask(mm), num_possible_cpus());
+}
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct=
 cpumask *affmsk) { }
 #endif /* !CONFIG_SCHED_MM_CID */

