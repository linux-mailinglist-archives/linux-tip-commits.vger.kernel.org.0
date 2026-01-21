Return-Path: <linux-tip-commits+bounces-8088-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEVUAX0OcWlEcgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8088-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 18:35:57 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2FF5A9F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 18:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7811C62FB24
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD973AEF44;
	Wed, 21 Jan 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3rG/w9re";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dttibsN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142933A010;
	Wed, 21 Jan 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014280; cv=none; b=ixG1sRbKCNYSdN/XHWozDh7Sn/ojKYLBkyPYzt1+Wh/8XDpmbZ57nSM5hwvZaDNSTde5dQqfjT6KZ+vG7CrtQcwWHx/25g42z1CQ0RXTposDwEZnhnySWs/2bL0G0nGO9BztlTOCbjdCGSnu01qyggHFWdQR5236C6T2A3NYvFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014280; c=relaxed/simple;
	bh=P0AtXjIoXynm2jcf+R9g9RE30v3GNM7AMrhWwoOPQDc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ScaUkkH28z/VudHBro45LdXCv26dItWirp0/6mtYo+VxOWJryxJS2gYYc0ur4Y4vgPPpl84FabBAimSPEAAJyHvfk+U0jh1dyAvkToFKtUZMZADg/fbMR3S44ChZGAr1JCWFuoXcZblFcmw51HMJ34ae04zema99GDvBPpRB4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3rG/w9re; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dttibsN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Jan 2026 16:51:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769014276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnsmtyC7pTLEKim1YREEvXMRR7kxKH0s8i/TLB0acsM=;
	b=3rG/w9rerqZ3cYEcmh9TZ41h1L/EkpQOAzCyEzUTvGWNziJAXtwAIzYaGcmKWpc3HsRh4V
	UEhrvTvXmcpVdq4phW1sNc2M7qWL/JQuz5ofA4iT9U7bpz0swxWsswjP/dMKBy40esItnW
	DjOkslfkAXzsdi7CKDpMb3AW2IBsgJ7W0maw9w0Cm+C3BIIvpHKGw+weV4LOd8Hm7zFGPy
	/vH8btvLBGotx2zU3BzigRN9d8zwG4Dzp+KnyRujfmTOlYP6INM3QHvo2SRNpphZGeGIUw
	BjRps54c3KNfeGgJ+SDYXjITyt8A0zz6pa2KCUeUrT1t4nkw6qwdI3y7Dc+TzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769014276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnsmtyC7pTLEKim1YREEvXMRR7kxKH0s8i/TLB0acsM=;
	b=9dttibsNK0uB3VKOvLkkYGMS79gdrAuPyzkxFM96bYXeyQnix1/VpSYh4lPLeG1OEcbV9G
	u/eDo11J2F55xsCQ==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/fair: Fix pelt clock sync when entering idle
Cc: Samuel Wu <wusamuel@google.com>, Alex Hoh <Alex.Hoh@mediatek.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121163317.505635-1-vincent.guittot@linaro.org>
References: <20260121163317.505635-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176901427445.510.16153450380853197689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-8088-lists,linux-tip-commits=lfdr.de];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linaro.org:email,vger.kernel.org:replyto,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linutronix.de:dkim]
X-Rspamd-Queue-Id: 9F2FF5A9F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     98c88dc8a1ace642d9021b103b28cba7b51e3abc
Gitweb:        https://git.kernel.org/tip/98c88dc8a1ace642d9021b103b28cba7b51=
e3abc
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 21 Jan 2026 17:33:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Jan 2026 17:46:08 +01:00

sched/fair: Fix pelt clock sync when entering idle

Samuel and Alex reported regressions of the util_avg of RT rq with
commit 17e3e88ed0b6 ("sched/fair: Fix pelt lost idle time detection").
It happens that fair is updating and syncing the pelt clock with task one
when pick_next_task_fair() fails to pick a task but before the prev
scheduling class got a chance to update its pelt signals.

Move update_idle_rq_clock_pelt() in set_next_task_idle() which is called
after prev class has been called.

Fixes: 17e3e88ed0b6 ("sched/fair: Fix pelt lost idle time detection")
Closes: https://lore.kernel.org/all/CAG2KctpO6VKS6GN4QWDji0t92_gNBJ7HjjXrE+6H=
+RwRXt=3DiLg@mail.gmail.com/
Closes: https://lore.kernel.org/all/8cf19bf0e0054dcfed70e9935029201694f1bb5a.=
camel@mediatek.com/
Reported-by: Samuel Wu <wusamuel@google.com>
Reported-by: Alex Hoh <Alex.Hoh@mediatek.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Samuel Wu <wusamuel@google.com>
Tested-by: Alex Hoh <Alex.Hoh@mediatek.com>
Link: https://patch.msgid.link/20260121163317.505635-1-vincent.guittot@linaro=
.org
---
 kernel/sched/fair.c | 6 ------
 kernel/sched/idle.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e713022..a148c61 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8995,12 +8995,6 @@ idle:
 			goto again;
 	}
=20
-	/*
-	 * rq is about to be idle, check if we need to update the
-	 * lost_idle_time of clock_pelt
-	 */
-	update_idle_rq_clock_pelt(rq);
-
 	return NULL;
 }
=20
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c174afe..abf8f15 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -468,6 +468,12 @@ static void set_next_task_idle(struct rq *rq, struct tas=
k_struct *next, bool fir
 	scx_update_idle(rq, true, true);
 	schedstat_inc(rq->sched_goidle);
 	next->se.exec_start =3D rq_clock_task(rq);
+
+	/*
+	 * rq is about to be idle, check if we need to update the
+	 * lost_idle_time of clock_pelt
+	 */
+	update_idle_rq_clock_pelt(rq);
 }
=20
 struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)

