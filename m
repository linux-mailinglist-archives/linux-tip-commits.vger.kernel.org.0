Return-Path: <linux-tip-commits+bounces-7335-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFFC5D116
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DA0A3469E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D217C21B;
	Fri, 14 Nov 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5nmy0Fo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="guB0tkTB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1B7261C;
	Fri, 14 Nov 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122745; cv=none; b=kKg5vaf7CAP+jOk+T6Zdd/elhvw6mVnCX1GZLZhZypy190qYAldcwasF6VdLAUiakLwt57dNu0Zmd+L6dpw6VFT162mvRc0bAioteCCX9RUJK914LY1hmUxMoqD+a7JL6XEJVNgpNfDf7hMsEhozJ4M4GZyJ9mcNCHEjESGoy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122745; c=relaxed/simple;
	bh=C3rkL2/obuGJ+yFf66YNLGjwooqBazKrqwHKCywYQDs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JZWF6MtsSOwwcyHghlkhzl+UKuTxYEkKNQUUB9y5dppizaBp4NRxMDQyOVRMcsqD/QX9CZ46mTAtvsRuxgK1o9gPR40vCtwVBpfAWzXSI4x0VpWPSHy0mneQVNOfBO9pTP/RQf+ia1zAqRsLf78dZ5fEm3nPa/RcVbZ9RGx3GSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5nmy0Fo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=guB0tkTB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 12:19:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763122742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsIjrqgSN6RdzspHZ4cM6B06UTmksv47zkAL90TJGHs=;
	b=T5nmy0FoA8euVdc9jBKbBC07RJgigopSZyP9GRpUwGk1AbWZU7yQ5j7KT/u71aowVm1H/R
	vVWvDkOb6Yra05USYf9jk9yDEYbfrZQe3m6fdop2i827hcYKNBNSXuPeT3uQ6xn5LbxR/f
	DTXv8sUMP1aTx3h2MLgyaD6oUsiZRsh2rb6+G63QWO+jndMA0wwNUCrZURW5RITXP/zzAj
	iV30Gxm58Lcg8FNUVWD8HcXlZAw1VoSnN6wGzwKPSCxVDvQWyb1V+jyzopDYSV97aJinTe
	Y0D7tLU3dArLWsPfv/aRPtMSplKcp+zCekhDI6ZnAtwn1aA0zf2JWEoPEAZ8Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763122742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsIjrqgSN6RdzspHZ4cM6B06UTmksv47zkAL90TJGHs=;
	b=guB0tkTBJsvpCkYrXACORdFiqsosuFl5bKMtQS7opvNnvhUGC1mnfnZHdJ6mS9ON60CfTK
	j7KDds9VXO/3HWCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Small cleanup to update_newidle_cost()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Mason <clm@meta.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251107161739.655208666@infradead.org>
References: <20251107161739.655208666@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312274090.498.11478237853387689367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5a1cbf5ce1445d0173fa1c850b653ecf2034054e
Gitweb:        https://git.kernel.org/tip/5a1cbf5ce1445d0173fa1c850b653ecf203=
4054e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 17:01:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Nov 2025 13:03:07 +01:00

sched/fair: Small cleanup to update_newidle_cost()

Simplify code by adding a few variables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20251107161739.655208666@infradead.org
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2870523..50461c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12225,22 +12225,25 @@ void update_max_interval(void)
=20
 static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 {
+	unsigned long next_decay =3D sd->last_decay_max_lb_cost + HZ;
+	unsigned long now =3D jiffies;
+
 	if (cost > sd->max_newidle_lb_cost) {
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
 		 */
 		sd->max_newidle_lb_cost =3D cost;
-		sd->last_decay_max_lb_cost =3D jiffies;
-	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		sd->last_decay_max_lb_cost =3D now;
+
+	} else if (time_after(now, next_decay)) {
 		/*
 		 * Decay the newidle max times by ~1% per second to ensure that
 		 * it is not outdated and the current max cost is actually
 		 * shorter.
 		 */
 		sd->max_newidle_lb_cost =3D (sd->max_newidle_lb_cost * 253) / 256;
-		sd->last_decay_max_lb_cost =3D jiffies;
-
+		sd->last_decay_max_lb_cost =3D now;
 		return true;
 	}
=20

