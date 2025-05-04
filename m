Return-Path: <linux-tip-commits+bounces-5211-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86ECAA846F
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 09:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487E83BC5B7
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399043597E;
	Sun,  4 May 2025 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZX5A1P8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62B3597A;
	Sun,  4 May 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746342242; cv=none; b=eRM9WoGF10/cKsCee7dCSo76LQD3aHSr/OSuujXSKVPkc+3HCkjh33fPe41hwek+TGbVxRkiKSuNTR9pO+98MnJ7HolbFThdWkuGAXNfEFZcTNcH09RDK5r5218yujz/yS92j/udmf4Hvno5hzQE8YE1nnqOV1job8z4QyvEtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746342242; c=relaxed/simple;
	bh=7+9exo8CEywbK6LgA6nC1UpjsY1aeOj+06sJ9jDbQFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/CowX29rCdvTaqspyZKSSzF+7h2NlhBY0K+yI/XAZa52fXPDsDAqvzBe4KE5X/MJX/kQlpI5JHlsuaYKB/aCUzf23diLFO4sGKJT6G6t1x6nANWRNq12BkbjgRcjvBAyWb0Ec0inWx1niYkPK3WgrrSjl6UaQxwUPaS9JupVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZX5A1P8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A21DC4CEE7;
	Sun,  4 May 2025 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746342241;
	bh=7+9exo8CEywbK6LgA6nC1UpjsY1aeOj+06sJ9jDbQFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZX5A1P8Qz+/05XWNgqFld9iL1OkMzHKR2t4vALSakWvRu0F6olefNi1R0tUZPcv8
	 BhXtbGCIQ2YxHiVFCTr5jlPoncqZc1T8EqDX4dgAQJUWLBFlYZJM0clNoq7/pXjwZJ
	 gEIyTgR2uGGHotVTFuEBznyCA52bcmNIEOJzSp+kd+c1UHMEmIJ4dQ7ZXATiAeOqOL
	 cnOM7ARDZetFGp2bzaknkLpr5WVPSiIJO/WPqN+wPO23tlafZGfu+rIrWmYr/56is3
	 d4px2h+bR6VqOV1/B6QmGcTq4h/YJ0Rgiqt42PmVMI2CIeluQ4jWSCAaQYWj7dhS50
	 VWxNeJU+KbtxA==
Date: Sun, 4 May 2025 09:03:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: [PATCH] x86/CPU/AMD: Clean up the last-reset printing code a bit
Message-ID: <aBcRXYkJlfySzBEx@gmail.com>
References: <20250422234830.2840784-6-superm1@kernel.org>
 <174617858494.22196.5727323411231361285.tip-bot2@tip-bot2>
 <aBcLJxjTQGa1-r5S@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBcLJxjTQGa1-r5S@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> With those addressed:
> 
>   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Patch attached to clean this all up.

Thanks,

	Ingo

====================>
From: Ingo Molnar <mingo@kernel.org>
Date: Sun, 4 May 2025 08:57:37 +0200
Subject: [PATCH] x86/CPU/AMD: Clean up the last-reset printing code a bit

 - Use consistent .rst formatting

 - Fix 'Sleep' class field to 'ACPI-State'

 - Standardize pin messages around the 'tripped' verbiage

 - Remove reference to ring-buffer printing & simplify
   the wording

 - Use curly braces for multi-line conditional statements

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/arch/x86/amd-debugging.rst | 18 ++++++++++++------
 arch/x86/kernel/cpu/amd.c                | 15 ++++++++-------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/arch/x86/amd-debugging.rst b/Documentation/arch/x86/amd-debugging.rst
index dea8a918c71b..d92bf59d62c7 100644
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
@@ -321,6 +326,7 @@ to help parse the messages.
 
 Random reboot issues
 ====================
+
 When a random reboot occurs, the high-level reason for the reboot is stored
 in a register that will persist onto the next boot.
 
@@ -338,7 +344,7 @@ There are 6 classes of reasons for the reboot:
 
    "0",  "Pin",      "thermal pin BP_THERMTRIP_L was tripped"
    "1",  "Pin",      "power button was pressed for 4 seconds"
-   "2",  "Pin",      "shutdown pin was shorted"
+   "2",  "Pin",      "shutdown pin was tripped"
    "4",  "Remote",   "remote ASF power off command was received"
    "9",  "Internal", "internal CPU thermal limit was tripped"
    "16", "Pin",      "system reset pin BP_SYS_RST_L was tripped"
@@ -346,8 +352,8 @@ There are 6 classes of reasons for the reboot:
    "18", "Software", "software wrote 0x4 to reset control register 0xCF9"
    "19", "Software", "software wrote 0x6 to reset control register 0xCF9"
    "20", "Software", "software wrote 0xE to reset control register 0xCF9"
-   "21", "Sleep",    "ACPI power state transition occurred"
-   "22", "Pin",      "keyboard reset pin KB_RST_L was asserted"
+   "21", "ACPI-state", "ACPI power state transition occurred"
+   "22", "Pin",      "keyboard reset pin KB_RST_L was tripped"
    "23", "Internal", "internal CPU shutdown event occurred"
    "24", "Hardware", "system failed to boot before failed boot timer expired"
    "25", "Hardware", "hardware watchdog timer expired"
@@ -357,6 +363,6 @@ There are 6 classes of reasons for the reboot:
    "30", "Internal", "a parity error occurred"
    "31", "Internal", "a software sync flood event occurred"
 
-This information is read by the kernel at bootup and is saved into the
-kernel ring buffer. When a random reboot occurs this message can be helpful
-to determine the next component to debug such an issue.
+This information is read by the kernel at bootup and printed into
+the syslog. When a random reboot occurs this message can be helpful
+to determine the next component to debug.
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 04b11e7c1bf5..56c281f086f1 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1241,18 +1241,18 @@ void amd_check_microcode(void)
 }
 
 static const char * const s5_reset_reason_txt[] = {
-	[0] = "thermal pin BP_THERMTRIP_L was tripped",
-	[1] = "power button was pressed for 4 seconds",
-	[2] = "shutdown pin was shorted",
-	[4] = "remote ASF power off command was received",
-	[9] = "internal CPU thermal limit was tripped",
+	[0]  = "thermal pin BP_THERMTRIP_L was tripped",
+	[1]  = "power button was pressed for 4 seconds",
+	[2]  = "shutdown pin was tripped",
+	[4]  = "remote ASF power off command was received",
+	[9]  = "internal CPU thermal limit was tripped",
 	[16] = "system reset pin BP_SYS_RST_L was tripped",
 	[17] = "software issued PCI reset",
 	[18] = "software wrote 0x4 to reset control register 0xCF9",
 	[19] = "software wrote 0x6 to reset control register 0xCF9",
 	[20] = "software wrote 0xE to reset control register 0xCF9",
 	[21] = "ACPI power state transition occurred",
-	[22] = "keyboard reset pin KB_RST_L was asserted",
+	[22] = "keyboard reset pin KB_RST_L was tripped",
 	[23] = "internal CPU shutdown event occurred",
 	[24] = "system failed to boot before failed boot timer expired",
 	[25] = "hardware watchdog timer expired",
@@ -1283,9 +1283,10 @@ static __init int print_s5_reset_status_mmio(void)
 		if (!(value & BIT(i)))
 			continue;
 
-		if (s5_reset_reason_txt[i])
+		if (s5_reset_reason_txt[i]) {
 			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
 				value, s5_reset_reason_txt[i]);
+		}
 	}
 
 	return 0;

