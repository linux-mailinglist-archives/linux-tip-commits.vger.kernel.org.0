Return-Path: <linux-tip-commits+bounces-4285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF370A64B69
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806593AE9FE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B92356BD;
	Mon, 17 Mar 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x0pA+9GX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPCevTLp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19738B;
	Mon, 17 Mar 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208974; cv=none; b=pbdJFSI+Oi6Xd6pk+c7ig9s6UvSMV4DT2OSvNFODdeuwFM0c6vIlPnO+4KZL1SIz0lR3H/nvgT5SyJ9aPVaMjW6yww9EV66UfE4cpY1j94mUJiy0L5nETIjXAS+2IbjYeCWoaQO8rsJhTWeThvtUxv+rPwPCikgOBYJAT6UP3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208974; c=relaxed/simple;
	bh=uM3t34ivaC8KST6x7dY0wBU/L8Tud9ZHPJ+748U3/q0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Ef/d3lMS0/JgLsmb/JHn0Pz560oKPDgqAk/Sq+/O0S+O8R9sbrBE0U2gRDCn8psTVAvPUV6gXQEFaJH/JVDYFqgRk3hNNxy4umuUPV67TBR/XEhw/u4M7WUczBOBh1Ym4zLxd54zVADoxf2FKdjzzoSsVjxy/fro0Pg5krac0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x0pA+9GX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPCevTLp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:56:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KEYABpgu10Wbc5MikT3BKwHLSq4ftetYGyL8ksfu4kM=;
	b=x0pA+9GX7B2xHuJ81rYzYczskDxD3/VIz6ywWzxL1/DBObuCDqnVhRHy5ib3OujsVvQsVy
	IXYe8oY/3e9Slt9AT4HAvut2wbChFvVdA6oeFHPoHzs6DWM+wJmMs8dj3U70nM0zyJb+UE
	zSQlRhNgMuxn6PZtJ+W2TA+uO5aUyWgrhZQzkHxod85nEOWwAczqduEj4ph9ThdQcS/s+c
	eeJBibxlJhuCKK9U9N+FDcHiZqRby7Buq0cUNOVxqKWmgKUM9sVaB53YYXa5FYtUUiIpnb
	TyETd0iIhO6N8XGj1W+LLM5G01Meqd99B0u6ngd5GmOZ9epUrl+8c3/R/cZMuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KEYABpgu10Wbc5MikT3BKwHLSq4ftetYGyL8ksfu4kM=;
	b=VPCevTLpROtLXmcwVHY+LIKFjuPWpRYSHBwO+wCaSYJ0mKcTYFJ+47yb/uz3/cKMbJ8Cfz
	zvpuAFssp21t+NBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix __percpu annotation
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, jirislaby@kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220896862.14745.11004519106792441790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     12e766d16814808b6a581597cef6ce9fc029e917
Gitweb:        https://git.kernel.org/tip/12e766d16814808b6a581597cef6ce9fc029e917
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 17 Mar 2025 11:39:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:42:57 +01:00

perf: Fix __percpu annotation

With bcecd5a529c1 ("percpu: repurpose __percpu tag as a named address
space qualifier") the normal compilers start caring about the __percpu
annotation, as such f67d1ffd841f ("perf/core: Detach 'struct
perf_cpu_pmu_context' and 'struct pmu' lifetimes") needs a fixup.

Fixes: f67d1ffd841f ("perf/core: Detach 'struct perf_cpu_pmu_context' and 'struct pmu' lifetimes")
Fixes: bcecd5a529c1 ("percpu: repurpose __percpu tag as a named address space qualifier")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: jirislaby@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5b8e3aa..63dddb3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -343,7 +343,7 @@ struct pmu {
 	 */
 	unsigned int			scope;
 
-	struct perf_cpu_pmu_context __percpu **cpu_pmu_context;
+	struct perf_cpu_pmu_context * __percpu *cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
 	int				hrtimer_interval_ms;

