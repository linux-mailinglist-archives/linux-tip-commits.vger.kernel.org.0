Return-Path: <linux-tip-commits+bounces-7297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9220C4D718
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6070189F23E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C8359FB4;
	Tue, 11 Nov 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3cKNKrzt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QNfPvqv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707D359F8C;
	Tue, 11 Nov 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861039; cv=none; b=oGfcxOt96EvH8cpy0a2vzXloDAELaz1QLplApcKcQW1bn5JWnovkVCzorRalzKRN31Mj1ZQmtK4j2gNDeJ/AdGWPOt8cBitvaXmrX8/9zE/+dje8NcYXMUzo550TNfCWoCxwoUspJcX07Qfx2dklS4gY5284pX8IZQDWux+/LeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861039; c=relaxed/simple;
	bh=HmJ6P8a67KW9gp98v421zecn35ABKNdkB57gvZX8f2s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LdIaeTiXY8xXW8yNlCfApQHYSR/+V6jZuf4jQa/Atats/LBuUbA8YWTVuZUX5uTVu7UTmATLBA1g+VsZqWg8QvFWAcppq1hZf64TExc3dBBtkwjkrZPvoO8yUhc4WHv0SZmjQ8pcvGy+9xdjzHcA/VZMCV/tCXnVLb18m2+HKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3cKNKrzt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QNfPvqv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRLK0YivYvxu98Vv3MdxvtYps0haS1FT7BegSa3mrcQ=;
	b=3cKNKrzt7/iff+yd53P7lsxqi8IW10+X+SvrdAxax8Jf+9AZPklCk8TQzWwyaY/TzrJFQU
	oBiUQPZOF9xmbOYOZnT+x2qmigb/SbR2MlLelcFe3u1068fkloi3ybBJN9UulFyQ6Ahz+P
	vuywQKhcSvyI0bC71Wa3DN9ZU9yJAj0YPOvlwzxIhhbwRQ17Gq/oua87Grf4rkKXPIxVkd
	jdDsswInAr78qWpgAIuHSreBzE1etAY/KtLlfpCeTwnEG9qgiffSVr7pKM4HImdfVqUDJR
	5bDT4q3Ofpb0QGYEeoVzNKr4IaVOvmPT+s0+R7bDcVMcaAPbNSDlxCopKHMKtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRLK0YivYvxu98Vv3MdxvtYps0haS1FT7BegSa3mrcQ=;
	b=3QNfPvqvHLs53DG7N5jCJRySPs7P2F5c1YO8sY/gOuOotanGuQ6miPXoi8G0pA+XhPwQHc
	RmovVHiPdW4zo4BA==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/deadline: Use cpumask_weight_and() in dl_bw_cpus
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014100342.978936-3-sshegde@linux.ibm.com>
References: <20251014100342.978936-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286103469.498.8073260484561257707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7259e53915cc99298952a35aa8772d33d1e51866
Gitweb:        https://git.kernel.org/tip/7259e53915cc99298952a35aa8772d33d1e=
51866
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Tue, 14 Oct 2025 15:33:42 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:39 +01:00

sched/deadline: Use cpumask_weight_and() in dl_bw_cpus

cpumask_subset(a,b) -> cpumask_weight(a) should be same as cpumask_weight_and=
(a,b)
for_each_cpu_and(a,b) to count cpus could be replaced by cpumask_weight_and(a=
,b)

No Functional Change. It could save a few cycles since cpumask_weight_and
would be more efficient. Plus one less stack variable.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20251014100342.978936-3-sshegde@linux.ibm.com
---
 kernel/sched/deadline.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4d6eaf2..e46df89 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -125,20 +125,11 @@ static inline struct dl_bw *dl_bw_of(int i)
 static inline int dl_bw_cpus(int i)
 {
 	struct root_domain *rd =3D cpu_rq(i)->rd;
-	int cpus;
=20
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
 			 "sched RCU must be held");
=20
-	if (cpumask_subset(rd->span, cpu_active_mask))
-		return cpumask_weight(rd->span);
-
-	cpus =3D 0;
-
-	for_each_cpu_and(i, rd->span, cpu_active_mask)
-		cpus++;
-
-	return cpus;
+	return cpumask_weight_and(rd->span, cpu_active_mask);
 }
=20
 static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)

