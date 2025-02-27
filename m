Return-Path: <linux-tip-commits+bounces-3705-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDBFA47A8B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E2F170C76
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AE22B8AB;
	Thu, 27 Feb 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8xxvxDt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20IiSxKE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F222A7F7;
	Thu, 27 Feb 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652938; cv=none; b=E5aJjG0nE5YxpW1+O7ETMd82g1KokZSCV57oiKSNrqO35Z+NNY3FcRKD4GPlLiAE9xuCCocsyTjs0byil0xgJJqTzyI7YghING27hUBp3/Up3IJ7O5zT6Gu2+1G/3gDwTNwaSe3Wsz+KcHahJeSQ05hdTgFVcUgIeMoqoVyHn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652938; c=relaxed/simple;
	bh=GiRVn9LoNskavqSFHOzk9beXXtla4zZyctOvAF/x0lE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RoVPpGNhMDQHcqGmG44ozoPSz+1cW0cyO6yQ0n+2uK5WqqSg2P+RlbRGxeJFzm/I1oC5GZr1M4J/cCja3MG0TxED+L9pl/ILl7n5X6actM5nbJrkiRJOSd6/kIhP4ajyx6FTvf/v3/vsZnQj80iQnI6U4zm+s/uGhPetJjdWOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8xxvxDt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20IiSxKE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnS4+DcVp5X3vs3MP68sD221TLxpGbQYe0GuYLfsGgA=;
	b=t8xxvxDtAj/i6GM7G8VQZKKBX++qCMSh0LUxpG9BN268cgi+sUMAKKJQfSW54RAmEIttCY
	rHA6Aef0sqz761qNokYquuA/1TqJQQhSH2IDp+nr6hcTHY+003AL/l4zQ0jJsqPfHywWSm
	Yq59TEeXNnpu4tfsewwpARRonFBH54y7rqPshLL4mnJaUYxp9RcawaZnpbbNMQTzYJFyrI
	SiX/nrDhedmMVvg0fqwzNeOXfKzIE4zbOqpRRZhCu/MRe5MO1M8P3MGLuRxCATXslqGmr5
	T/PsMYZ5KvOPh3mNemZot86he8roW+8N+aqdNUPQvRjY91S5FuQwlu4081JcoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnS4+DcVp5X3vs3MP68sD221TLxpGbQYe0GuYLfsGgA=;
	b=20IiSxKEEyF+NPcmnCsLHcn8ESaSEezmdA7uQZyyde9nI7qJs4MYGhBqzRngA7/lhDO8qR
	tKnagJOF+JNO/lDA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Remove CONFIG_HIGHMEM64G support
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-6-arnd@kernel.org>
References: <20250226213714.4040853-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065293297.10177.16425148066296540101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     bbeb69ce301323e84f1677484eb8e4cd8fb1f9f8
Gitweb:        https://git.kernel.org/tip/bbeb69ce301323e84f1677484eb8e4cd8fb1f9f8
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:21:53 +01:00

x86/mm: Remove CONFIG_HIGHMEM64G support

HIGHMEM64G support was added in linux-2.3.25 to support (then)
high-end Pentium Pro and Pentium III Xeon servers with more than 4GB of
addressing, NUMA and PCI-X slots started appearing.

I have found no evidence of this ever being used in regular dual-socket
servers or consumer devices, all the users seem obsolete these days,
even by i386 standards:

 - Support for NUMA servers (NUMA-Q, IBM x440, unisys) was already
   removed ten years ago.

 - 4+ socket non-NUMA servers based on Intel 450GX/450NX, HP F8 and
   ServerWorks ServerSet/GrandChampion could theoretically still work
   with 8GB, but these were exceptionally rare even 20 years ago and
   would have usually been equipped with than the maximum amount of
   RAM.

 - Some SKUs of the Celeron D from 2004 had 64-bit mode fused off but
   could still work in a Socket 775 mainboard designed for the later
   Core 2 Duo and 8GB. Apparently most BIOSes at the time only allowed
   64-bit CPUs.

 - The rare Xeon LV "Sossaman" came on a few motherboards with
   registered DDR2 memory support up to 16GB.

 - In the early days of x86-64 hardware, there was sometimes the need
   to run a 32-bit kernel to work around bugs in the hardware drivers,
   or in the syscall emulation for 32-bit userspace. This likely still
   works but there should never be a need for this any more.

PAE mode is still required to get access to the 'NX' bit on Atom
'Pentium M' and 'Core Duo' CPUs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-6-arnd@kernel.org
---
 Documentation/admin-guide/kdump/kdump.rst     |  4 +--
 Documentation/arch/x86/usb-legacy-support.rst | 11 +----
 arch/x86/Kconfig                              | 46 ++----------------
 arch/x86/configs/xen.config                   |  2 +-
 arch/x86/include/asm/page_32_types.h          |  4 +-
 arch/x86/mm/init_32.c                         |  9 +----
 6 files changed, 11 insertions(+), 65 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 5376890..1f7f14c 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -180,10 +180,6 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
 1) On i386, enable high memory support under "Processor type and
    features"::
 
-	CONFIG_HIGHMEM64G=y
-
-   or::
-
 	CONFIG_HIGHMEM4G
 
 2) With CONFIG_SMP=y, usually nr_cpus=1 need specified on the kernel
diff --git a/Documentation/arch/x86/usb-legacy-support.rst b/Documentation/arch/x86/usb-legacy-support.rst
index e01c08b..b17bf12 100644
--- a/Documentation/arch/x86/usb-legacy-support.rst
+++ b/Documentation/arch/x86/usb-legacy-support.rst
@@ -20,11 +20,7 @@ It has several drawbacks, though:
    features (wheel, extra buttons, touchpad mode) of the real PS/2 mouse may
    not be available.
 
-2) If CONFIG_HIGHMEM64G is enabled, the PS/2 mouse emulation can cause
-   system crashes, because the SMM BIOS is not expecting to be in PAE mode.
-   The Intel E7505 is a typical machine where this happens.
-
-3) If AMD64 64-bit mode is enabled, again system crashes often happen,
+2) If AMD64 64-bit mode is enabled, again system crashes often happen,
    because the SMM BIOS isn't expecting the CPU to be in 64-bit mode.  The
    BIOS manufacturers only test with Windows, and Windows doesn't do 64-bit
    yet.
@@ -38,11 +34,6 @@ Problem 1)
   compiled-in, too.
 
 Problem 2)
-  can currently only be solved by either disabling HIGHMEM64G
-  in the kernel config or USB Legacy support in the BIOS. A BIOS update
-  could help, but so far no such update exists.
-
-Problem 3)
   is usually fixed by a BIOS update. Check the board
   manufacturers web site. If an update is not available, disable USB
   Legacy support in the BIOS. If this alone doesn't help, try also adding
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 887b77b..737a0c6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1388,15 +1388,11 @@ config X86_CPUID
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
 
-choice
-	prompt "High Memory Support"
-	default HIGHMEM4G
+config HIGHMEM4G
+	bool "High Memory Support"
 	depends on X86_32
-
-config NOHIGHMEM
-	bool "off"
 	help
-	  Linux can use up to 64 Gigabytes of physical memory on x86 systems.
+	  Linux can use up to 4 Gigabytes of physical memory on x86 systems.
 	  However, the address space of 32-bit x86 processors is only 4
 	  Gigabytes large. That means that, if you have a large amount of
 	  physical memory, not all of it can be "permanently mapped" by the
@@ -1412,38 +1408,9 @@ config NOHIGHMEM
 	  possible.
 
 	  If the machine has between 1 and 4 Gigabytes physical RAM, then
-	  answer "4GB" here.
+	  answer "Y" here.
 
-	  If more than 4 Gigabytes is used then answer "64GB" here. This
-	  selection turns Intel PAE (Physical Address Extension) mode on.
-	  PAE implements 3-level paging on IA32 processors. PAE is fully
-	  supported by Linux, PAE mode is implemented on all recent Intel
-	  processors (Pentium Pro and better). NOTE: If you say "64GB" here,
-	  then the kernel will not boot on CPUs that don't support PAE!
-
-	  The actual amount of total physical memory will either be
-	  auto detected or can be forced by using a kernel command line option
-	  such as "mem=256M". (Try "man bootparam" or see the documentation of
-	  your boot loader (lilo or loadlin) about how to pass options to the
-	  kernel at boot time.)
-
-	  If unsure, say "off".
-
-config HIGHMEM4G
-	bool "4GB"
-	help
-	  Select this if you have a 32-bit processor and between 1 and 4
-	  gigabytes of physical RAM.
-
-config HIGHMEM64G
-	bool "64GB"
-	depends on X86_HAVE_PAE
-	select X86_PAE
-	help
-	  Select this if you have a 32-bit processor and more than 4
-	  gigabytes of physical RAM.
-
-endchoice
+	  If unsure, say N.
 
 choice
 	prompt "Memory split" if EXPERT
@@ -1489,8 +1456,7 @@ config PAGE_OFFSET
 	depends on X86_32
 
 config HIGHMEM
-	def_bool y
-	depends on X86_32 && (HIGHMEM64G || HIGHMEM4G)
+	def_bool HIGHMEM4G
 
 config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
diff --git a/arch/x86/configs/xen.config b/arch/x86/configs/xen.config
index 5812962..d5d091e 100644
--- a/arch/x86/configs/xen.config
+++ b/arch/x86/configs/xen.config
@@ -1,6 +1,4 @@
 # global x86 required specific stuff
-# On 32-bit HIGHMEM4G is not allowed
-CONFIG_HIGHMEM64G=y
 CONFIG_64BIT=y
 
 # These enable us to allow some of the
diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index faf9cc1..25c3265 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -11,8 +11,8 @@
  * a virtual address space of one gigabyte, which limits the
  * amount of physical memory you can use to about 950MB.
  *
- * If you want more physical memory than this then see the CONFIG_HIGHMEM4G
- * and CONFIG_HIGHMEM64G options in the kernel configuration.
+ * If you want more physical memory than this then see the CONFIG_VMSPLIT_2G
+ * and CONFIG_HIGHMEM4G options in the kernel configuration.
  */
 #define __PAGE_OFFSET_BASE	_AC(CONFIG_PAGE_OFFSET, UL)
 #define __PAGE_OFFSET		__PAGE_OFFSET_BASE
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index ac41b1e..f288aad 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -582,7 +582,7 @@ static void __init lowmem_pfn_init(void)
 	"only %luMB highmem pages available, ignoring highmem size of %luMB!\n"
 
 #define MSG_HIGHMEM_TRIMMED \
-	"Warning: only 4GB will be used. Use a HIGHMEM64G enabled kernel!\n"
+	"Warning: only 4GB will be used. Support for for CONFIG_HIGHMEM64G was removed!\n"
 /*
  * We have more RAM than fits into lowmem - we try to put it into
  * highmem, also taking the highmem=x boot parameter into account:
@@ -606,18 +606,13 @@ static void __init highmem_pfn_init(void)
 #ifndef CONFIG_HIGHMEM
 	/* Maximum memory usable is what is directly addressable */
 	printk(KERN_WARNING "Warning only %ldMB will be used.\n", MAXMEM>>20);
-	if (max_pfn > MAX_NONPAE_PFN)
-		printk(KERN_WARNING "Use a HIGHMEM64G enabled kernel.\n");
-	else
-		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
+	printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
 	max_pfn = MAXMEM_PFN;
 #else /* !CONFIG_HIGHMEM */
-#ifndef CONFIG_HIGHMEM64G
 	if (max_pfn > MAX_NONPAE_PFN) {
 		max_pfn = MAX_NONPAE_PFN;
 		printk(KERN_WARNING MSG_HIGHMEM_TRIMMED);
 	}
-#endif /* !CONFIG_HIGHMEM64G */
 #endif /* !CONFIG_HIGHMEM */
 }
 

