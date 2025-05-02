Return-Path: <linux-tip-commits+bounces-5178-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA4AA6E3F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF98189202A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB99022FE0F;
	Fri,  2 May 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yH/+yG7C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qdiJOg8J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53013AD24;
	Fri,  2 May 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178596; cv=none; b=M+59ja+SDU8+aRRjD8V7MBITbccz8CXAg8JBqRST9BmYN7v1et3OJdeyvEpNPYz4ZLOHhvDJ/VbDuCBkJVH37knw8xPvp4VO0Hwc71myj7CyA2nAaSbdZH9pw8goTGSWnC9LijKD1yhgwcsGwhmt+Kz5g4xr/Y6c/q7m1yh58FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178596; c=relaxed/simple;
	bh=cybWIbhdToiqjztt3t74GVKMu7l8DKLMUUSdZkohcSw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=swqCSHL8/NAY9lVCibHpkszOU36AM5Zro0IKM4TyoWsHTb1zgJrodsCSqY401hPHrry2plJH4ASCShgC6396OqWcQIQtK3dymqMp/oGexi3gfgG2c5PVTDmDt8iv22cDDru2EFEbwXLUf4KGD7tIVarDT2vr6AbMzpVBNi66viw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yH/+yG7C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qdiJOg8J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746178590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K14BzHu6GdVpLsnaehFsUxthQ57AFgSmSHdAIrF/bhU=;
	b=yH/+yG7CI1z3d1ISBaxkMA3F/0wud/qCFOl95IYWBTW9uqTD90BrxZyYukfHXdf1BNj9rt
	WsdAiVEQDTKdsuNIOiZDjsUBcTqvUEf4QYqxtER/etcW7c6gpIA2GpS73zSoHhtIKu/SY7
	+8FdfDe236omuzocKb79aQibOBAYo9bER1TvmlRpkWCwlh/NWiEEpV0QOB0zS0dUgvrPf4
	62NxdGR/RM6pb+oeKw8z2+wg/lCgq4J5OQx0LxaR+tAZURzKYiib9KtUOg8xqxnUXVzl7R
	ommjHoJimaC9Ak48LKfoTFN0ZTggZs67H1Eu0L2bNekegxoFU6DbG4+lO9HHgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746178590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K14BzHu6GdVpLsnaehFsUxthQ57AFgSmSHdAIrF/bhU=;
	b=qdiJOg8JJs9LfQSQe0kPTQnpNeJyLSmW9TLWYg6Id+z/q3Ia6rLzfePQ1exErxtl+40GwS
	azisU29Ln568WIBA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/CPU/AMD: Print the reason for the last reset
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250422234830.2840784-6-superm1@kernel.org>
References: <20250422234830.2840784-6-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617858494.22196.5727323411231361285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     b343579de7b250101e4ed6c354b4c1fa986973a7
Gitweb:        https://git.kernel.org/tip/b343579de7b250101e4ed6c354b4c1fa986973a7
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 22 Apr 2025 18:48:30 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 02 May 2025 10:57:40 +02:00

x86/CPU/AMD: Print the reason for the last reset

The following register contains bits that indicate the cause for the
previous reset.

  PMx000000C0 (FCH::PM::S5_RESET_STATUS)

This is useful for debug. The reasons for reset are broken into 6 high level
categories. Decode it by category and print during boot.

Specifics within a category are split off into debugging documentation.

The register is accessed indirectly through a "PM" port in the FCH. Use
MMIO access in order to avoid restrictions with legacy port access.

Use a late_initcall() to ensure that MMIO has been set up before trying to
access the register.

This register was introduced with AMD Family 17h, so avoid access on older
families. There is no CPUID feature bit for this register.

  [ bp: Simplify the reason dumping loop. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250422234830.2840784-6-superm1@kernel.org
---
 Documentation/arch/x86/amd-debugging.rst | 42 ++++++++++++++++++-
 arch/x86/include/asm/amd/fch.h           |  1 +-
 arch/x86/kernel/cpu/amd.c                | 53 +++++++++++++++++++++++-
 3 files changed, 96 insertions(+)

diff --git a/Documentation/arch/x86/amd-debugging.rst b/Documentation/arch/x86/amd-debugging.rst
index d3290f2..dea8a91 100644
--- a/Documentation/arch/x86/amd-debugging.rst
+++ b/Documentation/arch/x86/amd-debugging.rst
@@ -318,3 +318,45 @@ As mentioned above, parsing by hand can be tedious, especially with a lot of
 messages.  To help with this, a tool has been created at
 `amd-debug-tools <https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.git/about/>`_
 to help parse the messages.
+
+Random reboot issues
+====================
+When a random reboot occurs, the high-level reason for the reboot is stored
+in a register that will persist onto the next boot.
+
+There are 6 classes of reasons for the reboot:
+ * Software induced
+ * Power state transition
+ * Pin induced
+ * Hardware induced
+ * Remote reset
+ * Internal CPU event
+
+.. csv-table::
+   :header: "Bit", "Type", "Reason"
+   :align: left
+
+   "0",  "Pin",      "thermal pin BP_THERMTRIP_L was tripped"
+   "1",  "Pin",      "power button was pressed for 4 seconds"
+   "2",  "Pin",      "shutdown pin was shorted"
+   "4",  "Remote",   "remote ASF power off command was received"
+   "9",  "Internal", "internal CPU thermal limit was tripped"
+   "16", "Pin",      "system reset pin BP_SYS_RST_L was tripped"
+   "17", "Software", "software issued PCI reset"
+   "18", "Software", "software wrote 0x4 to reset control register 0xCF9"
+   "19", "Software", "software wrote 0x6 to reset control register 0xCF9"
+   "20", "Software", "software wrote 0xE to reset control register 0xCF9"
+   "21", "Sleep",    "ACPI power state transition occurred"
+   "22", "Pin",      "keyboard reset pin KB_RST_L was asserted"
+   "23", "Internal", "internal CPU shutdown event occurred"
+   "24", "Hardware", "system failed to boot before failed boot timer expired"
+   "25", "Hardware", "hardware watchdog timer expired"
+   "26", "Remote",   "remote ASF reset command was received"
+   "27", "Internal", "an uncorrected error caused a data fabric sync flood event"
+   "29", "Internal", "FCH and MP1 failed warm reset handshake"
+   "30", "Internal", "a parity error occurred"
+   "31", "Internal", "a software sync flood event occurred"
+
+This information is read by the kernel at bootup and is saved into the
+kernel ring buffer. When a random reboot occurs this message can be helpful
+to determine the next component to debug such an issue.
diff --git a/arch/x86/include/asm/amd/fch.h b/arch/x86/include/asm/amd/fch.h
index 01ee15b..2cf5153 100644
--- a/arch/x86/include/asm/amd/fch.h
+++ b/arch/x86/include/asm/amd/fch.h
@@ -8,5 +8,6 @@
 #define FCH_PM_DECODEEN			0x00
 #define FCH_PM_DECODEEN_SMBUS0SEL	GENMASK(20, 19)
 #define FCH_PM_SCRATCH			0x80
+#define FCH_PM_S5_RESET_STATUS		0xC0
 
 #endif /* _ASM_X86_AMD_FCH_H_ */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2b36379..9a8c590 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -9,6 +9,7 @@
 #include <linux/sched/clock.h>
 #include <linux/random.h>
 #include <linux/topology.h>
+#include <asm/amd/fch.h>
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cacheinfo.h>
@@ -1237,3 +1238,55 @@ void amd_check_microcode(void)
 	if (cpu_feature_enabled(X86_FEATURE_ZEN2))
 		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
+
+static const char * const s5_reset_reason_txt[] = {
+	[0] = "thermal pin BP_THERMTRIP_L was tripped",
+	[1] = "power button was pressed for 4 seconds",
+	[2] = "shutdown pin was shorted",
+	[4] = "remote ASF power off command was received",
+	[9] = "internal CPU thermal limit was tripped",
+	[16] = "system reset pin BP_SYS_RST_L was tripped",
+	[17] = "software issued PCI reset",
+	[18] = "software wrote 0x4 to reset control register 0xCF9",
+	[19] = "software wrote 0x6 to reset control register 0xCF9",
+	[20] = "software wrote 0xE to reset control register 0xCF9",
+	[21] = "ACPI power state transition occurred",
+	[22] = "keyboard reset pin KB_RST_L was asserted",
+	[23] = "internal CPU shutdown event occurred",
+	[24] = "system failed to boot before failed boot timer expired",
+	[25] = "hardware watchdog timer expired",
+	[26] = "remote ASF reset command was received",
+	[27] = "an uncorrected error caused a data fabric sync flood event",
+	[29] = "FCH and MP1 failed warm reset handshake",
+	[30] = "a parity error occurred",
+	[31] = "a software sync flood event occurred",
+};
+
+static __init int print_s5_reset_status_mmio(void)
+{
+	unsigned long value;
+	void __iomem *addr;
+	int i;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return 0;
+
+	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
+	if (!addr)
+		return 0;
+
+	value = ioread32(addr);
+	iounmap(addr);
+
+	for (i = 0; i <= ARRAY_SIZE(s5_reset_reason_txt); i++) {
+		if (!(value & BIT(i)))
+			continue;
+
+		if (s5_reset_reason_txt[i])
+			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
+				value, s5_reset_reason_txt[i]);
+	}
+
+	return 0;
+}
+late_initcall(print_s5_reset_status_mmio);

