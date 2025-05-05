Return-Path: <linux-tip-commits+bounces-5235-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BAAA8BAF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 07:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A003AE1C8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 05:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FAD1A5BAA;
	Mon,  5 May 2025 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mm98GEtL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rs0WOa2a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7D19D8BC;
	Mon,  5 May 2025 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746423151; cv=none; b=FVbLkJ6J2n68WIavt+CGW5W75/71oHbYVNm7sjRYzTovUQi5y7FzuAMKYkFhZay6q1RZhVFYccnJ4RcXR52bSRQyGHOCiBs19G15YRBLRV4mXCQqYX2OXYTnF/RppgWVrtFCWJKwxOiqrfbr6Rz1xsCsXt6Cf7FI7uiC4fmyM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746423151; c=relaxed/simple;
	bh=Bk1TG3cr+MXZkNrThIsAfSusmsgVOtv76eY7MXaKR/E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hy1Y5b9gA1KnRZE5rR2lAPuThYk+M3y/qnSl1jqYGwcEa/Yo2aKcxUlWLiJ4AJPUlVCItLHE6e59tY6F3WCbxyjVhudZqNtvXDL6ZrXbuqmYCBafIZ1+JWLa+E2rtPyPY8NALZNx0tTKKg8/XzsGFzHHn5AE1ONto030lZ97CIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mm98GEtL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rs0WOa2a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 05:32:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746423148;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rNF27alkUFoHMu25Xl5E6dV0k+kofNAzwo0gWl5WFc=;
	b=mm98GEtLmpyZzLUHmChNNDnRZTrGXvG9gfj2vY0I5lIVxQHSb6jHpcBhUB9fB97KGVAYY2
	6j6VBgEFORF8nBM6RK62tcPc5Ct3k0lRjUlXKk49or04iF9tzU9f0rSpWQAHEJVWFxduNl
	Fw/Xg8Lv2ZehjcXhl96AvGhlwSpAUZt1Txo542G3+DXayE4gremIxMnxYn8hpwuF4mWJXV
	gPaTkZ07eV2485W3XBDz1SAWRsaJ/st/8bPW2wISUnzyeLdON3+/32unK4emO110gSwE3+
	ozIkTsHYXGcyKeGDGKThQcHH5sHwhSOIKgS/2XZDTLVACYyfABHbNCss5quekQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746423148;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rNF27alkUFoHMu25Xl5E6dV0k+kofNAzwo0gWl5WFc=;
	b=rs0WOa2aIkXqEI8NoqMxzavAzzyVZipxqoxE+beRBZ9DzlGBdxzbpUp+btxLySoimJD6Cl
	gAJXVsVIWi+Gg2Aw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/platform] x86/CPU/AMD: Clean up the last-reset printing code a bit
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, linux-tip-commits@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aBcRXYkJlfySzBEx@gmail.com>
References: <aBcRXYkJlfySzBEx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174642314731.22196.15886008630542679014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     5b91231c3afd2d75b4efbd40854655ae3b8664a5
Gitweb:        https://git.kernel.org/tip/5b91231c3afd2d75b4efbd40854655ae3b8664a5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 04 May 2025 09:04:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 05 May 2025 07:17:03 +02:00

x86/CPU/AMD: Clean up the last-reset printing code a bit

 - Use consistent .rst formatting

 - Fix 'Sleep' class field to 'ACPI-State'

 - Standardize pin messages around the 'tripped' verbiage

 - Remove reference to ring-buffer printing & simplify
   the wording

 - Use curly braces for multi-line conditional statements

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-tip-commits@vger.kernel.org
Link: https://lore.kernel.org/r/aBcRXYkJlfySzBEx@gmail.com
---
 Documentation/arch/x86/amd-debugging.rst | 18 ++++++++++++------
 arch/x86/kernel/cpu/amd.c                | 15 ++++++++-------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/arch/x86/amd-debugging.rst b/Documentation/arch/x86/amd-debugging.rst
index dea8a91..d92bf59 100644
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
index 9a8c590..469afcd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1240,18 +1240,18 @@ void amd_check_microcode(void)
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
@@ -1282,9 +1282,10 @@ static __init int print_s5_reset_status_mmio(void)
 		if (!(value & BIT(i)))
 			continue;
 
-		if (s5_reset_reason_txt[i])
+		if (s5_reset_reason_txt[i]) {
 			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
 				value, s5_reset_reason_txt[i]);
+		}
 	}
 
 	return 0;

