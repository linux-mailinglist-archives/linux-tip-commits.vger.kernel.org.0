Return-Path: <linux-tip-commits+bounces-8025-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDFD28D39
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA9F2309F2E8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42033121C;
	Thu, 15 Jan 2026 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DtOGFGFS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="obzTbAgg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05459329C6F;
	Thu, 15 Jan 2026 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513460; cv=none; b=Bmci4oC041xKVhs7UuG837J5GoWtaEBrdnD2xbaM7H5/ZAE+BBIFwD2FC+sLrvEoundIvtd7gXcBEPAIb2uF9xexTG1ieUV3kD2GHNeY189KXOpq1yJBhj4N768Uc9VqZNBSbAY6YWO8YT4NxGj+8h3cqe+NNqEEL4Gp7qJg0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513460; c=relaxed/simple;
	bh=wzoqXH7lRicNF5PPHcF4WwCCc2F3wZTBiHaMRO3rsUs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HLK44gBjnYlJmpbuFMIkviNFEsFQoTfr29zDIK7t5IqQO20PbPga0SCz0nYcGtnEEBFOZh7uaPlYez43eM3U12SyMQSfOym/1DvMl/wkNM7a3UThdhd7Lx7eAU9PR+SpIjSrHtYKSu9H7IwRE4ailLMetKOrfms55abEY2zhD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DtOGFGFS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=obzTbAgg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9dOMfBbl6EaNvRydmj8w6afcccq5V6Mw6sjEVQe+xs=;
	b=DtOGFGFSy8IE7V1Jp95454qld2SKY3XGVm4ICGqI8W6TNGy1qSEovNKyB6axRaKdayVBtP
	faYUfZ8D8jJ9Pkr2/rtt8pj5D7Sf6/HKnVlWFbRRlscXO9F+zV+M+BMPVCJtVu1+zbEUO5
	XniSancl7KzCNY0sG4YVojnk0tcq/WJjI7HPf9qaFAnH/lh5NIqvu2Uat9CBw3oVV8qrIW
	MDTQ3l5TpNdNu3j9a5Oa2POgjIX4otx9sH9S86MI2ClpPQOq7AErKCTHIJ/IQl5zjlrCTh
	gS80yBsysNpbzzEu4ZyYold4DNq0iEXyBBJ0CHEgk3qPpN7tI5NGzCv/GltsCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9dOMfBbl6EaNvRydmj8w6afcccq5V6Mw6sjEVQe+xs=;
	b=obzTbAgg4+pYGVWvHV0jdKTmEnRPP4TFoD11nEhTOR2+5HccZ5ZPgxUJNHjWpa6PTuuYux
	SI1MciX9+Peq8rBw==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Change likelyhood of nohz.nr_cpus
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115073524.376643-3-sshegde@linux.ibm.com>
References: <20260115073524.376643-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851345658.510.10023012687723072941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     94e70734b4d034b9df795bd1ad3452ea96e742ca
Gitweb:        https://git.kernel.org/tip/94e70734b4d034b9df795bd1ad3452ea96e=
742ca
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Thu, 15 Jan 2026 13:05:23 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 22:41:27 +01:00

sched/fair: Change likelyhood of nohz.nr_cpus

These days most of the system have multi cores. The likelyhood of
at least one or more CPUs in nohz (idle state) is higher.

Give accurate hint to the branch predictor.

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://patch.msgid.link/20260115073524.376643-3-sshegde@linux.ibm.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9afe0c6..4ae06ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12459,9 +12459,9 @@ static void nohz_balancer_kick(struct rq *rq)
=20
 	/*
 	 * None are in tickless mode and hence no need for NOHZ idle load
-	 * balancing:
+	 * balancing
 	 */
-	if (likely(!atomic_read(&nohz.nr_cpus)))
+	if (unlikely(!atomic_read(&nohz.nr_cpus)))
 		return;
=20
 	if (rq->nr_running >=3D 2) {

