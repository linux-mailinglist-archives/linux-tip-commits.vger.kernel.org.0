Return-Path: <linux-tip-commits+bounces-8334-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAUPBwkPo2m99QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8334-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:51:37 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5921C4283
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AAAB31FF38B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736A481FCE;
	Sat, 28 Feb 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mM/FYhMl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XK7WzWtS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C10481A84;
	Sat, 28 Feb 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293031; cv=none; b=eGlj6yZdd1wxgjAifAC3YBvP+ocol713Vg4jPL8AFuYbTCYCDavxKLt19Orxe3P3SJax/CZOwQCZe//qF+EZQnIBcYR4PdD7Zr4EzVrsyj9J+7N52e4wk+Pj4N7wQ0f+H/DzgW97/1eonfF4v3PphgWVoOx7QQxZMdze3bYQj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293031; c=relaxed/simple;
	bh=UUZFne2SE/WDBlL0ySpEU9g9XCyXapx2UEHqRShqz1E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bPFaysQ3Ll4C5hMK8+vX2s6C4k0cgdpXSA5sw6GZrN9Bf5rVJMhBFfFAUHZ/x4tCU7x7S4r55eD977CrUu/kzAtOKFjAD7BWZ7TE//2fO+Iyt3PveMaxp0dhjpK7zvpk0X0QjTK9q3OpriBW2jkVmlFEZYs+DbkPxNA8tpVWOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mM/FYhMl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XK7WzWtS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:37:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2mu/79CXjuSrKJ/yS7ddGVA+Jqp5lfnTj/JWM646RY=;
	b=mM/FYhMlr+ajLq2yvjEp4Y34txFSy1vUTioT9pn8CBqPRnhb+Fs8lNubiZ+WS6M6usfOZR
	bv4u8d/sZW8U57CW313kTd73ugbJs/jgXku8Y/eYQpjKzE4+6SQb3L3/9UiMpkzMwImR0V
	Lnt1LOS/33AsfatFg7EsBnUIRFnb9vlRym4Tu6R2i9Ir6qugite1CqpiGwUSMWr1vC44HS
	gbA4IenrAhHPdif/LB2EijNsT2rWmhhPaqvXnd5b9zL7q3O9TMJu4NI9tPCPOn4GDBLuL+
	Tf18CGRDioNFMJVqpwlzGFj8T7x4SdjVkKTMYQerr9baEX2ia1t40+0MhsLbNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2mu/79CXjuSrKJ/yS7ddGVA+Jqp5lfnTj/JWM646RY=;
	b=XK7WzWtSdXTwwv3FncTJLuBTcWkSzKs6QyPNa/JxZllG/bBreEp9xuigZS6FqROSdHnObv
	jhxZrdAOHAvYhuAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched/eevdf: Fix HRTICK duration
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260224163428.798198874@kernel.org>
References: <20260224163428.798198874@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229302335.1647592.2614799712513216333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8334-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8F5921C4283
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     558c18d3fbb6c5b9c0b42629d7fe34476363ac00
Gitweb:        https://git.kernel.org/tip/558c18d3fbb6c5b9c0b42629d7fe3447636=
3ac00
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:03 +01:00

sched/eevdf: Fix HRTICK duration

The nominal duration for an EEVDF task to run is until its deadline. At
which point the deadline is moved ahead and a new task selection is done.

Try and predict the time 'lost' to higher scheduling classes. Since this is
an estimate, the timer can be both early or late. In case it is early
task_tick_fair() will take the !need_resched() path and restarts the timer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20260224163428.798198874@kernel.org
---
 kernel/sched/fair.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eea99ec..247fecd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6735,21 +6735,37 @@ static inline void sched_fair_update_stop_tick(struct=
 rq *rq, struct task_struct
 static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se =3D &p->se;
+	unsigned long scale =3D 1024;
+	unsigned long util =3D 0;
+	u64 vdelta;
+	u64 delta;
=20
 	WARN_ON_ONCE(task_rq(p) !=3D rq);
=20
-	if (rq->cfs.h_nr_queued > 1) {
-		u64 ran =3D se->sum_exec_runtime - se->prev_sum_exec_runtime;
-		u64 slice =3D se->slice;
-		s64 delta =3D slice - ran;
+	if (rq->cfs.h_nr_queued <=3D 1)
+		return;
=20
-		if (delta < 0) {
-			if (task_current_donor(rq, p))
-				resched_curr(rq);
-			return;
-		}
-		hrtick_start(rq, delta);
+	/*
+	 * Compute time until virtual deadline
+	 */
+	vdelta =3D se->deadline - se->vruntime;
+	if ((s64)vdelta < 0) {
+		if (task_current_donor(rq, p))
+			resched_curr(rq);
+		return;
 	}
+	delta =3D (se->load.weight * vdelta) / NICE_0_LOAD;
+
+	/*
+	 * Correct for instantaneous load of other classes.
+	 */
+	util +=3D cpu_util_irq(rq);
+	if (util && util < 1024) {
+		scale *=3D 1024;
+		scale /=3D (1024 - util);
+	}
+
+	hrtick_start(rq, (scale * delta) / 1024);
 }
=20
 /*
@@ -13365,11 +13381,8 @@ static void task_tick_fair(struct rq *rq, struct tas=
k_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
=20
-	if (queued) {
-		if (!need_resched())
-			hrtick_start_fair(rq, curr);
+	if (queued)
 		return;
-	}
=20
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);

