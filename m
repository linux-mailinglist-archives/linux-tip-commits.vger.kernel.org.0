Return-Path: <linux-tip-commits+bounces-5020-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97836A90C22
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 21:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4433D5A3816
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 19:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D45E225768;
	Wed, 16 Apr 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zsaoEceR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4h3pQSvV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800F2253EF;
	Wed, 16 Apr 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831003; cv=none; b=aT3/HwE0BmeKDq/P+x/8MsE3mFSR7is7L10vj0QXSpRpBQ42/Q8q38tpuST7vwptwJhZzNWqlqo9UgZi2omgzrwquQpqsuC2lAFheZY3Y3jrvx/rTYiTh72w4uRYhgFKKLlV1/gAIxVu1ek20hQMmtTsJENedzeUAyvoHio4fRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831003; c=relaxed/simple;
	bh=1Opu5mGMyyQZBNjrpMuTUB8AeXYckCct++E3AMnULe4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G10lwj9McgIVOBO66uCjn7ReBbYozdhNzB3PoyGxGxhRneh+4ssjzUL6vtuhInpn2IukCk0YwG0ytD2puvVDVPdVPcDOaVwZTAz6E4WCjpleXeJLwRjZFyKQVVnMhnPZTkwf4u1x5lJaX/vBtuTTVT/7i+oqWHc2MZ38sldrdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zsaoEceR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4h3pQSvV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 19:16:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744830999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aa1Wb5sPywK7zmdH30azMl4IYnnHkOT/puZig3RWRXM=;
	b=zsaoEceRnjP4dqkyG1wknNfMDd+IDNn9sPHAqbH9w1/5i6Ny5R559H/ksPwQW+He6Qb6zQ
	nfMRAmL/tG95ppL6Aca7q/gcXd0QPqzMs1GG27nGXozOJTfEiud86x3RCtKOTNPXUn4g4q
	Kk6m5vaPPfyoDbTjoh+vZ49wYTozKedPTSwEiSMYDttLvUwmb+siAxZu66l/xgL7ggowkV
	JVRkNDuXOv5/WAjF5Ma9OLvJhfglt2VBqZSyH+zAG+FV5WdZuMLsFpPKiyiRFF44uCrphY
	lzianACgcow4NuG5gk3UqTZFmycy5t2+0/xSOo7pOehjUvissiSk9v11gMmQtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744830999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aa1Wb5sPywK7zmdH30azMl4IYnnHkOT/puZig3RWRXM=;
	b=4h3pQSvV9G1qFKwvzt7CeBAiVg4VbBV7OyQShRO/qcz6ECR1oPoDkF8FPcZSULCVjHseTs
	wJ58JtUv1sKHiECA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Use READ_ONCE() to read sg->asym_prefer_cpu
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250409053446.23367-2-kprateek.nayak@amd.com>
References: <20250409053446.23367-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174483099840.31282.17802635645325940436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     872aa4de18889be63317a8c0f2de71a3a01e487c
Gitweb:        https://git.kernel.org/tip/872aa4de18889be63317a8c0f2de71a3a01e487c
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Wed, 09 Apr 2025 05:34:43 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Apr 2025 21:09:11 +02:00

sched/fair: Use READ_ONCE() to read sg->asym_prefer_cpu

Subsequent commits add the support to dynamically update the sched_group
struct's "asym_prefer_cpu" member from a remote CPU. Use READ_ONCE()
when reading the "sg->asym_prefer_cpu" to ensure load balancer always
reads the latest value.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250409053446.23367-2-kprateek.nayak@amd.com
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c19459..5e1bd9e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10251,7 +10251,7 @@ sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group
 	    (sgs->group_weight - sgs->idle_cpus != 1))
 		return false;
 
-	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
+	return sched_asym(env->sd, env->dst_cpu, READ_ONCE(group->asym_prefer_cpu));
 }
 
 /* One group has more than one SMT CPU while the other group does not */
@@ -10488,7 +10488,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_asym_packing:
 		/* Prefer to move from lowest priority CPU's work */
-		return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
+		return sched_asym_prefer(READ_ONCE(sds->busiest->asym_prefer_cpu),
+					 READ_ONCE(sg->asym_prefer_cpu));
 
 	case group_misfit_task:
 		/*

