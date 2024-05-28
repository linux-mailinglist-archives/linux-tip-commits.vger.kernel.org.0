Return-Path: <linux-tip-commits+bounces-1302-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C50518D22F7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 20:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3993BB234D0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DC6482F6;
	Tue, 28 May 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NGy7IdSe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wl2GaFUv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A145BE3;
	Tue, 28 May 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919511; cv=none; b=PZY3FRsWM9xXnnzo/f29s2yTolRwC0xrst6DYuNBwaOGhB3qqChuwyDzUD0EI2dPn+uAefXo+k8k1RYZNg/RcxPrCsnYsA7S3QwfIy+i68t7CZIWqa+RCkbedEiMV3HAH9DbGLJ7RkGYNNMPXRora4AmXFpgcmX0Q6Y50y0ZBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919511; c=relaxed/simple;
	bh=gf8HfaWUs8lva9RzIFhkItpAMu8uT86Y3bpiE4FE9rU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=JCsS4Me3ULBKMrsFK/mO8Ot61gBODyqzdIy/Nlz36qR8yswOi4cGyeolyvP/Asa7ioifGP69wCYoHNNBcqT0OTEfGDEHqZyozthlMvOe+DLfUtJ+jHafc9MqBtGSRP68QtoW7nYgQy0k/eOGwtohhaV5jCIRqw/ufQ3Kt+vse/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NGy7IdSe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wl2GaFUv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 18:05:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Ytc86M+kcM6yGuB1biJtZsIracxGk/rNgeeigq//YWs=;
	b=NGy7IdSeAB2zYy38rmuscLNM/a3RGnKDDMe20cs9BLZ5oQqjSC9lxsUqSCe9ufQrYIoQ4E
	AAdJlprCaun/fBCwCj6g0289HQrGB3EtjItr9gqFofxEC2Y2oxIvG3CKYBoveAh6r36IkM
	KMobXYqvy1sR0J4CKnIAPb+DdEjvEqK6QCtQFoCT9DrL3/7Cva3omceLvD97O8yPoC/9FZ
	okWMS65FeEOiS7cYR3zgvJpbiJgfP6tZYgZIwBEaGzptbxjYpOl7pCCBsRIjaqtQvBV7Sn
	XkI6W3k4QZmTIa71Z3YRDbELmA2KKVXe/xYakURPOwPbYrpLrdXhTEqOzsCmfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Ytc86M+kcM6yGuB1biJtZsIracxGk/rNgeeigq//YWs=;
	b=wl2GaFUvgwIP8MZx61mYVnbNw3F1mcEC1Q7A0gsyEWbTIzGsWYVH0uKpTsFUq8IG04LhIj
	u49uzk8ahToS0YBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] perf/x86/intel: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171691950734.10875.9603955189450613351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d142df13f3574237688c7a20e0019cccc7ae39eb
Gitweb:        https://git.kernel.org/tip/d142df13f3574237688c7a20e0019cccc7ae39eb
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 20 May 2024 15:46:02 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 May 2024 10:59:02 -07:00

perf/x86/intel: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240520224620.9480-32-tony.luck%40intel.com
---
 arch/x86/events/intel/core.c | 148 +++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f..7f7f1c3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4698,8 +4698,8 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs);
 static inline bool intel_pmu_broken_perf_cap(void)
 {
 	/* The Perf Metric (Bit 15) is always cleared */
-	if ((boot_cpu_data.x86_model == INTEL_FAM6_METEORLAKE) ||
-	    (boot_cpu_data.x86_model == INTEL_FAM6_METEORLAKE_L))
+	if (boot_cpu_data.x86_vfm == INTEL_METEORLAKE ||
+	    boot_cpu_data.x86_vfm == INTEL_METEORLAKE_L)
 		return true;
 
 	return false;
@@ -6238,19 +6238,19 @@ __init int intel_pmu_init(void)
 	/*
 	 * Install the hw-cache-events table:
 	 */
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_CORE_YONAH:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_CORE_YONAH:
 		pr_cont("Core events, ");
 		name = "core";
 		break;
 
-	case INTEL_FAM6_CORE2_MEROM:
+	case INTEL_CORE2_MEROM:
 		x86_add_quirk(intel_clovertown_quirk);
 		fallthrough;
 
-	case INTEL_FAM6_CORE2_MEROM_L:
-	case INTEL_FAM6_CORE2_PENRYN:
-	case INTEL_FAM6_CORE2_DUNNINGTON:
+	case INTEL_CORE2_MEROM_L:
+	case INTEL_CORE2_PENRYN:
+	case INTEL_CORE2_DUNNINGTON:
 		memcpy(hw_cache_event_ids, core2_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 
@@ -6262,9 +6262,9 @@ __init int intel_pmu_init(void)
 		name = "core2";
 		break;
 
-	case INTEL_FAM6_NEHALEM:
-	case INTEL_FAM6_NEHALEM_EP:
-	case INTEL_FAM6_NEHALEM_EX:
+	case INTEL_NEHALEM:
+	case INTEL_NEHALEM_EP:
+	case INTEL_NEHALEM_EX:
 		memcpy(hw_cache_event_ids, nehalem_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, nehalem_hw_cache_extra_regs,
@@ -6296,11 +6296,11 @@ __init int intel_pmu_init(void)
 		name = "nehalem";
 		break;
 
-	case INTEL_FAM6_ATOM_BONNELL:
-	case INTEL_FAM6_ATOM_BONNELL_MID:
-	case INTEL_FAM6_ATOM_SALTWELL:
-	case INTEL_FAM6_ATOM_SALTWELL_MID:
-	case INTEL_FAM6_ATOM_SALTWELL_TABLET:
+	case INTEL_ATOM_BONNELL:
+	case INTEL_ATOM_BONNELL_MID:
+	case INTEL_ATOM_SALTWELL:
+	case INTEL_ATOM_SALTWELL_MID:
+	case INTEL_ATOM_SALTWELL_TABLET:
 		memcpy(hw_cache_event_ids, atom_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 
@@ -6313,11 +6313,11 @@ __init int intel_pmu_init(void)
 		name = "bonnell";
 		break;
 
-	case INTEL_FAM6_ATOM_SILVERMONT:
-	case INTEL_FAM6_ATOM_SILVERMONT_D:
-	case INTEL_FAM6_ATOM_SILVERMONT_MID:
-	case INTEL_FAM6_ATOM_AIRMONT:
-	case INTEL_FAM6_ATOM_AIRMONT_MID:
+	case INTEL_ATOM_SILVERMONT:
+	case INTEL_ATOM_SILVERMONT_D:
+	case INTEL_ATOM_SILVERMONT_MID:
+	case INTEL_ATOM_AIRMONT:
+	case INTEL_ATOM_AIRMONT_MID:
 		memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
 			sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, slm_hw_cache_extra_regs,
@@ -6335,8 +6335,8 @@ __init int intel_pmu_init(void)
 		name = "silvermont";
 		break;
 
-	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GOLDMONT_D:
+	case INTEL_ATOM_GOLDMONT:
+	case INTEL_ATOM_GOLDMONT_D:
 		memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
@@ -6362,7 +6362,7 @@ __init int intel_pmu_init(void)
 		name = "goldmont";
 		break;
 
-	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_ATOM_GOLDMONT_PLUS:
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
@@ -6391,9 +6391,9 @@ __init int intel_pmu_init(void)
 		name = "goldmont_plus";
 		break;
 
-	case INTEL_FAM6_ATOM_TREMONT_D:
-	case INTEL_FAM6_ATOM_TREMONT:
-	case INTEL_FAM6_ATOM_TREMONT_L:
+	case INTEL_ATOM_TREMONT_D:
+	case INTEL_ATOM_TREMONT:
+	case INTEL_ATOM_TREMONT_L:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
@@ -6420,7 +6420,7 @@ __init int intel_pmu_init(void)
 		name = "Tremont";
 		break;
 
-	case INTEL_FAM6_ATOM_GRACEMONT:
+	case INTEL_ATOM_GRACEMONT:
 		intel_pmu_init_grt(NULL);
 		intel_pmu_pebs_data_source_grt();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
@@ -6432,8 +6432,8 @@ __init int intel_pmu_init(void)
 		name = "gracemont";
 		break;
 
-	case INTEL_FAM6_ATOM_CRESTMONT:
-	case INTEL_FAM6_ATOM_CRESTMONT_X:
+	case INTEL_ATOM_CRESTMONT:
+	case INTEL_ATOM_CRESTMONT_X:
 		intel_pmu_init_grt(NULL);
 		x86_pmu.extra_regs = intel_cmt_extra_regs;
 		intel_pmu_pebs_data_source_cmt();
@@ -6446,9 +6446,9 @@ __init int intel_pmu_init(void)
 		name = "crestmont";
 		break;
 
-	case INTEL_FAM6_WESTMERE:
-	case INTEL_FAM6_WESTMERE_EP:
-	case INTEL_FAM6_WESTMERE_EX:
+	case INTEL_WESTMERE:
+	case INTEL_WESTMERE_EP:
+	case INTEL_WESTMERE_EX:
 		memcpy(hw_cache_event_ids, westmere_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, nehalem_hw_cache_extra_regs,
@@ -6477,8 +6477,8 @@ __init int intel_pmu_init(void)
 		name = "westmere";
 		break;
 
-	case INTEL_FAM6_SANDYBRIDGE:
-	case INTEL_FAM6_SANDYBRIDGE_X:
+	case INTEL_SANDYBRIDGE:
+	case INTEL_SANDYBRIDGE_X:
 		x86_add_quirk(intel_sandybridge_quirk);
 		x86_add_quirk(intel_ht_bug);
 		memcpy(hw_cache_event_ids, snb_hw_cache_event_ids,
@@ -6491,7 +6491,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.event_constraints = intel_snb_event_constraints;
 		x86_pmu.pebs_constraints = intel_snb_pebs_event_constraints;
 		x86_pmu.pebs_aliases = intel_pebs_aliases_snb;
-		if (boot_cpu_data.x86_model == INTEL_FAM6_SANDYBRIDGE_X)
+		if (boot_cpu_data.x86_vfm == INTEL_SANDYBRIDGE_X)
 			x86_pmu.extra_regs = intel_snbep_extra_regs;
 		else
 			x86_pmu.extra_regs = intel_snb_extra_regs;
@@ -6517,8 +6517,8 @@ __init int intel_pmu_init(void)
 		name = "sandybridge";
 		break;
 
-	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_IVYBRIDGE_X:
+	case INTEL_IVYBRIDGE:
+	case INTEL_IVYBRIDGE_X:
 		x86_add_quirk(intel_ht_bug);
 		memcpy(hw_cache_event_ids, snb_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
@@ -6534,7 +6534,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_constraints = intel_ivb_pebs_event_constraints;
 		x86_pmu.pebs_aliases = intel_pebs_aliases_ivb;
 		x86_pmu.pebs_prec_dist = true;
-		if (boot_cpu_data.x86_model == INTEL_FAM6_IVYBRIDGE_X)
+		if (boot_cpu_data.x86_vfm == INTEL_IVYBRIDGE_X)
 			x86_pmu.extra_regs = intel_snbep_extra_regs;
 		else
 			x86_pmu.extra_regs = intel_snb_extra_regs;
@@ -6556,10 +6556,10 @@ __init int intel_pmu_init(void)
 		break;
 
 
-	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_G:
+	case INTEL_HASWELL:
+	case INTEL_HASWELL_X:
+	case INTEL_HASWELL_L:
+	case INTEL_HASWELL_G:
 		x86_add_quirk(intel_ht_bug);
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
@@ -6589,10 +6589,10 @@ __init int intel_pmu_init(void)
 		name = "haswell";
 		break;
 
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_D:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_BROADWELL_X:
+	case INTEL_BROADWELL:
+	case INTEL_BROADWELL_D:
+	case INTEL_BROADWELL_G:
+	case INTEL_BROADWELL_X:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -6631,8 +6631,8 @@ __init int intel_pmu_init(void)
 		name = "broadwell";
 		break;
 
-	case INTEL_FAM6_XEON_PHI_KNL:
-	case INTEL_FAM6_XEON_PHI_KNM:
+	case INTEL_XEON_PHI_KNL:
+	case INTEL_XEON_PHI_KNM:
 		memcpy(hw_cache_event_ids,
 		       slm_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs,
@@ -6651,15 +6651,15 @@ __init int intel_pmu_init(void)
 		name = "knights-landing";
 		break;
 
-	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_SKYLAKE_X:
 		pmem = true;
 		fallthrough;
-	case INTEL_FAM6_SKYLAKE_L:
-	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
-	case INTEL_FAM6_COMETLAKE_L:
-	case INTEL_FAM6_COMETLAKE:
+	case INTEL_SKYLAKE_L:
+	case INTEL_SKYLAKE:
+	case INTEL_KABYLAKE_L:
+	case INTEL_KABYLAKE:
+	case INTEL_COMETLAKE_L:
+	case INTEL_COMETLAKE:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -6708,16 +6708,16 @@ __init int intel_pmu_init(void)
 		name = "skylake";
 		break;
 
-	case INTEL_FAM6_ICELAKE_X:
-	case INTEL_FAM6_ICELAKE_D:
+	case INTEL_ICELAKE_X:
+	case INTEL_ICELAKE_D:
 		x86_pmu.pebs_ept = 1;
 		pmem = true;
 		fallthrough;
-	case INTEL_FAM6_ICELAKE_L:
-	case INTEL_FAM6_ICELAKE:
-	case INTEL_FAM6_TIGERLAKE_L:
-	case INTEL_FAM6_TIGERLAKE:
-	case INTEL_FAM6_ROCKETLAKE:
+	case INTEL_ICELAKE_L:
+	case INTEL_ICELAKE:
+	case INTEL_TIGERLAKE_L:
+	case INTEL_TIGERLAKE:
+	case INTEL_ROCKETLAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
@@ -6752,13 +6752,13 @@ __init int intel_pmu_init(void)
 		name = "icelake";
 		break;
 
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_EMERALDRAPIDS_X:
+	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.extra_regs = intel_glc_extra_regs;
 		fallthrough;
-	case INTEL_FAM6_GRANITERAPIDS_X:
-	case INTEL_FAM6_GRANITERAPIDS_D:
+	case INTEL_GRANITERAPIDS_X:
+	case INTEL_GRANITERAPIDS_D:
 		intel_pmu_init_glc(NULL);
 		if (!x86_pmu.extra_regs)
 			x86_pmu.extra_regs = intel_rwc_extra_regs;
@@ -6776,11 +6776,11 @@ __init int intel_pmu_init(void)
 		name = "sapphire_rapids";
 		break;
 
-	case INTEL_FAM6_ALDERLAKE:
-	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_RAPTORLAKE:
-	case INTEL_FAM6_RAPTORLAKE_P:
-	case INTEL_FAM6_RAPTORLAKE_S:
+	case INTEL_ALDERLAKE:
+	case INTEL_ALDERLAKE_L:
+	case INTEL_RAPTORLAKE:
+	case INTEL_RAPTORLAKE_P:
+	case INTEL_RAPTORLAKE_S:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
@@ -6838,8 +6838,8 @@ __init int intel_pmu_init(void)
 		name = "alderlake_hybrid";
 		break;
 
-	case INTEL_FAM6_METEORLAKE:
-	case INTEL_FAM6_METEORLAKE_L:
+	case INTEL_METEORLAKE:
+	case INTEL_METEORLAKE_L:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
 		x86_pmu.pebs_latency_data = mtl_latency_data_small;

