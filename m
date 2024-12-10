Return-Path: <linux-tip-commits+bounces-3050-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497109EB901
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 19:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A8D188939A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D408C214200;
	Tue, 10 Dec 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChlMB6WF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="01R9xZ5W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727E2046A2;
	Tue, 10 Dec 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853922; cv=none; b=tDl1i3uKB5G9Pgsq3Y8vul3MufvIYx9G7Tv5NBQfXxOYOgg8tFmDCF8lvMkyyQzjzWsQLnNbDXVAP0Xyein1sy586C/G5qrQqhX6KQB8X4WAGKL2yQuFC9DKOoweGseVlwFJAAVRboqospRGSI4FRvLO+pKFFnzMuvER+m8u3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853922; c=relaxed/simple;
	bh=BieKL7c33cHfp95zpAhOo7VTdJ7dH6kwDaN6DHa5f7A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RkyLyhjP6z8WIIn/UFp5vVXb51BuM+PAatnOV04TeXXYUy62gO59u4xKFhj4p5ki4r1m+YdezDAqM545IvGR5vnR+uhibv69n/EnK/mgpVJw7tL5bWYLQZhMIF2iaenXQuf+3iyFrjjlVB+YEcRI43g/CqxRpjNy4ddFqfWOr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChlMB6WF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=01R9xZ5W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Dec 2024 18:05:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733853917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tDu9FVXJduq6QsDKz+5PkvtmJqYR66/ELZjEogRSyk=;
	b=ChlMB6WF7I1S5xR4HRoyew+Wbo4I5jbojoFLHIfD5LVN1+K4tYmAPmEJlMbVqMYd2jcR8j
	6fsNN6/xX8gBtVZCcBheNjCZkPFjWCtPu7uQb5D0+INTCJKmGi4a8hCXOFZxdxoLLxFb2S
	hcJGCuZqmHk7N0vx6ljYuko3dQ5M27cj8qTlo7AsXS/88bfcETO3PXj8AjRAbIeo0VjFHh
	kkwXybzETsmM8miblCt6IlyqKpWnCqhw1C1oNO6kOX6pobs33xNOSjGO3oysUHexOpZlDv
	ufEFBOeR73jD+jwJFfX3IzYbOCHQIERExY7NA8sImKOvzCd+Yt7a7VTsAcpT6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733853917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tDu9FVXJduq6QsDKz+5PkvtmJqYR66/ELZjEogRSyk=;
	b=01R9xZ5WpgAcNLTrB1h1x15fc2m/kFDHxTS1P4/RnMxXSuq6TpZCz5l08Vo/HDyJNDJ213
	/uXhZoODJwc51BCA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] Documentation: Merge x86-specific boot options
 doc into kernel-parameters.txt
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202190011.11979-1-bp@kernel.org>
References: <20241202190011.11979-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173385391562.412.7209645577276296571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ab0e7f20768af59fe161d71cc5d1de384f2a9da8
Gitweb:        https://git.kernel.org/tip/ab0e7f20768af59fe161d71cc5d1de384f2a9da8
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 02 Dec 2024 20:00:10 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Dec 2024 18:25:40 +01:00

Documentation: Merge x86-specific boot options doc into kernel-parameters.txt

Documentation/arch/x86/x86_64/boot-options.rst is causing unnecessary
confusion by being a second place where one can put x86 boot options.
Move them into the main one.

Drop removed ones like "acpi=ht", while at it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20241202190011.11979-1-bp@kernel.org
---
 Documentation/admin-guide/kernel-parameters.rst         |   3 +-
 Documentation/admin-guide/kernel-parameters.txt         | 237 ++++-
 Documentation/arch/x86/x86_64/boot-options.rst          | 312 +-------
 Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst |   2 +-
 Documentation/arch/x86/x86_64/index.rst                 |   1 +-
 arch/x86/Kconfig.debug                                  |   2 +-
 arch/x86/kernel/pci-dma.c                               |   4 +-
 7 files changed, 227 insertions(+), 334 deletions(-)
 delete mode 100644 Documentation/arch/x86/x86_64/boot-options.rst

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 59931f2..39d0e7f 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -194,8 +194,6 @@ is applicable::
 	WDT	Watchdog support is enabled.
 	X86-32	X86-32, aka i386 architecture is enabled.
 	X86-64	X86-64 architecture is enabled.
-			More X86-64 boot options can be found in
-			Documentation/arch/x86/x86_64/boot-options.rst.
 	X86	Either 32-bit or 64-bit x86 (same as X86-32+X86-64)
 	X86_UV	SGI UV support is enabled.
 	XEN	Xen support is enabled
@@ -213,7 +211,6 @@ Do not modify the syntax of boot loader parameters without extreme
 need or coordination with <Documentation/arch/x86/boot.rst>.
 
 There are also arch-specific kernel-parameters not documented here.
-See for example <Documentation/arch/x86/x86_64/boot-options.rst>.
 
 Note that ALL kernel parameters listed below are CASE SENSITIVE, and that
 a trailing = on the name of any parameter states that that parameter will
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dc663c0..bf7b356 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -21,6 +21,10 @@
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
 			copy_dsdt -- copy DSDT to memory
+			nocmcff -- Disable firmware first mode for corrected
+			errors. This disables parsing the HEST CMC error
+			source to check if firmware has set the FF flag. This
+			may result in duplicate corrected error reports.
 			nospcr -- disable console in ACPI SPCR table as
 				default _serial_ console on ARM64
 			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
@@ -405,6 +409,8 @@
 			not play well with APC CPU idle - disable it if you have
 			APC and your system crashes randomly.
 
+	apic		[APIC,X86-64] Use IO-APIC. Default.
+
 	apic=		[APIC,X86,EARLY] Advanced Programmable Interrupt Controller
 			Change the output verbosity while booting
 			Format: { quiet (default) | verbose | debug }
@@ -424,6 +430,10 @@
 			      useful so that a dump capture kernel won't be
 			      shot down by NMI
 
+	apicpmtimer	Do APIC timer calibration using the pmtimer. Implies
+			apicmaintimer. Useful when your PIT timer is totally
+			broken.
+
 	autoconf=	[IPV6]
 			See Documentation/networking/ipv6.rst.
 
@@ -1726,6 +1736,8 @@
 
 			off:	Disable GDS mitigation.
 
+	gbpages		[X86] Use GB pages for kernel direct mappings.
+
 	gcov_persist=	[GCOV] When non-zero (default), profiling data for
 			kernel modules is saved and remains accessible via
 			debugfs, even when the module is unloaded/reloaded.
@@ -2008,12 +2020,21 @@
 
 	idle=		[X86,EARLY]
 			Format: idle=poll, idle=halt, idle=nomwait
-			Poll forces a polling idle loop that can slightly
-			improve the performance of waking up a idle CPU, but
-			will use a lot of power and make the system run hot.
-			Not recommended.
+
+			idle=poll:  Don't do power saving in the idle loop
+			using HLT, but poll for rescheduling event. This will
+			make the CPUs eat a lot more power, but may be useful
+			to get slightly better performance in multiprocessor
+			benchmarks. It also makes some profiling using
+			performance counters more accurate.  Please note that
+			on systems with MONITOR/MWAIT support (like Intel
+			EM64T CPUs) this option has no performance advantage
+			over the normal idle loop.  It may also interact badly
+			with hyperthreading.
+
 			idle=halt: Halt is forced to be used for CPU idle.
 			In such case C2/C3 won't be used again.
+
 			idle=nomwait: Disable mwait for CPU C-states
 
 	idxd.sva=	[HW]
@@ -2311,20 +2332,73 @@
 		relaxed
 
 	iommu=		[X86,EARLY]
+
 		off
+			Don't initialize and use any kind of IOMMU.
+
 		force
+			Force the use of the hardware IOMMU even when
+			it is not actually needed (e.g. because < 3 GB
+			memory).
+
 		noforce
+			Don't force hardware IOMMU usage when it is not
+			needed. (default).
+
 		biomerge
 		panic
 		nopanic
 		merge
 		nomerge
+
 		soft
-		pt		[X86]
-		nopt		[X86]
-		nobypass	[PPC/POWERNV]
+			Use software bounce buffering (SWIOTLB) (default for
+			Intel machines). This can be used to prevent the usage
+			of an available hardware IOMMU.
+
+			[X86]
+		pt
+			[X86]
+		nopt
+			[PPC/POWERNV]
+		nobypass
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
+		[X86]
+		AMD Gart HW IOMMU-specific options:
+
+		<size>
+			Set the size of the remapping area in bytes.
+
+		allowed
+			Overwrite iommu off workarounds for specific chipsets
+
+		fullflush
+			Flush IOMMU on each allocation (default).
+
+		nofullflush
+			Don't use IOMMU fullflush.
+
+		memaper[=<order>]
+			Allocate an own aperture over RAM with size
+			32MB<<order.  (default: order=1, i.e. 64MB)
+
+		merge
+			Do scatter-gather (SG) merging. Implies "force"
+			(experimental).
+
+		nomerge
+			Don't do scatter-gather (SG) merging.
+
+		noaperture
+			Ask the IOMMU not to touch the aperture for AGP.
+
+		noagp
+			Don't initialize the AGP driver and use full aperture.
+
+		panic
+			Always panic when IOMMU overflows.
+
 	iommu.forcedac=	[ARM64,X86,EARLY] Control IOVA allocation for PCI devices.
 			Format: { "0" | "1" }
 			0 - Try to allocate a 32-bit DMA address first, before
@@ -3259,9 +3333,77 @@
 			devices can be requested on-demand with the
 			/dev/loop-control interface.
 
-	mce		[X86-32] Machine Check Exception
+	mce=		[X86-{32,64}]
+
+			Please see Documentation/arch/x86/x86_64/machinecheck.rst for sysfs runtime tunables.
+
+		off
+			disable machine check
+
+		no_cmci
+			disable CMCI(Corrected Machine Check Interrupt) that
+			Intel processor supports.  Usually this disablement is
+			not recommended, but it might be handy if your
+			hardware is misbehaving.
+
+			Note that you'll get more problems without CMCI than
+			with due to the shared banks, i.e. you might get
+			duplicated error logs.
+
+		dont_log_ce
+			don't make logs for corrected errors.  All events
+			reported as corrected are silently cleared by OS. This
+			option will be useful if you have no interest in any
+			of corrected errors.
+
+		ignore_ce
+			disable features for corrected errors, e.g.
+			polling timer and CMCI.  All events reported as
+			corrected are not cleared by OS and remained in its
+			error banks.
+
+			Usually this disablement is not recommended, however
+			if there is an agent checking/clearing corrected
+			errors (e.g. BIOS or hardware monitoring
+			applications), conflicting with OS's error handling,
+			and you cannot deactivate the agent, then this option
+			will be a help.
+
+		no_lmce
+			do not opt-in to Local MCE delivery. Use legacy method
+			to broadcast MCEs.
+
+		bootlog
+			enable logging of machine checks left over from
+			booting. Disabled by default on AMD Fam10h and older
+			because some BIOS leave bogus ones.
+
+			If your BIOS doesn't do that it's a good idea to
+			enable though to make sure you log even machine check
+			events that result in a reboot. On Intel systems it is
+			enabled by default.
+
+		nobootlog
+			disable boot machine check logging.
+
+		monarchtimeout (number)
+			sets the time in us to wait for other CPUs on machine
+			checks. 0 to disable.
+
+		bios_cmci_threshold
+			don't overwrite the bios-set CMCI threshold. This boot
+			option prevents Linux from overwriting the CMCI
+			threshold set by the bios.  Without this option, Linux
+			always sets the CMCI threshold to 1. Enabling this may
+			make memory predictive failure analysis less effective
+			if the bios sets thresholds for memory errors since we
+			will not see details for all errors.
+
+		recovery
+			force-enable recoverable machine check code paths
+
+			Everything else is in sysfs now.
 
-	mce=option	[X86-64] See Documentation/arch/x86/x86_64/boot-options.rst
 
 	md=		[HW] RAID subsystems devices and level
 			See Documentation/admin-guide/md.rst.
@@ -3887,6 +4029,8 @@
 	noapic		[SMP,APIC,EARLY] Tells the kernel to not make use of any
 			IOAPICs that may be present in the system.
 
+	noapictimer	[APIC,X86] Don't set up the APIC timer
+
 	noautogroup	Disable scheduler automatic task group creation.
 
 	nocache		[ARM,EARLY]
@@ -3934,6 +4078,8 @@
 			register save and restore. The kernel will only save
 			legacy floating-point registers on task switch.
 
+	nogbpages	[X86] Do not use GB pages for kernel direct mappings.
+
 	no_hash_pointers
 			[KNL,EARLY]
 			Force pointers printed to the console or buffers to be
@@ -3960,6 +4106,8 @@
 			the impact of the sleep instructions. This is also
 			useful when using JTAG debugger.
 
+	nohpet		[X86] Don't use the HPET timer.
+
 	nohugeiomap	[KNL,X86,PPC,ARM64,EARLY] Disable kernel huge I/O mappings.
 
 	nohugevmalloc	[KNL,X86,PPC,ARM64,EARLY] Disable kernel huge vmalloc mappings.
@@ -4111,8 +4259,10 @@
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
-	no_timer_check	[X86,APIC] Disables the code which tests for
-			broken timer IRQ sources.
+	no_timer_check	[X86,APIC] Disables the code which tests for broken
+			timer IRQ sources, i.e., the IO-APIC timer. This can
+			work around problems with incorrect timer
+			initialization on some boards.
 
 	no_uaccess_flush
 	                [PPC,EARLY] Don't flush the L1-D cache after accessing user data.
@@ -4192,6 +4342,11 @@
 			If given as an integer followed by 'U', it will
 			divide each physical node into N emulated nodes.
 
+	numa=noacpi	[X86] Don't parse the SRAT table for NUMA setup
+
+	numa=nohmat	[X86] Don't parse the HMAT table for NUMA setup, or
+			soft-reserved memory partitioning.
+
 	numa_balancing=	[KNL,ARM64,PPC,RISCV,S390,X86] Enable or disable automatic
 			NUMA balancing.
 			Allowed values are enable and disable
@@ -5710,6 +5865,55 @@
 			      reboot_cpu is s[mp]#### with #### being the processor
 					to be used for rebooting.
 
+		acpi
+			Use the ACPI RESET_REG in the FADT. If ACPI is not
+			configured or the ACPI reset does not work, the reboot
+			path attempts the reset using the keyboard controller.
+
+		bios
+			Use the CPU reboot vector for warm reset
+
+		cold
+			Set the cold reboot flag
+
+		default
+			There are some built-in platform specific "quirks"
+			- you may see: "reboot: <name> series board detected.
+			Selecting <type> for reboots." In the case where you
+			think the quirk is in error (e.g. you have newer BIOS,
+			or newer board) using this option will ignore the
+			built-in quirk table, and use the generic default
+			reboot actions.
+
+		efi
+			Use efi reset_system runtime service. If EFI is not
+			configured or the EFI reset does not work, the reboot
+			path attempts the reset using the keyboard controller.
+
+		force
+			Don't stop other CPUs on reboot. This can make reboot
+			more reliable in some cases.
+
+		kbd
+			Use the keyboard controller. cold reset (default)
+
+		pci
+			Use a write to the PCI config space register 0xcf9 to
+			trigger reboot.
+
+		triple
+			Force a triple fault (init)
+
+		warm
+			Don't set the cold reboot flag
+
+			Using warm reset will be much faster especially on big
+			memory systems because the BIOS will not go through
+			the memory check.  Disadvantage is that not all
+			hardware will be completely reinitialized on reboot so
+			there may be boot problems on some systems.
+
+
 	refscale.holdoff= [KNL]
 			Set test-start holdoff period.  The purpose of
 			this parameter is to delay the start of the
@@ -6101,7 +6305,16 @@
 
 	serialnumber	[BUGS=X86-32]
 
-	sev=option[,option...] [X86-64] See Documentation/arch/x86/x86_64/boot-options.rst
+	sev=option[,option...] [X86-64]
+
+		debug
+			Enable debug messages.
+
+		nosnp
+			Do not enable SEV-SNP (applies to host/hypervisor
+			only). Setting 'nosnp' avoids the RMP check overhead
+			in memory accesses when users do not want to run
+			SEV-SNP guests.
 
 	shapers=	[NET]
 			Maximal number of shapers.
diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
deleted file mode 100644
index d69e3cf..0000000
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ /dev/null
@@ -1,312 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-===========================
-AMD64 Specific Boot Options
-===========================
-
-There are many others (usually documented in driver documentation), but
-only the AMD64 specific ones are listed here.
-
-Machine check
-=============
-Please see Documentation/arch/x86/x86_64/machinecheck.rst for sysfs runtime tunables.
-
-   mce=off
-		Disable machine check
-   mce=no_cmci
-		Disable CMCI(Corrected Machine Check Interrupt) that
-		Intel processor supports.  Usually this disablement is
-		not recommended, but it might be handy if your hardware
-		is misbehaving.
-		Note that you'll get more problems without CMCI than with
-		due to the shared banks, i.e. you might get duplicated
-		error logs.
-   mce=dont_log_ce
-		Don't make logs for corrected errors.  All events reported
-		as corrected are silently cleared by OS.
-		This option will be useful if you have no interest in any
-		of corrected errors.
-   mce=ignore_ce
-		Disable features for corrected errors, e.g. polling timer
-		and CMCI.  All events reported as corrected are not cleared
-		by OS and remained in its error banks.
-		Usually this disablement is not recommended, however if
-		there is an agent checking/clearing corrected errors
-		(e.g. BIOS or hardware monitoring applications), conflicting
-		with OS's error handling, and you cannot deactivate the agent,
-		then this option will be a help.
-   mce=no_lmce
-		Do not opt-in to Local MCE delivery. Use legacy method
-		to broadcast MCEs.
-   mce=bootlog
-		Enable logging of machine checks left over from booting.
-		Disabled by default on AMD Fam10h and older because some BIOS
-		leave bogus ones.
-		If your BIOS doesn't do that it's a good idea to enable though
-		to make sure you log even machine check events that result
-		in a reboot. On Intel systems it is enabled by default.
-   mce=nobootlog
-		Disable boot machine check logging.
-   mce=monarchtimeout (number)
-		monarchtimeout:
-		Sets the time in us to wait for other CPUs on machine checks. 0
-		to disable.
-   mce=bios_cmci_threshold
-		Don't overwrite the bios-set CMCI threshold. This boot option
-		prevents Linux from overwriting the CMCI threshold set by the
-		bios. Without this option, Linux always sets the CMCI
-		threshold to 1. Enabling this may make memory predictive failure
-		analysis less effective if the bios sets thresholds for memory
-		errors since we will not see details for all errors.
-   mce=recovery
-		Force-enable recoverable machine check code paths
-
-   nomce (for compatibility with i386)
-		same as mce=off
-
-   Everything else is in sysfs now.
-
-APICs
-=====
-
-   apic
-	Use IO-APIC. Default
-
-   noapic
-	Don't use the IO-APIC.
-
-   disableapic
-	Don't use the local APIC
-
-   nolapic
-     Don't use the local APIC (alias for i386 compatibility)
-
-   pirq=...
-	See Documentation/arch/x86/i386/IO-APIC.rst
-
-   noapictimer
-	Don't set up the APIC timer
-
-   no_timer_check
-	Don't check the IO-APIC timer. This can work around
-	problems with incorrect timer initialization on some boards.
-
-   apicpmtimer
-	Do APIC timer calibration using the pmtimer. Implies
-	apicmaintimer. Useful when your PIT timer is totally broken.
-
-Timing
-======
-
-  notsc
-    Deprecated, use tsc=unstable instead.
-
-  nohpet
-    Don't use the HPET timer.
-
-Idle loop
-=========
-
-  idle=poll
-    Don't do power saving in the idle loop using HLT, but poll for rescheduling
-    event. This will make the CPUs eat a lot more power, but may be useful
-    to get slightly better performance in multiprocessor benchmarks. It also
-    makes some profiling using performance counters more accurate.
-    Please note that on systems with MONITOR/MWAIT support (like Intel EM64T
-    CPUs) this option has no performance advantage over the normal idle loop.
-    It may also interact badly with hyperthreading.
-
-Rebooting
-=========
-
-   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] | p[ci] [, [w]arm | [c]old]
-      bios
-        Use the CPU reboot vector for warm reset
-      warm
-        Don't set the cold reboot flag
-      cold
-        Set the cold reboot flag
-      triple
-        Force a triple fault (init)
-      kbd
-        Use the keyboard controller. cold reset (default)
-      acpi
-        Use the ACPI RESET_REG in the FADT. If ACPI is not configured or
-        the ACPI reset does not work, the reboot path attempts the reset
-        using the keyboard controller.
-      efi
-        Use efi reset_system runtime service. If EFI is not configured or
-        the EFI reset does not work, the reboot path attempts the reset using
-        the keyboard controller.
-      pci
-        Use a write to the PCI config space register 0xcf9 to trigger reboot.
-
-   Using warm reset will be much faster especially on big memory
-   systems because the BIOS will not go through the memory check.
-   Disadvantage is that not all hardware will be completely reinitialized
-   on reboot so there may be boot problems on some systems.
-
-   reboot=force
-     Don't stop other CPUs on reboot. This can make reboot more reliable
-     in some cases.
-
-   reboot=default
-     There are some built-in platform specific "quirks" - you may see:
-     "reboot: <name> series board detected. Selecting <type> for reboots."
-     In the case where you think the quirk is in error (e.g. you have
-     newer BIOS, or newer board) using this option will ignore the built-in
-     quirk table, and use the generic default reboot actions.
-
-NUMA
-====
-
-  numa=off
-    Only set up a single NUMA node spanning all memory.
-
-  numa=noacpi
-    Don't parse the SRAT table for NUMA setup
-
-  numa=nohmat
-    Don't parse the HMAT table for NUMA setup, or soft-reserved memory
-    partitioning.
-
-ACPI
-====
-
-  acpi=off
-    Don't enable ACPI
-  acpi=ht
-    Use ACPI boot table parsing, but don't enable ACPI interpreter
-  acpi=force
-    Force ACPI on (currently not needed)
-  acpi=strict
-    Disable out of spec ACPI workarounds.
-  acpi_sci={edge,level,high,low}
-    Set up ACPI SCI interrupt.
-  acpi=noirq
-    Don't route interrupts
-  acpi=nocmcff
-    Disable firmware first mode for corrected errors. This
-    disables parsing the HEST CMC error source to check if
-    firmware has set the FF flag. This may result in
-    duplicate corrected error reports.
-
-PCI
-===
-
-  pci=off
-    Don't use PCI
-  pci=conf1
-    Use conf1 access.
-  pci=conf2
-    Use conf2 access.
-  pci=rom
-    Assign ROMs.
-  pci=assign-busses
-    Assign busses
-  pci=irqmask=MASK
-    Set PCI interrupt mask to MASK
-  pci=lastbus=NUMBER
-    Scan up to NUMBER busses, no matter what the mptable says.
-  pci=noacpi
-    Don't use ACPI to set up PCI interrupt routing.
-
-IOMMU (input/output memory management unit)
-===========================================
-Multiple x86-64 PCI-DMA mapping implementations exist, for example:
-
-   1. <kernel/dma/direct.c>: use no hardware/software IOMMU at all
-      (e.g. because you have < 3 GB memory).
-      Kernel boot message: "PCI-DMA: Disabling IOMMU"
-
-   2. <arch/x86/kernel/amd_gart_64.c>: AMD GART based hardware IOMMU.
-      Kernel boot message: "PCI-DMA: using GART IOMMU"
-
-   3. <arch/x86_64/kernel/pci-swiotlb.c> : Software IOMMU implementation. Used
-      e.g. if there is no hardware IOMMU in the system and it is need because
-      you have >3GB memory or told the kernel to us it (iommu=soft))
-      Kernel boot message: "PCI-DMA: Using software bounce buffering
-      for IO (SWIOTLB)"
-
-::
-
-  iommu=[<size>][,noagp][,off][,force][,noforce]
-  [,memaper[=<order>]][,merge][,fullflush][,nomerge]
-  [,noaperture]
-
-General iommu options:
-
-    off
-      Don't initialize and use any kind of IOMMU.
-    noforce
-      Don't force hardware IOMMU usage when it is not needed. (default).
-    force
-      Force the use of the hardware IOMMU even when it is
-      not actually needed (e.g. because < 3 GB memory).
-    soft
-      Use software bounce buffering (SWIOTLB) (default for
-      Intel machines). This can be used to prevent the usage
-      of an available hardware IOMMU.
-
-iommu options only relevant to the AMD GART hardware IOMMU:
-
-    <size>
-      Set the size of the remapping area in bytes.
-    allowed
-      Overwrite iommu off workarounds for specific chipsets.
-    fullflush
-      Flush IOMMU on each allocation (default).
-    nofullflush
-      Don't use IOMMU fullflush.
-    memaper[=<order>]
-      Allocate an own aperture over RAM with size 32MB<<order.
-      (default: order=1, i.e. 64MB)
-    merge
-      Do scatter-gather (SG) merging. Implies "force" (experimental).
-    nomerge
-      Don't do scatter-gather (SG) merging.
-    noaperture
-      Ask the IOMMU not to touch the aperture for AGP.
-    noagp
-      Don't initialize the AGP driver and use full aperture.
-    panic
-      Always panic when IOMMU overflows.
-
-iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
-implementation:
-
-    swiotlb=<slots>[,force,noforce]
-      <slots>
-        Prereserve that many 2K slots for the software IO bounce buffering.
-      force
-        Force all IO through the software TLB.
-      noforce
-        Do not initialize the software TLB.
-
-
-Miscellaneous
-=============
-
-  nogbpages
-    Do not use GB pages for kernel direct mappings.
-  gbpages
-    Use GB pages for kernel direct mappings.
-
-
-AMD SEV (Secure Encrypted Virtualization)
-=========================================
-Options relating to AMD SEV, specified via the following format:
-
-::
-
-   sev=option1[,option2]
-
-The available options are:
-
-   debug
-     Enable debug messages.
-
-   nosnp
-     Do not enable SEV-SNP (applies to host/hypervisor only). Setting
-     'nosnp' avoids the RMP check overhead in memory accesses when
-     users do not want to run SEV-SNP guests.
diff --git a/Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst b/Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst
index ba74617..970ee94 100644
--- a/Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst
+++ b/Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst
@@ -18,7 +18,7 @@ For more information on the features of cpusets, see
 Documentation/admin-guide/cgroup-v1/cpusets.rst.
 There are a number of different configurations you can use for your needs.  For
 more information on the numa=fake command line option and its various ways of
-configuring fake nodes, see Documentation/arch/x86/x86_64/boot-options.rst.
+configuring fake nodes, see Documentation/admin-guide/kernel-parameters.txt
 
 For the purposes of this introduction, we'll assume a very primitive NUMA
 emulation setup of "numa=fake=4*512,".  This will split our system memory into
diff --git a/Documentation/arch/x86/x86_64/index.rst b/Documentation/arch/x86/x86_64/index.rst
index ad15e9b..a026195 100644
--- a/Documentation/arch/x86/x86_64/index.rst
+++ b/Documentation/arch/x86/x86_64/index.rst
@@ -7,7 +7,6 @@ x86_64 Support
 .. toctree::
    :maxdepth: 2
 
-   boot-options
    uefi
    mm
    5level-paging
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 74777a9..1eb4d23 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -97,7 +97,7 @@ config IOMMU_DEBUG
 	  code. When you use it make sure you have a big enough
 	  IOMMU/AGP aperture.  Most of the options enabled by this can
 	  be set more finegrained using the iommu= command line
-	  options. See Documentation/arch/x86/x86_64/boot-options.rst for more
+	  options. See Documentation/admin-guide/kernel-parameters.txt for more
 	  details.
 
 config IOMMU_LEAK
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index f323d83..6267363 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -108,10 +108,6 @@ void __init pci_iommu_alloc(void)
 	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
 }
 
-/*
- * See <Documentation/arch/x86/x86_64/boot-options.rst> for the iommu kernel
- * parameter documentation.
- */
 static __init int iommu_setup(char *p)
 {
 	iommu_merge = 1;

