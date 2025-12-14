Return-Path: <linux-tip-commits+bounces-7661-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A07CBB7AD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142DA303AEB9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1A62D7D41;
	Sun, 14 Dec 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E6x4p7BV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLqfTgnU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EA2D12F5;
	Sun, 14 Dec 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698412; cv=none; b=pl2NHqVs/W+DBw26YdpxLDjlffnRi+K7KoypzqCv/SD5TohvVG/tBEnNaE7y2HNh5E8Mwn5cXrxGdiySuTOZ8WFVtnC43u6BpTwnZ4Lt0l/meyJD8+UEskSI/w2ZsFGHaEQiQ/8NAMDebicM8iP07L6UQ01su9Ay5K6MdPJqulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698412; c=relaxed/simple;
	bh=Mrb7jVJhipseIU1S9ugTS1Sjy8B8K9/cd0dur0RBpNw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lipqe2kmqQx6/P1ZgS8rwZ+Kib9s4ZC3woBY/5H1YaIkPQs2+rehf71RlTmvx0i7O2Gks5Y4yq+GQfrigTTF2eTSdVCaggq2ZRhoBY/pzari+7+TyJBQHa8wHajKjp08y52lz60q/+6iA4AAa/plsCBiD8mfIUll6g/MGHTT0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E6x4p7BV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLqfTgnU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698409;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09oShMYQwYzhRhdmNu3jbrQisMRxhSk948KrMUFd7u8=;
	b=E6x4p7BVX2wW+TFHFUeJt3KT/L9FExA8FvAK2ZAkG1qWtgkOWMGiVqkKQcuhIdLLiqsWd/
	UFfQ5E+xIWagEmfciI7vBwhQTne88+H0FiswBhxv/liRYQyE1I7LDNwN75PjL5B6MdIy0W
	/o6Au6NaFpm5bup/WZjUAvTJQzPEt/VJZa+HI8Ll8Z2YjTl8Dm3sehk11DoipMTAz5cSYG
	RLXxfNHIWrVg/TdgHN31hs3wVU7WOX41BxEmYo8z80Zd0dxiGcUxtLMt4MqUzDw/rH2N5C
	LBX1AtabX65aLKfGtdCJGqTd6ogxwRYM6dgOoV39rmDlqH3Fl4JlbUPd6nslKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698409;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09oShMYQwYzhRhdmNu3jbrQisMRxhSk948KrMUFd7u8=;
	b=hLqfTgnU+aGBlgGPfis4a/s3EqCDZP1NZYSIuomnq2KUs3e6yYX+Sg08GL3PDUrOG8l8MC
	hdWFeiRievB4GoBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Avoid rq->lock bouncing in
 sched_balance_newidle()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251127154725.532469061@infradead.org>
References: <20251127154725.532469061@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569840793.498.18390642936583575224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     45e09225085f70b856b7b9f26a18ea767a7e1563
Gitweb:        https://git.kernel.org/tip/45e09225085f70b856b7b9f26a18ea767a7=
e1563
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 Nov 2025 16:08:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

sched/fair: Avoid rq->lock bouncing in sched_balance_newidle()

While poking at this code recently I noted we do a pointless
unlock+lock cycle in sched_balance_newidle(). We drop the rq->lock (so
we can balance) but then instantly grab the same rq->lock again in
sched_balance_update_blocked_averages().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251127154725.532469061@infradead.org
---
 kernel/sched/fair.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa033e4..708ad01 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9905,15 +9905,11 @@ static unsigned long task_h_load(struct task_struct *=
p)
 }
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
=20
-static void sched_balance_update_blocked_averages(int cpu)
+static void __sched_balance_update_blocked_averages(struct rq *rq)
 {
 	bool decayed =3D false, done =3D true;
-	struct rq *rq =3D cpu_rq(cpu);
-	struct rq_flags rf;
=20
-	rq_lock_irqsave(rq, &rf);
 	update_blocked_load_tick(rq);
-	update_rq_clock(rq);
=20
 	decayed |=3D __update_blocked_others(rq, &done);
 	decayed |=3D __update_blocked_fair(rq, &done);
@@ -9921,7 +9917,15 @@ static void sched_balance_update_blocked_averages(int =
cpu)
 	update_blocked_load_status(rq, !done);
 	if (decayed)
 		cpufreq_update_util(rq, 0);
-	rq_unlock_irqrestore(rq, &rf);
+}
+
+static void sched_balance_update_blocked_averages(int cpu)
+{
+	struct rq *rq =3D cpu_rq(cpu);
+
+	guard(rq_lock_irqsave)(rq);
+	update_rq_clock(rq);
+	__sched_balance_update_blocked_averages(rq);
 }
=20
 /********** Helpers for sched_balance_find_src_group ***********************=
*/
@@ -12868,12 +12872,17 @@ static int sched_balance_newidle(struct rq *this_rq=
, struct rq_flags *rf)
 	}
 	rcu_read_unlock();
=20
+	/*
+	 * Include sched_balance_update_blocked_averages() in the cost
+	 * calculation because it can be quite costly -- this ensures we skip
+	 * it when avg_idle gets to be very low.
+	 */
+	t0 =3D sched_clock_cpu(this_cpu);
+	__sched_balance_update_blocked_averages(this_rq);
+
 	rq_modified_clear(this_rq);
 	raw_spin_rq_unlock(this_rq);
=20
-	t0 =3D sched_clock_cpu(this_cpu);
-	sched_balance_update_blocked_averages(this_cpu);
-
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		u64 domain_cost;

