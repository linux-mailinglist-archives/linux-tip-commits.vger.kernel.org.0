Return-Path: <linux-tip-commits+bounces-3103-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE59F6844
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCD81893EEC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8F1E9B2C;
	Wed, 18 Dec 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGLBsNsH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZcWO9SBu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9891D45FC;
	Wed, 18 Dec 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531760; cv=none; b=dK6e2FkOBGpFXmU/SU1SYaCg2aH73cvbgby8dbwkjpzmr6bhshT129PLPpDyIOKh/ARwr7vNMLx835H+5buwBNe88sYY2BO4QVIOXh93abzqag07EF+jLOOYLwfRcD8BuY6zDMmTOlG2w0BBytmJmQioIxnq0izk2LUDz4VfnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531760; c=relaxed/simple;
	bh=U58e6kV2cWFkC6oqGfNAm/NiWWDRues43q2GylPguSc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=g6m94kBMu+MH51tN7XMDAcGLaa1ACbmnPRg9wKkLU0uQekQhWO5Jm/nR0SV9srEIX692tNEQHmO7b3jGrurCUZlBVvLwZoox4Sz61npYz98u5xLQBjI+yASJ0/7iEzkZ7UjDQSP8148S26yhbZsXkSsKFg8yP29sjDr7FoA60js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGLBsNsH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZcWO9SBu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6cxdCaCN88KS7tCKXwZlNNItiAXfhT44Uq9VUgYKZ50=;
	b=dGLBsNsHHPrVtQSnVPgNro1GYaV4CwEOvjiGuAZAS9d1PosvFhGzDuncqxalz/vNPTxoAP
	5iBNYUpaTJi6NaKBETvBuueA6z1oePSICM6CSO8dByLiOSv8aIL1N6YhS+HGPqrIpmJEik
	b+HQR7dW5lQ260lKTP8vNMfnmventDVsYHsqSjiaGcl0mkB6RQ8aHErD+ZTOA+inxQzMYh
	oEVu2gqkT/Z7HzZeYW9HTDeE5/jfuPI5Hxd3Fj7LGKDjq29iW6jM4cx3ffr350L98xjskc
	2P32eJs1194y/XMuAv5eZe0YMjahuwfX2RI6jmeneYQnOojEnGv5myAtj5WlOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6cxdCaCN88KS7tCKXwZlNNItiAXfhT44Uq9VUgYKZ50=;
	b=ZcWO9SBu9sf/9c5CymDjhrl+m0ImfD0/qQYQQOKnzSsgYnHDyTNfgMIJMzBiMh1K48hY3y
	eVSY9cPGV4JS1JDA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Refresh DCA leaf reading code
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453175668.7135.9164894794621554485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5d82d8e0a9ac06bfc6ac59407b96bc357eff441a
Gitweb:        https://git.kernel.org/tip/5d82d8e0a9ac06bfc6ac59407b96bc357eff441a
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:32 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:34 -08:00

x86/cpu: Refresh DCA leaf reading code

The DCA leaf number is also hard-coded in the CPUID level dependency
table. Move its definition to common code and use it.

While at it, fix up the naming and types in the probe code.  All
CPUID data is provided in 32-bit registers, not 'unsigned long'.
Also stop referring to "level_9".  Move away from test_bit()
because the type is no longer an 'unsigned long'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205032.476A30FE%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpuid.h | 3 ++-
 arch/x86/kernel/cpu/common.c | 2 +-
 drivers/dma/ioat/dca.c       | 8 +++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 13ecab9..8ba4d9f 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -21,7 +21,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_MWAIT_LEAF		5
+#define CPUID_MWAIT_LEAF	0x5
+#define CPUID_DCA_LEAF		0x9
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 853e373..5ffa1f4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -638,7 +638,7 @@ struct cpuid_dependent_feature {
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
 	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
-	{ X86_FEATURE_DCA,		0x00000009 },
+	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
 	{ X86_FEATURE_XSAVE,		0x0000000d },
 	{ 0, 0 }
 };
diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
index 17f6b63..658ea2e 100644
--- a/drivers/dma/ioat/dca.c
+++ b/drivers/dma/ioat/dca.c
@@ -10,6 +10,8 @@
 #include <linux/interrupt.h>
 #include <linux/dca.h>
 
+#include <asm/cpuid.h>
+
 /* either a kernel change is needed, or we need something like this in kernel */
 #ifndef CONFIG_SMP
 #include <asm/smp.h>
@@ -58,11 +60,11 @@ static int dca_enabled_in_bios(struct pci_dev *pdev)
 {
 	/* CPUID level 9 returns DCA configuration */
 	/* Bit 0 indicates DCA enabled by the BIOS */
-	unsigned long cpuid_level_9;
+	u32 eax;
 	int res;
 
-	cpuid_level_9 = cpuid_eax(9);
-	res = test_bit(0, &cpuid_level_9);
+	eax = cpuid_eax(CPUID_DCA_LEAF);
+	res = eax & BIT(0);
 	if (!res)
 		dev_dbg(&pdev->dev, "DCA is disabled in BIOS\n");
 

