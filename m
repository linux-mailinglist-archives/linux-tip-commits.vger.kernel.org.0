Return-Path: <linux-tip-commits+bounces-3142-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4199FC185
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B931885474
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150F2147E3;
	Tue, 24 Dec 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tWdph4N/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AxjcYJBt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8021324D;
	Tue, 24 Dec 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066484; cv=none; b=HOjOOxl4p/8OAXWZHSDOano6qVdLcU5eN9/rRDihMhjMGeEnX7BToknM9KfLRX7j6+LI+e8MHJxByHVzl0Teac6/4uGxGenyARZLdwkulw9/Knp8ryt0Bt0AJ7tbddWi17lSAypuOdeiMrNzAtsSR2meCikFzD2RsHTWri3gUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066484; c=relaxed/simple;
	bh=EepGV6w7LjnQaUinC7Um6zBiIrxzMV1bn1/s/UNRXMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rObL/+9kuh5IEb1Dvw/gMRaLLWiArvZ5Mj0WgmTWdVyduwMrxDgRtWiidrPbcVaTMAI9uNFIKtbQbdaSeOllw/JQuS2MKXrSgZHn6OJkYDb1B8FOv8FEyV6W4sZdY1tMAPIbRsyKMDsJKpGZtcMef2UuljfrUEaGikxDjK0uPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tWdph4N/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AxjcYJBt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BUlk1VZSFn+0XQNHLS6iw+1DUMPi+k0xNjLnBHwC3o=;
	b=tWdph4N/kQT4HDQnsy+BRfSbRVf9otb1V3ZqJhuX2h/l/62JJ/1Y7GM2cqXbGKgz0JpTAB
	ZyzQq8to16AXcRS93GsQrUPl8E5jAqnx49ALw1dU84fOZuJZgNB2f4i03e41lDWeCDTk1z
	Sy2RibrBApcYnnDB83ur+VQ/pbyXpkluP+w0rVLCndY9iqRmiV4ToOkRpTm6439VM7myuC
	xgg1DvYBErWTiojmvcBoPuT2n7CDGy1pRQOberMex0++Bo7US/LzzfJKKmaKuGZRNRHzDL
	vwu8QVgGtLlMoL8lohKSeenqk0OUM3Sk63eM+SoqjSaIlFXqKdOdgLZ/r/Bnwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BUlk1VZSFn+0XQNHLS6iw+1DUMPi+k0xNjLnBHwC3o=;
	b=AxjcYJBtq6ClNsUOaPmdRx5B8CDln3h0ackJB26Fy8Sv7/w+obSYMApkxGbISE60qd0gKY
	d16FMh+YQ3XyNTCg==
From: "tip-bot2 for Swapnil Sapkal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Move sched domain name out of CONFIG_SCHED_DEBUG
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220063224.17767-5-swapnil.sapkal@amd.com>
References: <20241220063224.17767-5-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506648005.399.6028009295642056920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1c055a0f5d3bafaca5d218bbb3e4e63d6307be45
Gitweb:        https://git.kernel.org/tip/1c055a0f5d3bafaca5d218bbb3e4e63d6307be45
Author:        Swapnil Sapkal <swapnil.sapkal@amd.com>
AuthorDate:    Fri, 20 Dec 2024 06:32:22 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:17 +01:00

sched: Move sched domain name out of CONFIG_SCHED_DEBUG

/proc/schedstat file shows cpu and sched domain level scheduler
statistics. It does not show domain name instead shows domain level.
It will be very useful for tools like `perf sched stats`[1] to
aggragate domain level stats if domain names are shown in /proc/schedstat.
But sched domain name is guarded by CONFIG_SCHED_DEBUG. As per the
discussion[2], move sched domain name out of CONFIG_SCHED_DEBUG.

[1] https://lore.kernel.org/lkml/20241122084452.1064968-1-swapnil.sapkal@amd.com/
[2] https://lore.kernel.org/lkml/fcefeb4d-3acb-462d-9c9b-3df8d927e522@amd.com/

Suggested-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241220063224.17767-5-swapnil.sapkal@amd.com
---
 include/linux/sched/topology.h | 8 --------
 kernel/sched/topology.c        | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 76a662e..7f3dbaf 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -143,9 +143,7 @@ struct sched_domain {
 	unsigned int ttwu_move_affine;
 	unsigned int ttwu_move_balance;
 #endif
-#ifdef CONFIG_SCHED_DEBUG
 	char *name;
-#endif
 	union {
 		void *private;		/* used during construction */
 		struct rcu_head rcu;	/* used during destruction */
@@ -201,18 +199,12 @@ struct sched_domain_topology_level {
 	int		    flags;
 	int		    numa_level;
 	struct sd_data      data;
-#ifdef CONFIG_SCHED_DEBUG
 	char                *name;
-#endif
 };
 
 extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 
-#ifdef CONFIG_SCHED_DEBUG
 # define SD_INIT_NAME(type)		.name = #type
-#else
-# define SD_INIT_NAME(type)
-#endif
 
 #else /* CONFIG_SMP */
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9c405f0..da33ec9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1635,9 +1635,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.max_newidle_lb_cost	= 0,
 		.last_decay_max_lb_cost	= jiffies,
 		.child			= child,
-#ifdef CONFIG_SCHED_DEBUG
 		.name			= tl->name,
-#endif
 	};
 
 	sd_span = sched_domain_span(sd);
@@ -2338,10 +2336,8 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 		if (!cpumask_subset(sched_domain_span(child),
 				    sched_domain_span(sd))) {
 			pr_err("BUG: arch topology borken\n");
-#ifdef CONFIG_SCHED_DEBUG
 			pr_err("     the %s domain not a subset of the %s domain\n",
 					child->name, sd->name);
-#endif
 			/* Fixup, ensure @sd has at least @child CPUs. */
 			cpumask_or(sched_domain_span(sd),
 				   sched_domain_span(sd),

