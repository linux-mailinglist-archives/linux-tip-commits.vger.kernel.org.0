Return-Path: <linux-tip-commits+bounces-7657-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB6CBB793
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F4B301B2FE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B712C21FB;
	Sun, 14 Dec 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="No/zViZi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wirlpBEX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E32BEC32;
	Sun, 14 Dec 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698409; cv=none; b=InHoTz6Gdn+eUBpyeZ9fyii6p2XftXKoWk9d0w4idI+bqkWlKZhEFAYvYwx/xHnDV3egOTDn8+J2nHdRkCYtR+Of2DdnvuaiSseUp3jW8Zrt6Dd+te+WUgiQCmHgfZI+KolhmUHsKIut4u7j2tfoCymfhoGB/UWGKeO6ueGnOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698409; c=relaxed/simple;
	bh=d3ehEgf2LMwG3EVN1HINg+UtNa6GaxzQKhDc+XEye1w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t4c5Z4yiD6wjDCts58p/ZTCQgEGUWPriJJUoX59xeJLXAJOZ3uNZCBu1zJ25Xq6Y2eQvLuDAcKJeUxbr3OSz6sARec1G1q06zu1U1xWNQunMFo8bnpzfot8UQgcTW4DhRhHzBqC3+y/ttJmOW2J8c1J5jDrXnCzaRhhs0RU3C/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=No/zViZi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wirlpBEX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQxLFfu8Ii38zbfR0c7bg+WWBBqZuHD7mS6NsE4Bt/4=;
	b=No/zViZiNIzI1FjcfGYCOZ5IHGYMo+peHw3oSw/kpiGZvTUmLEkB56cS6CO3QKJmiHKAbu
	Z3TYk9Uw32VuhV8UWHGkkb6aOjhgCzL9ccXSPu1mBTygzwjZdqsvB3wmZwk0w5jGLiP82a
	vOkF73BrtWQUWK5C11IHymGyYYHSjFnMP1wvs5DUnArjjR5b57bsKu0U3j8oYzCzrdfCxl
	zR/IizVtNaOfEfcHyZkRX2Lo8CgSVuJKmmYwoaQgwWTuGzn1Lsu2UYZ5eipgL5YexYDJ+Z
	H4aCgi9fm1f2xHKWysltnM0P/dhct2vQrIvq1EqqTF8kLBXHzr3Rovk+ndLfWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQxLFfu8Ii38zbfR0c7bg+WWBBqZuHD7mS6NsE4Bt/4=;
	b=wirlpBEXh5d288HiDYAyByaqgDsk7wRUhXz6XVdnxRHvs9fqyxkIXi8bkmNjU7+2bcW2Sz
	NRRJCKnOId+7u3Cg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove superfluous rcu_read_lock()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251127154725.647502625@infradead.org>
References: <20251127154725.647502625@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569840446.498.719471047587243574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a03fee333a2f1e065a739bdbe5edbc5512fab9a4
Gitweb:        https://git.kernel.org/tip/a03fee333a2f1e065a739bdbe5edbc5512f=
ab9a4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 14 Nov 2025 11:00:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

sched/fair: Remove superfluous rcu_read_lock()

With fair switched to rcu_dereference_all() validation, having IRQ or
preemption disabled is sufficient, remove the rcu_read_lock()
clutter.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251127154725.647502625@infradead.org
---
 kernel/sched/fair.c |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44a359d..496a30a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12856,21 +12856,16 @@ static int sched_balance_newidle(struct rq *this_rq=
, struct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
=20
-	rcu_read_lock();
 	sd =3D rcu_dereference_sched_domain(this_rq->sd);
-	if (!sd) {
-		rcu_read_unlock();
+	if (!sd)
 		goto out;
-	}
=20
 	if (!get_rd_overloaded(this_rq->rd) ||
 	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
=20
 		update_next_balance(sd, &next_balance);
-		rcu_read_unlock();
 		goto out;
 	}
-	rcu_read_unlock();
=20
 	/*
 	 * Include sched_balance_update_blocked_averages() in the cost
@@ -12883,7 +12878,6 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 	rq_modified_clear(this_rq);
 	raw_spin_rq_unlock(this_rq);
=20
-	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		u64 domain_cost;
=20
@@ -12933,7 +12927,6 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 		if (pulled_task || !continue_balancing)
 			break;
 	}
-	rcu_read_unlock();
=20
 	raw_spin_rq_lock(this_rq);
=20

