Return-Path: <linux-tip-commits+bounces-6822-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00179BDFC38
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 18:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E4919A85B5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C2340D90;
	Wed, 15 Oct 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVgsDuDP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LjqBxQ8x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362C33EB17;
	Wed, 15 Oct 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547149; cv=none; b=etZl3llBpY0FxlmP6PO/m/+85pxwy0N/iRcEXhOmwdTBogeDqKEDnRygdbjXbzwULySZRA0JDQ1XsVSBDvjMy+zW/Xm3O03WpQFU0JsLiEUwKXVplVD6O3T0tpNariEavF61qBSg3RL0q9UnCez0FDCtJRPBP+tDWkP2KMCeKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547149; c=relaxed/simple;
	bh=gnnqMQNCYqUJozSiUVz/HskCXIqgymGXK45+BG31ric=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T7qbGZ+NJ9BBvvoyrxjmTDm3L/IwS11v6tcmAWaDTOuhIyBpsF+eiToUtyojbFtpIShfc5PQI02gNNLr2DPiLM5gtzUr404R+C4S8u9ocD1IWepSyR+U31dwKBg7UCKntVb9l1DtPXbdhexWudLn2gtPHxf14CXlg8PtNcJeNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iVgsDuDP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LjqBxQ8x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 16:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760547145;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8SaYcmPO/J9zbh/J+oWIx5HmRhVsrSSUeNWrMj/m38=;
	b=iVgsDuDPodMFY8NZKDjuKcp2qUGMyCtKJk9ze7DryfXWGLqyo9M7zvFw16BP8iZ6duGlq+
	pP94qxpI4LUxY90upy+ULTJfe9MpWSb5MzEFRbV2Gub8dyHy9Jw8Ii5TIawFMudjiyiQPy
	NG6BnOz4nklN8ZC6pYltoRN9pV9w1n3f7aK4a+SzL7zqZJh+/rRpASbUdGfM2xHXBGJNEJ
	cpC811igzxPAzaf/6ttumkReAtH7Hu7kBtB3g3BsDqF0xxLkMA8RH+O3lnghKxYu+JEHdx
	T+G0S2LD21RwkvHpV9oAqyxevszWfVYigypF5R7pNGTcA44GOf0lH7R5i6DKKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760547145;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8SaYcmPO/J9zbh/J+oWIx5HmRhVsrSSUeNWrMj/m38=;
	b=LjqBxQ8xF9wd8chodt8iqbQKa3BjD+ioX2Gl1i0YGzRHJOl5l6YZNOn+9IEPAHjESQG5lg
	HKjFH/txvBhQs9Dg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/cpu/topology: Make primary thread mask
 available with SMP=n
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250921224841.3545-2-chang.seok.bae@intel.com>
References: <20250921224841.3545-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176054714443.709179.14324172763516419832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     ed44a5625f304ff14d01acfa086e77b5262a842f
Gitweb:        https://git.kernel.org/tip/ed44a5625f304ff14d01acfa086e77b5262=
a842f
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Sun, 21 Sep 2025 15:48:35 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Oct 2025 16:46:11 +02:00

x86/cpu/topology: Make primary thread mask available with SMP=3Dn

cpu_primary_thread_mask is only defined when CONFIG_SMP=3Dy. However, even
in UP kernels there is always exactly one CPU, which can reasonably be
treated as the primary thread.

Historically, topology_is_primary_thread() always returned true with
CONFIG_SMP=3Dn. A recent commit:

  4b455f59945aa ("cpu/SMT: Provide a default topology_is_primary_thread()")

replaced it with a generic implementation with the note:

  "When disabling SMT, the primary thread of the SMT will remain
   enabled/active. Architectures that have a special primary thread (e.g.
   x86) need to override this function. ..."

For consistency and clarity, make the primary thread mask available
regardless of SMP, similar to cpu_possible_mask and cpu_present_mask.

Move __cpu_primary_thread_mask into common code to prevent build issues.
Let cpu_mark_primary_thread() configure the mask even for UP kernels,
alongside other masks. Then, topology_is_primary_thread() can
consistently reference it.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20250320234104.8288-1-chang.seok.bae@intel.com
---
 arch/x86/include/asm/topology.h       | 12 ++++++------
 arch/x86/kernel/cpu/topology.c        |  4 ----
 arch/x86/kernel/cpu/topology_common.c |  3 +++
 arch/x86/kernel/smpboot.c             |  3 ---
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2104189..8c6354f 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -218,6 +218,12 @@ static inline unsigned int topology_amd_nodes_per_pkg(vo=
id)
 	return __amd_nodes_per_pkg;
 }
=20
+#else /* CONFIG_SMP */
+static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0;=
 }
+static inline int topology_max_smt_threads(void) { return 1; }
+static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
+#endif /* !CONFIG_SMP */
+
 extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thre=
ad_mask)
=20
@@ -241,12 +247,6 @@ static inline bool topology_is_core_online(unsigned int =
cpu)
 }
 #define topology_is_core_online topology_is_core_online
=20
-#else /* CONFIG_SMP */
-static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0;=
 }
-static inline int topology_max_smt_threads(void) { return 1; }
-static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
-#endif /* !CONFIG_SMP */
-
 static inline void arch_fix_phys_package_id(int num, u32 slot)
 {
 }
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 6073a16..f55ea3c 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -75,15 +75,11 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 	return phys_id =3D=3D (u64)cpuid_to_apicid[cpu];
 }
=20
-#ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
 	if (!(apicid & (__max_threads_per_core - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
-#else
-static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int ap=
icid) { }
-#endif
=20
 /*
  * Convert the APIC ID to a domain level ID by masking out the low bits
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topo=
logy_common.c
index b5a5e14..7162579 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -16,6 +16,9 @@ EXPORT_SYMBOL_GPL(x86_topo_system);
 unsigned int __amd_nodes_per_pkg __ro_after_init;
 EXPORT_SYMBOL_GPL(__amd_nodes_per_pkg);
=20
+/* CPUs which are the primary SMT threads */
+struct cpumask __cpu_primary_thread_mask __read_mostly;
+
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 		      unsigned int shift, unsigned int ncpus)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index eb289ab..6b43417 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -103,9 +103,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 EXPORT_PER_CPU_SYMBOL(cpu_die_map);
=20
-/* CPUs which are the primary SMT threads */
-struct cpumask __cpu_primary_thread_mask __read_mostly;
-
 /* Representing CPUs for which sibling maps can be computed */
 static cpumask_var_t cpu_sibling_setup_mask;
=20

