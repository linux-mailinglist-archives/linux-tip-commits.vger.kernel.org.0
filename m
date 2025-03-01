Return-Path: <linux-tip-commits+bounces-3763-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49B1A4ADB6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5646C7A25FE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990411EC01F;
	Sat,  1 Mar 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XTCNgrx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oCEVFBb8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D11EB1A4;
	Sat,  1 Mar 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859660; cv=none; b=GohcTmsktEeH04nuKCJ2fdGf6nyINMf4gUZq3qlTx3R/LNQfIVlXji3UtMhQgvhBGFTEAWJ4KHSA1RN8+jrhN73JavYcVaiT5th0NBqXezjfSFhKdBACdBsTbff4e9jUrOMdkI0cNs+FHPzn5iBd+2Vis2l+xmbDLLbeXMcXQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859660; c=relaxed/simple;
	bh=ufjprtPPhLU+bcy2qWX0Rj8P8BRtOtMQxI0pZq5Qffo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hwGhAWwdrAu1CIio7fMM+eVdQUc8YSPJAgUZLb7D8sThD9qCUAgp774aFzM/PwiWwvkiWkE0AFESFS4blUyWPlix2MjGQRVLaNZ5X6g5aHp8XSGMUCvwkqHYtQO4IiJniTVNWq2Pj2QbJt9u2NEOCxlzPR0k4jMyHo1JFw2r0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3XTCNgrx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oCEVFBb8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeBFiowq0SP6g/5Eqem9bvvyJhVV8o2rXBAhTMOhlks=;
	b=3XTCNgrxheP0sjxgHeM80heQzzkC57kHaTYXi+0iF/Is1wUrpklZL3Au6gRso9hUy+XSFt
	wAztOjm636m0eiN891/mqfGlkOQpuDj7KvaGUYxdTl+oqlPh/w3f7DM0IWC0bfw0kCEI/K
	cduN3n0eQU1R2N8p65Ya4bIF2bxZxHFW7Y76ypU9VSXpZFOEONfakkGeyG5tsYsRHTAk/V
	0dh91vzFp1sSZwUxiYD2K3EK3O75Ba75zogV5D7OV84OFq4cYkOlaPruaEHRpo8NEatDqr
	5tio7CdSEugFcM4WyoveDoJf/PQuWBHoq+b8D92+O/YgawyIjvTZfMwM0jAWsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeBFiowq0SP6g/5Eqem9bvvyJhVV8o2rXBAhTMOhlks=;
	b=oCEVFBb8VgvcvcTA2gVyFtEX6D6pgFVPcFbUOtr74arcfAE/7g4BJ1OnmOfewOtwfqrkhy
	hpvfEE3DR7btk+AA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix pmus_lock vs. pmus_srcu ordering
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135517.679556858@infradead.org>
References: <20241104135517.679556858@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965644.10177.4731104673562903630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2565e42539b120b81a68a58da961ce5d1e34eac8
Gitweb:        https://git.kernel.org/tip/2565e42539b120b81a68a58da961ce5d1e34eac8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 19:38:42 +01:00

perf/core: Fix pmus_lock vs. pmus_srcu ordering

Commit a63fbed776c7 ("perf/tracing/cpuhotplug: Fix locking order")
placed pmus_lock inside pmus_srcu, this makes perf_pmu_unregister()
trip lockdep.

Move the locking about such that only pmu_idr and pmus (list) are
modified while holding pmus_lock. This avoids doing synchronize_srcu()
while holding pmus_lock and all is well again.

Fixes: a63fbed776c7 ("perf/tracing/cpuhotplug: Fix locking order")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241104135517.679556858@infradead.org
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6364319..11793d6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11939,6 +11939,8 @@ void perf_pmu_unregister(struct pmu *pmu)
 {
 	mutex_lock(&pmus_lock);
 	list_del_rcu(&pmu->entry);
+	idr_remove(&pmu_idr, pmu->type);
+	mutex_unlock(&pmus_lock);
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
@@ -11948,7 +11950,6 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	idr_remove(&pmu_idr, pmu->type);
 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -11956,7 +11957,6 @@ void perf_pmu_unregister(struct pmu *pmu)
 		put_device(pmu->dev);
 	}
 	free_pmu_context(pmu);
-	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 

