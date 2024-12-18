Return-Path: <linux-tip-commits+bounces-3093-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464759F67E4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC7A16CA93
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AAA1B0435;
	Wed, 18 Dec 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K1cxw6Hu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NNk9aKaN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590721D47BB;
	Wed, 18 Dec 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530605; cv=none; b=QwhwSqoMv7ECiweEWNeNiRMimK4deyEGWt0JNMrqRJSSKme1PWbZr67te0I+83MhVZ110X/Z+HNXvBctL+/L7Lus5p2kvrMt9iWrIu/7BATOHRiixPk4l8JFPAJUp15eQlZPLyFGL44cuNTffBusuLFieqeomH8Q5RhSYQsp3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530605; c=relaxed/simple;
	bh=N79R7gSZ/tp3xg4p36E8+ArQAouuGWpnd+RBSOq3RUE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gwZA2yqoeVQk6MFQvbWCXcpdVwHt4yxP9CwfXDuhjvErfaepgc2sPwo8fGE0Hr/T+nUPx2NcPfeU08k9/85dG3A7/4Vwmexj0fCLclZUiOU8gKaxWbSiID+K2fCXfwYUsEutpqyiuYo5dZO76rJNEIVnu+e1jGFRdxFebpCUW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K1cxw6Hu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NNk9aKaN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ND08FWqf3he2HbnRYj0MbQ/N1ByQ+x8412+57nW+vow=;
	b=K1cxw6HukUYacrTUrlgr0cHq5AlnQOP3g8KEia9BVlUSMQlG6rxRhoGSzVet9uxernqTs2
	sfTQB1FxCL86gSyqaJdiHLojO5j+3LHaCsvXoUUV5Q1NtJtnPDaxIvC4NjtEiYiKzQTeLN
	KnVDUO9zo3Q7KNFhGHBgtx+PvY/TZceI8mThu9ivf/auZ2m1BsSTldEdSD0iCjKfrmC7qx
	a4hpilKX1Xybqhly9T8x5AS8fN+JIiZvEmVpmRUqRxAIQn8ORT1+AchPAHw3bdHTfX+E+R
	CiOi6eyui7E/dtkG5RNKd9aJIcMAZ0Sx0MQLy6K3DLgtpqTHysjztU8AtMURVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ND08FWqf3he2HbnRYj0MbQ/N1ByQ+x8412+57nW+vow=;
	b=NNk9aKaNIF1BxBfcM5k6P04Qu4l9lvGSyzUiHQGPiHBlsmGsFe7qd8CRVD3ixHLMBXQlcs
	T1gRrAEojDc1Q5CA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove unnecessary MwAIT leaf checks
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453060177.7135.12868475963229451572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     060da9df542689301d6ca28ca29c71585d8a5a24
Gitweb:        https://git.kernel.org/tip/060da9df542689301d6ca28ca29c71585d8a5a24
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:30 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:42 -08:00

x86/cpu: Remove unnecessary MwAIT leaf checks

The CPUID leaf dependency checker will remove X86_FEATURE_MWAIT if
the CPUID level is below the required level (CPUID_MWAIT_LEAF).
Thus, if you check X86_FEATURE_MWAIT you do not need to also
check the CPUID level.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241213205030.9B42B458%40davehans-spike.ostc.intel.com
---
 arch/x86/kernel/hpet.c    | 3 ---
 arch/x86/kernel/smpboot.c | 2 --
 drivers/acpi/acpi_pad.c   | 2 --
 drivers/idle/intel_idle.c | 3 ---
 4 files changed, 10 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 2593504..953de5b 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -928,9 +928,6 @@ static bool __init mwait_pc10_supported(void)
 	if (!cpu_feature_enabled(X86_FEATURE_MWAIT))
 		return false;
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return false;
-
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	return (ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) &&
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 52b0d30..116c46f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1292,8 +1292,6 @@ static inline void mwait_play_dead(void)
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
 		return;
-	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
-		return;
 
 	eax = CPUID_MWAIT_LEAF;
 	ecx = 0;
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index b561974..f3cffae 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -47,8 +47,6 @@ static void power_saving_mwait_init(void)
 
 	if (!boot_cpu_has(X86_FEATURE_MWAIT))
 		return;
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5d8ed1a..efa32d2 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2317,9 +2317,6 @@ static int __init intel_idle_init(void)
 			return -ENODEV;
 	}
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return -ENODEV;
-
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||

