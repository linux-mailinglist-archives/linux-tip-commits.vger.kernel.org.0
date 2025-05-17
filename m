Return-Path: <linux-tip-commits+bounces-5656-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D71ABA969
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4626BA03C78
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB8820E6E6;
	Sat, 17 May 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PbmlEDhF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TgcgZDcB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74820C497;
	Sat, 17 May 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476189; cv=none; b=SSpX7DjoR5f29nMuzQur1TQkoQxFmDoN8YNlUbZjywfovAvbSlXmqWi+YYeVutIfbMDSriLPMkZxna2GvQjdcFpQrSav5g0sc6Z1YebuXchb/QgP7YttONhmogTpSy1BkiMFWY5hkwWk4Sls3GZJ5PS55TXBgYqwV+MaBo2Dlbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476189; c=relaxed/simple;
	bh=cA1kLAPU1vVKxEQ4d9LEOobFFnPaUrobXxBCSKdDjNk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k53nEKP5pOw+ZDoGJnpV7dFwd2GSFS4VFn4mTX8VIKGW+HioqWvYSVUF8scKC/RlpjcxlBW5cBrKRhxEJUOn/0oPsI7ZtvJdSl6fkLw6m2ov5WlL7XFqoWdncVxMuyYhTISiSkEUvTGBOtxUDCfY6xOIKEXCUTRc63O+rMEduns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PbmlEDhF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TgcgZDcB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjsYwrwlN3CwHRanBaSt5hcGCPaPYClb6VSfsAvBctM=;
	b=PbmlEDhFOxUiFmUtlLw0twSbxRp+p71Bc2SxZvlgtczZ2brWVCgd23mtHZ7k6bwWT9MC6S
	H4zMKE/A8KLXsiCNKklnucqvSzrRH2yAhqY9ftPWEjJIAuxjygNAXNL+0qKTvZGKjvxIXu
	FgmXgNZXtAprnq68P7/qkWfCKdRre6THiMlCXxbsp5q4oiplszAVk+v7LgVKYF3AikuHOA
	bl9dXZ6Mi9SDe67LthwnVtkvjEx0B5dygUOGoXkTygC2+MDHbRHi7GMMGGMbPHDbUgi3lf
	0q6u0DmNzukuG26+tfkZ3aB0auda/M/7kMT54OSR9Z9LWdT269zqn/3k11H2IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjsYwrwlN3CwHRanBaSt5hcGCPaPYClb6VSfsAvBctM=;
	b=TgcgZDcBV7xtQ1Vg0GIpdjigdd68C94RLothj2CwjaOmDzzyAHOpPffR8zhkPNzSyAbzpL
	FBpIH35aLIURM4BA==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Optimize cpumask_any_housekeeping()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-5-james.morse@arm.com>
References: <20250515165855.31452-5-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618489.406.16388124501789539670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     94f7531430285b4ec600693f7222c2ca29bd7472
Gitweb:        https://git.kernel.org/tip/94f7531430285b4ec600693f7222c2ca29bd7472
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Thu, 15 May 2025 16:58:34 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 20:53:26 +02:00

x86/resctrl: Optimize cpumask_any_housekeeping()

With the lack of cpumask_any_andnot_but(), cpumask_any_housekeeping()
has to abuse cpumask_nth() functions.

Update cpumask_any_housekeeping() to use the new cpumask_any_but()
and cpumask_any_andnot_but(). These two functions understand
RESCTRL_PICK_ANY_CPU, which simplifies cpumask_any_housekeeping()
significantly.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-5-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 28 ++++++-------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index eaae996..25b61e4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -47,30 +47,16 @@
 static inline unsigned int
 cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 {
-	unsigned int cpu, hk_cpu;
-
-	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
-		cpu = cpumask_any(mask);
-	else
-		cpu = cpumask_any_but(mask, exclude_cpu);
-
-	/* Only continue if tick_nohz_full_mask has been initialized. */
-	if (!tick_nohz_full_enabled())
-		return cpu;
-
-	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */
-	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
-		return cpu;
+	unsigned int cpu;
 
 	/* Try to find a CPU that isn't nohz_full to use in preference */
-	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
-	if (hk_cpu == exclude_cpu)
-		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
-
-	if (hk_cpu < nr_cpu_ids)
-		cpu = hk_cpu;
+	if (tick_nohz_full_enabled()) {
+		cpu = cpumask_any_andnot_but(mask, tick_nohz_full_mask, exclude_cpu);
+		if (cpu < nr_cpu_ids)
+			return cpu;
+	}
 
-	return cpu;
+	return cpumask_any_but(mask, exclude_cpu);
 }
 
 struct rdt_fs_context {

