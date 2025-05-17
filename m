Return-Path: <linux-tip-commits+bounces-5657-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD52FABA96B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428977B3CCF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206720FABA;
	Sat, 17 May 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i6Sn81hd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBHnh6+R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1B20CCFB;
	Sat, 17 May 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476190; cv=none; b=ClOyUuvJ6k52rZVd45aUqMJw70tQKtrb/8SfCrxogkFFlwxeuYCjhsNGEs7kcev/qsUYXVINw2buaYFiVpg9ChKrT3i41JPEPL74RxzaKgIM6MJpROFUG6jn9UYOzDqUJD9NiTfTVqsSZKn9n5fBUUPDXDccYy258gnROfDPvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476190; c=relaxed/simple;
	bh=+ByLNUY9BARlG8/OI9oLC6lUZ7+Qvhl2nHWrjSen7B8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SgUuw4MHEJ0W05k2aT9StPOPtlseV/DoCSPBvc+ARmJYA+ERJurnS7pdUA8BA/AaRHjBtBHWEvoAlvBQiexcq7MjPYrduwGPoCrJyOMnQykZg1br1JTiE93/wlNCUb56sNSAjNr2Q+8pt5xpac869UitFSggP7xTVWKpyT8NeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i6Sn81hd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBHnh6+R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qy294dlJYKQysDPIelSeBL8/StbXRNQiEwJ6lE8SHr4=;
	b=i6Sn81hdhqt6/b08bACeHcrJD89dk6PDV4XF1xN0mCUAzozHYt6R77bRZGKMLSawVOhiWY
	WI/Dm1KrEEhBsXAAdvD8Ae4/dzIdPO2Wcnj/DnRHchOr7ewbttnEcjC1eB1BayH1arMFes
	h8Sk+J8T0qOnwFogB1Stz7P6TaEuDHQQKlzfSB8uEhTsbLZ5Eovrvdfg1vZINfXgiwv4c6
	/pvIplDTrLrusT9yB15XZpML70AxkXOYokin9aAtdaRz0yRRVQi3Wt75sss9uoXjJvrYbG
	DMmfJhmxG0T+krnlgzBYnr7MWdzleAlzH50wvadqFbpy/IOuGCGNdXF0hF4+Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qy294dlJYKQysDPIelSeBL8/StbXRNQiEwJ6lE8SHr4=;
	b=DBHnh6+Rsmedi//UXUm+PWdma34cW7Yl87ImSzPUCIxgE86OAZb+xfV28Y4pFFS7CyevHo
	oEE0L8rjRPfMR4DA==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] cpumask: Add cpumask_{first,next}_andnot() API
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-4-james.morse@arm.com>
References: <20250515165855.31452-4-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618564.406.16412301340914355967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     5da703ef4e4a82b2f9a00f2b3a1eae5657e68a92
Gitweb:        https://git.kernel.org/tip/5da703ef4e4a82b2f9a00f2b3a1eae5657e68a92
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Thu, 15 May 2025 16:58:33 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 20:28:12 +02:00

cpumask: Add cpumask_{first,next}_andnot() API

With the lack of the functions, client code has to abuse less efficient
cpumask_nth().

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: James Morse <james.morse@arm.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-4-james.morse@arm.com
---
 include/linux/cpumask.h | 59 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index a3ee875..6a569c7 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -179,6 +179,19 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
 }
 
 /**
+ * cpumask_first_andnot - return the first cpu from *srcp1 & ~*srcp2
+ * @srcp1: the first input
+ * @srcp2: the second input
+ *
+ * Return: >= nr_cpu_ids if no such cpu found.
+ */
+static __always_inline
+unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
+}
+
+/**
  * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
  * @srcp1: the first input
  * @srcp2: the second input
@@ -285,6 +298,25 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 }
 
 /**
+ * cpumask_next_andnot - get the next cpu in *src1p & ~*src2p
+ * @n: the cpu prior to the place to search (i.e. return will be > @n)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if no further cpus set in both.
+ */
+static __always_inline
+unsigned int cpumask_next_andnot(int n, const struct cpumask *src1p,
+				 const struct cpumask *src2p)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_andnot_bit(cpumask_bits(src1p), cpumask_bits(src2p),
+		small_cpumask_bits, n + 1);
+}
+
+/**
  * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
  *			   @n+1. If nothing found, wrap around and start from
  *			   the beginning
@@ -459,6 +491,33 @@ unsigned int cpumask_any_and_but(const struct cpumask *mask1,
 }
 
 /**
+ * cpumask_any_andnot_but - pick an arbitrary cpu from *mask1 & ~*mask2, but not this one.
+ * @mask1: the first input cpumask
+ * @mask2: the second input cpumask
+ * @cpu: the cpu to ignore
+ *
+ * If @cpu == -1, the function returns the first matching cpu.
+ * Returns >= nr_cpu_ids if no cpus set.
+ */
+static __always_inline
+unsigned int cpumask_any_andnot_but(const struct cpumask *mask1,
+				    const struct cpumask *mask2,
+				    int cpu)
+{
+	unsigned int i;
+
+	/* -1 is a legal arg here. */
+	if (cpu != -1)
+		cpumask_check(cpu);
+
+	i = cpumask_first_andnot(mask1, mask2);
+	if (i != cpu)
+		return i;
+
+	return cpumask_next_andnot(cpu, mask1, mask2);
+}
+
+/**
  * cpumask_nth - get the Nth cpu in a cpumask
  * @srcp: the cpumask pointer
  * @cpu: the Nth cpu to find, starting from 0

