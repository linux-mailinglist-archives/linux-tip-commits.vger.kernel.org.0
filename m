Return-Path: <linux-tip-commits+bounces-3882-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D6A4D8CA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59949188D8BC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9361FF7AC;
	Tue,  4 Mar 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MET0tD1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhPvDnfh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AA1FF5E6;
	Tue,  4 Mar 2025 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081045; cv=none; b=teXuphIs+p02Q9pV/nkhJmAZspp6t0+jofp3GACEqvwG5r0KqblhqnoutAVGQBT6wObBarEBBBv0jw9RUpgf1/o2Eye7teIv5UdKcwz292owfixZmsU7HGgVLV2da5KVNLwGNy/5pZk3jUdrllbr23H+yQFYZS2xvFtFGJc7Q6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081045; c=relaxed/simple;
	bh=4BI0tDfvmjibhUMBfu383Mkk6Ix/drNbHp4FOgV80OI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TsVtUXT7K99lyOSw1ab3UUwMuQzUdZBMCz8X+67Pc/4kFfBotmNLJcFqGLajSGBh/xwIkSsTS1tE/02mouwDCglTJsIHljM5PRzzeOPAXDk6u/j277nRCaMjk1aoAHwerSAT3e5SkZYn5PBEnG5aDgixSuSqKN77vheLnvWTjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3MET0tD1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhPvDnfh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABtnDbRkhLJmugnaxbPz4Vthq5bOKftiYsNdJ0X7PVU=;
	b=3MET0tD16LKk4cvCduRG6WFp/9a840EZwA0uevXYPvnSdVVQucCgZLXy4UpHlFpxao33Ua
	FlXT7EqxULCK2uFq74eSRO7wwZehPC0cngQpU0kMpvGI7zTOvSFu4zhATTaSH++toCK3eB
	CPSDodIy7d9f9V664rVlaqvBW4XiqjU70rTaQCWH+lSNxeiqWLZNAWCNv7uzZyoB3juovB
	GrPHMXeYIWUwfbVuQTQkLug/wooPs6/oQHSgRu63pu8GNt3+zzxJcIT7MVqs/TzB0c0Mgp
	LB06BItWh3jfwI8qvRTVO5UhtO/J1JRCvVD0iaVQ+iXi1n2IXEqX/3InEohBuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABtnDbRkhLJmugnaxbPz4Vthq5bOKftiYsNdJ0X7PVU=;
	b=dhPvDnfhN0u9Vda6Tpo/wsUNRi8Yv+1t8oLR26RCAlMPKUIGr0+P7Gqqs6d7hN+16LxzmV
	hkQJM9FAIGZYfgBQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Remove unnecessary headers and reorder the rest
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-6-darwi@linutronix.de>
References: <20250304085152.51092-6-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108104097.14745.6160731149454222885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fab220ad2128088ebb702e3ac7b10fbc5e4ec10d
Gitweb:        https://git.kernel.org/tip/fab220ad2128088ebb702e3ac7b10fbc5e4ec10d
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:15:19 +01:00

x86/cpu: Remove unnecessary headers and reorder the rest

Remove the headers at intel.c that are no longer required.

Alphabetically reorder what remains since more headers will be included
in further commits.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-6-darwi@linutronix.de
---
 arch/x86/kernel/cpu/intel.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c5d833f..60b58b1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1,40 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/pgtable.h>
 
-#include <linux/string.h>
 #include <linux/bitops.h>
-#include <linux/smp.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
-#include <linux/thread_info.h>
 #include <linux/init.h>
-#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+
+#ifdef CONFIG_X86_64
+#include <linux/topology.h>
+#endif
 
-#include <asm/cpufeature.h>
-#include <asm/msr.h>
 #include <asm/bugs.h>
+#include <asm/cpu_device_id.h>
+#include <asm/cpufeature.h>
 #include <asm/cpu.h>
+#include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
-#include <asm/hwcap2.h>
-#include <asm/elf.h>
-#include <asm/cpu_device_id.h>
-#include <asm/resctrl.h>
+#include <asm/msr.h>
 #include <asm/numa.h>
+#include <asm/resctrl.h>
 #include <asm/thermal.h>
-
-#ifdef CONFIG_X86_64
-#include <linux/topology.h>
-#endif
+#include <asm/uaccess.h>
 
 #include "cpu.h"
 
-#ifdef CONFIG_X86_LOCAL_APIC
-#include <asm/mpspec.h>
-#include <asm/apic.h>
-#endif
-
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists

