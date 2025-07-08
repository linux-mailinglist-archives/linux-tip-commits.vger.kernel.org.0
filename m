Return-Path: <linux-tip-commits+bounces-6032-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2BBAFCE37
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8336A16751A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49C2E0412;
	Tue,  8 Jul 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NVkhwGwb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0u+dO3Hu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F732E0411;
	Tue,  8 Jul 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986241; cv=none; b=opjQGVaJdF5EG8OzA3Fdls9xfGTbRBmahRq4bTz1X1PPivRR2LBqoLQtdKmieXBPOZOxE3pW5a7K2gWGtiHQ4j11Q0/bBp/zOndlDK0slXu/tSLQWyVBZp6IxNdb503hFYGzyTeDVdfnABlseeAm9io5xV8J9ystSQORaFgJF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986241; c=relaxed/simple;
	bh=68MRrFNt5e7oUjGjVCwDou8USGemiPJsmJX+swkJGw4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pS1gm1YEb423zQyPNxFDIpGRDP+0MTPfmQtRK3YflpNrTyAF+ZAIytFdryZK+VSK8Js70KXKHmjjeCwYJG4hWw108CB8rcXxzG6V7wbpiZIojPxiyfjzqo3MbQCz121rEBBDweOVVshBhkGtCzy0fLcM977vrFnTnf4jUecJb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NVkhwGwb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0u+dO3Hu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 14:50:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751986233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JXSn9qg3IxDphEmOAlLZ/pMxi3pBX4rwYQI4H3gZNQ=;
	b=NVkhwGwbnzTzsJkU1R5MpsPq3gP8oENnoyT1H55eSkFYebNQbOqBkRRTqK6HeTZI1hQkA6
	kvUkgqLLwP/YU1xx0FcQ4Xj77ydH5V5PIny22B1MOS6houHrAokiPQ2FXvV09r3I+6kcwh
	qnKGtjjLkzuqKLQxBHLdJYSFgnkkOXC8tbQG9QiXt6k4i2NWeSewX88kYAmAfgBK91gU+n
	yVRy4U2LJP65AX2zQXN6XGIP6uXcfFlUkp3lDmOxQADj7+fhWgyDJBSf09r4tYFvXxBW/d
	2UDkZzvG1CQu+sR3fgegxWNsdueS/C5s8QA+njq2dnPPoUqCZ41B4PjF5Y3LEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751986233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JXSn9qg3IxDphEmOAlLZ/pMxi3pBX4rwYQI4H3gZNQ=;
	b=0u+dO3HurY2J8V4+7Td8kEDd+RxlPW3fN0UVx6T+NP1IzXno1lQLDiwdWgIdTAgTCgylUq
	TV0KfOrbk1B+1HCw==
From: "tip-bot2 for Mikhail Paulyshka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/rdrand: Disable RDSEED on AMD Cyan Skillfish
Cc: Mikhail Paulyshka <me@mixaill.net>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250524145319.209075-1-me@mixaill.net>
References: <20250524145319.209075-1-me@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175198623217.406.15281181371611195725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dc562662cb2b0bcc7af4ca3cd53e6140ff52a418
Gitweb:        https://git.kernel.org/tip/dc562662cb2b0bcc7af4ca3cd53e6140ff52a418
Author:        Mikhail Paulyshka <me@mixaill.net>
AuthorDate:    Sat, 24 May 2025 17:53:19 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 08 Jul 2025 16:26:42 +02:00

x86/rdrand: Disable RDSEED on AMD Cyan Skillfish

AMD Cyan Skillfish (Family 17h, Model 47h, Stepping 0h) has an error that
causes RDSEED to always return 0xffffffff, while RDRAND works correctly.

Mask the RDSEED cap for this CPU so that both /proc/cpuinfo and direct CPUID
read report RDSEED as unavailable.

  [ bp: Move to amd.c, massage. ]

Signed-off-by: Mikhail Paulyshka <me@mixaill.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250524145319.209075-1-me@mixaill.net
---
 arch/x86/include/asm/msr-index.h       | 1 +
 arch/x86/kernel/cpu/amd.c              | 7 +++++++
 tools/arch/x86/include/asm/msr-index.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b7dded3..5cfb5d7 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -628,6 +628,7 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 655f44f..e1c4661 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -930,6 +930,13 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
 	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 	zen2_zenbleed_check(c);
+
+	/* Disable RDSEED on AMD Cyan Skillfish because of an error. */
+	if (c->x86_model == 0x47 && c->x86_stepping == 0x0) {
+		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
+		pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
+	}
 }
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index b7dded3..5cfb5d7 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -628,6 +628,7 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022

