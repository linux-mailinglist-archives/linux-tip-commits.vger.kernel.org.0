Return-Path: <linux-tip-commits+bounces-8012-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30ED28941
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2F5330128D3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB89327C1C;
	Thu, 15 Jan 2026 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VP94mKw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ddpBBMDK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDE32573C;
	Thu, 15 Jan 2026 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510867; cv=none; b=NHwQ9046CRFv2JBxlBwaO/wPNnuesP0g3lwUnkMgPbHW62yRTAyn6wzCHjO+HEgzUHXesC3zRWrI6Gp62Ihnm9GFN7Vb/ZslTPSwY4jvm7gNYTGgk53LPAArVUF2xk6pvszf8CbRIiuk5jZuuwgN3useqmi9I9pW+9Wd5fHf3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510867; c=relaxed/simple;
	bh=uRxJlqTVdM3Z2vJVOYNFHZ9rEgsr+MzihI7T8jKHRYc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vk9zYYri1FKOjb5gNVewxIVnAXWDPsBFka+L4Zc8+BCErgA4nVHSfQNmRkdV1nkZIZOGcMOsO0hHHBVwD9uB5f5PG35o5U5hm7sBfTtLM1eKeLG4q+7KEoMubtV/d18Ia9S+RsDfIlG2Ip9dEVCHaKkQODhkEfOhdbHAdri8XvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VP94mKw8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ddpBBMDK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:01:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768510864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51ehnEkLzr5FMkIz8RHuarF/faLiX7J2TtdGrpu88fM=;
	b=VP94mKw8W4iTNyurvGMzsfrTYXjat4Ojtb4p9YJqV7HJqzEk+B7VP7u+B2+iP4GxhO/zWn
	1CpX28sS6L5KwMDSdlyZZzESrsKX5Qy4L47VbHbPfELEnfX0qTpuYiSzQdCf22EXR+14TD
	P0fXuH1XQOHjH0Jpqyad+0XG9STRfHZLmESJfttJyWRvGb9p/mnim7A+/9fMfkp8g9grRh
	LU+c8WKld3ud86NNDZ3ANR/cM/QLBdoccjcaWP2Io4m/5HCxGp7WF94+7KpqDq7ncsJN2T
	3U5lvyTnNoPfnIWSI1nfKWhU0Ck37ss9/poe3ErhKxP0pt0Xmxd4qN+mXn8TMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768510864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51ehnEkLzr5FMkIz8RHuarF/faLiX7J2TtdGrpu88fM=;
	b=ddpBBMDKzOA/KlXYQAnO5iZsPT2ClV3pKtoUnP3hSs3pS4juwD68wI3L+5LL9CjOfEaxSZ
	Sz/SUVrhQNNtEFCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Avoid double update_rq_clock()
Cc: Pierre Gondois <pierre.gondois@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260113115622.GA831285@noisy.programming.kicks-ass.net>
References: <20260113115622.GA831285@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851086283.510.1348786970791383617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4de9ff76067b40c3660df73efaea57389e62ea7a
Gitweb:        https://git.kernel.org/tip/4de9ff76067b40c3660df73efaea57389e6=
2ea7a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 13 Jan 2026 12:57:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 21:57:52 +01:00

sched/deadline: Avoid double update_rq_clock()

When setup_new_dl_entity() is called from enqueue_task_dl() ->
enqueue_dl_entity(), the rq-clock should already be updated, and
calling update_rq_clock() again is not right.

Move the update_rq_clock() to the one other caller of
setup_new_dl_entity(): sched_init_dl_server().

Fixes: 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")
Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://patch.msgid.link/20260113115622.GA831285@noisy.programming.kick=
s-ass.net
---
 kernel/sched/deadline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b7acf74..5d6f3cc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -752,8 +752,6 @@ static inline void setup_new_dl_entity(struct sched_dl_en=
tity *dl_se)
 	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
 	struct rq *rq =3D rq_of_dl_rq(dl_rq);
=20
-	update_rq_clock(rq);
-
 	WARN_ON(is_dl_boosted(dl_se));
 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
=20
@@ -1839,6 +1837,7 @@ void sched_init_dl_servers(void)
 		rq =3D cpu_rq(cpu);
=20
 		guard(rq_lock_irq)(rq);
+		update_rq_clock(rq);
=20
 		dl_se =3D &rq->fair_server;
=20

