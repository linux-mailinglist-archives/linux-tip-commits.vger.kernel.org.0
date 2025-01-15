Return-Path: <linux-tip-commits+bounces-3228-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F0CA11D43
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA820188984A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106FF3DAC13;
	Wed, 15 Jan 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/krN5L5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="icGz/vVN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FA23F273;
	Wed, 15 Jan 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932642; cv=none; b=tIfJbetvTKqTlZz2SGCERec6gzqljTPwaxZYt6jVRbjYo7b1pEtwo8nBzp7olzw7YtE4tk+opEKNX3T2Nj+ygsdPmPT9u/JK48uK2210hyRu2s5NQXHfXGM7FSl0AhAX70FXbntI55RkFXQwxSKnz1qXx6c5NfeW+ZUpplOT7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932642; c=relaxed/simple;
	bh=bjpEsOnGrWtTX4JZ2XYkx5Fps7xQxGZMdxL2chF4Z0w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mntMVs/NU96FagGddRWlI2gdNMfN/d9xZM4f5A9zvb5r2CI/L5CQUxIVYbImnRlcQqMN389+A2a9MoWDJolEGIQMi6GKLWtpV6Rfx/sl+Fo7Jph4zbLaEJ7wA0e8szV2Zsl/zRf1Y3i/LdR52ALx+nJTZ0/DK2w3ddQeYicf0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/krN5L5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=icGz/vVN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWBmuLNzFFEmTF6d+T26i80TFogJxnRvUSZ8R+nyJrw=;
	b=Y/krN5L5hdHJMAwOt/MJpA6n+HHKPSKx8kONGzur9U9INT1XJBv8f/p2dOgMIc9dRmdgdP
	XhyRD8QjR9zMt3gejPUNgJo7/g+GUn2mFlGCcfrRQ96Mwq7BzSNGWoc2Hf88DpJ5ggiMR9
	tvDMsyB5FUwVy6oBhdr+QpAhIWM5rSOaM6PrLd/zMbhmAeIBqr6zXLmszPh9rRm7YJ+Fcg
	A3jtlgLKz/XJzqyqLB40RNGekVGPZq2HlB+y+lEK3JrAYOfrmMGpVxKXdluwsvKFZULwPB
	oOFmHvaZMfHOH9l6FUpu+eypCUNE8PBkhuy2D2EH/kTjdJSHlV3I/qVdvtRzmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWBmuLNzFFEmTF6d+T26i80TFogJxnRvUSZ8R+nyJrw=;
	b=icGz/vVNIoKPpJWQrFosEy1YfHYbQWIsAhFO6ZYk1w14MFiCCg2O78QOD7H/NYv9fK9rMT
	6pBuOFKci3fwZPCQ==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/itmt: Use guard() for itmt_update_mutex
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241223043407.1611-3-kprateek.nayak@amd.com>
References: <20241223043407.1611-3-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263737.31546.15433425491969887556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fc1055d5334f1808e3e445592a83f31624b953f1
Gitweb:        https://git.kernel.org/tip/fc1055d5334f1808e3e445592a83f31624b953f1
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 23 Dec 2024 04:34:01 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:23 +01:00

x86/itmt: Use guard() for itmt_update_mutex

Use guard() for itmt_update_mutex which avoids the extra mutex_unlock()
in the bailout and return paths.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lore.kernel.org/r/20241223043407.1611-3-kprateek.nayak@amd.com
---
 arch/x86/kernel/itmt.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 28f4491..ee43d1b 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -44,12 +44,10 @@ static int sched_itmt_update_handler(const struct ctl_table *table, int write,
 	unsigned int old_sysctl;
 	int ret;
 
-	mutex_lock(&itmt_update_mutex);
+	guard(mutex)(&itmt_update_mutex);
 
-	if (!sched_itmt_capable) {
-		mutex_unlock(&itmt_update_mutex);
+	if (!sched_itmt_capable)
 		return -EINVAL;
-	}
 
 	old_sysctl = sysctl_sched_itmt_enabled;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
@@ -59,8 +57,6 @@ static int sched_itmt_update_handler(const struct ctl_table *table, int write,
 		rebuild_sched_domains();
 	}
 
-	mutex_unlock(&itmt_update_mutex);
-
 	return ret;
 }
 
@@ -97,18 +93,14 @@ static struct ctl_table_header *itmt_sysctl_header;
  */
 int sched_set_itmt_support(void)
 {
-	mutex_lock(&itmt_update_mutex);
+	guard(mutex)(&itmt_update_mutex);
 
-	if (sched_itmt_capable) {
-		mutex_unlock(&itmt_update_mutex);
+	if (sched_itmt_capable)
 		return 0;
-	}
 
 	itmt_sysctl_header = register_sysctl("kernel", itmt_kern_table);
-	if (!itmt_sysctl_header) {
-		mutex_unlock(&itmt_update_mutex);
+	if (!itmt_sysctl_header)
 		return -ENOMEM;
-	}
 
 	sched_itmt_capable = true;
 
@@ -117,8 +109,6 @@ int sched_set_itmt_support(void)
 	x86_topology_update = true;
 	rebuild_sched_domains();
 
-	mutex_unlock(&itmt_update_mutex);
-
 	return 0;
 }
 
@@ -134,12 +124,11 @@ int sched_set_itmt_support(void)
  */
 void sched_clear_itmt_support(void)
 {
-	mutex_lock(&itmt_update_mutex);
+	guard(mutex)(&itmt_update_mutex);
 
-	if (!sched_itmt_capable) {
-		mutex_unlock(&itmt_update_mutex);
+	if (!sched_itmt_capable)
 		return;
-	}
+
 	sched_itmt_capable = false;
 
 	if (itmt_sysctl_header) {
@@ -153,8 +142,6 @@ void sched_clear_itmt_support(void)
 		x86_topology_update = true;
 		rebuild_sched_domains();
 	}
-
-	mutex_unlock(&itmt_update_mutex);
 }
 
 int arch_asym_cpu_priority(int cpu)

