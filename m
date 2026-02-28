Return-Path: <linux-tip-commits+bounces-8288-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM7ZII8Lo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8288-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:47 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9501C4005
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C73C30138CD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E7947B437;
	Sat, 28 Feb 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqeZ4exe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q5EOG/Xi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71A222584;
	Sat, 28 Feb 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292976; cv=none; b=bEPd0STALUwHIXWXYk2wJLWsfjFavDTIynVMyhgzPPfjPeVHkDyF9/Xxw0+mcwJ/gAQJUSW0cyXLUtWGFy2Nige5S1lGajqaLFrbPYk6/CIcYhHLsoY+1pkIhlDv2X2T4zI+e+W9JeEsG83UseE4KbNJG8Mcwv8CF1xOqiDK3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292976; c=relaxed/simple;
	bh=bv6du6qzvTdqm9Q2kXl0uv0sRyvoxBCDZcVgfdPTDV0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D9291kJ62ANoO+ypFCTwYFXdJ71VdZhRihdxkMHWWPuVqNEecA9K7TYlGfeoEpDujWHgTU9ouL9hDOS4LkxHZ1ShM+Cx+p2MkpVXvSl2dn5HPg5jkXkjSRik12NcHiNQaZn+KscEefJ1w4uu/rkMMaHEktkRAIAjmn9eivHxqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqeZ4exe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q5EOG/Xi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2cepctLufnEr4TvHnhQ1gqXfeUSG1rm19MkLghH3jU=;
	b=xqeZ4exexhuSebBIHbiAK3vwor98kq3mm3mngseChLrvpyTgXGm6pUHjqcu48b+nhfDb92
	BF/cBZigMDTEVUllEva3BzWAhUC4onjgQC1N4aXysO88veqQjo2jWCPGtVow6O4QNcyn3f
	n9/ywKD8kpOSZss4sEGlwrCZG+ZlayosUs9dn+k8mligdYScwsKZiQFmBdSrDVIjlZYD66
	XWcgAWH5CogleTDBR3al7bjWJkqwwtHYS51mh1U7xgDFwNczDpQKHsZgPMrnsMguoth5xv
	Qth9ppRGfU8N/oiV5S4z5I9qX5Uvm2qqTD9SwBqSsMwPfDuzNt5c/BzZFYXm/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2cepctLufnEr4TvHnhQ1gqXfeUSG1rm19MkLghH3jU=;
	b=Q5EOG/XiW+YIiSUJXXpYlzCZgZfwLfSH73H3BfVuMG5pRBsK4n8PDBNXY5MbZUZBsNXzcn
	noFPbTL3nLsX9XBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Try to modify timers in place
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.873359816@kernel.org>
References: <20260224163431.873359816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229297284.1647592.4600642609431822331.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8288-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8B9501C4005
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     343f2f4dc5425107d509d29e26ef59c2053aeaa4
Gitweb:        https://git.kernel.org/tip/343f2f4dc5425107d509d29e26ef59c2053=
aeaa4
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:39:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:17 +01:00

hrtimer: Try to modify timers in place

When modifying the expiry of a armed timer it is first dequeued, then the
expiry value is updated and then it is queued again.

This can be avoided when the new expiry value is within the range of the
previous and the next timer as that does not change the position in the RB
tree.

The linked timerqueue allows to peak ahead to the neighbours and check
whether the new expiry time is within the range of the previous and next
timer. If so just modify the timer in place and spare the enqueue and
requeue effort, which might end up rotating the RB tree twice for nothing.

This speeds up the handling of frequently rearmed hrtimers, like the hrtick
scheduler timer significantly.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.873359816@kernel.org
---
 kernel/time/hrtimer.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5e45982..b94bd56 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1203,6 +1203,31 @@ static inline bool remove_hrtimer(struct hrtimer *time=
r, struct hrtimer_clock_ba
 	return false;
 }
=20
+/*
+ * Update in place has to retrieve the expiry times of the neighbour nodes
+ * if they exist. That is cache line neutral because the dequeue/enqueue
+ * operation is going to need the same cache lines. But there is a big win
+ * when the dequeue/enqueue can be avoided because the RB tree does not
+ * have to be rebalanced twice.
+ */
+static inline bool
+hrtimer_can_update_in_place(struct hrtimer *timer, struct hrtimer_clock_base=
 *base, ktime_t expires)
+{
+	struct timerqueue_linked_node *next =3D timerqueue_linked_next(&timer->node=
);
+	struct timerqueue_linked_node *prev =3D timerqueue_linked_prev(&timer->node=
);
+
+	/* If the new expiry goes behind the next timer, requeue is required */
+	if (next && expires > next->expires)
+		return false;
+
+	/* If this is the first timer, update in place */
+	if (!prev)
+		return true;
+
+	/* Update in place when it does not go ahead of the previous one */
+	return expires >=3D prev->expires;
+}
+
 static inline bool
 remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_bas=
e *base,
 			     const enum hrtimer_mode mode, ktime_t expires, u64 delta_ns)
@@ -1211,8 +1236,18 @@ remove_and_enqueue_same_base(struct hrtimer *timer, st=
ruct hrtimer_clock_base *b
=20
 	/* Remove it from the timer queue if active */
 	if (timer->is_queued) {
-		debug_hrtimer_deactivate(timer);
 		was_first =3D !timerqueue_linked_prev(&timer->node);
+
+		/* Try to update in place to avoid the de/enqueue dance */
+		if (hrtimer_can_update_in_place(timer, base, expires)) {
+			hrtimer_set_expires_range_ns(timer, expires, delta_ns);
+			trace_hrtimer_start(timer, mode, true);
+			if (was_first)
+				base->expires_next =3D expires;
+			return was_first;
+		}
+
+		debug_hrtimer_deactivate(timer);
 		timerqueue_linked_del(&base->active, &timer->node);
 	}
=20

