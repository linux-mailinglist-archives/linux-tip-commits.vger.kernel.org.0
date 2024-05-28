Return-Path: <linux-tip-commits+bounces-1304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4978D22FB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D2C1F250A1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55495173329;
	Tue, 28 May 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vn8Ocd/o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBoWAG3U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECDA16C866;
	Tue, 28 May 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919513; cv=none; b=FGScA3nMntmIhaoqfZWdhR9fJjF3+/dEp2xdLThbRNUYyn7r1FAxXn8nI51q1TCKAwPq1CKmTO2TGVj1O0g4M3hK4fBC2KCLYHXsvLm2St3tFuM4CeTtkrEpEtmNooJb/EdaPR8Bh1mRqo4KQiJEnWzd2PL82aVpDghV5nM7kgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919513; c=relaxed/simple;
	bh=5G7tKmfCtHyv18bLVIF0v2xAiIAwF4cOtKBeuU72N98=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=j8+3d38PFyCJ2GKZY/59TBjeYgKubqeazifrggLHBeBPjk1oZYMu6y6JGEh01RfNgJpb267KjFi/ssgtj7wstvsexfUafvGzG9n4TgbKnIp8cbul8jSgwCgsyZE+5+QlublI2xr5HmySO4BSAQ+3bpX+N+E67s8BO+1tdGZ7A1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vn8Ocd/o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OBoWAG3U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 18:05:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uYHZBPzRKOs4EVB1O7xnTk06IscfJLUuTsg1am8cADU=;
	b=vn8Ocd/oT+QrMr6V13OV7bnwkfyWHmsfWu5DKmj6YaWeBDxABTrVHK0vQuQcQNlIPZoPgs
	wFAaUBii9JYz4RiIxPwu+46Sm2nNh847c70qbQaPEnTCwKwPNPevLLY/24y+M7H5IKVtRd
	Sdw3EB2w+WjQFbXeQz6fjyToZHa9aMeBDXhG8Zofo1RvDXXOshGuj5NmsB7jwtYIHr//jy
	CyZT7iAVjYU5EjjKjXoxA2UhSCXc/KcOIIX8iy/2lPJwsqiedVeQtQ5IuVhiFDPvAOYf6Z
	YutDCmjonb13SSkKWjMzoTzgb4/3uilMp2TtnCn2FaPOrUx71Di4MdGBV7P4MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uYHZBPzRKOs4EVB1O7xnTk06IscfJLUuTsg1am8cADU=;
	b=OBoWAG3UaOfGrC135/xSKrpB06IDAVMlbzGA2LipF/h63NHd3ZjUcsjc8kRSexPMDOMOa6
	j+NuZjOCjM3nNzDg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/PCI: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171691950764.10875.4006879439642445283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ac6bee4bf73cdfbd2234125d387b1db3a5bbfc19
Gitweb:        https://git.kernel.org/tip/ac6bee4bf73cdfbd2234125d387b1db3a5bbfc19
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 20 May 2024 15:46:00 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 May 2024 10:59:02 -07:00

x86/PCI: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240520224620.9480-30-tony.luck%40intel.com
---
 arch/x86/pci/intel_mid_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 8edd622..933ff79 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -216,7 +216,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 }
 
 static const struct x86_cpu_id intel_mid_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 
@@ -243,7 +243,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		model = id->model;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_SILVERMONT_MID:
+	case VFM_MODEL(INTEL_ATOM_SILVERMONT_MID):
 		polarity_low = false;
 
 		/* Special treatment for IRQ0 */

