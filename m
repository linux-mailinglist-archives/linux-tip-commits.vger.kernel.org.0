Return-Path: <linux-tip-commits+bounces-3706-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE8A47A8C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566741703EF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199822B8B9;
	Thu, 27 Feb 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Ka/USsk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sU/wFQFW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0E22A801;
	Thu, 27 Feb 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652938; cv=none; b=O3nbSg7cgWkxLPvlKb2ZYqTWHlFLYg1xD6RB1E+5D5jZwil6Iv8hpQXX4lJPpao1yDhPVaB8RPuaAxzDIy/Ad8+Etv21LDUUS6kBGcQGmufQmEImMwfySR1IEXHDHPLKgAIpiq1LgICCbXZUUL1RFe5SBTPptiCUijISune2AZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652938; c=relaxed/simple;
	bh=EYnUwjU8rAc7vy5qfgO0HfS6NwKjgIHO5vaApt+0TZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i/e1nckeimHje+rTEeJgokCjraLctmSY59Acbb658GNif/Elt1u9GF4nVEqiqplTkQt8YL0twyljAJ3lvB4c6qkMSU3GXbztuhv8/iVQZEaE15Jz4pmKrQj0e1tQ+1G18tiglL1XMISfR+rtYIy7pF2LBbCDwNHnUHH3pnQfrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Ka/USsk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sU/wFQFW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWzodRqT8YDGO5D5YPAfnFSoEmnHOhgQpZl2QhTGNp4=;
	b=4Ka/USskZlzI9MAYbIdffAE1kQ0sIgCbBlHRBSWw+cJHkTPbrr6laBNmazm0yYwW62Jwtv
	KaDmy17nM2X+nPJKIcguHVHuKxSBnBJ8X2FUtsPFpSLwB5NUFoTTilYPv0M0WHwZ8NAfed
	ssGbINQ0k+jGXqTFsxejNZ83+Hg8r4A1fOqxc4JlSlEqB+nVWvjq+OYgqJxMSPGdiTeaV1
	VaU4goErw/erbhjZprAeP1IXnJC3tTZjT4zvKGnUW5eYm2O16rr3s4kc6zcI8CYWBMSkOk
	0qi1JQZGEBqAlvDi17U4EMaHVpq8MjK7TEgSXc6YdOI1n5LeLPisc4C3ltp0tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWzodRqT8YDGO5D5YPAfnFSoEmnHOhgQpZl2QhTGNp4=;
	b=sU/wFQFWL1GxUdOf76J4rCmx9I9FSRv+gdNz7UbqQadrCmreCwDgovpqzy/koEoMxEKZgF
	+nj53bzj5mGLiJDg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Drop configuration options for early 64-bit CPUs
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-5-arnd@kernel.org>
References: <20250226213714.4040853-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065293385.10177.8552261502512949515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f388f60ca9041a95c9b3f157d316ed7c8f297e44
Gitweb:        https://git.kernel.org/tip/f388f60ca9041a95c9b3f157d316ed7c8f297e44
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:19:06 +01:00

x86/cpu: Drop configuration options for early 64-bit CPUs

The x86 CPU selection menu is confusing for a number of reasons:

When configuring 32-bit kernels, it shows a small number of early 64-bit
microarchitectures (K8, Core 2) but not the regular generic 64-bit target
that is the normal default.  There is no longer a reason to run 32-bit
kernels on production 64-bit systems, so only actual 32-bit CPUs need
to be shown here.

When configuring 64-bit kernels, the options also pointless as there is
no way to pick any CPU from the past 15 years, leaving GENERIC_CPU as
the only sensible choice.

Address both of the above by removing the obsolete options and making
all 64-bit kernels run on both Intel and AMD CPUs from any generation.
Testing generic 32-bit kernels on 64-bit hardware remains possible,
just not building a 32-bit kernel that requires a 64-bit CPU.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-5-arnd@kernel.org
---
 arch/x86/Kconfig.cpu            | 95 ++++----------------------------
 arch/x86/Makefile               | 16 +-----
 arch/x86/Makefile_32.cpu        |  5 +--
 arch/x86/include/asm/vermagic.h |  4 +-
 drivers/misc/mei/Kconfig        |  2 +-
 5 files changed, 18 insertions(+), 104 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 42e6a40..8fcb8cc 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Put here option for CPU selection and depending optimization
 choice
-	prompt "Processor family"
-	default M686 if X86_32
-	default GENERIC_CPU if X86_64
+	prompt "x86-32 Processor family"
+	depends on X86_32
+	default M686
 	help
 	  This is the processor type of your CPU. This information is
 	  used for optimizing purposes. In order to compile a kernel
@@ -31,7 +31,6 @@ choice
 	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
 	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
 	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
-	  - "Opteron/Athlon64/Hammer/K8" for all K8 and newer AMD CPUs.
 	  - "Crusoe" for the Transmeta Crusoe series.
 	  - "Efficeon" for the Transmeta Efficeon series.
 	  - "Winchip-C6" for original IDT Winchip.
@@ -42,13 +41,10 @@ choice
 	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
 	  - "VIA C3-2" for VIA C3-2 "Nehemiah" (model 9 and above).
 	  - "VIA C7" for VIA C7.
-	  - "Intel P4" for the Pentium 4/Netburst microarchitecture.
-	  - "Core 2/newer Xeon" for all core2 and newer Intel CPUs.
 	  - "Intel Atom" for the Atom-microarchitecture CPUs.
-	  - "Generic-x86-64" for a kernel which runs on any x86-64 CPU.
 
 	  See each option's help text for additional details. If you don't know
-	  what to do, choose "486".
+	  what to do, choose "Pentium-Pro".
 
 config M486SX
 	bool "486SX"
@@ -114,11 +110,11 @@ config MPENTIUMIII
 	  extensions.
 
 config MPENTIUMM
-	bool "Pentium M"
+	bool "Pentium M/Pentium Dual Core/Core Solo/Core Duo"
 	depends on X86_32
 	help
 	  Select this for Intel Pentium M (not Pentium-4 M)
-	  notebook chips.
+	  "Merom" Core Solo/Duo notebook chips
 
 config MPENTIUM4
 	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/older Xeon"
@@ -139,22 +135,10 @@ config MPENTIUM4
 		-Mobile Pentium 4
 		-Mobile Pentium 4 M
 		-Extreme Edition (Gallatin)
-		-Prescott
-		-Prescott 2M
-		-Cedar Mill
-		-Presler
-		-Smithfiled
 	    Xeons (Intel Xeon, Xeon MP, Xeon LV, Xeon MV) corename:
 		-Foster
 		-Prestonia
 		-Gallatin
-		-Nocona
-		-Irwindale
-		-Cranford
-		-Potomac
-		-Paxville
-		-Dempsey
-
 
 config MK6
 	bool "K6/K6-II/K6-III"
@@ -172,13 +156,6 @@ config MK7
 	  some extended instructions, and passes appropriate optimization
 	  flags to GCC.
 
-config MK8
-	bool "Opteron/Athlon64/Hammer/K8"
-	help
-	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.
-	  Enables use of some extended instructions, and passes appropriate
-	  optimization flags to GCC.
-
 config MCRUSOE
 	bool "Crusoe"
 	depends on X86_32
@@ -258,42 +235,14 @@ config MVIAC7
 	  Select this for a VIA C7.  Selecting this uses the correct cache
 	  shift and tells gcc to treat the CPU as a 686.
 
-config MPSC
-	bool "Intel P4 / older Netburst based Xeon"
-	depends on X86_64
-	help
-	  Optimize for Intel Pentium 4, Pentium D and older Nocona/Dempsey
-	  Xeon CPUs with Intel 64bit which is compatible with x86-64.
-	  Note that the latest Xeons (Xeon 51xx and 53xx) are not based on the
-	  Netburst core and shouldn't use this option. You can distinguish them
-	  using the cpu family field
-	  in /proc/cpuinfo. Family 15 is an older Xeon, Family 6 a newer one.
-
-config MCORE2
-	bool "Core 2/newer Xeon"
-	help
-
-	  Select this for Intel Core 2 and newer Core 2 Xeons (Xeon 51xx and
-	  53xx) CPUs. You can distinguish newer from older Xeons by the CPU
-	  family in /proc/cpuinfo. Newer ones have 6 and older ones 15
-	  (not a typo)
-
 config MATOM
 	bool "Intel Atom"
 	help
-
 	  Select this for the Intel Atom platform. Intel Atom CPUs have an
 	  in-order pipelining architecture and thus can benefit from
 	  accordingly optimized code. Use a recent GCC with specific Atom
 	  support in order to fully benefit from selecting this option.
 
-config GENERIC_CPU
-	bool "Generic-x86-64"
-	depends on X86_64
-	help
-	  Generic x86-64 CPU.
-	  Run equally well on all x86-64 CPUs.
-
 endchoice
 
 config X86_GENERIC
@@ -317,8 +266,8 @@ config X86_INTERNODE_CACHE_SHIFT
 
 config X86_L1_CACHE_SHIFT
 	int
-	default "7" if MPENTIUM4 || MPSC
-	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
+	default "7" if MPENTIUM4
+	default "6" if MK7 || MPENTIUMM || MATOM || MVIAC7 || X86_GENERIC || X86_64
 	default "4" if MELAN || M486SX || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
@@ -336,35 +285,19 @@ config X86_ALIGNMENT_16
 
 config X86_INTEL_USERCOPY
 	def_bool y
-	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2
+	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK7 || MEFFICEON
 
 config X86_USE_PPRO_CHECKSUM
 	def_bool y
-	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM
-
-#
-# P6_NOPs are a relatively minor optimization that require a family >=
-# 6 processor, except that it is broken on certain VIA chips.
-# Furthermore, AMD chips prefer a totally different sequence of NOPs
-# (which work on all CPUs).  In addition, it looks like Virtual PC
-# does not understand them.
-#
-# As a result, disallow these if we're not compiling for X86_64 (these
-# NOPs do work on all x86-64 capable chips); the list of processors in
-# the right-hand clause are the cores that benefit from this optimization.
-#
-config X86_P6_NOP
-	def_bool y
-	depends on X86_64
-	depends on (MCORE2 || MPENTIUM4 || MPSC)
+	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MATOM
 
 config X86_TSC
 	def_bool y
-	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64
+	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MATOM) || X86_64
 
 config X86_HAVE_PAE
 	def_bool y
-	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64
+	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
 
 config X86_CMPXCHG64
 	def_bool y
@@ -374,12 +307,12 @@ config X86_CMPXCHG64
 # generates cmov.
 config X86_CMOV
 	def_bool y
-	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
+	depends on (MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || MATOM || MGEODE_LX || X86_64)
 
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MK7)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5af3172..8120085 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -178,20 +178,8 @@ else
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
-        # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
-        cflags-$(CONFIG_MK8)		+= -march=k8
-        cflags-$(CONFIG_MPSC)		+= -march=nocona
-        cflags-$(CONFIG_MCORE2)		+= -march=core2
-        cflags-$(CONFIG_MATOM)		+= -march=atom
-        cflags-$(CONFIG_GENERIC_CPU)	+= -march=x86-64 -mtune=generic
-        KBUILD_CFLAGS += $(cflags-y)
-
-        rustflags-$(CONFIG_MK8)		+= -Ctarget-cpu=k8
-        rustflags-$(CONFIG_MPSC)	+= -Ctarget-cpu=nocona
-        rustflags-$(CONFIG_MCORE2)	+= -Ctarget-cpu=core2
-        rustflags-$(CONFIG_MATOM)	+= -Ctarget-cpu=atom
-        rustflags-$(CONFIG_GENERIC_CPU)	+= -Ctarget-cpu=x86-64 -Ztune-cpu=generic
-        KBUILD_RUSTFLAGS += $(rustflags-y)
+        KBUILD_CFLAGS += -march=x86-64 -mtune=generic
+        KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index 94834c4..af7de9a 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -24,7 +24,6 @@ cflags-$(CONFIG_MK6)		+= -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
 cflags-$(CONFIG_MK7)		+= -march=athlon
-cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,-march=athlon)
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)
 cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call tune,pentium3) $(align)
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
@@ -32,9 +31,7 @@ cflags-$(CONFIG_MWINCHIP3D)	+= $(call cc-option,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MCYRIXIII)	+= $(call cc-option,-march=c3,-march=i486) $(align)
 cflags-$(CONFIG_MVIAC3_2)	+= $(call cc-option,-march=c3-2,-march=i686)
 cflags-$(CONFIG_MVIAC7)		+= -march=i686
-cflags-$(CONFIG_MCORE2)		+= -march=i686 $(call tune,core2)
-cflags-$(CONFIG_MATOM)		+= $(call cc-option,-march=atom,$(call cc-option,-march=core2,-march=i686)) \
-	$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
+cflags-$(CONFIG_MATOM)		+= -march=atom
 
 # AMD Elan support
 cflags-$(CONFIG_MELAN)		+= -march=i486
diff --git a/arch/x86/include/asm/vermagic.h b/arch/x86/include/asm/vermagic.h
index 75884d2..5d47125 100644
--- a/arch/x86/include/asm/vermagic.h
+++ b/arch/x86/include/asm/vermagic.h
@@ -15,8 +15,6 @@
 #define MODULE_PROC_FAMILY "586TSC "
 #elif defined CONFIG_M586MMX
 #define MODULE_PROC_FAMILY "586MMX "
-#elif defined CONFIG_MCORE2
-#define MODULE_PROC_FAMILY "CORE2 "
 #elif defined CONFIG_MATOM
 #define MODULE_PROC_FAMILY "ATOM "
 #elif defined CONFIG_M686
@@ -33,8 +31,6 @@
 #define MODULE_PROC_FAMILY "K6 "
 #elif defined CONFIG_MK7
 #define MODULE_PROC_FAMILY "K7 "
-#elif defined CONFIG_MK8
-#define MODULE_PROC_FAMILY "K8 "
 #elif defined CONFIG_MELAN
 #define MODULE_PROC_FAMILY "ELAN "
 #elif defined CONFIG_MCRUSOE
diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 67d9391..7575fee 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -3,7 +3,7 @@
 config INTEL_MEI
 	tristate "Intel Management Engine Interface"
 	depends on X86 && PCI
-	default GENERIC_CPU || MCORE2 || MATOM || X86_GENERIC
+	default X86_64 || MATOM
 	help
 	  The Intel Management Engine (Intel ME) provides Manageability,
 	  Security and Media services for system containing Intel chipsets.

