Return-Path: <linux-tip-commits+bounces-3738-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C0BA49895
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 12:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0785817182D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 11:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900F260A4E;
	Fri, 28 Feb 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4bFHrY4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNxy6Tyq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707925F781;
	Fri, 28 Feb 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743627; cv=none; b=Oeil9Jsu+K3FVjD76BhR+TlSbRE+hRmjUZCxpa5jrWaeEpYl8/AewCmmPdnY/FyJpFwB288UBdN/3lssul1iBNdVy5A347WxlGcBTe6roJp3jXGIeLtKrT8n/JhrCNHwpuTUzHqUq9WW6pGCwJ9dpldCGQ8+hVXSFYFSA12dv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743627; c=relaxed/simple;
	bh=E1hqlbTgogEWysyrmKzHGbChBIgfmeI6e5ILt4hPov4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DMTSICapU6rYasE/cN0LYgvNvOGxGKb/hQaxUtJRu0kn07iIL5f/MgqAm7fteC61bDIbtBVQR+1glyu6RaEQvm13kChNb+xpe3PbVXZns2T+++8GrgCkFrBTdgkLzJQ5LPb2sk8o6mZ+L3cgunGxxIO8nr9cIIwnnk4JZcWlIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4bFHrY4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNxy6Tyq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 11:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740743624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsjPWnynEbbF2TFIsikWVKKbCJuqCcEWuoQl6fWp41o=;
	b=s4bFHrY4B8n8vnuksn6N7YU4CxDyvgN2TCYKsAiopye2GLop7bSqxjn+58Yv9S+wsuVthY
	iZ/+IOGnDaLHF+v0zx3f6isf5WUhr5BcS6wvp0glbM+Fgw4bSDauNwoWXTMyXz/ArHZKMn
	QfbCZHznD9LdewrQPU05rKba1QBwvqBU9a/592ZIVpGXpbu6kJ3UPjZD25keaSouQGuGNs
	xFu8ZF/PXq0tdYjnoVDDxJ8a7LJCm7bY8YIEWGcZeMahr10vAXDZ4UlHi4CEqtX0UiTdOV
	ZD7UUHZFIdmgNqvtFuXiK/FAuOLrKDD8Orph/6gqN9w/EVXIjfawuVsn7GXK+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740743624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsjPWnynEbbF2TFIsikWVKKbCJuqCcEWuoQl6fWp41o=;
	b=fNxy6Tyq/A+5bzRH+RXbGDr8k/8F6Eb5CdLWZOHzseapiltDM3eEfHriSsA86FueaXGEQj
	6vlC+CUW0QohSuBg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Relocate mds/taa/mmio/rfds defines
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250108202515.385902-3-david.kaplan@amd.com>
References: <20250108202515.385902-3-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174074362368.10177.4839927541564124478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     2c93762ec4b3ab66980ee7aaffde1e050bfbf291
Gitweb:        https://git.kernel.org/tip/2c93762ec4b3ab66980ee7aaffde1e050bfbf291
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 08 Jan 2025 14:24:42 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Feb 2025 12:39:17 +01:00

x86/bugs: Relocate mds/taa/mmio/rfds defines

Move the mds, taa, mmio, and rfds mitigation enums earlier in the file to
prepare for restructuring of these mitigations as they are all inter-related.

No functional change.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250108202515.385902-3-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 60 +++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5397d0a..4269ed1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -247,6 +247,37 @@ static const char * const mds_strings[] = {
 	[MDS_MITIGATION_VMWERV]	= "Vulnerable: Clear CPU buffers attempted, no microcode",
 };
 
+enum taa_mitigations {
+	TAA_MITIGATION_OFF,
+	TAA_MITIGATION_UCODE_NEEDED,
+	TAA_MITIGATION_VERW,
+	TAA_MITIGATION_TSX_DISABLED,
+};
+
+/* Default mitigation for TAA-affected CPUs */
+static enum taa_mitigations taa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
+
+enum mmio_mitigations {
+	MMIO_MITIGATION_OFF,
+	MMIO_MITIGATION_UCODE_NEEDED,
+	MMIO_MITIGATION_VERW,
+};
+
+/* Default mitigation for Processor MMIO Stale Data vulnerabilities */
+static enum mmio_mitigations mmio_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
+
+enum rfds_mitigations {
+	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_VERW,
+	RFDS_MITIGATION_UCODE_NEEDED,
+};
+
+/* Default mitigation for Register File Data Sampling */
+static enum rfds_mitigations rfds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+
 static void __init mds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
@@ -290,16 +321,6 @@ early_param("mds", mds_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"TAA: " fmt
 
-enum taa_mitigations {
-	TAA_MITIGATION_OFF,
-	TAA_MITIGATION_UCODE_NEEDED,
-	TAA_MITIGATION_VERW,
-	TAA_MITIGATION_TSX_DISABLED,
-};
-
-/* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -390,15 +411,6 @@ early_param("tsx_async_abort", tsx_async_abort_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"MMIO Stale Data: " fmt
 
-enum mmio_mitigations {
-	MMIO_MITIGATION_OFF,
-	MMIO_MITIGATION_UCODE_NEEDED,
-	MMIO_MITIGATION_VERW,
-};
-
-/* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -487,16 +499,6 @@ early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"Register File Data Sampling: " fmt
 
-enum rfds_mitigations {
-	RFDS_MITIGATION_OFF,
-	RFDS_MITIGATION_VERW,
-	RFDS_MITIGATION_UCODE_NEEDED,
-};
-
-/* Default mitigation for Register File Data Sampling */
-static enum rfds_mitigations rfds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
-
 static const char * const rfds_strings[] = {
 	[RFDS_MITIGATION_OFF]			= "Vulnerable",
 	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",

