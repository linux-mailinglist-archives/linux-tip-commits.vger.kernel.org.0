Return-Path: <linux-tip-commits+bounces-7336-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54590C5D11F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 984EC346D5E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B11237707;
	Fri, 14 Nov 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O8d5E45r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMvhmvic"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6915539A;
	Fri, 14 Nov 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122746; cv=none; b=m92vpbrQanReBwwdD2intv7cnPpMW1mwpliYCxOGxAKABHZboEVOS+TKt2X9iR8+znN8caTimaYnUHelS4v1O/g0KfG/FtfRjSZejKZKWgNGbht2jSHJClXpNWqcTOc39ZX/h/piFa03nCJffCe4nV71qEoZl72xcOCmSmV9/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122746; c=relaxed/simple;
	bh=M0PrrtTxoFEnLsQkKzfgp61AOfp95Ik5Ou+dc4iAjeA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QMRcJr+wSbf6W2LrOP3ZGJE2PWuxd6DGCadQT+f4oz58wuwnK1Q9u8fKBcjtWEKkovR+ZR6yKm0uwtbNWfC2CKB+rU3ac0tV43eLKqLJipdf22ATKkUTc1vjkMJ7i6MXX5w0Cl2MaXeE7lS8MIL/T8zh/JOt35sF1mXhyagD3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O8d5E45r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMvhmvic; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 12:19:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763122743;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7vqvYJ4rwxXFrEMbLOTcpNShRUUI/SNn/X8IilPQZY=;
	b=O8d5E45rNnVVmZH5FPY01d9DojUgoH/oyZU3I6e5vdibrIMkcuy4kIWVyDQJDUJyhNGNik
	4bMfBilSpBvPkzjX/rd9Ied/mG/VoZGQzXVfY8rCYokQkxOyMP63Jc5tlzD22+AdIhXdtU
	HY1PCfNMWkFZ4+lY0lKCYHQ1ogBj/RhS6NrEzPwlOpIYXO1Qrdrwt0ANsmoHrBjJj/3NSY
	cQDQhO7m9fuD1PHbaMHyhaW19lIZo1IICetuXeUqnnv+W+X2VapuL+BUT4wv3/p9gHywu+
	n1OrnylzE+UtEeQeUPOOZkfDw7+d71sGsxGLOiSTPextkTkfQvGTOYcYipInyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763122743;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7vqvYJ4rwxXFrEMbLOTcpNShRUUI/SNn/X8IilPQZY=;
	b=nMvhmvic3+/7Q1NB008oQGU52l1cxzPyL8KtKd7cHJ0VIr0baBlIiOj+DNCg+eitVnrW2p
	S0yJpeQxefojRDCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Small cleanup to sched_balance_newidle()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Mason <clm@meta.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251107161739.525916173@infradead.org>
References: <20251107161739.525916173@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312274188.498.15313034806106914289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0a37a229bd68647ed01aa687f2249056f080265e
Gitweb:        https://git.kernel.org/tip/0a37a229bd68647ed01aa687f2249056f08=
0265e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 17:01:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Nov 2025 13:03:07 +01:00

sched/fair: Small cleanup to sched_balance_newidle()

Pull out the !sd check to simplify code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20251107161739.525916173@infradead.org
---
 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfb8935..2870523 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12878,14 +12878,16 @@ static int sched_balance_newidle(struct rq *this_rq=
, struct rq_flags *rf)
=20
 	rcu_read_lock();
 	sd =3D rcu_dereference_check_sched_domain(this_rq->sd);
+	if (!sd) {
+		rcu_read_unlock();
+		goto out;
+	}
=20
 	if (!get_rd_overloaded(this_rq->rd) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
+	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
=20
-		if (sd)
-			update_next_balance(sd, &next_balance);
+		update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
-
 		goto out;
 	}
 	rcu_read_unlock();

