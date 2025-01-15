Return-Path: <linux-tip-commits+bounces-3218-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5EDA11D38
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501433A7A44
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13A22E407;
	Wed, 15 Jan 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NNAch1AC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7g/HRNOT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B91E7C03;
	Wed, 15 Jan 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932637; cv=none; b=kFZc1n/+HSoo4FgrO3XEyrXYF4/vUUdTqAsz9XcBpDuyeyiaQXND+Wym4ubvOv/aFbl1isJZGt8/Yed3Jw1plRPzxB2M5oIw+P7nvqIRTwCAts3Xw6uuvzZDnYZLph/qPUhdcoVVsBAPKgbt2aJ91fOzkRXUuVThUQ1iQ2jdksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932637; c=relaxed/simple;
	bh=isd1ycc+JfzCSb5d8KGahUb6UnwhMnAP3QmX9lja87M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WZGKtFc8R0h5M41nDWjE1m0DUe4HGZeQFD3+AtmAT3+psuaFKeY6gY1u6EhClAnxxC36fahZ7T6AdQD5VJuvq7ZHgle1ZJaY0YgBN88D/lrRhWYz31Uh9NTdMjTOAKvk0DIal2tA37KwZ8dQHdgbWzwQWuMl4vXDlE7Zy7qpJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NNAch1AC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7g/HRNOT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeLMDyRswGz8Bw0fErLXWnvvcwpUh7Yci9usntkP/JY=;
	b=NNAch1ACer6sDZO3VWlqPuBoJHRyMpzKB3QXznTXEcRBirpqVKwEOaxTonN7RcFkUj+Htf
	V6rm8gOgX8066odexolIQYXoH7xj/cI4yz7BV4G1TF8NXDninNufW5EJhyM/UiO/O2a12k
	r65Uqr+Qv3DppYMkiVm5B/IK72djulbbWZJbiDr3wn8oe7r0gKY6C0aU0ShFA06XzoBOMv
	TEggMvqUOGZYe3er3h23DSRTaxAclZ4HH5zl6iMh9ww3Kzp1HpP121z+C+xXjW8wD13dIH
	xHA1d1kiwu55n76RTzZpnA6+21T2bqJ8OpjdhihASQ+5VX0ZpPPmvX2KevKEiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeLMDyRswGz8Bw0fErLXWnvvcwpUh7Yci9usntkP/JY=;
	b=7g/HRNOTxAL9fH5N1kkgdp6gXmd19nhI/mEAiTdmccON7Z6cLVjaN5qet8LVdBzNAhhR/+
	ARlyQE1xsBGzfkCA==
From: "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Cc: Yafang Shao <laoar.shao@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, mkoutny@suse.com,
 Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250103022409.2544-4-laoar.shao@gmail.com>
References: <20250103022409.2544-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263378.31546.928096545861627460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a6fd16148fdd7e9da143037106956a3447c247a8
Gitweb:        https://git.kernel.org/tip/a6fd16148fdd7e9da143037106956a3447c=
247a8
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Fri, 03 Jan 2025 10:24:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:26 +01:00

sched, psi: Don't account irq time if sched_clock_irqtime is disabled

sched_clock_irqtime may be disabled due to the clock source. When disabled,
irq_time_read() won't change over time, so there is nothing to account. We
can save iterating the whole hierarchy on every tick and context switch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20250103022409.2544-4-laoar.shao@gmail.com
---
 kernel/sched/psi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84dad15..bb56805 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -998,7 +998,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struc=
t *curr, struct task_st
 	s64 delta;
 	u64 irq;
=20
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
 		return;
=20
 	if (!curr->pid)
@@ -1240,6 +1240,11 @@ int psi_show(struct seq_file *m, struct psi_group *gro=
up, enum psi_res res)
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
=20
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	if (!irqtime_enabled() && res =3D=3D PSI_IRQ)
+		return -EOPNOTSUPP;
+#endif
+
 	/* Update averages before reporting them */
 	mutex_lock(&group->avgs_lock);
 	now =3D sched_clock();

