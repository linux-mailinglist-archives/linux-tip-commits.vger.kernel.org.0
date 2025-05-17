Return-Path: <linux-tip-commits+bounces-5659-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD84EABA970
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801CF189F101
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1EF2116FB;
	Sat, 17 May 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xYVNHlul";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eMqYhcdN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074720E6EB;
	Sat, 17 May 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476191; cv=none; b=VJT5Q8EzGC+eS/Q8iJ2/G3NLhh7CK3Vet20jzNPQ0wXFQxt79PHkk/o7+8l6+s4ocQhHnxZvJzG5yxHWbpOXsUWpjeLNPTyUI5DQ80Zd///dQpIP1LFuSJ2wR101mh34/k+Ha1xN7ul/xftzkvYFkna7O71DZxTpZNZTG9NdPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476191; c=relaxed/simple;
	bh=2ybJlWpR/QuJvABpkIJlXTk6kMLfJLGf6FCwF8WG4eA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S+3qeJdL+Lp9cLGbBxYQu6CPhQVvbHAsdVzNXlx0MOxPp3NyskMC4vIyHX9shjGhUuzKms9I/oDdbJ5lrgNsZjM4qUFMjwpGMkgtWn6FqGYdo9CU1fIdk1yprFL1pQVIkkqFL18hetfht7aMuKgd2dF3Y71uBhkVmBDuehnjSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xYVNHlul; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eMqYhcdN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuUn8cKqOTjuNEfHp2yj+KO26bLMTTxbTLo3jLLSwdE=;
	b=xYVNHlull3gxEVwSaYEvDNPyGEIf5O4yDX1FJ1GwVqb8MuX6qi0/eKMkZX/p/Rsmz/hMuW
	E+9A5eF0htQ+n1m44lqMCbEK5BA8/ux2gePvDNLhQbAxf+NyeL5a+dONdJsDFGTa63Mk+Z
	tMA+djaUVSR7N+Lk5RsxnkEcb6NVK4va9EdM+/NkoXDmMW3cV9m14yOYnfdkrnSZpiGKNj
	K3u7SRODB6Cei8Dq2mscy4a/cCR5tkzBR6x7fTd1EiZV9LGObwXxDcwHZ4qQeNq+8IE5J8
	9pahMyMLcliSAyqhKJBNPz58i6clgUKYJ1sLuIO0VrHFvk8tcZzrVeVUU2u1Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuUn8cKqOTjuNEfHp2yj+KO26bLMTTxbTLo3jLLSwdE=;
	b=eMqYhcdNA49GAKs5sjWe1NtTpsJcT0zfqLtloHGB+Xux0hi8tJaMLpBtIuEBQlRFi6tzCx
	+JgnvgQAHCf0svCg==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] cpumask: Relax cpumask_any_but()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-2-james.morse@arm.com>
References: <20250515165855.31452-2-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618717.406.10177537461146320578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     189572bf4e005431051319def435ac4b7e4489ca
Gitweb:        https://git.kernel.org/tip/189572bf4e005431051319def435ac4b7e4489ca
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Thu, 15 May 2025 16:58:31 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 20:24:22 +02:00

cpumask: Relax cpumask_any_but()

Similarly to other cpumask search functions, accept -1, and consider it as
'any CPU' hint. This helps users to avoid coding special cases.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: James Morse <james.morse@arm.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Link: https://lore.kernel.org/20250515165855.31452-2-james.morse@arm.com
---
 include/linux/cpumask.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f9a8683..a3ee875 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -413,14 +413,18 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *src)
  * @cpu: the cpu to ignore.
  *
  * Often used to find any cpu but smp_processor_id() in a mask.
+ * If @cpu == -1, the function is equivalent to cpumask_any().
  * Return: >= nr_cpu_ids if no cpus set.
  */
 static __always_inline
-unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
+unsigned int cpumask_any_but(const struct cpumask *mask, int cpu)
 {
 	unsigned int i;
 
-	cpumask_check(cpu);
+	/* -1 is a legal arg here. */
+	if (cpu != -1)
+		cpumask_check(cpu);
+
 	for_each_cpu(i, mask)
 		if (i != cpu)
 			break;
@@ -433,16 +437,20 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
  * @mask2: the second input cpumask
  * @cpu: the cpu to ignore
  *
+ * If @cpu == -1, the function is equivalent to cpumask_any_and().
  * Returns >= nr_cpu_ids if no cpus set.
  */
 static __always_inline
 unsigned int cpumask_any_and_but(const struct cpumask *mask1,
 				 const struct cpumask *mask2,
-				 unsigned int cpu)
+				 int cpu)
 {
 	unsigned int i;
 
-	cpumask_check(cpu);
+	/* -1 is a legal arg here. */
+	if (cpu != -1)
+		cpumask_check(cpu);
+
 	i = cpumask_first_and(mask1, mask2);
 	if (i != cpu)
 		return i;

