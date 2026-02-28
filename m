Return-Path: <linux-tip-commits+bounces-8333-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BBYB9UPo2nk9QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8333-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:55:01 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130B1C42BA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5146531F75DE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E651481FA8;
	Sat, 28 Feb 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qleB2iW4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="872wApiU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C91480966;
	Sat, 28 Feb 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293029; cv=none; b=ETYEfJir9ctkZOo7WEXOcKsUfE3Up0Z2cHGMHmXxN1ci1mQNOKoZp0mKLrVJZSPFQslkq0FFvS+bliPaMiUkoQYgumcJCera21h3UKX4pjsoBMcK367ySqFbHi6AWL1+Mm2qZA79yX8mPfyC4m+MUd9+q1j9MJIXu5j97j9BClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293029; c=relaxed/simple;
	bh=7PFKSer5Pd1NPy/HhwTAUDjXZTvPAczH4dvt52hzJoo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cmYdeOYeSrTg/F9+lfYCohz/Gqf9ar/0HV7iALh7MJpJ63onPj9GZlCCcCUJ43XQLFpzfJj83YqDqAf3TSQX5tJDV2/b49VNGDmWz27OHzGkAlSF/Y0MoL1oAz4b2myVVo2x/XCuqKn5tO5qNJF2Pecj63aAVfTZu3VqWi17MEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qleB2iW4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=872wApiU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:37:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQZq+f6Qd3t8YQcvPrmjaoxZatuaZe+tskyEHuNefwI=;
	b=qleB2iW4mGr0BnmqkJreJJPWS6PwUogWOzQkrE5aZTnCfNTcRoqiJ7gRZgtzYRAOv9dRNl
	ohl1kkJ1Y6c6Sez/lg61/QNjjKpkALvQqICPr0kqZv/aKa8Zeb+9AHECKvdz86keWl7VEh
	eQ8aAAQ/N2JiTxKkprb/qe6i1Mtx1YM+ZJWAAM/DK4XHtMMRN6yYoCHE47EukxQ31yjPeY
	EFSpmIJL5NaQdYWvwKrwqzfe0LCBkbgGZp/i9DVjoTysb+tXYEwgTkTjPAoPyX84zY4zSc
	ctEoQNre9dM2dtmPSfCj/tgTKHpd2bSALJnjaUDWdxvw6nY33Any0CEUJv5E4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQZq+f6Qd3t8YQcvPrmjaoxZatuaZe+tskyEHuNefwI=;
	b=872wApiUeTQuNgJPeTXIpdcTMmV9Oqfeog+t1zcRWZpwRyftVftfoBLR9mP3UrGuCYNDb8
	CiAqTT1ud9+ZrMAA==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched/fair: Simplify hrtick_update()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163428.866374835@kernel.org>
References: <20260224163428.866374835@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229302230.1647592.15395233051763563169.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8333-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 7130B1C42BA
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     97015376642f3cb7aa5c3cdb13bf094e94fbcd81
Gitweb:        https://git.kernel.org/tip/97015376642f3cb7aa5c3cdb13bf094e94f=
bcd81
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:03 +01:00

sched/fair: Simplify hrtick_update()

hrtick_update() was needed when the slice depended on nr_running, all that
code is gone. All that remains is starting the hrtick when nr_running
becomes more than 1.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163428.866374835@kernel.org
---
 kernel/sched/fair.c  | 12 ++++--------
 kernel/sched/sched.h |  4 ++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 247fecd..0b6ce88 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6769,9 +6769,7 @@ static void hrtick_start_fair(struct rq *rq, struct tas=
k_struct *p)
 }
=20
 /*
- * called from enqueue/dequeue and updates the hrtick when the
- * current task is from our class and nr_running is low enough
- * to matter.
+ * Called on enqueue to start the hrtick when h_nr_queued becomes more than =
1.
  */
 static void hrtick_update(struct rq *rq)
 {
@@ -6780,6 +6778,9 @@ static void hrtick_update(struct rq *rq)
 	if (!hrtick_enabled_fair(rq) || donor->sched_class !=3D &fair_sched_class)
 		return;
=20
+	if (hrtick_active(rq))
+		return;
+
 	hrtick_start_fair(rq, donor);
 }
 #else /* !CONFIG_SCHED_HRTICK: */
@@ -7102,9 +7103,6 @@ static int dequeue_entities(struct rq *rq, struct sched=
_entity *se, int flags)
 		WARN_ON_ONCE(!task_sleep);
 		WARN_ON_ONCE(p->on_rq !=3D 1);
=20
-		/* Fix-up what dequeue_task_fair() skipped */
-		hrtick_update(rq);
-
 		/*
 		 * Fix-up what block_task() skipped.
 		 *
@@ -7138,8 +7136,6 @@ static bool dequeue_task_fair(struct rq *rq, struct tas=
k_struct *p, int flags)
 	/*
 	 * Must not reference @p after dequeue_entities(DEQUEUE_DELAYED).
 	 */
-
-	hrtick_update(rq);
 	return true;
 }
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b82fb70..73bc20c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3041,6 +3041,10 @@ static inline int hrtick_enabled_dl(struct rq *rq)
 }
=20
 extern void hrtick_start(struct rq *rq, u64 delay);
+static inline bool hrtick_active(struct rq *rq)
+{
+	return hrtimer_active(&rq->hrtick_timer);
+}
=20
 #else /* !CONFIG_SCHED_HRTICK: */
=20

