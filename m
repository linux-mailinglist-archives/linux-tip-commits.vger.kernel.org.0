Return-Path: <linux-tip-commits+bounces-3180-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F5A07130
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CEA188A109
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E43215F5B;
	Thu,  9 Jan 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOFXscVa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAaLl0Ld"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F521576E;
	Thu,  9 Jan 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414145; cv=none; b=Bb2EaNmG2YTCpn8Noric+RQu2icPuDNHAHINaevJV1Ka3sOs6ZxwoGxm3ZBD6K64AW35RflpzHop8NT6pqio/ATRhjFAbOwL0duiLv/k46RgZDUnqiN8vh+ASzz3NbZLxf762GgYT5IX1K7im0o2043JbljzGAiKsf4ohwaTnEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414145; c=relaxed/simple;
	bh=o1cdBo+DBCobaWL8PSAyqYb33FUDGHrAt34294CLfPQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VuMeUtPLKy1/IbFzS/3cvRgEREhMv0C0mIz7ZE9obkUBPGFyqdIqqQ1I+JEHxpV0mCl6Go8LhG5Pyrwqaqz1WMkURs6ytKOJr6gHCon7RK2Vwifr0UXbUgLfNpXyYtYGY2nerU+687x02DibVEVXBd5z7G0peaJrylDXBSH34II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOFXscVa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAaLl0Ld; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtby4PcbRXc0h8F85pWYA7AA3Gzajp+G6OTRutk1k1E=;
	b=OOFXscVacxjnnp5NMlcBmBHEniV5jO7W0oXPtWHHHDpwuOBDLFFMvOvKM0ESu8EVhkb19G
	lpB8Y7Mu4eWdRTX4H4/BET2RBZgYUfufk9/T59FgVp3mcnSMrA+eHcfxothimG5z4z2NCZ
	ucSruX38Ak5J2rxDolXqbN75nVIMu5+HUESdlq0tNdP37K/3pttrZREDoHydgqqD0mgsCG
	rJRzlPiZ2Gn/qJ3JpjHMKNJMy3ApcspwQbGtaAYJ+4TzLf57ohwjZFD3+i//cQkTQav4MT
	tu2yDVrRxcW0gECVIt1sofvzAX9FlorL6C6Y7ZNq0X34mxvJwx63fPLni/gcZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtby4PcbRXc0h8F85pWYA7AA3Gzajp+G6OTRutk1k1E=;
	b=vAaLl0LddQD04AmZRoY4ENQxndYbeLFcbYNhYOb0t4vNic6OUXRZ+FullWJ/oeuY5v4OQU
	4olCtN2s712DmhCg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb: Simplify function 3 search
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250107222847.3300430-8-yazen.ghannam@amd.com>
References: <20250107222847.3300430-8-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641414093.399.13196840762577704554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     49b96fc0dddc7b3a01c6707fcaad06fc520402ac
Gitweb:        https://git.kernel.org/tip/49b96fc0dddc7b3a01c6707fcaad06fc520402ac
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 07 Jan 2025 22:28:42 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:58:16 +01:00

x86/amd_nb: Simplify function 3 search

Use the newly introduced helper function to look up "function 3". Drop
unused PCI IDs and code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250107222847.3300430-8-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c | 46 +---------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6371fe9..e335d89 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -29,31 +29,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
-	{}
-};
-
-static const struct pci_device_id hygon_nb_misc_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
 
@@ -84,17 +59,6 @@ struct amd_northbridge *node_to_amd_nb(int node)
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
 
-static struct pci_dev *next_northbridge(struct pci_dev *dev,
-					const struct pci_device_id *ids)
-{
-	do {
-		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
-		if (!dev)
-			break;
-	} while (!pci_match_id(ids, dev));
-	return dev;
-}
-
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -183,18 +147,12 @@ EXPORT_SYMBOL_GPL(amd_smn_write);
 
 static int amd_cache_northbridges(void)
 {
-	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	struct pci_dev *misc;
 	struct amd_northbridge *nb;
 	u16 i;
 
 	if (amd_northbridges.num)
 		return 0;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		misc_ids = hygon_nb_misc_ids;
-	}
-
 	amd_northbridges.num = amd_num_nodes();
 
 	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
@@ -203,11 +161,9 @@ static int amd_cache_northbridges(void)
 
 	amd_northbridges.nb = nb;
 
-	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = amd_node_get_root(i);
-		node_to_amd_nb(i)->misc = misc =
-			next_northbridge(misc, misc_ids);
+		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
 
 		/*
 		 * Each Northbridge must have a 'misc' device.

