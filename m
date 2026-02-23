Return-Path: <linux-tip-commits+bounces-8227-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EHpHZ4rnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8227-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:27:42 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55C174DC9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A2653030520
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272D362120;
	Mon, 23 Feb 2026 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIN6AfTD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m2jdAHwD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F2361DBA;
	Mon, 23 Feb 2026 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842328; cv=none; b=PQdBUYhCx7OoxARpx6bZvPXU8iHxfX2zObQhw/mosCZJs2n9vXdAobAT6AbiOVCbccCdTpNZP3fKsX6tmGFOyjJhvZzhcCbZR6N9DDaWU4mWklrCGqw/YNf5IwGJ6kReeE1RTETpuG30LF3gp0NkQ9bEMvsTWaAWFEL1FH878Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842328; c=relaxed/simple;
	bh=YQZWnOqgJFFAxbKGwKVHGUdpw22tZqQQtlDHoQHwTtw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mAzi+CqMfD2FU2zjFi62JrfyYJTH2S/NpCEdsavcYwBV0I1aeTdaVB2DWTiDGvKZ+AWMOkgm9hdGsVius3rueV/f/gszPkahDKFrTy5ThQ9fXfPQRba2RPgIfm0tWEnhap8OGzuQf5x7/261ABGgWiOLzKnztE54BfTCiPt4+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIN6AfTD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m2jdAHwD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JaJHZvhKCql9+OxnUa1SXmQE0JmjF8Cesjl9asflD+A=;
	b=aIN6AfTDORzBqeRkZv8m1zpNz25NXKCYKf2tMf+Hur/UHeExjDB6kbyKLLYsrpGIyDrQ43
	hXqqOAUNf6fRyTMiUcaNBqSAYKqIY4h5lpIpOfRG0pfnl2s5jQlKvRlD7/fUorliy0MPpe
	oombHQ8Sgo4D/TFpymouPz9VQpwFMsVhjCXKrwnub90DGNzhyVIJN7+71Hua5Jt1DoTQr4
	0WMIZvg7y/Tnv0w4W5q9Snk80wxL9OXDmXAEwKi3cF6T7Bs2o5RESDZ2df9khUpjo76pXW
	xynaJ8Ecenh+BrbVpV4eVxNaTC7bJ4J8cAjw4WliIKuEHkfNUy9+jCwnjdzBXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JaJHZvhKCql9+OxnUa1SXmQE0JmjF8Cesjl9asflD+A=;
	b=m2jdAHwD1Jec/WpUUxi6JHgHR+at2oKjsjZdqFI/jeR4kmLaZMtYcyquLQ4Q3WrzR+jj6O
	cHm98Ohk5dvNCXBQ==
From: "tip-bot2 for Wang Tao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/eevdf: Update se->vprot in reweight_entity()
Cc: Zhang Qiao <zhangqiao22@huawei.com>, Wang Tao <wangtao554@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260120123113.3518950-1-wangtao554@huawei.com>
References: <20260120123113.3518950-1-wangtao554@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184232257.1647592.11476735322518429138.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8227-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,infradead.org:email,vger.kernel.org:replyto,linutronix.de:dkim,linaro.org:email,amperecomputing.com:email]
X-Rspamd-Queue-Id: CD55C174DC9
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ff38424030f98976150e42ca35f4b00e6ab8fa23
Gitweb:        https://git.kernel.org/tip/ff38424030f98976150e42ca35f4b00e6ab=
8fa23
Author:        Wang Tao <wangtao554@huawei.com>
AuthorDate:    Tue, 20 Jan 2026 12:31:13=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:18 +01:00

sched/eevdf: Update se->vprot in reweight_entity()

In the EEVDF framework with Run-to-Parity protection, `se->vprot` is an
independent variable defining the virtual protection timestamp.

When `reweight_entity()` is called (e.g., via nice/renice), it performs
the following actions to preserve Lag consistency:
 1. Scales `se->vlag` based on the new weight.
 2. Calls `place_entity()`, which recalculates `se->vruntime` based on
    the new weight and scaled lag.

However, the current implementation fails to update `se->vprot`, leading
to mismatches between the task's actual runtime and its expected duration.

Fixes: 63304558ba5d ("sched/eevdf: Curb wakeup-preemption")
Suggested-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Wang Tao <wangtao554@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260120123113.3518950-1-wangtao554@huawei.com
---
 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f2b46c3..93fa5b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3815,6 +3815,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se,
 			    unsigned long weight)
 {
 	bool curr =3D cfs_rq->curr =3D=3D se;
+	bool rel_vprot =3D false;
+	u64 vprot;
=20
 	if (se->on_rq) {
 		/* commit outstanding execution time */
@@ -3822,6 +3824,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, str=
uct sched_entity *se,
 		update_entity_lag(cfs_rq, se);
 		se->deadline -=3D se->vruntime;
 		se->rel_deadline =3D 1;
+		if (curr && protect_slice(se)) {
+			vprot =3D se->vprot - se->vruntime;
+			rel_vprot =3D true;
+		}
+
 		cfs_rq->nr_queued--;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
@@ -3837,6 +3844,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se,
 	if (se->rel_deadline)
 		se->deadline =3D div_s64(se->deadline * se->load.weight, weight);
=20
+	if (rel_vprot)
+		vprot =3D div_s64(vprot * se->load.weight, weight);
+
 	update_load_set(&se->load, weight);
=20
 	do {
@@ -3848,6 +3858,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		place_entity(cfs_rq, se, 0);
+		if (rel_vprot)
+			se->vprot =3D se->vruntime + vprot;
 		update_load_add(&cfs_rq->load, se->load.weight);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);

