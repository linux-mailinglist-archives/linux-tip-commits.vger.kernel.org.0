Return-Path: <linux-tip-commits+bounces-8324-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPueAJINo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8324-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:45:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA91C4168
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99549316011C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922948124E;
	Sat, 28 Feb 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WtOkv67p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UtWXFpXb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859A480968;
	Sat, 28 Feb 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293022; cv=none; b=EXxqyBLyhS2/KF7g6ghj7u2cziZwXxAKm3wRZTGPQPLF+iX/e322ymzVFSpbnJac1SGvc9awvup5518HOWzs/WxlPM/kzNGhGZQ4/DCJQ/u9y3rLXp9vU1GUNyTg6EI+feZhI+FxX43kTqH9j1lJVk1UQMneIIYoDEnEzG586Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293022; c=relaxed/simple;
	bh=EUF88A5fLJE3qLYDUmhrQoX/eXvCtW2zJh4fhoy83Hk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RvFMPNOBjFza1eUf4bfuGs3sdIlBiGH6cjJtlWcveBlspQAenEg+IPjvU2wNHsRdcA8lUq6fcbluF4+4t/yDFUpcexovr43oG86yWroZwjE/Pl9jg4I6oF1HBYlHhCb35rWjC01v8/yBZePvP+Ilc8sH2VK5/fa10LRKYZMFgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WtOkv67p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UtWXFpXb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT3AQGHShlyKtPFP8oiVAfnOpI9CiiMjUwbxEcyJ5iw=;
	b=WtOkv67p95Ev2KZQI4iYGBDqOARLCyX5zto7BsIhUvLrrBeJ4dJevL9wuqcIXpmv/NWaTH
	pVh607/vIE1gB8L0oEsq4uMJIMMBcpulF6sXjbZZtxdIhiLP4kkShbm+ShiXllWVggtWOX
	dRULdp6DC21eQ3Sa3iYLcbc5RX1GmRGMqy95l8XiFyl/BgyitWA+2tz546BzP7rCAZTXTj
	tnrPYNz8NEbLwH7eHAm5I0n+o33iQ84jcdaQKBrfiDXaqsZwCZVrbP2yw3fFfgAyhHeutB
	tx0cYKy8XH1QeP+g+6cpYLFF75Ia6Zf5jwtoey7ls3sLjLDMCzk0pJSqEquBWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT3AQGHShlyKtPFP8oiVAfnOpI9CiiMjUwbxEcyJ5iw=;
	b=UtWXFpXbF8DIPuvulsySCvCrQ7bUupGZaLNWM5IaT5Cr4tVFoAQbB30WJTXIL0rwI6WDKz
	Uhd+KZjnBoCVciBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched/hrtick: Mark hrtick timer LAZY_REARM
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.475409346@kernel.org>
References: <20260224163429.475409346@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301290.1647592.9275760123863212398.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8324-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 87FA91C4168
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     0abec32a6836eca6b61ae81e4829f94abd4647c7
Gitweb:        https://git.kernel.org/tip/0abec32a6836eca6b61ae81e4829f94abd4=
647c7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:06 +01:00

sched/hrtick: Mark hrtick timer LAZY_REARM

The hrtick timer is frequently rearmed before expiry and most of the time
the new expiry is past the armed one. As this happens on every context
switch it becomes expensive with scheduling heavy work loads especially in
virtual machines as the "hardware" reprogamming implies a VM exit.

hrtimer now provide a lazy rearm mode flag which skips the reprogamming if:

    1) The timer was the first expiring timer before the rearm

    2) The new expiry time is farther out than the armed time

This avoids a massive amount of reprogramming operations of the hrtick
timer for the price of eventually taking the alredy armed interrupt for
nothing.

Mark the hrtick timer accordingly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.475409346@kernel.org
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5bc446e..2d1239a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -998,7 +998,8 @@ static void hrtick_rq_init(struct rq *rq)
 {
 	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
 	rq->hrtick_sched =3D HRTICK_SCHED_NONE;
-	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_REL_=
HARD);
+	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD | HRTIMER_MODE_LAZY_REARM);
 }
 #else /* !CONFIG_SCHED_HRTICK: */
 static inline void hrtick_clear(struct rq *rq) { }

