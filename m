Return-Path: <linux-tip-commits+bounces-2608-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB39B9B1684
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375AC1F22519
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAC1D095C;
	Sat, 26 Oct 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+youjh4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1x7i+/PV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695F189F59;
	Sat, 26 Oct 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729935171; cv=none; b=UOQOugwQHuaabXNQN4EKlwTvn+iDYC61LkuKV1bwEbT1OsFxKtzceZrUHZQJ0rZaWvLlWV4OO2AAnALKmyh24CtCJf9tor6jo7D2te+AUs7yJ9aY/pyU7DdNDwIs+DBipj6pejWNslVf0+FpTqfTORdy3r4dLoVS8NWpzwo0Eug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729935171; c=relaxed/simple;
	bh=5/kwbV1rbjMCdWu6+FGlW7RtQlCso8EnAD9k0zw4C9c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sQR1U9/hGfhqSsiuULHPItv5sGCyUVcNvlEwjMFZRAvdPAU2OVGYEvmJsJ5vjVC6EZVJGq/04KXbH/ZA0Qj67fssfDjcE11LvpI1mfUuCBocUsRI/6arMeBv9nYsqi/IYavvLTBohbDDMe7gvIde9UJ4jPoHC9PMCCiak81BDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+youjh4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1x7i+/PV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 09:32:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729935166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjUm9whVpYzSeAftjD2BbBOvmDlaC46mh81OoNtn1l4=;
	b=m+youjh4L/L+H1NJbll3UqLhEOCkfFD/JfLUoJMQfsGDX9pXP16TJZst3ovMRe66xTKbHN
	o7f5syssyGdCruYarl6zqervBZBEhSH3AOVI/9fEH3csI0W11xMVEmMJzIGDie50vOLM9e
	19861FFO2X0ERI3xchxTiAf67tzyfHC9D8A+KuZ9trUFqjdtspj34O2njpPOV9KZ75XnjB
	Sc5Ap3hriiXlKWJK2Za8CadZQrXgPwKpZLz9IK074pPH3VqtXQLYvnPqH1tN/Aq1w1/rkb
	vsV2N/K83qvKgeos+zWKqQCKWN5vDOQH/xrRW4+e30ZwJ3t6GJpAedWnjCdCyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729935166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjUm9whVpYzSeAftjD2BbBOvmDlaC46mh81OoNtn1l4=;
	b=1x7i+/PVjxuBu29XHvL4oxYXQAKkHCrjautpCOQhLoepe0vgqsGj6LsglwzxNURj6cbamh
	GO6cR3FWTjxNsoCQ==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add CPU type to struct cpuinfo_topology
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025171459.1093-5-mario.limonciello@amd.com>
References: <20241025171459.1093-5-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172993516618.1442.12813885130587689293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     45239ba39a5279e9efc671774e2eef29df4d2484
Gitweb:        https://git.kernel.org/tip/45239ba39a5279e9efc671774e2eef29df4d2484
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Fri, 25 Oct 2024 12:14:58 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 25 Oct 2024 20:44:26 +02:00

x86/cpu: Add CPU type to struct cpuinfo_topology

Sometimes it is required to take actions based on if a CPU is a performance or
efficiency core. As an example, intel_pstate driver uses the Intel core-type
to determine CPU scaling. Also, some CPU vulnerabilities only affect
a specific CPU type, like RFDS only affects Intel Atom. Hybrid systems that
have variants P+E, P-only(Core) and E-only(Atom), it is not straightforward to
identify which variant is affected by a type specific vulnerability.

Such processors do have CPUID field that can uniquely identify them. Like,
P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE identification, while P+E
additionally enumerates CPUID.7.HYBRID. Based on this information, it is
possible for boot CPU to identify if a system has mixed CPU types.

Add a new field hw_cpu_type to struct cpuinfo_topology that stores the
hardware specific CPU type. This saves the overhead of IPIs to get the CPU
type of a different CPU. CPU type is populated early in the boot process,
before vulnerabilities are enumerated.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241025171459.1093-5-mario.limonciello@amd.com
---
 arch/x86/include/asm/intel-family.h   |  6 +++++-
 arch/x86/include/asm/processor.h      | 18 ++++++++++++++-
 arch/x86/include/asm/topology.h       |  9 +++++++-
 arch/x86/kernel/cpu/debugfs.c         |  1 +-
 arch/x86/kernel/cpu/topology_amd.c    |  3 ++-
 arch/x86/kernel/cpu/topology_common.c | 34 ++++++++++++++++++++++++++-
 6 files changed, 71 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 1a42f82..7367644 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -183,4 +183,10 @@
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
+/* CPU core types */
+enum intel_cpu_type {
+	INTEL_CPU_TYPE_ATOM = 0x20,
+	INTEL_CPU_TYPE_CORE = 0x40,
+};
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0..c097581 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -105,6 +105,24 @@ struct cpuinfo_topology {
 	// Cache level topology IDs
 	u32			llc_id;
 	u32			l2c_id;
+
+	// Hardware defined CPU-type
+	union {
+		u32		cpu_type;
+		struct {
+			// CPUID.1A.EAX[23-0]
+			u32	intel_native_model_id	:24;
+			// CPUID.1A.EAX[31-24]
+			u32	intel_type		:8;
+		};
+		struct {
+			// CPUID 0x80000026.EBX
+			u32	amd_num_processors	:16,
+				amd_power_eff_ranking	:8,
+				amd_native_model_id	:4,
+				amd_type		:4;
+		};
+	};
 };
 
 struct cpuinfo_x86 {
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index aef7033..9f9376d 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,6 +114,12 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
 };
 
+enum x86_topology_cpu_type {
+	TOPO_CPU_TYPE_PERFORMANCE,
+	TOPO_CPU_TYPE_EFFICIENCY,
+	TOPO_CPU_TYPE_UNKNOWN,
+};
+
 struct x86_topology_system {
 	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int	dom_size[TOPO_MAX_DOMAIN];
@@ -149,6 +155,9 @@ extern unsigned int __max_threads_per_core;
 extern unsigned int __num_threads_per_package;
 extern unsigned int __num_cores_per_package;
 
+const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
+
 static inline unsigned int topology_max_packages(void)
 {
 	return __max_logical_packages;
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e4..10719ab 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "cpu_type:            %s\n", get_topology_cpu_type_name(c));
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 7d476fa..03b3c9c 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -182,6 +182,9 @@ static void parse_topology_amd(struct topo_scan *tscan)
 	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
 		has_topoext = cpu_parse_topology_ext(tscan);
 
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
+
 	if (!has_topoext && !parse_8000_0008(tscan))
 		return;
 
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 9a6069e..8277c64 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -3,6 +3,7 @@
 
 #include <xen/xen.h>
 
+#include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/processor.h>
 #include <asm/smp.h>
@@ -27,6 +28,36 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 	}
 }
 
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c)
+{
+	if (c->x86_vendor == X86_VENDOR_INTEL) {
+		switch (c->topo.intel_type) {
+		case INTEL_CPU_TYPE_ATOM: return TOPO_CPU_TYPE_EFFICIENCY;
+		case INTEL_CPU_TYPE_CORE: return TOPO_CPU_TYPE_PERFORMANCE;
+		}
+	}
+	if (c->x86_vendor == X86_VENDOR_AMD) {
+		switch (c->topo.amd_type) {
+		case 0:	return TOPO_CPU_TYPE_PERFORMANCE;
+		case 1:	return TOPO_CPU_TYPE_EFFICIENCY;
+		}
+	}
+
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
+
+const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c)
+{
+	switch (get_topology_cpu_type(c)) {
+	case TOPO_CPU_TYPE_PERFORMANCE:
+		return "performance";
+	case TOPO_CPU_TYPE_EFFICIENCY:
+		return "efficiency";
+	default:
+		return "unknown";
+	}
+}
+
 static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
 {
 	struct {
@@ -87,6 +118,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		.cu_id			= 0xff,
 		.llc_id			= BAD_APICID,
 		.l2c_id			= BAD_APICID,
+		.cpu_type		= TOPO_CPU_TYPE_UNKNOWN,
 	};
 	struct cpuinfo_x86 *c = tscan->c;
 	struct {
@@ -132,6 +164,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
+		if (c->cpuid_level >= 0x1a)
+			c->topo.cpu_type = cpuid_eax(0x1a);
 		break;
 	case X86_VENDOR_HYGON:
 		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))

