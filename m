Return-Path: <linux-tip-commits+bounces-4648-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E04A7A3D8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668BE1745BD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63A2512DE;
	Thu,  3 Apr 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juqUjugd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HAW8UTRr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1062505C6;
	Thu,  3 Apr 2025 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687228; cv=none; b=XpnNZHGWANQnXZPpByZS6JiycVHjmkACegyHHKdAVLv1YAOYMKq/mXOUu98rAH+GthflQ1YJUUVzSt0aGcvctuiRgoo3YYpEP7KpuJzNbon90FNVksbCoogvA57GgLDRG8R5tlgm26yNDpXUpCCn+QwPo2Bnvq0aPSIv8+Uaims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687228; c=relaxed/simple;
	bh=uhjcSpFtBDjLRDUtRnxBHi7CnOXD7wN3uYc8vH18wJs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lOCOal/PSqELioKJu5Vmu99xamtm/BPlLEfEgeQi1iGWgDlXEbYqFZ79VM69Szsk+M4m1/xz/erwIUSIa13vyXzfvlTZmzTtW8CaorMBR2Osg1S0ZiBE4V9V33NoM+WuX/0nPCpa2hgWclM3BvxnsxSWvCLlJZL7jnXMW3P9sYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juqUjugd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HAW8UTRr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4t0GVqqoEaOKHTP3A31s7T5TVXWT9yknbDhYcA5lXEM=;
	b=juqUjugdcV3zR3vPWF92GsfN2hVxJCGX7TGXUzzj1xOUTo/kHHklG3VnyOOrOrNVQOG/oK
	Sd+wCkCGUK/HnagYExYpxtByuf76aLbIRHSer8qO6LV6bajQG4s78DnPo2IchQ9PB7vaYd
	34oHf2FugNdkVIMRkJNZZ88Dt6+Ed0JOcdgWVmhOWfh36pEx4X/YJZFKhKoK/dMzvfj8hT
	Ib99bMG8bfmdTn0yuJxT9aiymAJIh6CIt9rcUCRfs5mhiH3aoGQfFsq8jsdIVTQhLABJjM
	P2Jk1I2+eDY5ALIO8MvTON+VJm8Ked9wYtZ+yRnJXPfN+mf0BdSRskm7jFPVEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4t0GVqqoEaOKHTP3A31s7T5TVXWT9yknbDhYcA5lXEM=;
	b=HAW8UTRrptjd5WUVFmcDXwaY8nZxXbrqLyu6I6IuHRlox8QeVAy2XU/eU9n2sFW27J7qOu
	44FgKneEw6CgX6DA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Simplify unknown NMI panic handling
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-2-sohil.mehta@intel.com>
References: <20250327234629.3953536-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368722390.30396.10003781910348300433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     2e016da1cbbd013368095270c040e065678c38f7
Gitweb:        https://git.kernel.org/tip/2e016da1cbbd013368095270c040e065678c38f7
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:21 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:25:41 +02:00

x86/nmi: Simplify unknown NMI panic handling

The unknown_nmi_panic variable is used to control whether the kernel
should panic on unknown NMIs. There is a sysctl entry under:

  /proc/sys/kernel/unknown_nmi_panic

which can be used to change the behavior at runtime.

However, it seems that in some places, the option unnecessarily depends
on CONFIG_X86_LOCAL_APIC. Other code in nmi.c uses unknown_nmi_panic
without such a dependency. This results in a few messy #ifdefs
splattered across the code. The dependency was likely introduce due to a
potential build bug reported a long time ago:

  https://lore.kernel.org/lkml/40BC67F9.3000609@myrealbox.com/

This build bug no longer exists.

Also, similar NMI panic options, such as panic_on_unrecovered_nmi and
panic_on_io_nmi, do not have an explicit dependency on the local APIC
either.

Though, it's hard to imagine a production system without the local APIC
configuration, making a specific NMI sysctl option dependent on it
doesn't make sense.

Remove the explicit dependency between unknown NMI handling and the
local APIC to make the code cleaner and more consistent.

While at it, reorder the header includes to maintain alphabetical order.

[ mingo: Cleaned up the changelog a bit, truly ordered the headers ... ]

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-2-sohil.mehta@intel.com
---
 arch/x86/include/asm/nmi.h |  4 ++--
 arch/x86/kernel/setup.c    | 35 +++++++++++++++--------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index f677382..9cf96cc 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -14,10 +14,10 @@ extern void release_perfctr_nmi(unsigned int);
 extern int reserve_evntsel_nmi(unsigned int);
 extern void release_evntsel_nmi(unsigned int);
 
-extern int unknown_nmi_panic;
-
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+extern int unknown_nmi_panic;
+
 #define NMI_FLAG_FIRST	1
 
 enum {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c7164a8..ecf4c13 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -11,6 +11,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/efi.h>
+#include <linux/hugetlb.h>
 #include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
 #include <linux/initrd.h>
@@ -18,21 +19,19 @@
 #include <linux/memblock.h>
 #include <linux/panic_notifier.h>
 #include <linux/pci.h>
+#include <linux/random.h>
 #include <linux/root_dev.h>
-#include <linux/hugetlb.h>
-#include <linux/tboot.h>
-#include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
-#include <linux/random.h>
+#include <linux/tboot.h>
+#include <linux/usb/xhci-dbgp.h>
+#include <linux/vmalloc.h>
 
 #include <uapi/linux/mount.h>
 
 #include <xen/xen.h>
 
 #include <asm/apic.h>
-#include <asm/efi.h>
-#include <asm/numa.h>
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
 #include <asm/cacheinfo.h>
@@ -47,18 +46,16 @@
 #include <asm/mce.h>
 #include <asm/memtype.h>
 #include <asm/mtrr.h>
-#include <asm/realmode.h>
+#include <asm/nmi.h>
+#include <asm/numa.h>
 #include <asm/olpc_ofw.h>
 #include <asm/pci-direct.h>
 #include <asm/prom.h>
 #include <asm/proto.h>
+#include <asm/realmode.h>
 #include <asm/thermal.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
-#include <linux/vmalloc.h>
-#if defined(CONFIG_X86_LOCAL_APIC)
-#include <asm/nmi.h>
-#endif
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
@@ -151,6 +148,13 @@ int bootloader_type, bootloader_version;
 
 static const struct ctl_table x86_sysctl_table[] = {
 	{
+		.procname       = "unknown_nmi_panic",
+		.data           = &unknown_nmi_panic,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{
 		.procname	= "panic_on_unrecovered_nmi",
 		.data		= &panic_on_unrecovered_nmi,
 		.maxlen		= sizeof(int),
@@ -185,15 +189,6 @@ static const struct ctl_table x86_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#if defined(CONFIG_X86_LOCAL_APIC)
-	{
-		.procname       = "unknown_nmi_panic",
-		.data           = &unknown_nmi_panic,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-#endif
 #if defined(CONFIG_ACPI_SLEEP)
 	{
 		.procname	= "acpi_video_flags",

