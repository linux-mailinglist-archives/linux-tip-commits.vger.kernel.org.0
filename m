Return-Path: <linux-tip-commits+bounces-3517-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E796A39BF4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902C43B077C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9AA2594BD;
	Tue, 18 Feb 2025 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9xIP6TG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vTpqMLQu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE302500C4;
	Tue, 18 Feb 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880721; cv=none; b=KhDLcET+Wtdx4veDV6Bpas1367+S+GJY6Y19GnT7mu2LGq/s2a+hvmM5DxvXGn43at6+rH4ZJwNE0rIUmifwL7ScFaf2UHsLXlelawdK+eZT/Nqo4mo2MLSZfAMZhbnGFUsykg0UtP56DHgwfCKTODdxa28DiwoNcPPXWiSFjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880721; c=relaxed/simple;
	bh=W6w1/Vacrur1pcpvVnMp+xkM6fR361cHrJ1NSteer30=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BVMi/9PLLLBiBPn4Dc1jJZJCKsmbpMwrCOZ2CRjr4CHLuAQsw18lHwGwL5lJo8Ez7zjMJ49pseAplQhEQBuU52+EEX9vcWmzNLzJG2qdoXt7IhZyItDLInkOqx43UYVtBP50yZ8/rUBNmgtwGsjK+eJrlgiI5hFVNloxf2aEvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9xIP6TG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vTpqMLQu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+jAL2EbFf+wvIEmlf+5o1e6USnhY/c/I7XzfHPLBpU=;
	b=j9xIP6TGptxtJJK+76oL4ZTeWkv9rV2xjD4etsGmZYAvTmK0hVX35PLox9skleSVAFvxge
	D4kj9ZsbcEDxmbtFMBJn9xXPHckkGBiSALr6F8Aqo+KNljtru8tT15cyOOZUIPV6zZWV2n
	W2GubeZaSgKe4MYKWb3utmCKaKEmCky+aMkjR6kHCCgmGU9vJH3YuCZWRNjeOLur5eRU9L
	NkS6Ex9tytSAe0MLle6bYQK5r25l5YFHWMPgOH6yacWuPUtpQpkVoD7C2ohD9I0bMQ1R/I
	j+Ax5xnRjGxQFTbmJM7UHxtkhUQAGOFT48s01lnXRGv5+z0bEcTjcTFT6tpxhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+jAL2EbFf+wvIEmlf+5o1e6USnhY/c/I7XzfHPLBpU=;
	b=vTpqMLQuNJksjurwiXZNA3wmEpEecFt2iDPBqrvB7Io0YE4lcxCLdkNMi52PgMdykSJZMR
	Z6Djbqe/bFCsewCw==
From: "tip-bot2 for Joel Granados" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Move sysctls into arch/x86
Cc: Joel Granados <joel.granados@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250218-jag-mv_ctltables-v1-8-cd3698ab8d29@kernel.org>
References: <20250218-jag-mv_ctltables-v1-8-cd3698ab8d29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988071721.10177.12280681171931939473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c305a4e98378903da5322c598381ad1ce643f4b4
Gitweb:        https://git.kernel.org/tip/c305a4e98378903da5322c598381ad1ce643f4b4
Author:        Joel Granados <joel.granados@kernel.org>
AuthorDate:    Tue, 18 Feb 2025 10:56:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 11:08:36 +01:00

x86: Move sysctls into arch/x86

Move the following sysctl tables into arch/x86/kernel/setup.c:

  panic_on_{unrecoverable_nmi,io_nmi}
  bootloader_{type,version}
  io_delay_type
  unknown_nmi_panic
  acpi_realmode_flags

Variables moved from include/linux/ to arch/x86/include/asm/ because there
is no longer need for them outside arch/x86/kernel:

  acpi_realmode_flags
  panic_on_{unrecoverable_nmi,io_nmi}

Include <asm/nmi.h> in arch/s86/kernel/setup.h in order to bring in
panic_on_{io_nmi,unrecovered_nmi}.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250218-jag-mv_ctltables-v1-8-cd3698ab8d29@kernel.org
---
 arch/x86/include/asm/setup.h |  1 +-
 arch/x86/include/asm/traps.h |  2 +-
 arch/x86/kernel/setup.c      | 66 +++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h         |  1 +-
 kernel/sysctl.c              | 56 +------------------------------
 5 files changed, 67 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 85f4fde..a8d676b 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -46,6 +46,7 @@ void setup_bios_corruption_check(void);
 void early_platform_quirks(void);
 
 extern unsigned long saved_video_mode;
+extern unsigned long acpi_realmode_flags;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 1f1deae..869b880 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -35,8 +35,6 @@ static inline int get_si_code(unsigned long condition)
 		return TRAP_BRKPT;
 }
 
-extern int panic_on_unrecovered_nmi;
-
 void math_emulate(struct math_emu_info *);
 
 bool fault_in_kernel_space(unsigned long address);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee31..9f8ff3a 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -56,6 +56,9 @@
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
 #include <linux/vmalloc.h>
+#if defined(CONFIG_X86_LOCAL_APIC)
+#include <asm/nmi.h>
+#endif
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
@@ -146,6 +149,69 @@ static size_t ima_kexec_buffer_size;
 /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
 int bootloader_type, bootloader_version;
 
+static const struct ctl_table x86_sysctl_table[] = {
+	{
+		.procname	= "panic_on_unrecovered_nmi",
+		.data		= &panic_on_unrecovered_nmi,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "panic_on_io_nmi",
+		.data		= &panic_on_io_nmi,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "bootloader_type",
+		.data		= &bootloader_type,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "bootloader_version",
+		.data		= &bootloader_version,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "io_delay_type",
+		.data		= &io_delay_type,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#if defined(CONFIG_X86_LOCAL_APIC)
+	{
+		.procname       = "unknown_nmi_panic",
+		.data           = &unknown_nmi_panic,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+#endif
+#if defined(CONFIG_ACPI_SLEEP)
+	{
+		.procname	= "acpi_video_flags",
+		.data		= &acpi_realmode_flags,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+#endif
+};
+
+static int __init init_x86_sysctl(void)
+{
+	register_sysctl_init("kernel", x86_sysctl_table);
+	return 0;
+}
+arch_initcall(init_x86_sysctl);
+
 /*
  * Setup options
  */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b2..a70e62d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -330,7 +330,6 @@ static inline bool acpi_sci_irq_valid(void)
 }
 
 extern int sbf_port;
-extern unsigned long acpi_realmode_flags;
 
 int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb57da4..8a37d30 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1831,16 +1831,6 @@ static const struct ctl_table kern_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
 	},
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
-	{
-		.procname       = "unknown_nmi_panic",
-		.data           = &unknown_nmi_panic,
-		.maxlen         = sizeof (int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-#endif
-
 #if (defined(CONFIG_X86_32) || defined(CONFIG_PARISC)) && \
 	defined(CONFIG_DEBUG_STACKOVERFLOW)
 	{
@@ -1851,43 +1841,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#if defined(CONFIG_X86)
-	{
-		.procname	= "panic_on_unrecovered_nmi",
-		.data		= &panic_on_unrecovered_nmi,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "panic_on_io_nmi",
-		.data		= &panic_on_io_nmi,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "bootloader_type",
-		.data		= &bootloader_type,
-		.maxlen		= sizeof (int),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "bootloader_version",
-		.data		= &bootloader_version,
-		.maxlen		= sizeof (int),
-		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "io_delay_type",
-		.data		= &io_delay_type,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #if defined(CONFIG_MMU)
 	{
 		.procname	= "randomize_va_space",
@@ -1906,15 +1859,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#if	defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
-	{
-		.procname	= "acpi_video_flags",
-		.data		= &acpi_realmode_flags,
-		.maxlen		= sizeof (unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-#endif
 #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
 	{
 		.procname	= "ignore-unaligned-usertrap",

