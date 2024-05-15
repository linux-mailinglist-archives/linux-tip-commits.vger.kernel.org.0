Return-Path: <linux-tip-commits+bounces-1257-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CBC8C62DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 May 2024 10:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAFB1F21185
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 May 2024 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531EA4F88C;
	Wed, 15 May 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s22HlCf6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i5K/s5a8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964F4F1E2;
	Wed, 15 May 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761683; cv=none; b=RZTnYfG8Edl49a+OhbFtNaSh5+h5TUuJBs+H3ZctBnhb1YK7lS9triPEWt88j5aLpngB1edhMYA/5mmowgfYEzqAp1Plzsh5+mXR2Vqsql2CK82l8VlVnkqDzjNA3Sb0IcDqRLL0KaiUkmoVuoU/QYffOg5cE98bLxOuSn+u92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761683; c=relaxed/simple;
	bh=TaBpvCXyVXCLluWt3oSvvI3u62844mjY3sXTsdCCQww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TqeTCp+bIZc4In2dbCtBYRKIVbQRXDWmN3mGVPmvuiCyru3r7xpRapJlpLNH44C4Aj+RJuxq3/JRnS1+WDw3ZnGSoym0stnxoXafzQ+yakwG7U+xJMKvjnKCfSZ1PeHwuizufXxkuhlMyD3/2guV5gHcgcqvz+yHscrYaa6+n50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s22HlCf6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i5K/s5a8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 May 2024 08:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715761673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MLBMflH6V1beYLEOpcr8SjmKUf1+Bmzp4Nn9lxHYoQ=;
	b=s22HlCf6jqzmAfHEyr9HV5qNO4E1+vWyGudTlk8Z2U9BeYj75cCYKilzEHnFw+ADL6OwjK
	9wrjGBkqSGVXI56Pe93Bx63xJniS+3Z5brgOhGvxmFp3Hcy9FFQ/INA0cp1ZSKT/UIzUkw
	OrVHrMaegGosVoMYVAUosyrIaVzfHkwb3jUutB9H16+PFoAEObra4EFSyliJ7J67ZTp6IS
	8XKQ/RPUWcis9MRC9n7BdL+NKGS+nV4U0ho6xXLzGTGROGvzHy143+/Acau/ngBwMMR1sf
	Kz/8bbXpZG70iwSYhVakT3B8WCYGKskmeOwuCAlNgmzoI16TeZp/mLKUr6husw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715761673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MLBMflH6V1beYLEOpcr8SjmKUf1+Bmzp4Nn9lxHYoQ=;
	b=i5K/s5a8KMUXvA5psWcp8veB7dGRczpbFGcabKR1Fk6XE/HBLhs46JLi+km6Xrt7eCgu1Q
	Hc0/F037ny0VZGDA==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] arch/topology: Fix variable naming to avoid shadowing
Cc: kernel test robot <lkp@intel.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240425073709.379016-1-vincent.guittot@linaro.org>
References: <20240425073709.379016-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171576167329.10875.14382447662148651409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e5bc44e47c531860be96ac615314b1ab23d5aa2b
Gitweb:        https://git.kernel.org/tip/e5bc44e47c531860be96ac615314b1ab23d5aa2b
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 25 Apr 2024 09:37:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 15 May 2024 10:22:16 +02:00

arch/topology: Fix variable naming to avoid shadowing

Using 'hw_pressure' for local variable name is confusing in regard to the
per-CPU 'hw_pressure' variable that uses the same name:

  include/linux/arch_topology.h:DECLARE_PER_CPU(unsigned long, hw_pressure);

.. which puts it into a global scope for all code that includes
<linux/topology.h>, shadowing the local variable.

Rename it to avoid compiler confusion & Sparse warnings.

[ mingo: Expanded the changelog. ]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240425073709.379016-1-vincent.guittot@linaro.org
Closes: https://lore.kernel.org/oe-kbuild-all/202404250740.VhQQoD7N-lkp@intel.com/
Fixes: d4dbc991714e ("sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()")
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # QC SM8550 QRD
---
 drivers/base/arch_topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0248912..c66d070 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -179,7 +179,7 @@ DEFINE_PER_CPU(unsigned long, hw_pressure);
 void topology_update_hw_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
 {
-	unsigned long max_capacity, capacity, hw_pressure;
+	unsigned long max_capacity, capacity, pressure;
 	u32 max_freq;
 	int cpu;
 
@@ -196,12 +196,12 @@ void topology_update_hw_pressure(const struct cpumask *cpus,
 	else
 		capacity = mult_frac(max_capacity, capped_freq, max_freq);
 
-	hw_pressure = max_capacity - capacity;
+	pressure = max_capacity - capacity;
 
-	trace_hw_pressure_update(cpu, hw_pressure);
+	trace_hw_pressure_update(cpu, pressure);
 
 	for_each_cpu(cpu, cpus)
-		WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
+		WRITE_ONCE(per_cpu(hw_pressure, cpu), pressure);
 }
 EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
 

