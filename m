Return-Path: <linux-tip-commits+bounces-3104-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A510C9F6846
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4611F16F7EE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3D1F0E25;
	Wed, 18 Dec 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cuPJhgyn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aneQum5d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE91DF961;
	Wed, 18 Dec 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531761; cv=none; b=fUZh+gtn9dcAcnBIPYFa4azNFD03cWjHruWwlvahCK03AzBfM+tgDmQSQBg3RDdG/QjoZpd5X+9iXPWFhzBW7ZqYxrT47dGDsBFCb5ulbst42KXZ1sFGTcTlRkamzNue1fqxCYSAT/9c88+XraOCmobTTWcM7X73cm1/vcxFkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531761; c=relaxed/simple;
	bh=NkesRJc4rldOI/24E1I36J6a1YzfDGnzj+lDVd+GYK0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ngVSp17w2sZyUomjGhbqAH3jFStWkeJR/edPVIpUGcTgqFLkp0C8ql+W8MqX8OxyzU9e2S0ki5/0xqPrjGs20Jmh5SfaNYzOXF3A1Bmvzjaq94cazdpdo1xlyb1GM8X4I/dypbwmwUFAwIHn87kyPPT16SaDBRfwMjguG0ViY2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cuPJhgyn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aneQum5d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gOV8t7FKUQct2LfmTMABROQdReU0+q9YUqRZnj0E1S0=;
	b=cuPJhgyns74izAkM7B24g5n6CzxRY7nwauAwZUQ7E417heoqhVoQJuCYCxpbwzmTUHxYqt
	tu6aAqzBY6LHSr9gPy7G+nq7m4+dF9RgiG0yJWtJ9A2tzlQ1xZAzJkXByLIXyW3G8+oubE
	xA/3qhKIYm/hTLlALlFPcyb28OfuXyqj66p7xPcFOUjow0goDtlwgXJbMOKKILNnLiABLR
	Ede205wqcH3QvJ/Oq4SSwvpxvAzPI0HyUzzReSxEbIdC9gOvx861Ajjv3380kQawcfAVFi
	xPiWR8fA8Ua0bB/UjDBQEzA77onQsEIQ+GFayZX9QdRHfMdCusiOLns+fun4Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gOV8t7FKUQct2LfmTMABROQdReU0+q9YUqRZnj0E1S0=;
	b=aneQum5dNJ6vPLKufnl2bla7jWdNWedQNV2kITCOo3/KZesAZsf1KQVhilLL6qOKn9dGXG
	VNIhdW91/bhZttBQ==
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
Message-ID: <173453175758.7135.9823105454576594179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     262fba55708b60a063b30d103963477dc5026f8c
Gitweb:        https://git.kernel.org/tip/262fba55708b60a063b30d103963477dc5026f8c
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:30 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:30 -08:00

x86/cpu: Remove unnecessary MwAIT leaf checks

The CPUID leaf dependency checker will remove X86_FEATURE_MWAIT if
the CPUID level is below the required level (CPUID_MWAIT_LEAF).
Thus, if you check X86_FEATURE_MWAIT you do not need to also
check the CPUID level.

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

