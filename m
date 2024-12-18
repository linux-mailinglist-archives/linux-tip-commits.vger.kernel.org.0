Return-Path: <linux-tip-commits+bounces-3089-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 474439F67DB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E76A7A04A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ACD1BEF6F;
	Wed, 18 Dec 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xuOpkDuK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Jm+WfyK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B711B0435;
	Wed, 18 Dec 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530602; cv=none; b=t1NlaZnSEylk28W7PHrNHcIo8a6+CreCFL27j3FXejECf7pY823RW5FwMImpZXat292bHbbYqglmAbJDFZPQeo2FafvFm3wzFzBPku6tq2TSRaRTxLnwCsnFxhIqLL9wkjBdYIDTE5gd1BEVss5DX3JMX36eY+HP6k6pME6IfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530602; c=relaxed/simple;
	bh=Xxk2ODYbo+1DGHMt3CakDWcc5byum9hids4seclDtnU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FKaXKMILvmCpdYe1Vt/+5q3vORxSKtqhvpv+P76MfpSryv7XLwhQziM5IyiB2G1AHSVPefUASFy1vHf0cD2+01J2WV4cAmPIfycybnnpYpHfK2CtWxxr6U9J2cw8xU3zSuJquGgJXk352ysQbdZvvGXfD19L9IUXToYVOTX46bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuOpkDuK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Jm+WfyK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FxpnzZjGMxp98gqv5cxDfmO0bPm1b422zkGsqOeJRLQ=;
	b=xuOpkDuKgN1+0Eg9WLeJV408J6bkxOR455DPhc+rm8vG3kD4j8O+toAnEFhv8Wow6GC8Bg
	tlxp2gU3y5sGf1kF2kY6gUNBnXnbwoR/Pbu4I73bhcP6EaCqCs3KI7Ll/vIVVZCS6fgx6b
	huEe2I7FFYldrEf9A6IlTlwF0dJGBdOpYvVqQUq/eNfcGjfPBVhe68SvFRY5tWvOsN0olP
	Hg+INN7oUZtlxekyd7CAnfPKcOvEYXvifGHgX/5i2j+zvzrDtAdrXhCthEnpppgV/4rqq9
	8+oqouBEgGS77F2udi2ywKBqdL/ECvC4ZscQUEXd5ApB12TlJUUOniRZJRxv/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FxpnzZjGMxp98gqv5cxDfmO0bPm1b422zkGsqOeJRLQ=;
	b=2Jm+WfyKM9u/D6c0YcZVWXyOqNeO9yubbyRN5hq7UeH1Gh6V7TYgLi6Dx0+PHj8Ho2yni5
	X1kq0DmQRsmBbSBw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/tsc: Remove CPUID "frequency" leaf magic numbers.
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453059778.7135.5532578648275229126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e9d6b0dc20f052de99e09fd0204ea210ca3f7418
Gitweb:        https://git.kernel.org/tip/e9d6b0dc20f052de99e09fd0204ea210ca3f7418
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:36 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:43 -08:00

x86/tsc: Remove CPUID "frequency" leaf magic numbers.

All the code that reads the CPUID frequency information leaf hard-codes
a magic number.  Give it a symbolic name and use it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205036.4397658F%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpuid.h |  1 +
 arch/x86/kernel/tsc.c        | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 9b0d14b..e7803c2 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -24,6 +24,7 @@ enum cpuid_regs_idx {
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
 #define CPUID_TSC_LEAF		0x15
+#define CPUID_FREQ_LEAF		0x16
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 8091b0e..678c36f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -681,8 +681,8 @@ unsigned long native_calibrate_tsc(void)
 
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
-	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
-	 * clock.
+	 * CPUID_FREQ_LEAF for the calculation below, so hardcode the 25MHz
+	 * crystal clock.
 	 */
 	if (crystal_khz == 0 &&
 			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
@@ -701,10 +701,10 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= 0x16) {
+	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_FREQ_LEAF) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
-		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
+		cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx, &ecx, &edx);
 		crystal_khz = eax_base_mhz * 1000 *
 			eax_denominator / ebx_numerator;
 	}
@@ -739,12 +739,12 @@ static unsigned long cpu_khz_from_cpuid(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < 0x16)
+	if (boot_cpu_data.cpuid_level < CPUID_FREQ_LEAF)
 		return 0;
 
 	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
 
-	cpuid(0x16, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
+	cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
 
 	return eax_base_mhz * 1000;
 }

