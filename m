Return-Path: <linux-tip-commits+bounces-3709-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC5A47A96
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1873172BC4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7922D4CF;
	Thu, 27 Feb 2025 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3ZW0xWU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQZRSlHD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A622A4DE;
	Thu, 27 Feb 2025 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652948; cv=none; b=aYKAe3+bPHPLjiRfKWNGPkTTWNOYz0nzOVIXlWNVV4YwwOg5g1OfXHfP0R0Ytv/ZvRIblYLKFPmuJUeud5ZtmbwxaMG8b+T4zgXCiY3SZA81izlBBpVHZQVeZMrFJQbZ8MsrfO79k4GMTapqEwDVUdXD0iT8wOnR9Ca+nOB4n6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652948; c=relaxed/simple;
	bh=qAr+67Z+iWlJhSpI1PFT9xNk24t5BIcoHItLpja3XAA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oFyC+pk1gHF0FNQcsTURlAj9Kf+6u+/i7CKEvPoms2fLWVcXReeECRGL4VB5n95gVHV6k8fLJEWlsinGXaDyzCJqbpX0Lyhh2jkHIrdz0IJX1acULrgVg/Kps2cJMI7uMfsJXvz2O60KgLQay0rsxeRTtbpJTDkddQAe0HGElCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3ZW0xWU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQZRSlHD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652944;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JppPBLhBkdP1vYSTnjvFo3uDvOfyq2MF5RqOPJMkd4c=;
	b=v3ZW0xWUhi5idNftDEZofJn1OtXEWkZzBaUGWE+pmoiU/Qa2a4/5hBeiuLpKiu57DTxdBz
	Fvt9iY3sr0yVsvCEiQsr5G8mfzOtDqAQPzc+wZpyPHJFwdN2nEDFsA5VExPvCVrWP4EacI
	25OOxxt9kp9CAiom9+ud2jrlab+IZZhdeBhvlfQesuaAB4NZOB5eUsYPRG8wOooorl2lpb
	ae1kJE/nmG2uzz7MwgKm8KN+CsEWospM6FghUuWMSmPQr/h9uyodQRWOC0S6iBMG0UqG5o
	1XVRzO+8VfjdgiyK36mBxwVtqnAYQBL+AV+4LPUH5rr4sDbiqgoBA536svdmdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652944;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JppPBLhBkdP1vYSTnjvFo3uDvOfyq2MF5RqOPJMkd4c=;
	b=IQZRSlHDyi0I8lD1oBU++lpHTJAy5vGx+vsYS7kMZkNhgTWUmRN1oJWVtt2jHiFyZMmmey
	4p4zB08XUS2ezKAA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/smp: Drop 32-bit "bigsmp" machine support
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-3-arnd@kernel.org>
References: <20250226213714.4040853-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065294360.10177.15471382143459800191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0abf508675c0dbbca6a387842f90db60756c4af5
Gitweb:        https://git.kernel.org/tip/0abf508675c0dbbca6a387842f90db60756c4af5
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:19:05 +01:00

x86/smp: Drop 32-bit "bigsmp" machine support

The x86-32 kernel used to support multiple platforms with more than eight
logical CPUs, from the 1999-2003 timeframe: Sequent NUMA-Q, IBM Summit,
Unisys ES7000 and HP F8. Support for all except the latter was dropped
back in 2014, leaving only the F8 based DL740 and DL760 G2 machines in
this catery, with up to eight single-core Socket-603 Xeon-MP processors
with hyperthreading.

Like the already removed machines, the HP F8 servers at the time cost
upwards of $100k in typical configurations, but were quickly obsoleted
by their 64-bit Socket-604 cousins and the AMD Opteron.

Earlier servers with up to 8 Pentium Pro or Xeon processors remain
fully supported as they had no hyperthreading. Similarly, the more
common 4-socket Xeon-MP machines with hyperthreading using Intel
or ServerWorks chipsets continue to work without this, and all the
multi-core Xeon processors also run 64-bit kernels.

While the "bigsmp" support can also be used to run on later 64-bit
machines (including VM guests), it seems best to discourage that
and get any remaining users to update their kernels to 64-bit builds
on these. As a side-effect of this, there is also no more need to
support NUMA configurations on 32-bit x86, as all true 32-bit
NUMA platforms are already gone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-3-arnd@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |   4 +-
 arch/x86/Kconfig                                |  20 +---
 arch/x86/kernel/apic/Makefile                   |   3 +-
 arch/x86/kernel/apic/apic.c                     |   3 +-
 arch/x86/kernel/apic/bigsmp_32.c                | 105 +---------------
 arch/x86/kernel/apic/local.h                    |  13 +--
 arch/x86/kernel/apic/probe_32.c                 |  29 +----
 7 files changed, 4 insertions(+), 173 deletions(-)
 delete mode 100644 arch/x86/kernel/apic/bigsmp_32.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b..8f92377 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -416,10 +416,6 @@
 			Format: { quiet (default) | verbose | debug }
 			Change the amount of debugging information output
 			when initialising the APIC and IO-APIC components.
-			For X86-32, this can also be used to specify an APIC
-			driver name.
-			Format: apic=driver_name
-			Examples: apic=bigsmp
 
 	apic_extnmi=	[APIC,X86,EARLY] External NMI delivery setting
 			Format: { bsp (default) | all | none }
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d581634..887b77b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -531,12 +531,6 @@ config X86_FRED
 	  ring transitions and exception/interrupt handling if the
 	  system supports it.
 
-config X86_BIGSMP
-	bool "Support for big SMP systems with more than 8 CPUs"
-	depends on SMP && X86_32
-	help
-	  This option is needed for the systems that have more than 8 CPUs.
-
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
 	default y
@@ -735,8 +729,8 @@ config X86_32_NON_STANDARD
 	depends on X86_32 && SMP
 	depends on X86_EXTENDED_PLATFORM
 	help
-	  This option compiles in the bigsmp and STA2X11 default
-	  subarchitectures.  It is intended for a generic binary
+	  This option compiles in the STA2X11 default
+	  subarchitecture.  It is intended for a generic binary
 	  kernel. If you select them all, kernel will probe it one by
 	  one and will fallback to default.
 
@@ -1013,8 +1007,7 @@ config NR_CPUS_RANGE_BEGIN
 config NR_CPUS_RANGE_END
 	int
 	depends on X86_32
-	default   64 if  SMP &&  X86_BIGSMP
-	default    8 if  SMP && !X86_BIGSMP
+	default    8 if  SMP
 	default    1 if !SMP
 
 config NR_CPUS_RANGE_END
@@ -1027,7 +1020,6 @@ config NR_CPUS_RANGE_END
 config NR_CPUS_DEFAULT
 	int
 	depends on X86_32
-	default   32 if  X86_BIGSMP
 	default    8 if  SMP
 	default    1 if !SMP
 
@@ -1574,8 +1566,7 @@ config AMD_MEM_ENCRYPT
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
 	depends on SMP
-	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
-	default y if X86_BIGSMP
+	depends on X86_64
 	select USE_PERCPU_NUMA_NODE_ID
 	select OF_NUMA if OF
 	help
@@ -1588,9 +1579,6 @@ config NUMA
 	  For 64-bit this is recommended if the system is Intel Core i7
 	  (or later), AMD Opteron, or EM64T NUMA.
 
-	  For 32-bit this is only needed if you boot a 32-bit
-	  kernel on a 64-bit NUMA platform.
-
 	  Otherwise, you should say N.
 
 config AMD_NUMA
diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
index 3bf0487..52d1808 100644
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -23,8 +23,5 @@ obj-$(CONFIG_X86_X2APIC)	+= x2apic_cluster.o
 obj-y				+= apic_flat_64.o
 endif
 
-# APIC probe will depend on the listing order here
-obj-$(CONFIG_X86_BIGSMP)	+= bigsmp_32.o
-
 # For 32bit, probe_32 need to be listed last
 obj-$(CONFIG_X86_LOCAL_APIC)	+= probe_$(BITS).o
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e893dc6..ddca8da 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1371,8 +1371,6 @@ void __init apic_intr_mode_init(void)
 
 	x86_64_probe_apic();
 
-	x86_32_install_bigsmp();
-
 	if (x86_platform.apic_post_init)
 		x86_platform.apic_post_init();
 
@@ -1674,7 +1672,6 @@ static __init void apic_read_boot_cpu_id(bool x2apic)
 		boot_cpu_apic_version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	}
 	topology_register_boot_apic(boot_cpu_physical_apicid);
-	x86_32_probe_bigsmp_early();
 }
 
 #ifdef CONFIG_X86_X2APIC
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
deleted file mode 100644
index 9285d50..0000000
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ /dev/null
@@ -1,105 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * APIC driver for "bigsmp" xAPIC machines with more than 8 virtual CPUs.
- *
- * Drives the local APIC in "clustered mode".
- */
-#include <linux/cpumask.h>
-#include <linux/dmi.h>
-#include <linux/smp.h>
-
-#include <asm/apic.h>
-#include <asm/io_apic.h>
-
-#include "local.h"
-
-static u32 bigsmp_get_apic_id(u32 x)
-{
-	return (x >> 24) & 0xFF;
-}
-
-static void bigsmp_send_IPI_allbutself(int vector)
-{
-	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
-}
-
-static void bigsmp_send_IPI_all(int vector)
-{
-	default_send_IPI_mask_sequence_phys(cpu_online_mask, vector);
-}
-
-static int dmi_bigsmp; /* can be set by dmi scanners */
-
-static int hp_ht_bigsmp(const struct dmi_system_id *d)
-{
-	printk(KERN_NOTICE "%s detected: force use of apic=bigsmp\n", d->ident);
-	dmi_bigsmp = 1;
-
-	return 0;
-}
-
-
-static const struct dmi_system_id bigsmp_dmi_table[] = {
-	{ hp_ht_bigsmp, "HP ProLiant DL760 G2",
-		{	DMI_MATCH(DMI_BIOS_VENDOR, "HP"),
-			DMI_MATCH(DMI_BIOS_VERSION, "P44-"),
-		}
-	},
-
-	{ hp_ht_bigsmp, "HP ProLiant DL740",
-		{	DMI_MATCH(DMI_BIOS_VENDOR, "HP"),
-			DMI_MATCH(DMI_BIOS_VERSION, "P47-"),
-		}
-	},
-	{ } /* NULL entry stops DMI scanning */
-};
-
-static int probe_bigsmp(void)
-{
-	return dmi_check_system(bigsmp_dmi_table);
-}
-
-static struct apic apic_bigsmp __ro_after_init = {
-
-	.name				= "bigsmp",
-	.probe				= probe_bigsmp,
-
-	.dest_mode_logical		= false,
-
-	.disable_esr			= 1,
-
-	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-
-	.max_apic_id			= 0xFE,
-	.get_apic_id			= bigsmp_get_apic_id,
-
-	.calc_dest_apicid		= apic_default_calc_apicid,
-
-	.send_IPI			= default_send_IPI_single_phys,
-	.send_IPI_mask			= default_send_IPI_mask_sequence_phys,
-	.send_IPI_mask_allbutself	= NULL,
-	.send_IPI_allbutself		= bigsmp_send_IPI_allbutself,
-	.send_IPI_all			= bigsmp_send_IPI_all,
-	.send_IPI_self			= default_send_IPI_self,
-
-	.read				= native_apic_mem_read,
-	.write				= native_apic_mem_write,
-	.eoi				= native_apic_mem_eoi,
-	.icr_read			= native_apic_icr_read,
-	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
-};
-
-bool __init apic_bigsmp_possible(bool cmdline_override)
-{
-	return apic == &apic_bigsmp || !cmdline_override;
-}
-
-void __init apic_bigsmp_force(void)
-{
-	if (apic != &apic_bigsmp)
-		apic_install_driver(&apic_bigsmp);
-}
-
-apic_driver(apic_bigsmp);
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 842fe28..bdcf609 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -65,17 +65,4 @@ void default_send_IPI_self(int vector);
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
-void x86_32_probe_bigsmp_early(void);
-void x86_32_install_bigsmp(void);
-#else
-static inline void x86_32_probe_bigsmp_early(void) { }
-static inline void x86_32_install_bigsmp(void) { }
-#endif
-
-#ifdef CONFIG_X86_BIGSMP
-bool apic_bigsmp_possible(bool cmdline_selected);
-void apic_bigsmp_force(void);
-#else
-static inline bool apic_bigsmp_possible(bool cmdline_selected) { return false; };
-static inline void apic_bigsmp_force(void) { }
 #endif
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index f75ee34..87bc9e7 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -93,35 +93,6 @@ static int __init parse_apic(char *arg)
 }
 early_param("apic", parse_apic);
 
-void __init x86_32_probe_bigsmp_early(void)
-{
-	if (nr_cpu_ids <= 8 || xen_pv_domain())
-		return;
-
-	if (IS_ENABLED(CONFIG_X86_BIGSMP)) {
-		switch (boot_cpu_data.x86_vendor) {
-		case X86_VENDOR_INTEL:
-			if (!APIC_XAPIC(boot_cpu_apic_version))
-				break;
-			/* P4 and above */
-			fallthrough;
-		case X86_VENDOR_HYGON:
-		case X86_VENDOR_AMD:
-			if (apic_bigsmp_possible(cmdline_apic))
-				return;
-			break;
-		}
-	}
-	pr_info("Limiting to 8 possible CPUs\n");
-	set_nr_cpu_ids(8);
-}
-
-void __init x86_32_install_bigsmp(void)
-{
-	if (nr_cpu_ids > 8 && !xen_pv_domain())
-		apic_bigsmp_force();
-}
-
 void __init x86_32_probe_apic(void)
 {
 	if (!cmdline_apic) {

