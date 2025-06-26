Return-Path: <linux-tip-commits+bounces-5935-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E445BAEA91A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 23:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A852177FC5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6343E265CDD;
	Thu, 26 Jun 2025 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XpQuh+fm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XHqi6Xpc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CA2609CC;
	Thu, 26 Jun 2025 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750974949; cv=none; b=HG9K4RphXiB0F/gMmoNtzP4DfYKm5rhEj6S8hn4nCbFHuDHn1MDEp6+2KfpNkQoNOfrHSSJLO6aulwSb+fpxmcQF5/uYQdHVwSUqnBpSteASjfoU/rbO/Lrcx4k9Eyqn8WLz4EOccppGehWn/GmB/QvhRhUyMGsVMK/7GO5uTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750974949; c=relaxed/simple;
	bh=44zLjyBrBTrqSEcxLxx0JKmO4LE26LPnAzbjp3r0+qk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VaUA+syQ8Dj/7vFNwV7ON9SxLmSL9CzDuI9dEM4VSBMCjnWbgTCFHCFoVJ0K+uz0jhvSEuQSr/0mE9GE4k15ZsKuZUWAsGFwAO/77y4OwIl5md1g6v3kVdv6yywWeicde1d8Aa+u0bN/A6qP64IiTE6ROAm+wf1EXqcvdd0WMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XpQuh+fm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XHqi6Xpc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 21:55:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750974946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw+7rRd+WS2MBwzuOS8McUEU5JxO/trDXTNgqniF0m0=;
	b=XpQuh+fmQ31h8z1XQ/RDM3HBpoAsfxpnbpmlqZAlRciTH4n/hQ/8IuCPyLGMfxgb/51N0x
	Xl1p5egEF2okFZlI+mWMTwkF5Becrdx2ET1pLxNJB4KsgpmPawOept1YTCLH2punW6y696
	bSsKlZ0gQi2oGRMxCi+9OCjYqCTQ4UkpKm7c1BX1KtYd+HLROb8YUvaY8fgWqhqu13Oe0N
	g4jhrWhscOLJqqne3aLJd0aZDlBlR2mfL9Av9LHvksFACfHTpJ6P8oOF6q35suc9VVF/E7
	OXmm1mf+t3+LWw2lAZcO7ukleAjGV+S+Nx/9dG57C+Y4FJGTf8Q0kKF74SRxyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750974946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw+7rRd+WS2MBwzuOS8McUEU5JxO/trDXTNgqniF0m0=;
	b=XHqi6Xpcoiu9KlGN6drsYSZIE2AoChb8r04f9SUjOw49uvonN8OaX7loSdQnS03wfWKvp/
	9baPsBShFUDVyWBA==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Improve locality in smp_call_function_any()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250623000010.10124-2-yury.norov@gmail.com>
References: <20250623000010.10124-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175097494507.406.15997424702190501157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     5f295519b42f100c735a1e8e1a70060e26f30c3f
Gitweb:        https://git.kernel.org/tip/5f295519b42f100c735a1e8e1a70060e26f30c3f
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Sun, 22 Jun 2025 20:00:06 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 23:46:34 +02:00

smp: Improve locality in smp_call_function_any()

smp_call_function_any() tries to make a local call as it's the cheapest
option, or switches to a CPU in the same node. If it's not possible, the
algorithm gives up and searches for any CPU, in a numerical order.

Instead, it can search for the best CPU based on NUMA locality, including
the 2nd nearest hop (a set of equidistant nodes), and higher.

sched_numa_find_nth_cpu() does exactly that, and also helps to drop most
of the housekeeping code.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250623000010.10124-2-yury.norov@gmail.com

---
 kernel/smp.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3..7c8cfab 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -741,32 +741,19 @@ EXPORT_SYMBOL_GPL(smp_call_function_single_async);
  *
  * Selection preference:
  *	1) current cpu if in @mask
- *	2) any cpu of current node if in @mask
- *	3) any other online cpu in @mask
+ *	2) nearest cpu in @mask, based on NUMA topology
  */
 int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait)
 {
 	unsigned int cpu;
-	const struct cpumask *nodemask;
 	int ret;
 
 	/* Try for same CPU (cheapest) */
 	cpu = get_cpu();
-	if (cpumask_test_cpu(cpu, mask))
-		goto call;
-
-	/* Try for same node. */
-	nodemask = cpumask_of_node(cpu_to_node(cpu));
-	for (cpu = cpumask_first_and(nodemask, mask); cpu < nr_cpu_ids;
-	     cpu = cpumask_next_and(cpu, nodemask, mask)) {
-		if (cpu_online(cpu))
-			goto call;
-	}
+	if (!cpumask_test_cpu(cpu, mask))
+		cpu = sched_numa_find_nth_cpu(mask, 0, cpu_to_node(cpu));
 
-	/* Any online will do: smp_call_function_single handles nr_cpu_ids. */
-	cpu = cpumask_any_and(mask, cpu_online_mask);
-call:
 	ret = smp_call_function_single(cpu, func, info, wait);
 	put_cpu();
 	return ret;

