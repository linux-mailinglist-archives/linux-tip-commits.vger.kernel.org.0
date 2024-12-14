Return-Path: <linux-tip-commits+bounces-3073-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2619F2071
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DEB16800A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A81B0F33;
	Sat, 14 Dec 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SrL48LE5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mfDVLjql"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE91ABEBB;
	Sat, 14 Dec 2024 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202075; cv=none; b=sikUa2V+T91hzUWarer2A8eBRGFAAy+7xovDNfmvWl6NYeNalQDi/Ipbefz3/QEHYY8Cs+3/uO8UhcgGTmWo2ICP1aPjYpYY2u3Ldojrn9gsx0w6Nfg94TmGneHXrW4YqsABXbEQwoli3etd3dVEdklNxAzgMwYA5ojIRnZAj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202075; c=relaxed/simple;
	bh=b3DjByCG+U1TVIxGFs076OVXBu4rRTXKtYWMNXm2XPs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BrhJAcAbI1V/MASQAes0giq2Qq85Xq3n0e65LKJkOCesXnlJ4mHEAsdFQAztZSFBOpagMDXbBDUNIWpXUp965lsFWMGF49gpZU7/4/d7DdQoDUJSCny0SIw9gjnHeD00wPaJafmQrrBHJTxh3JosVB/DEhRq3r6YX7EmkX3VfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SrL48LE5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mfDVLjql; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734202072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvGQ16Utw3T6o0ro9gy0ez2vKczMe0VhyV3OfJ1jjeY=;
	b=SrL48LE5KHboudpj3rfY6sQyYsiPMOIycI9DuTPaJAuGc8n03+A8lVpiKSHtiwcNBO6cfv
	HPb/2Vvty40BRgBIVAqwjrfW/BkzsEVJaZQc6CpnBBxsFNfWG1cN0TEvSyjr6z65DbBihX
	nXf7dX986ZqRZuwnUoz4OLce9PTiMboaaC8xPKKz4Ph4XU7Rnyew0Lr7bj4ncduODIpNm1
	lscilF4kCGkqiGMA5y/lJ/3EBXJzXjpc8qBFgd3mJqozPomlDe765XSFCFSdzVcYZFGNdP
	B2tcOWsmvR/fX123LEj3stWo1G1Uh8SGh2nU9BgQlg2HD1+i2gBlYM/rf80e6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734202072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvGQ16Utw3T6o0ro9gy0ez2vKczMe0VhyV3OfJ1jjeY=;
	b=mfDVLjqlXzb6yT2DHhKYONGH+BuRFpHnEif8Wl71RTsbFUsrMHVXuRoClC5wr+tATuoQ2f
	nxQ6OPQWUWDmDpBA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Move the SNP probe routine out of the way
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6c2975bbf132d567dd12e1435be1d18c0bf9131c=2E17331?=
 =?utf-8?q?72653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C6c2975bbf132d567dd12e1435be1d18c0bf9131c=2E173317?=
 =?utf-8?q?2653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420207145.412.17772875013895035804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e2f3d40df82eeb70f6c3602418bca63c54183776
Gitweb:        https://git.kernel.org/tip/e2f3d40df82eeb70f6c3602418bca63c54183776
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 02 Dec 2024 14:50:49 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 14 Dec 2024 11:08:48 +01:00

x86/sev: Move the SNP probe routine out of the way

To make patch review easier for the segmented RMP support, move the SNP
probe function out from in between the initialization-related routines.

No functional change.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Link: https://lore.kernel.org/r/6c2975bbf132d567dd12e1435be1d18c0bf9131c.1733172653.git.thomas.lendacky@amd.com
---
 arch/x86/virt/svm/sev.c | 60 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 18191cb..0df3789 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -135,36 +135,6 @@ static __init void snp_enable(void *arg)
 	__snp_enable(smp_processor_id());
 }
 
-#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
-
-bool snp_probe_rmptable_info(void)
-{
-	u64 rmp_sz, rmp_base, rmp_end;
-
-	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
-	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
-
-	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
-		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
-		return false;
-	}
-
-	if (rmp_base > rmp_end) {
-		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
-		return false;
-	}
-
-	rmp_sz = rmp_end - rmp_base + 1;
-
-	probed_rmp_base = rmp_base;
-	probed_rmp_size = rmp_sz;
-
-	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
-		rmp_base, rmp_end);
-
-	return true;
-}
-
 static void __init __snp_fixup_e820_tables(u64 pa)
 {
 	if (IS_ALIGNED(pa, PMD_SIZE))
@@ -291,6 +261,36 @@ nosnp:
  */
 device_initcall(snp_rmptable_init);
 
+#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
+
+bool snp_probe_rmptable_info(void)
+{
+	u64 rmp_sz, rmp_base, rmp_end;
+
+	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+
+	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
+		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
+		return false;
+	}
+
+	if (rmp_base > rmp_end) {
+		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
+		return false;
+	}
+
+	rmp_sz = rmp_end - rmp_base + 1;
+
+	probed_rmp_base = rmp_base;
+	probed_rmp_size = rmp_sz;
+
+	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
+		rmp_base, rmp_end);
+
+	return true;
+}
+
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
 	if (!rmptable)

