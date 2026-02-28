Return-Path: <linux-tip-commits+bounces-8332-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MEhNhYRo2kf9gQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8332-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 17:00:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CCA1C4326
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 17:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCD7B30DAD32
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A2481ABF;
	Sat, 28 Feb 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1lzHdVM0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vEGAqDGF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B3481252;
	Sat, 28 Feb 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293029; cv=none; b=mmoLTk19oEI5VeFvWFYUlbTstbcj26Df/ZEhDKOhrU+681nzbG2aOyzq4J7J0LZ8YtUHARV3dWFw/7xbGsM/Bt/BwYj0/ZRQsmvzkHMe1wCAA1k5mmzap+L+Six+UiIxmu46mHoXQW1HTbCHo/YGIAiRZUfm4d30Wm9QnKMID28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293029; c=relaxed/simple;
	bh=zls7RdYOLeL2asUk1KXw/BMe5qRDdSDWPWWEwWHSHIk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XutcyaeRi/09gsjYf20qthLiWj2uCeIwRQ+iZw30u7ZSmq9hrnnoSUJo6J+WV2YZolJTdC/zhrpewDTz0mkoTMdSGPdbtcavL5LpTWOXRvVec664Kzwdjtk2M5YI9UZMBgIT3L7doAb9grYB0KSfadtJo57Cu538Rp67YcycyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1lzHdVM0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vEGAqDGF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:37:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb89KAHbcVceWUZFY/+J3Jj4XpTrOZLu8cYxhARHNb0=;
	b=1lzHdVM0W47QoJ3+TIHdN0fLBaR7WoPcL7IE8Oxic7IlP0oDJAWgHq/EkSrsNeCQtZtEUs
	QdqLi88KKD7p8eqEBPQ/qa5aM3+VaJO+C2h7J2ssJzqMIbeIE/15GXADq96el1Q1HDt35t
	UJGAHRIrtBZD6qo/lMW+vkZfWd1EMHsh6jT3j2GpQ+kHwY+v2UUjCLBfxyEL2rEFcFuJPH
	zorOrUoNbYmms0jvRz5f35cBWyIEFThFLgnP2Oh46MkKrnTyP453MEB0wRDmwBsz9BFh0J
	9QVM9HAAcI6GmOBiDQJdonUVdpjeWngNg937CEtrIl4L0vzuEhKuTDlSvxFQcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb89KAHbcVceWUZFY/+J3Jj4XpTrOZLu8cYxhARHNb0=;
	b=vEGAqDGFsInoiycysnB2N9UbCRzEgc5/B9IU8KbQA5xtspS8lVDHcZIXmP3nvhTER3qpto
	R2aSTfJYcJSBc4Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched: Avoid ktime_get() indirection
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.001511662@kernel.org>
References: <20260224163429.001511662@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229302015.1647592.15855095407485608814.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8332-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 06CCA1C4326
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     d70c1080a957a5144e6c40e95bcbe04ab542fe05
Gitweb:        https://git.kernel.org/tip/d70c1080a957a5144e6c40e95bcbe04ab54=
2fe05
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:04 +01:00

sched: Avoid ktime_get() indirection

The clock of the hrtick and deadline timers is known to be CLOCK_MONOTONIC.
No point in looking it up via hrtimer_cb_get_time().

Just use ktime_get() directly.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.001511662@kernel.org
---
 kernel/sched/core.c     | 3 +--
 kernel/sched/deadline.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7597776..a716cc6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -925,7 +925,6 @@ static void __hrtick_start(void *arg)
  */
 void hrtick_start(struct rq *rq, u64 delay)
 {
-	struct hrtimer *timer =3D &rq->hrtick_timer;
 	s64 delta;
=20
 	/*
@@ -933,7 +932,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 * doesn't make sense and can cause timer DoS.
 	 */
 	delta =3D max_t(s64, delay, 10000LL);
-	rq->hrtick_time =3D ktime_add_ns(hrtimer_cb_get_time(timer), delta);
+	rq->hrtick_time =3D ktime_add_ns(ktime_get(), delta);
=20
 	if (rq =3D=3D this_rq())
 		__hrtick_restart(rq);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d08b004..9d619a4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1097,7 +1097,7 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
 		act =3D ns_to_ktime(dl_next_period(dl_se));
 	}
=20
-	now =3D hrtimer_cb_get_time(timer);
+	now =3D ktime_get();
 	delta =3D ktime_to_ns(now) - rq_clock(rq);
 	act =3D ktime_add_ns(act, delta);
=20

