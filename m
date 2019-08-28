Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB9A0295
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2019 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfH1NEO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Aug 2019 09:04:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfH1NEO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Aug 2019 09:04:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2xcE-0003gQ-Ta; Wed, 28 Aug 2019 15:03:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8778E1C07D2;
        Wed, 28 Aug 2019 15:03:58 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:03:58 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/intel: Aggregate big core graphics naming
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190827195122.622802314@infradead.org>
References: <20190827195122.622802314@infradead.org>
MIME-Version: 1.0
Message-ID: <156699743845.796.2954712958903066023.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5e741407eab7c602ee5a2b06afb0070a02f4412f
Gitweb:        https://git.kernel.org/tip/5e741407eab7c602ee5a2b06afb0070a02f4412f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Aug 2019 21:48:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Aug 2019 11:29:31 +02:00

x86/intel: Aggregate big core graphics naming

Currently big core clients with extra graphics on have:

 - _G
 - _GT3E

Make it uniformly: _G

for i in `git grep -l "\(INTEL_FAM6_\|VULNWL_INTEL\|INTEL_CPU_FAM6\).*_GT3E"`
do
	sed -i -e 's/\(\(INTEL_FAM6_\|VULNWL_INTEL\|INTEL_CPU_FAM6\).*\)_GT3E/\1_G/g' ${i}
done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20190827195122.622802314@infradead.org
---
 arch/x86/events/intel/core.c          |  8 ++++----
 arch/x86/events/intel/cstate.c        |  8 ++++----
 arch/x86/events/intel/pt.c            |  2 +-
 arch/x86/events/intel/rapl.c          |  4 ++--
 arch/x86/events/intel/uncore.c        |  4 ++--
 arch/x86/events/msr.c                 |  4 ++--
 arch/x86/include/asm/intel-family.h   |  4 ++--
 arch/x86/kernel/apic/apic.c           |  4 ++--
 arch/x86/kernel/cpu/bugs.c            |  4 ++--
 arch/x86/kernel/cpu/intel.c           |  4 ++--
 drivers/cpufreq/intel_pstate.c        |  4 ++--
 drivers/idle/intel_idle.c             |  4 ++--
 drivers/powercap/intel_rapl_common.c  |  4 ++--
 tools/power/x86/turbostat/turbostat.c | 18 +++++++++---------
 14 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 22ef9cc..472b45c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3966,11 +3966,11 @@ static __init void intel_clovertown_quirk(void)
 static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_L,		 1, 0x0000001e),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_G,		 1, 0x00000015),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL,		 4, 0x00000023),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_G,		 1, 0x00000014),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 4, 0x0f000009),
@@ -4860,7 +4860,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 		x86_add_quirk(intel_ht_bug);
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
@@ -4892,7 +4892,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9b014e8..03d7a40 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -593,9 +593,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,      snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X,	   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_GT3E, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_G, snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_L, hswult_cstates),
 
@@ -605,7 +605,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,        snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_XEON_D, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_GT3E,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_G,      snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_L, snb_cstates),
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8cb9626..d0195d1 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -206,7 +206,7 @@ static int __init pt_pmu_hw_init(void)
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 		/* not setting BRANCH_EN will #GP, erratum BDM106 */
 		pt_pmu.branch_en_always_on = true;
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 70dcfe9..82e2c0e 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -723,9 +723,9 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_L,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_G,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 8428e28..5a2f237 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1453,9 +1453,9 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,	  ivb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_L,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,	  hsw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_G,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL,	  bdw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E, bdw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,	  bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,  snbep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EX,	  nhmex_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_WESTMERE_EX,	  nhmex_uncore_init),
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 12265c1..e11fbdb 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -62,11 +62,11 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 25b71d4..0bc7f39 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -52,10 +52,10 @@
 #define INTEL_FAM6_HASWELL		0x3C
 #define INTEL_FAM6_HASWELL_X		0x3F
 #define INTEL_FAM6_HASWELL_L		0x45
-#define INTEL_FAM6_HASWELL_GT3E		0x46
+#define INTEL_FAM6_HASWELL_G		0x46
 
 #define INTEL_FAM6_BROADWELL		0x3D
-#define INTEL_FAM6_BROADWELL_GT3E	0x47
+#define INTEL_FAM6_BROADWELL_G		0x47
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index adf001d..c297e6d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -595,10 +595,10 @@ static const struct x86_cpu_id deadline_match[] = {
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_L,	0x20),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_GT3E,	0x17),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_G,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_GT3E,	0x17),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_G,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_L,	0xb2),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f435780..0b569f1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1186,9 +1186,9 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_L:
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index bafa273..1d2c64b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -150,12 +150,12 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
 	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
-	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
+	{ INTEL_FAM6_BROADWELL_G,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
 	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
 	{ INTEL_FAM6_HASWELL_L,		0x01,	0x21 },
-	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
+	{ INTEL_FAM6_HASWELL_G,		0x01,	0x18 },
 	{ INTEL_FAM6_HASWELL,		0x03,	0x23 },
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6e393aa..99b9c01 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1876,8 +1876,8 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_L,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_G,		core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_G,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d0e4f16..c408132 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1075,10 +1075,10 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(HASWELL,			idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_L,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_GT3E,		idle_cpu_hsw),
+	INTEL_CPU_FAM6(HASWELL_G,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_X,	idle_cpu_avn),
 	INTEL_CPU_FAM6(BROADWELL,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_GT3E,		idle_cpu_bdw),
+	INTEL_CPU_FAM6(BROADWELL_G,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_XEON_D,	idle_cpu_bdw),
 	INTEL_CPU_FAM6(SKYLAKE_L,		idle_cpu_skl),
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index ac52a6e..07af068 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -959,11 +959,11 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	INTEL_CPU_FAM6(HASWELL, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_GT3E, rapl_defaults_core),
+	INTEL_CPU_FAM6(HASWELL_G, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_X, rapl_defaults_hsw_server),
 
 	INTEL_CPU_FAM6(BROADWELL, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_GT3E, rapl_defaults_core),
+	INTEL_CPU_FAM6(BROADWELL_G, rapl_defaults_core),
 	INTEL_CPU_FAM6(BROADWELL_XEON_D, rapl_defaults_core),
 	INTEL_CPU_FAM6(BROADWELL_X, rapl_defaults_hsw_server),
 
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bb1bef6..271cf18 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3209,9 +3209,9 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		break;
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
@@ -3405,9 +3405,9 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
@@ -3841,9 +3841,9 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
@@ -4032,7 +4032,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_HASWELL:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 		do_core_perf_limit_reasons = 1;
@@ -4251,9 +4251,9 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
