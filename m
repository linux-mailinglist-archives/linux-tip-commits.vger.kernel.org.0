Return-Path: <linux-tip-commits+bounces-3331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C0A279B0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Feb 2025 19:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFA618872B7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Feb 2025 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165F21766E;
	Tue,  4 Feb 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LmZuY1o5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ceduz7hH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE178F4A;
	Tue,  4 Feb 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693515; cv=none; b=f9Bs4CPesx7QkYPz6WqeZLlBGChMZOIdnPPTbF6K/I/iTQrqnw5QdhgPqRnDtZzAAQtD+nlhBGV7qcfXP0loU+sfXDrfIZwUXx5sxQJ+mHDim5YAWfErjLEC64CiAd+sbhRr8UV5w/1ycgP3Mniq6o1QqYW9xmCkiRuYW4mpCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693515; c=relaxed/simple;
	bh=Ih/INvZDCjTqbRdtGwJE97I8DmetNY+nzTtRbY9RI4o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qliosSYWZDla5Q6DOOBIpNlheQxC/Xdn8xPTuvSDb5VOFNtgkKF3+0lp9y0Dnypodzpp7hNYeiQCxmbvpe1Wu8tKKivPb0GhKUxtNpfHsEsL+SzxWBCnHL8GlkwrRFmZHYR/fl08o/tVfK+RwoINXL5EZ6DdW94VKp6vH4SBN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LmZuY1o5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ceduz7hH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Feb 2025 18:25:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738693511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=h9tFbYkezPHVMN3uSKCz+iPyCmPBwmrlGejhZ4UlaJ4=;
	b=LmZuY1o5H3lZ+7aVcTWR4SWFDChZeRRc+tak0pFP6IA0phCRIZLpQ9UrGdtUi/hY6H1rFn
	pGRQqvfkhbzYwTIjlkll+3zpvfEqoi9dyY5ukMZpy012atr1XmreRKvJE+LTxXjKzwmrGf
	Ff6g1Gf73b6CwOmWuHCvOg0C7jPIVJWV4FXfb2EVq5r5OAnjjK84KWtw6kO0DQUsRI1Eao
	RHnWkRTJCiNM/aGrAYQDRYhm/Id7z9lWV4qNqq7jdAA8PCvKt7lDppHrNJgr64KUNWcopX
	JkmpxmE0t8BQDkl7XXqWZm223mTrLCFfBTVAwNuEXQjJf/DvmzT7G9RAeXWmhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738693511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=h9tFbYkezPHVMN3uSKCz+iPyCmPBwmrlGejhZ4UlaJ4=;
	b=Ceduz7hHoSEDDTl3EiiaweLv/IhKGkCU7gjWTBWKf4xn46CHuYscztToaZ/Mg2OUW3wICz
	EeiFsBhxfXv77nBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Fix #define name for Intel CPU model 0x5A
Cc: Christian Ludloff <ludloff@gmail.com>, Tony Luck <tony.luck@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173869351005.10177.15922683716075278539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1e66d6cf888fd206a89b8c476b1b28b63faf7fd6
Gitweb:        https://git.kernel.org/tip/1e66d6cf888fd206a89b8c476b1b28b63faf7fd6
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 07 Oct 2024 09:57:01 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 04 Feb 2025 10:05:53 -08:00

x86/cpu: Fix #define name for Intel CPU model 0x5A

This CPU was mistakenly given the name INTEL_ATOM_AIRMONT_MID. But it
uses a Silvermont core, not Airmont.

Change #define name to INTEL_ATOM_SILVERMONT_MID2

Reported-by: Christian Ludloff <ludloff@gmail.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241007165701.19693-1-tony.luck%40intel.com
---
 arch/x86/events/intel/core.c                                   | 2 +-
 arch/x86/include/asm/intel-family.h                            | 2 +-
 arch/x86/kernel/cpu/common.c                                   | 2 +-
 arch/x86/kernel/tsc_msr.c                                      | 2 +-
 drivers/powercap/intel_rapl_common.c                           | 2 +-
 drivers/staging/media/atomisp/include/linux/atomisp_platform.h | 4 ++--
 drivers/thermal/intel/intel_tcc.c                              | 2 +-
 tools/power/x86/turbostat/turbostat.c                          | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7601196..8988054 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6622,7 +6622,7 @@ __init int intel_pmu_init(void)
 	case INTEL_ATOM_SILVERMONT_D:
 	case INTEL_ATOM_SILVERMONT_MID:
 	case INTEL_ATOM_AIRMONT:
-	case INTEL_ATOM_AIRMONT_MID:
+	case INTEL_ATOM_SILVERMONT_MID2:
 		memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
 			sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, slm_hw_cache_extra_regs,
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 6d7b04f..8359113 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -149,9 +149,9 @@
 #define INTEL_ATOM_SILVERMONT		IFM(6, 0x37) /* Bay Trail, Valleyview */
 #define INTEL_ATOM_SILVERMONT_D		IFM(6, 0x4D) /* Avaton, Rangely */
 #define INTEL_ATOM_SILVERMONT_MID	IFM(6, 0x4A) /* Merriefield */
+#define INTEL_ATOM_SILVERMONT_MID2	IFM(6, 0x5A) /* Anniedale */
 
 #define INTEL_ATOM_AIRMONT		IFM(6, 0x4C) /* Cherry Trail, Braswell */
-#define INTEL_ATOM_AIRMONT_MID		IFM(6, 0x5A) /* Moorefield */
 #define INTEL_ATOM_AIRMONT_NP		IFM(6, 0x75) /* Lightning Mountain */
 
 #define INTEL_ATOM_GOLDMONT		IFM(6, 0x5C) /* Apollo Lake */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b..76598a9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1164,7 +1164,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 
 	VULNWL_INTEL(INTEL_CORE_YONAH,		NO_SSB),
 
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
+	VULNWL_INTEL(INTEL_ATOM_SILVERMONT_MID2,NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
 	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index deeb028..48e6cc1 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -152,7 +152,7 @@ static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&freq_desc_byt),
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&freq_desc_tng),
 	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&freq_desc_cht),
-	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,	&freq_desc_ann),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,	&freq_desc_ann),
 	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_NP,	&freq_desc_lgm),
 	{}
 };
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 77d75e1..5ccde39 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1274,7 +1274,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&rapl_defaults_byt),
 	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&rapl_defaults_cht),
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &rapl_defaults_tng),
-	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,	&rapl_defaults_ann),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,&rapl_defaults_ann),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&rapl_defaults_core),
diff --git a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
index 0492467..6146555 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
@@ -172,10 +172,10 @@ void atomisp_unregister_subdev(struct v4l2_subdev *subdev);
 #define IS_BYT	__IS_SOC(INTEL_ATOM_SILVERMONT)
 #define IS_CHT	__IS_SOC(INTEL_ATOM_AIRMONT)
 #define IS_MRFD	__IS_SOC(INTEL_ATOM_SILVERMONT_MID)
-#define IS_MOFD	__IS_SOC(INTEL_ATOM_AIRMONT_MID)
+#define IS_MOFD	__IS_SOC(INTEL_ATOM_SILVERMONT_MID2)
 
 /* Both CHT and MOFD come with ISP2401 */
 #define IS_ISP2401 __IS_SOCS(INTEL_ATOM_AIRMONT, \
-			     INTEL_ATOM_AIRMONT_MID)
+			     INTEL_ATOM_SILVERMONT_MID2)
 
 #endif /* ATOMISP_PLATFORM_H_ */
diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index 8174215..b2a615a 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -106,7 +106,7 @@ static const struct x86_cpu_id intel_tcc_cpu_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_D,		&temp_broadwell),
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&temp_broadwell),
 	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,		&temp_broadwell),
-	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,		&temp_broadwell),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,	&temp_broadwell),
 	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_NP,		&temp_broadwell),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,		&temp_goldmont),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,		&temp_goldmont),
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8d5011a..26057af 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1056,7 +1056,7 @@ static const struct platform_data turbostat_pdata[] = {
 	 * Missing support for
 	 * INTEL_ICELAKE
 	 * INTEL_ATOM_SILVERMONT_MID
-	 * INTEL_ATOM_AIRMONT_MID
+	 * INTEL_ATOM_SILVERMONT_MID2
 	 * INTEL_ATOM_AIRMONT_NP
 	 */
 	{ 0, NULL },

