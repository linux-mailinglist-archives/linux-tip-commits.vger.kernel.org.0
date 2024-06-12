Return-Path: <linux-tip-commits+bounces-1386-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ED3905CC5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5013B1F2512B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3312BF3A;
	Wed, 12 Jun 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cs/Jahda";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QyZGsHrJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6586131;
	Wed, 12 Jun 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223870; cv=none; b=FAWgECEWnZ5LCc2OOV2V/jvABhqxWpI0aPpo/nQzuzAtQgfeBjRnOzv6E+Bk8tRQbHcACpRD0qE5wETVdlirpoSj+u66WBWSTpTDzFfEfVNlnw8XkrGrvVPPcdstqrv60XXgX2JupcUVbCKwmgzduA2C93yGYDHn6e68W5NeFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223870; c=relaxed/simple;
	bh=ApYZdLNuUJzjqE4AKZ+XdS38KhFjXZWN2LCzSRNDuww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jK6Ig+fioMABRc6h+vdlaP8Z6ebHq3ocvwu0o1Xv7moFU6iEXJlWLDdnUaK6EV5NMpBiUi3jYzaOQvA4ciJJq7ET39jL5Qi4n/Y/nu6N7vmOc+eBC0GyfQDgScZ5raqq5yHQq4NaYoZxg/RaFUMQK8f5GriB609SfCOtGXLZ7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cs/Jahda; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QyZGsHrJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aQHRXengOg/8EE3hlu3ApaMxL+SykXrZ6fuyZrWFmQ=;
	b=cs/JahdaVO2NoaCHRCTSurbVGX/G81KP4HcdlZMwbUn+gmq9u/s/z/IHanmRbT8JNJ1k+M
	aVzL6csIV4pym59iEF6Mhn5JPJNeBg9awljcrplN/rdJfjD4vJRHa6C2pAGb6puHgC/5ti
	XeknKdwwfT0JCUCYOeaNaeeZ4cLDm3/EoMogjNIaxI6L+KS3r7zuXnaNeNzkXV8IAe4RUz
	3wU1Lf+IXkEowjPBU6TwQJXpmLXaYuL4iRwD5oVOLQRh/23bEebPj05IQW8dnJHTQTmBUA
	qhtOvRuvd+26wifCb1iecJ9lTCTEG/368Cvy+pvUfilEylv38Fi20M4SRRChkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aQHRXengOg/8EE3hlu3ApaMxL+SykXrZ6fuyZrWFmQ=;
	b=QyZGsHrJwz7txMt2Vow3OKnLskvhFqZzvtHjzQInr/xi2g2redMWYy00CAWeR343gu8Ei7
	eY7r0nfus+kpRYAA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] EDAC/amd64: Remove unused register accesses
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240606-fix-smn-bad-read-v4-1-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-1-ffde21931c3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386485.10875.12222726531901598153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f97a8b9170a0524c5432791cd5852bf797934af4
Gitweb:        https://git.kernel.org/tip/f97a8b9170a0524c5432791cd5852bf797934af4
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 06 Jun 2024 11:12:54 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:33:45 +02:00

EDAC/amd64: Remove unused register accesses

A number of UMC registers are read only for the purpose of debug printing. They
are not used in any calculations. Nor do they have any specific debug value.

Remove them.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-1-ffde21931c3f@amd.com
---
 drivers/edac/amd64_edac.c | 18 +-----------------
 drivers/edac/amd64_edac.h |  4 ----
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index a17f3c0..dfc4fb8 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -20,7 +20,6 @@ static inline u32 get_umc_reg(struct amd64_pvt *pvt, u32 reg)
 		return reg;
 
 	switch (reg) {
-	case UMCCH_ADDR_CFG:		return UMCCH_ADDR_CFG_DDR5;
 	case UMCCH_ADDR_MASK_SEC:	return UMCCH_ADDR_MASK_SEC_DDR5;
 	case UMCCH_DIMM_CFG:		return UMCCH_DIMM_CFG_DDR5;
 	}
@@ -1341,22 +1340,15 @@ static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
-	u32 i, tmp, umc_base;
+	u32 i;
 
 	for_each_umc(i) {
-		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
 		edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
 		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
 		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
 		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
-
-		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
-		edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
-
-		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_UMC_CAP, &tmp);
-		edac_dbg(1, "UMC%d UMC cap: 0x%x\n", i, tmp);
 		edac_dbg(1, "UMC%d UMC cap high: 0x%x\n", i, umc->umc_cap_hi);
 
 		edac_dbg(1, "UMC%d ECC capable: %s, ChipKill ECC capable: %s\n",
@@ -1369,14 +1361,6 @@ static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
 				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
 
-		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
-			amd_smn_read(pvt->mc_node_id,
-				     umc_base + get_umc_reg(pvt, UMCCH_ADDR_CFG),
-				     &tmp);
-			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
-					i, 1 << ((tmp >> 4) & 0x3));
-		}
-
 		umc_debug_display_dimm_sizes(pvt, i);
 	}
 }
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index b879b12..17228d0 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -256,15 +256,11 @@
 #define UMCCH_ADDR_MASK			0x20
 #define UMCCH_ADDR_MASK_SEC		0x28
 #define UMCCH_ADDR_MASK_SEC_DDR5	0x30
-#define UMCCH_ADDR_CFG			0x30
-#define UMCCH_ADDR_CFG_DDR5		0x40
 #define UMCCH_DIMM_CFG			0x80
 #define UMCCH_DIMM_CFG_DDR5		0x90
 #define UMCCH_UMC_CFG			0x100
 #define UMCCH_SDP_CTRL			0x104
 #define UMCCH_ECC_CTRL			0x14C
-#define UMCCH_ECC_BAD_SYMBOL		0xD90
-#define UMCCH_UMC_CAP			0xDF0
 #define UMCCH_UMC_CAP_HI		0xDF4
 
 /* UMC CH bitfields */

