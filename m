Return-Path: <linux-tip-commits+bounces-6034-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522DAFD788
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43BB97B54CA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251423A9BD;
	Tue,  8 Jul 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FO8f0sDS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8BwOhHNf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CB238152;
	Tue,  8 Jul 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004229; cv=none; b=bWe/83N/4n/AjMRL6GsVNNAcpNrhPVLa61lQHmT57e+uKabzzEFQVHMu2r0HiOkf+4ay8GAcvCDyZZFE6ayebTXY4eyOrF2EcpK2JVLOswgIShnxGPWncm4HOO4EMjwqerxI4/wYodj601NV2DALYhv8Fzu6zT+sdKgaRIY/EM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004229; c=relaxed/simple;
	bh=UwmKIRI3/rXQWWCZog6ZM2WoDdWMjM6xEJp7EJpfwfE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QUkaQBJpS9+EoqtBRXTxRcuCaIwPzay/PMWtFimrdVZ1bOd4KZ/0br+h05gACowa1Lb4cn4AZckrIsxKGduPvypsSZRS1VerbyabsWwHrl+3St+yZjoV6v05TUYb2jUTTbMATX+7oGBWPfx0+L+URArNuggGiGhUZje6LvopoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FO8f0sDS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8BwOhHNf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 19:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752004225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKyrGkB9Kx7hAdWcZnkKHFjAk3ax69GJ1bgJ1HGzYVs=;
	b=FO8f0sDSJRKuWVpmYNmBv/feKlKZc5oAhVxAdU5oRzITY6M4aThOdLg2hJcyQCq3SlRHpH
	cqUJurzhqgm9Ys/ZDg6jodzCAfwSm34pC0Br/z6DTQiOnrklFsots00qGoLRw87GRHn8E6
	Wo2spVuXeIFWrhoeLvOnBm/aVK9H19HghFRNU4B/qK9MOx7CEHTpZkl0PBKFrhiFUN3txN
	Q7JUb663d77a3gIahlUdb7GjerAf7sKRVEUHKgTzzwX2AimGuzd85lSlvHGm1Luqrx37Hy
	oCrDiGRsqSe5RgOgPEx7e3b60ceFKowtbeHvu9wqaYVd3G0Wcgft5nNFPzyh8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752004225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKyrGkB9Kx7hAdWcZnkKHFjAk3ax69GJ1bgJ1HGzYVs=;
	b=8BwOhHNfYFltZd0RbfKsNN1icNm78H895KjfriiBnwIkyyTEovvekFsHwxK6g7RwJF7bPx
	/2od+39rJmnn26AQ==
From: "tip-bot2 for Mikhail Paulyshka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/rdrand: Disable RDSEED on AMD Cyan Skillfish
Cc: Mikhail Paulyshka <me@mixaill.net>, "Borislav Petkov (AMD)" <bp@alien8.de>,
  <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250524145319.209075-1-me@mixaill.net>
References: <20250524145319.209075-1-me@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175200422447.406.16824702825580478461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5b937a1ed64ebeba8876e398110a5790ad77407c
Gitweb:        https://git.kernel.org/tip/5b937a1ed64ebeba8876e398110a5790ad77407c
Author:        Mikhail Paulyshka <me@mixaill.net>
AuthorDate:    Sat, 24 May 2025 17:53:19 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 08 Jul 2025 21:33:26 +02:00

x86/rdrand: Disable RDSEED on AMD Cyan Skillfish

AMD Cyan Skillfish (Family 17h, Model 47h, Stepping 0h) has an error that
causes RDSEED to always return 0xffffffff, while RDRAND works correctly.

Mask the RDSEED cap for this CPU so that both /proc/cpuinfo and direct CPUID
read report RDSEED as unavailable.

  [ bp: Move to amd.c, massage. ]

Signed-off-by: Mikhail Paulyshka <me@mixaill.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
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

