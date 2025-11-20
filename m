Return-Path: <linux-tip-commits+bounces-7415-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69739C73AF4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 856994E8A45
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E648331A45;
	Thu, 20 Nov 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJxGMt+1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5usr7WZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F32E889C;
	Thu, 20 Nov 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637602; cv=none; b=CONHQLnFiyriGsH7kfEfRwsp2cAskltI4Wwa8QhE0qLu+ZjjCPuNLcIEtRGcnQsYhH4rqZnqN5l5om+XIovZEGp9OJzgSHZvJMDGEtP4dbzOVrT12NaT4cfGYQhwx7P1ZZ2GoiCiNUlJytTo1oYPm8pyTi034ohgfrVKTZRRaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637602; c=relaxed/simple;
	bh=rAh3UzdhPSvC/Jvmz+JVNm4Iqlq9hkGVabrVGuZcuTk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K6uzG9sIEMnvEjdteVxhz/IQXLyBrcCGTHrzRmkzBKSfcyOaIOo8CseoCK5lFEK/B76KjywkE1W2A1/HawyIgxRf365y0KG38jFKP7DF6XqXKD0u5NXFLuH8YEwj/6lTSY0IYW0GK4Pp+Ye8s4i7TjEVdSKsC4AhTb2glayGO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJxGMt+1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5usr7WZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyLpwpWneOslr8q73emNIVS05JnVhzzxvTpOCA76m+A=;
	b=HJxGMt+1Z7YWfdv9ox0h9O9v8ZR3YWqFR/XbavK7vvFb0Ox+KqTC67nSFTJlJDQt00cifK
	EJVrTOfb0KVQyrHX8zeh4fMbGYx7z0rFxBrmDxszC/gyve2lrkbxsuOPZfwvKFMSLsiPoA
	Wg6B+0odNT8yim55YWs54Uxy8IuSxToE0sTTr7EaVeSNgMYqBfAQbuDGvE76vAP2RhWaKE
	Yi/GoflIPXek3Crayzz28Ug+GPqqeMcwqdzaNTU6GQIx7sILydunNvEYYsW7EBh65lKk/C
	bcHk8mSWp03z9Xzs8dIkuN6y30tZmqPTtXgcJTWSu6vuQgBVte2oIwuL3jNlug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyLpwpWneOslr8q73emNIVS05JnVhzzxvTpOCA76m+A=;
	b=T5usr7WZPfvfBgzXyTcje/8LQn1RzuAXoVzv7aIHg2LGdulj9HX851uAw2E/E8otpplvNt
	jNzezc1C5CRrmDDw==
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
Message-ID: <176363759729.498.9774136526940129983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     61c7810a91fb15cffaa0b44810b8074c5e8a125d
Gitweb:        https://git.kernel.org/tip/61c7810a91fb15cffaa0b44810b8074c5e8=
a125d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:55 +01:00

sched/mmcid: Move initialization out of line

It's getting bigger soon, so just move it out of line to the rest of the
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

