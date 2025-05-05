Return-Path: <linux-tip-commits+bounces-5243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F782AA9525
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 16:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A163BD532
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F9259CA4;
	Mon,  5 May 2025 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="riWvSFNB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/6W9TTB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B41F9F70;
	Mon,  5 May 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454341; cv=none; b=lxvUAUncvfZsWtppTGhrf8lyi4t+pMza4ecIzawskal+Rk8babOvEj6nuKERC+c3UtcR06fvwacOUOatHKAhlIanQbbA82N3YD6u0+erJ79YQU+0gMIY9V0m8hZgAlyAw8R2m8i4TMnVa4aSEM9PKRpzcgHKIIX+7ElzcdfW2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454341; c=relaxed/simple;
	bh=8qGlmhtN6d45m0iYJDpRl9af/26dZhT/YVPFvzmsRus=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dsG1hNoHDOqK+s7nQfyQtQL2ztIoY+oRCbb2e39E1nO7rn/hXJj+n8MkvR2CkqQ6O1rE+62q0szp9Bfzbj/evrOjOAu9lv0nDJQd1KCss+/NLc9QBw5lJvabWDFlRzBzL/dmXMdcfX3lxJPHnBPQgGK9ubphVLjXGDY1uSRbItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=riWvSFNB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/6W9TTB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 14:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746454335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97SXynVy8RbV/33z/XSivtrnS3uo7Eyb9hocrgqEeUo=;
	b=riWvSFNBz4a9BlB2Pu3NjxEcm2pQ5vaqwJjqV0esE0b9ty94oie4q6NW2X5mxMyob/9jk5
	w+GxsxCwlk7khpIgJRWshye4QRhRVcPAkbH4K9oOVdrGUnGsyS4lf0agOzG26Vn+SvHeuX
	m5KlptFybVMf+ZKmvyCIPx5kat9G2Wcc3eIJc1ipHgEVGpazLfbszAaAu5IamsHZ65AyPZ
	JX078UCbIfvA22cxvDwQC313myAWU5PU9z/FTFVKgshGf04xzmSNhLxw4XZKnEjQqAeL4e
	COGvNEz5pHZhffOKTxo0snLjwCMd8CmNTFCvCkvb9rnhOojTYOFqLIFInEBGXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746454335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97SXynVy8RbV/33z/XSivtrnS3uo7Eyb9hocrgqEeUo=;
	b=e/6W9TTBahD0mOMTgVLdFzPklK5cKAW/fzmOTNQpoS76QYNK9jHsQ7G4VUM09NaOzVY97k
	prKs/uDIBnzGTPCw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/CPU/AMD: Print the reason for the last reset
Cc: James Dutton <james.dutton@gmail.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250422234830.2840784-6-superm1@kernel.org>
References: <20250422234830.2840784-6-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174645433169.22196.15231212692699077898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     ab8131028710d009ab93d6bffd2a2749ade909b0
Gitweb:        https://git.kernel.org/tip/ab8131028710d009ab93d6bffd2a2749ade909b0
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 22 Apr 2025 18:48:30 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 May 2025 15:51:24 +02:00

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

  [ bp: Simplify the reason dumping loop.
    - merge a fix to not access an array element after the last one:
      https://lore.kernel.org/r/20250505133609.83933-1-superm1@kernel.org
      Reported-by: James Dutton <james.dutton@gmail.com>
      ]

  [ mingo:
    - Use consistent .rst formatting
    - Fix 'Sleep' class field to 'ACPI-State'
    - Standardize pin messages around the 'tripped' verbiage
    - Remove reference to ring-buffer printing & simplify the wording
    - Use curly braces for multi-line conditional statements ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250422234830.2840784-6-superm1@kernel.org
---
 Documentation/arch/x86/amd-debugging.rst | 48 ++++++++++++++++++++-
 arch/x86/include/asm/amd/fch.h           |  1 +-
 arch/x86/kernel/cpu/amd.c                | 54 +++++++++++++++++++++++-
 3 files changed, 103 insertions(+)

diff --git a/Documentation/arch/x86/amd-debugging.rst b/Documentation/arch/x86/amd-debugging.rst
index d3290f2..d92bf59 100644
--- a/Documentation/arch/x86/amd-debugging.rst
+++ b/Documentation/arch/x86/amd-debugging.rst
@@ -52,6 +52,7 @@ report generated from this script to
 
 Spurious s2idle wakeups from an IRQ
 ===================================
+
 Spurious wakeups will generally have an IRQ set to ``/sys/power/pm_wakeup_irq``.
 This can be matched to ``/proc/interrupts`` to determine what device woke the system.
 
@@ -134,6 +135,7 @@ The ``amd_s2idle.py`` script will capture most of these artifacts for you.
 
 s2idle PM debug messages
 ========================
+
 During the s2idle flow on AMD systems, the ACPI LPS0 driver is responsible
 to check all uPEP constraints.  Failing uPEP constraints does not prevent
 s0i3 entry.  This means that if some constraints are not met, it is possible
@@ -160,6 +162,7 @@ After doing this, run the suspend cycle and look specifically for errors around:
 
 Historical examples of s2idle issues
 ====================================
+
 To help understand the types of issues that can occur and how to debug them,
 here are some historical examples of s2idle issues that have been resolved.
 
@@ -248,6 +251,7 @@ state entry.
 
 Runtime power consumption issues
 ================================
+
 Runtime power consumption is influenced by many factors, including but not
 limited to the configuration of the PCIe Active State Power Management (ASPM),
 the display brightness, the EPP policy of the CPU, and the power management
@@ -272,6 +276,7 @@ the battery life when more heavily biased towards performance.
 
 BIOS debug messages
 ===================
+
 Most OEM machines don't have a serial UART for outputting kernel or BIOS
 debug messages. However BIOS debug messages are useful for understanding
 both BIOS bugs and bugs with the Linux kernel drivers that call BIOS AML.
@@ -318,3 +323,46 @@ As mentioned above, parsing by hand can be tedious, especially with a lot of
 messages.  To help with this, a tool has been created at
 `amd-debug-tools <https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.git/about/>`_
 to help parse the messages.
+
+Random reboot issues
+====================
+
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
+   "2",  "Pin",      "shutdown pin was tripped"
+   "4",  "Remote",   "remote ASF power off command was received"
+   "9",  "Internal", "internal CPU thermal limit was tripped"
+   "16", "Pin",      "system reset pin BP_SYS_RST_L was tripped"
+   "17", "Software", "software issued PCI reset"
+   "18", "Software", "software wrote 0x4 to reset control register 0xCF9"
+   "19", "Software", "software wrote 0x6 to reset control register 0xCF9"
+   "20", "Software", "software wrote 0xE to reset control register 0xCF9"
+   "21", "ACPI-state", "ACPI power state transition occurred"
+   "22", "Pin",      "keyboard reset pin KB_RST_L was tripped"
+   "23", "Internal", "internal CPU shutdown event occurred"
+   "24", "Hardware", "system failed to boot before failed boot timer expired"
+   "25", "Hardware", "hardware watchdog timer expired"
+   "26", "Remote",   "remote ASF reset command was received"
+   "27", "Internal", "an uncorrected error caused a data fabric sync flood event"
+   "29", "Internal", "FCH and MP1 failed warm reset handshake"
+   "30", "Internal", "a parity error occurred"
+   "31", "Internal", "a software sync flood event occurred"
+
+This information is read by the kernel at bootup and printed into
+the syslog. When a random reboot occurs this message can be helpful
+to determine the next component to debug.
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
index 2b36379..ded4a2a 100644
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
@@ -1237,3 +1238,56 @@ void amd_check_microcode(void)
 	if (cpu_feature_enabled(X86_FEATURE_ZEN2))
 		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
+
+static const char * const s5_reset_reason_txt[] = {
+	[0]  = "thermal pin BP_THERMTRIP_L was tripped",
+	[1]  = "power button was pressed for 4 seconds",
+	[2]  = "shutdown pin was tripped",
+	[4]  = "remote ASF power off command was received",
+	[9]  = "internal CPU thermal limit was tripped",
+	[16] = "system reset pin BP_SYS_RST_L was tripped",
+	[17] = "software issued PCI reset",
+	[18] = "software wrote 0x4 to reset control register 0xCF9",
+	[19] = "software wrote 0x6 to reset control register 0xCF9",
+	[20] = "software wrote 0xE to reset control register 0xCF9",
+	[21] = "ACPI power state transition occurred",
+	[22] = "keyboard reset pin KB_RST_L was tripped",
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
+	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
+		if (!(value & BIT(i)))
+			continue;
+
+		if (s5_reset_reason_txt[i]) {
+			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
+				value, s5_reset_reason_txt[i]);
+		}
+	}
+
+	return 0;
+}
+late_initcall(print_s5_reset_status_mmio);

