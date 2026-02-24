Return-Path: <linux-tip-commits+bounces-8244-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEMVI8hrnWnhPwQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8244-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:13:44 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1918458F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85885300A64A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62620A5F3;
	Tue, 24 Feb 2026 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="New8K6XL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Isgy5KgL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015E36B053;
	Tue, 24 Feb 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924403; cv=none; b=Z3CKdqjis/MWGCoTJU1oul2/dkgqHylAAnAnl49RPdSnWIHTsBPIkLN9QePHvqCxEa4x29HhKN9iriBwkEFwIkVjEq8CuAYElPRlquQ6RLzrwbwoUVXaRkeqeOm9T7yb6HFkpTxJfI0QleJkIvJ3F0Mop5FswbZLeWEytynu9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924403; c=relaxed/simple;
	bh=toTN8NDfjuiI5LbUSo1HlKmREu7Zd3gojBvxPfPbayM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JeWWzWvoH9FA8U2aMZhn+SAdh9cKj/qs5Az5e9QTZZv3PFOLrJ/Ny0+hJAOuPojpFHYjOOpltGiBwaqB6SifjKx9STC8SjawKadU14Pfk7kfWrh12UQWY/pA0k7cX/9p4c5GpIDPAXE8xHf1ciytg1XZut+e0HXyt1h8+BmmdqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=New8K6XL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Isgy5KgL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACJZDMsmf/esNM1Ii6rTp+MR/abxSOWaCLWdM8JePoE=;
	b=New8K6XL2g+aSh6dEQP0GVaGpODJ5xx2XlPSyOCZXFxH4dbN6tMSamSq2aWfl+cf1QzMmj
	Sabn2iorggkVwn3lnAo7LPjc9mKy0VV8iDdGJQmy+bVUgXnQTAaYOlKVeEPv7e19mdqWEb
	791voht3DZ1Ks81r93MlcAEL5uWZ4gCU+wzA2EiWeZvNyIG14HiKurmQ6TZqpeNN1eQQes
	ZyISi2MlYoYMh+CnqSBkZArQ6/2WFYj+eeY+Qr+9rSS0hyB9eLH/KcQze9CLYIkzsres1x
	5TYtFjrWlzKgKDErI6RcrjCNO2OYq/sJBVi254HcRmPoQQNrjZJaeSvuQSC5+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACJZDMsmf/esNM1Ii6rTp+MR/abxSOWaCLWdM8JePoE=;
	b=Isgy5KgLhHaWcgCy0OzQOI/oWtqqT8eYt0Tu2NF7x9h2aDCEryEvrw7HK3AqZdFg0VPrfv
	D2agjwhVpsCi3TAw==
From: "tip-bot2 for Marco Crivellari" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Replace use of system_unbound_wq with system_dfl_wq
Cc: Tejun Heo <tj@kernel.org>, Marco Crivellari <marco.crivellari@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251107092452.43399-1-marco.crivellari@suse.com>
References: <20251107092452.43399-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192439559.1647592.4928150972871704614.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8244-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email,vger.kernel.org:replyto,msgid.link:url,suse.com:email];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 98B1918458F
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c2a57380df9dd5df6fae11c6ba9f624b9cad3e6a
Gitweb:        https://git.kernel.org/tip/c2a57380df9dd5df6fae11c6ba9f624b9ca=
d3e6a
Author:        Marco Crivellari <marco.crivellari@suse.com>
AuthorDate:    Fri, 07 Nov 2025 10:24:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:11 +01:00

sched: Replace use of system_unbound_wq with system_dfl_wq

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_dfl_wq because system_unbound_wq is going away as part=
 of
a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Link: https://patch.msgid.link/20251107092452.43399-1-marco.crivellari@suse.c=
om
---
 kernel/sched/core.c | 4 ++--
 kernel/sched/ext.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b7f77c1..bfd280e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5678,7 +5678,7 @@ static void sched_tick_remote(struct work_struct *work)
 	os =3D atomic_fetch_add_unless(&twork->state, -1, TICK_SCHED_REMOTE_RUNNING=
);
 	WARN_ON_ONCE(os =3D=3D TICK_SCHED_REMOTE_OFFLINE);
 	if (os =3D=3D TICK_SCHED_REMOTE_RUNNING)
-		queue_delayed_work(system_unbound_wq, dwork, HZ);
+		queue_delayed_work(system_dfl_wq, dwork, HZ);
 }
=20
 static void sched_tick_start(int cpu)
@@ -5697,7 +5697,7 @@ static void sched_tick_start(int cpu)
 	if (os =3D=3D TICK_SCHED_REMOTE_OFFLINE) {
 		twork->cpu =3D cpu;
 		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
-		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+		queue_delayed_work(system_dfl_wq, &twork->work, HZ);
 	}
 }
=20
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 06cc0a4..a448a84 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2762,7 +2762,7 @@ static void scx_watchdog_workfn(struct work_struct *wor=
k)
=20
 		cond_resched();
 	}
-	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+	queue_delayed_work(system_dfl_wq, to_delayed_work(work),
 			   scx_watchdog_timeout / 2);
 }
=20
@@ -5059,7 +5059,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct=
 bpf_link *link)
=20
 	WRITE_ONCE(scx_watchdog_timeout, timeout);
 	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
-	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
+	queue_delayed_work(system_dfl_wq, &scx_watchdog_work,
 			   scx_watchdog_timeout / 2);
=20
 	/*

