Return-Path: <linux-tip-commits+bounces-1387-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A0905CC6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01751C23357
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08712C46B;
	Wed, 12 Jun 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWKv6YvS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OaJc+8Ch"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE486136;
	Wed, 12 Jun 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223870; cv=none; b=HtFnJhL4gJbsvaMSHYf3OLSHar/cYeNtMg3WT8DMCykb1uk0RHDaz9pZP9FlTtXYT3TFjRm95TpBGWmvC3/+NCFVd34lpqBmoZccKy6DXJjmzsVFA2hYD0FQRDXHnDqYiu5tQhmSKFmP+XyXS9ohhDoCO2vwIIPG1bSValpBog0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223870; c=relaxed/simple;
	bh=JvlkmWHp3P0dni5DDs+SzyHei/Lx0vps4XnzwG+qMXU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u6pJFD5p1iAzB6/LPeD0cDZmycImH8nlJ+Cw890GNHsygY1ZmIT/LmeBMTRQ2RD8Y3uIcmkFdOCEgXMi1CxpvjasgraN5k/+FwKxF/tNGp2O8RThPsPuuaPJPtmPCuxa1den5C5hflMaHMLSl4vcEGf9Kyr0ppVObRY5rGyJxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWKv6YvS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OaJc+8Ch; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQuo7rsFRtq2Le53hgCQQXzloZoV6Wq50+nX5xbwYm0=;
	b=HWKv6YvS8TG9f6bvdUMy8Xf51rl2c71q9jNfk9kGgBm/XtaXSAYweqwtM5wUnuDUbJup+k
	43GVu4aS82+SNqMTJmeLjPNNuIENqR6ejO2YMOLhvp0rWQ2iEKj7nWkA4zeDDhCr/imQIv
	Vf8WOMsy6KgKzfOuTDXyjlA5+I0jODi80gTK6q0qwnZNYMpNMKXVV13bxWMaqiSUOqZbaa
	otAIAbEXmGPFNfr05B4LdOLNaRbdWgdABF2964QLlxuaUXyXuoRSXn8V0TXdRY4xX201uV
	dP7BvsL2xIHf+KxjORPn/TTjvOo5tmnkO16B1V6qytAM0lS9us7PtLkxWmhYZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQuo7rsFRtq2Le53hgCQQXzloZoV6Wq50+nX5xbwYm0=;
	b=OaJc+8ChGnZyo8u68Thu8l/hiZE6WaXjC8qnbbcU3BXGTHfiiBSX51e9U/JNoiU3fZU0Xg
	eDGtojOp5a9PwyBw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] EDAC/amd64: Check return value of amd_smn_read()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240606-fix-smn-bad-read-v4-2-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-2-ffde21931c3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386457.10875.4849010821781301086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     5ac6293047cf5de6daca662347c19347e856c2a5
Gitweb:        https://git.kernel.org/tip/5ac6293047cf5de6daca662347c19347e856c2a5
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 06 Jun 2024 11:12:55 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:33:45 +02:00

EDAC/amd64: Check return value of amd_smn_read()

Check the return value of amd_smn_read() before saving a value. This
ensures invalid values aren't saved. The struct umc instance is
initialized to 0 during memory allocation. Therefore, a bad read will
keep the value as 0 providing the expected Read-as-Zero behavior.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-2-ffde21931c3f@amd.com
---
 drivers/edac/amd64_edac.c | 51 +++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index dfc4fb8..ddfbdb6 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1438,6 +1438,7 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 	u32 *base, *base_sec;
 	u32 *mask, *mask_sec;
 	int cs, umc;
+	u32 tmp;
 
 	for_each_umc(umc) {
 		umc_base_reg = get_umc_base(umc) + UMCCH_BASE_ADDR;
@@ -1450,13 +1451,17 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 			base_reg = umc_base_reg + (cs * 4);
 			base_reg_sec = umc_base_reg_sec + (cs * 4);
 
-			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, &tmp)) {
+				*base = tmp;
 				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *base, base_reg);
+			}
 
-			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, base_sec))
+			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, &tmp)) {
+				*base_sec = tmp;
 				edac_dbg(0, "    DCSB_SEC%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *base_sec, base_reg_sec);
+			}
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
@@ -1469,13 +1474,17 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 			mask_reg = umc_mask_reg + (cs * 4);
 			mask_reg_sec = umc_mask_reg_sec + (cs * 4);
 
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, &tmp)) {
+				*mask = tmp;
 				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *mask, mask_reg);
+			}
 
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, mask_sec))
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, &tmp)) {
+				*mask_sec = tmp;
 				edac_dbg(0, "    DCSM_SEC%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *mask_sec, mask_reg_sec);
+			}
 		}
 	}
 }
@@ -2894,7 +2903,7 @@ static void umc_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u32 i, umc_base;
+	u32 i, tmp, umc_base;
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
@@ -2902,11 +2911,20 @@ static void umc_read_mc_regs(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &umc->dimm_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
+		if (!amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &tmp))
+			umc->dimm_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &tmp))
+			umc->umc_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &tmp))
+			umc->sdp_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &tmp))
+			umc->ecc_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &tmp))
+			umc->umc_cap_hi = tmp;
 	}
 }
 
@@ -3635,16 +3653,21 @@ static void gpu_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u32 i, umc_base;
+	u32 i, tmp, umc_base;
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
 		umc_base = gpu_get_umc_base(pvt, i, 0);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &tmp))
+			umc->umc_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &tmp))
+			umc->sdp_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &tmp))
+			umc->ecc_ctrl = tmp;
 	}
 }
 

