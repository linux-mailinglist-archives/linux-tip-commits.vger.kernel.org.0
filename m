Return-Path: <linux-tip-commits+bounces-5558-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAC4AB8D7C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 19:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613D41BC736F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE525B66A;
	Thu, 15 May 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HbOfRo2m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2UgaTYRN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3E2586FE;
	Thu, 15 May 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329441; cv=none; b=QGeCuw7rscKf5gWD2/2/Gp6cm1Oxvi0//pRFKHXHl33FTMPv7d52jjPzbFJJIDCXdpc19dAUWuqaq7Wft37nx/gHE877fyLJKJoHFlTd5gVI8s9Tai/hskhM9rFrMXQQtVjO0EUUANG9/5566gFTQRAc4oRLRuxiYT+yXicMR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329441; c=relaxed/simple;
	bh=Us59DZ00ol34b0WAvFrqXy0Be3jlZTIKIMGPSVDbkic=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jhSxHHI4beQfmzll2L+mP+SQFMYCAhLgAX1z7roY6bqiNSQc8GK1HlZW1WXz68eNCygw4h55S02UHIz+XsaYoTLFwK+AhI9jcOXSr93/WVuf245KF9JTsNxakB9El4fyEgh2rep5xC+RAQT1bKaNHg3J3VLAiBFlVkGNusZGyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HbOfRo2m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2UgaTYRN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 17:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747329437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9XQ7cpIEOSIUhnsp+grEm7dB6uyWzWRgJ0vBn/C22k=;
	b=HbOfRo2mLPS+YP8OnEpXdxwyD0bEfig1RvAqtNU3DB9ef+gpAjE2CBl4hyAG1kJ3zmlUvm
	BvG1XwaiArz6ykneCgEZ1mOAO8xsWG587TB/GJgcUSgg2Jh3bng08iwAiR+PoFqBKBSgjd
	68y2AS0x0gTpUvTl9jIPndvGdD3wGdERtxI/RzR0pAhOF2/YhlkzSVpLL2HTECuKNWZ02l
	lcXtHSS7te+jDZs55ZT2oeOc1LLa31sSk1rK5dwll/dNRiJWeLeO8fS9bsoIZoy+pX0vyQ
	RsTqUydo6WR/Y9ZUt/nDDp4Zw00adIIQMNUQDRGrWq+b6DNdPLameODOz+2vGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747329437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9XQ7cpIEOSIUhnsp+grEm7dB6uyWzWRgJ0vBn/C22k=;
	b=2UgaTYRNK2oUOSGNZq/tsJWAgxVXglHkbhQ4EIEMzDrGHYNeAMT6VzTCez5jWiI/ZnH3zO
	lZH7KccGa7s6HJBg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpuid: Rename have_cpuid_p() to cpuid_feature()
Cc: Ingo Molnar <mingo@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508150240.172915-4-darwi@linutronix.de>
References: <20250508150240.172915-4-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732943698.406.15999647853466431436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2f924ca36d2f788d40a57ea48825ff51cba4e700
Gitweb:        https://git.kernel.org/tip/2f924ca36d2f788d40a57ea48825ff51cba4e700
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 18:23:55 +02:00

x86/cpuid: Rename have_cpuid_p() to cpuid_feature()

In order to let all the APIs under <cpuid/api.h> have a shared "cpuid_"
namespace, rename have_cpuid_p() to cpuid_feature().

Adjust all call-sites accordingly.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250508150240.172915-4-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h     |  4 ++--
 arch/x86/kernel/cpu/common.c         | 10 +++++-----
 arch/x86/kernel/cpu/microcode/core.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index ff8891a..c0211fc 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -14,9 +14,9 @@
  */
 
 #ifdef CONFIG_X86_32
-bool have_cpuid_p(void);
+bool cpuid_feature(void);
 #else
-static inline bool have_cpuid_p(void)
+static inline bool cpuid_feature(void)
 {
 	return true;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c14db8d..8feb8fd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -322,7 +322,7 @@ static int __init cachesize_setup(char *str)
 __setup("cachesize=", cachesize_setup);
 
 /* Probe for the CPUID instruction */
-bool have_cpuid_p(void)
+bool cpuid_feature(void)
 {
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
@@ -1711,11 +1711,11 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 	c->extended_cpuid_level = 0;
 
-	if (!have_cpuid_p())
+	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
 	/* cyrix could have cpuid enabled via c_identify()*/
-	if (have_cpuid_p()) {
+	if (cpuid_feature()) {
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		intel_unlock_cpuid_leafs(c);
@@ -1875,11 +1875,11 @@ static void generic_identify(struct cpuinfo_x86 *c)
 {
 	c->extended_cpuid_level = 0;
 
-	if (!have_cpuid_p())
+	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
 	/* cyrix could have cpuid enabled via c_identify()*/
-	if (!have_cpuid_p())
+	if (!cpuid_feature())
 		return;
 
 	cpu_detect(c);
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index a3bcb6d..fe50eb5 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -118,7 +118,7 @@ bool __init microcode_loader_disabled(void)
 	 * 3) Certain AMD patch levels are not allowed to be
 	 *    overwritten.
 	 */
-	if (!have_cpuid_p() ||
+	if (!cpuid_feature() ||
 	    native_cpuid_ecx(1) & BIT(31) ||
 	    amd_check_current_patch_level())
 		dis_ucode_ldr = true;

