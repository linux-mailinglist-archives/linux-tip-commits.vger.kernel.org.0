Return-Path: <linux-tip-commits+bounces-7373-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBE2C65288
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 17:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2234B13E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD22C3251;
	Mon, 17 Nov 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WGgnbE1k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KwK+8JyY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5C284889;
	Mon, 17 Nov 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396617; cv=none; b=uozlB+X8Gw4bUWl5XGrxgq42oas/z1WqMDs8zdWp5TZ9ejDM8KStoc0V1w3WqQrsj9ANZubLaUNSTsPAseotObtkgfNOm8hlO3gLIBMRuz09R5skuJ4BPbuIGszzAAMoeKXCuVUi+mfVmdH49s5uW7j3O67qdlH1toROAFtqsHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396617; c=relaxed/simple;
	bh=dL/yax+1ckO5Ev4SZxcG7Zy/DeGCE+mHW1fz3yfoqbk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mcpd/bFIl0h3H5b4xUMLoYYLybNL7wsyl5prSVQ+9VQJAI868vB9fUVzwARM2QFiA679GVQe+pzKyssNTYqBkq0MJd/AE9NSupmTmYbc+bUiggeKpA3CKK5QUr4TKHMOWR28NJwOdDKZP/rzVC7dj9l4DwkqykpZCrkmdgOwlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WGgnbE1k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KwK+8JyY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Nov 2025 16:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763396614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdwzjgDcU9w0b7OEcdtmnX+CsVwllVeWuJ8gAJdcujk=;
	b=WGgnbE1k6W4xDl2auI3Ncy+bc7LAir0efIsDmuvT8kqVM1xmn5QeGFjaw5kNa9nFZfEcDn
	CxR33lBe/ryJogdqMVOH6g1oXh0Ng6mh+5+haWHIKd4iow4eAuJvauuUPYTeVTOaEjlo4i
	FJ2jm6bkHkJTGMCrdznhCFBUHw/p9uzJn7b1WixUgISbn+yHSJpNfuRvpLJzxE93icXS+i
	8X08EFP9frdRbh3h6EWFlCKqIxm05GJjqyBlzotmm1X6rBGf62GHyg9K4X/MpEqpgI01gt
	5IbhvNoitzgT/JTeCE94IVfrnWX/h54rstvtYIzSkIqcpGI1to91747RSxXUDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763396614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdwzjgDcU9w0b7OEcdtmnX+CsVwllVeWuJ8gAJdcujk=;
	b=KwK+8JyYffaWMf0vKYIH8QejaUcTb2banNOkb+BTWzLGRzMvKoHoUui4Ye56qnM/SFr+nO
	xwKFpWT/6BiH1FCA==
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
Message-ID: <176339661310.498.8759027571439426473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e78e70dbf603c1425f15f32b455ca148c932f6c1
Gitweb:        https://git.kernel.org/tip/e78e70dbf603c1425f15f32b455ca148c93=
2f6c1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 17:01:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Nov 2025 17:13:15 +01:00

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
index b73af37..75f891d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12879,14 +12879,16 @@ static int sched_balance_newidle(struct rq *this_rq=
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

