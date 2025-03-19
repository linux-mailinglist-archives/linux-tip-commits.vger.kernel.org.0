Return-Path: <linux-tip-commits+bounces-4349-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF5A68AB6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B76917CB23
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F44258CE7;
	Wed, 19 Mar 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xd7d3niC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vXybipfL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC376257ADB;
	Wed, 19 Mar 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382225; cv=none; b=ZG9eS5hNBF3sHy3xQfVTWlJNbV7UEGc0XequB+yiSQ8FYLIjAfbIVcj56Kpv4hbp9x4bjq13OZ+cnRmyh1PSNU6xBC10oZA1BcAC4X1pfsxbmwnAtdCuc51ptXSlxl1kDvlGNn427fyYqkGOtNLuaGPpJ0GsNJ7v+sIIQuXsvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382225; c=relaxed/simple;
	bh=a4vpITdm6t/8XzaPSJdcd6K/bnVaIt6FRKmqB3J5Z4o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kFYhAmAstzSEKi4UdjxtuSZ9c/iX7W1JwurOklPiA4Z5TVcKSbrOK5fApQI1z7hChPkMTZ6Urgq8UvPr/4pUETFKRsNtJnPqiAtuDXi3xlJ7mdtqSOwLNEVXVoDVZ6S9IOXGnNgS1RI+yy8fG1G16bdhmrF2R0J3hRRC/cx083c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xd7d3niC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vXybipfL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMipg8iaxfFsV3Wmm+zaVQZkAwsB9eep7kN1AIs8srI=;
	b=xd7d3niCyjrApzozCIxpHJEQLxtiLNfnnSp2igCYa/022pvvZEomAcdiuROWjc+XC3XcbM
	oU/p/m1Di6o6eone9iz93QC+CxK1PssWQKZU62H4SBxTDqsNog0ZfINlZIi6/PhpFvBoWO
	0biFdZA3RBKLj6YKkkzrV/WZMDAtxGYtKKWJQTEe7huBak8OJyN5ZSfwvs//VAprmQEdtL
	hitysqd+iTwO+pZWaQ5i+TUahgoNOKXf+QHuf10lsvBHgqyjTJGissARX1bmxasVRkOuxb
	F0PUrxXadcJcM7b6Cso03P6C8D80hF80ao6cvI24jDmzPJDhvtJ6uJGheUmxIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMipg8iaxfFsV3Wmm+zaVQZkAwsB9eep7kN1AIs8srI=;
	b=vXybipfLSIK6j1e5moUZ+MEK2iX8O8IxcGp4rdZHUO3hsS5tFH70Nr59WRqpKHASHESp//
	BT8dXGGdS2qBUiDw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/cpu/intel: Replace early Family 6 checks with VFM ones
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-6-sohil.mehta@intel.com>
References: <20250219184133.816753-6-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222189.14745.4121935575691336561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     eaa472f76d1cc356c0f9d4406d2358ca924a797e
Gitweb:        https://git.kernel.org/tip/eaa472f76d1cc356c0f9d4406d2358ca924a797e
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:23 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:41 +01:00

x86/cpu/intel: Replace early Family 6 checks with VFM ones

Introduce names for some old pentium models and replace the x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-6-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h |  4 ++++
 arch/x86/kernel/cpu/intel.c         | 11 +++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f0e7ed0..58735bc 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -45,8 +45,12 @@
 /* Wildcard match so X86_MATCH_VFM(ANY) works */
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
+/* Family 6 */
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
 #define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
+#define INTEL_PENTIUM_III_TUALATIN	IFM(6, 0x0B)
+#define INTEL_PENTIUM_M_DOTHAN		IFM(6, 0x0D)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 99b4c40..a49615f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -186,7 +186,7 @@ void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (c->x86 < 6 || (c->x86 == 6 && c->x86_model < 0xd))
+	if (c->x86_vfm < INTEL_PENTIUM_M_DOTHAN)
 		return;
 
 	/*
@@ -341,9 +341,7 @@ static void bsp_init_intel(struct cpuinfo_x86 *c)
 int ppro_with_ram_bug(void)
 {
 	/* Uses data from early_cpu_detect now */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86 == 6 &&
-	    boot_cpu_data.x86_model == 1 &&
+	if (boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO &&
 	    boot_cpu_data.x86_stepping < 8) {
 		pr_info("Pentium Pro with Errata#50 detected. Taking evasive action.\n");
 		return 1;
@@ -404,7 +402,8 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * SEP CPUID bug: Pentium Pro reports SEP but doesn't have it until
 	 * model 3 mask 3
 	 */
-	if ((c->x86<<8 | c->x86_model<<4 | c->x86_stepping) < 0x633)
+	if ((c->x86_vfm == INTEL_PENTIUM_II_KLAMATH && c->x86_stepping < 3) ||
+	    c->x86_vfm < INTEL_PENTIUM_II_KLAMATH)
 		clear_cpu_cap(c, X86_FEATURE_SEP);
 
 	/*
@@ -606,7 +605,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	 * to determine which, so we use a boottime override
 	 * for the 512kb model, and assume 256 otherwise.
 	 */
-	if ((c->x86 == 6) && (c->x86_model == 11) && (size == 0))
+	if (c->x86_vfm == INTEL_PENTIUM_III_TUALATIN && size == 0)
 		size = 256;
 
 	/*

