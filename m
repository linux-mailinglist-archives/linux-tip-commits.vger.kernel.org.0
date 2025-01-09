Return-Path: <linux-tip-commits+bounces-3178-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A130A0712A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A68188A7DD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839A215786;
	Thu,  9 Jan 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jj8XJT2v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+U2zJCzI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97732153EE;
	Thu,  9 Jan 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414144; cv=none; b=pejaVC2bFx11GJIO0KTVS+qx+/ICVTqY2U5n0SyrV0Ct7i4FVdBw7Zu1J1Q3MdOfJZiMgvVtm7xtdwR3S9IfYpE7mZr0v1Z3ZzaDc3iW7i0juaW3qYtTdTMdx0sXNZTNi2wKwuR3DdnJOB76kWjlGYTtEstLjcvg0tYaL6M7s90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414144; c=relaxed/simple;
	bh=zbihtPIAw1MVD4Dy3qg63OIs6/DT5pgwFc1Z7yNeRcc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GqZFYm9cUwFSj1Kwv2EaxrRn7bWlnK95Wi4C62rtuozLw/34M9zUz9GtQ8ljP/89HmpW5PS96oKE/nvQAjsiGc40w3G/FkFWVKPZyoGCBOq8EJkhZ2c4liyRfzBbhMsU5rlt5xLJVX8e4OM6T9LKWdpad0RDU+qMi4jumuZEtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jj8XJT2v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+U2zJCzI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFoG06LhdEVtEdwUhsDTEc2+CSFjyUMSvegFpsrR/as=;
	b=Jj8XJT2vDa0+0U2peEGLsGOPI4/tqq/TBIhuRQF9BhKLzribikVAPomzxSIwwaLzlUHm1P
	DHvkvsqaQfxlG1QMS45UBfUWemCc2gHbYJjYF0lUGY75+83Gwxj0EZ+ObMk6cqSRNEQEWq
	bkROvDm+apkNcPgC4YpoxrgaC48q6ZQjDObH8ao9iUZ/fx942PNeL1oGfu+AvfU8jf7HzG
	VNsj/GQaEXuR9zk68RHdzIgGhSwCbpewcdqLi+7m4rF42+Xwncz0gDDSoZ625SlZqXB17k
	GfQX1fdt23CeXRP81VTpzxh6GRRQpC+IkRPeNeMDrF1M4MbgTn15pBQedRwDNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFoG06LhdEVtEdwUhsDTEc2+CSFjyUMSvegFpsrR/as=;
	b=+U2zJCzI1P3Jrt3l2fmGmYVZDfKct5nlqjBU5yR1oAbLJB1rdfuDZFQ9jm7zbi8Wx7gvYa
	shWAam8C9i9KrQCA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb, hwmon: (k10temp): Simplify
 amd_pci_dev_to_node_id()
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-10-yazen.ghannam@amd.com>
References: <20241206161210.163701-10-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641413969.399.16178260728108752476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     7dd57db495d49c004fffc77265ffbaccf340aa20
Gitweb:        https://git.kernel.org/tip/7dd57db495d49c004fffc77265ffbaccf340aa20
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:12:02 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:59:01 +01:00

x86/amd_nb, hwmon: (k10temp): Simplify amd_pci_dev_to_node_id()

amd_pci_dev_to_node_id() tries to find the AMD node ID of a device by
searching and counting devices.

The AMD node ID of an AMD node device is simply its slot number minus
the AMD node 0 slot number.

Simplify this function and move it to k10temp.c.

  [ Yazen: Update commit message and simplify function. ]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20241206161210.163701-10-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_nb.h | 17 -----------------
 drivers/hwmon/k10temp.c       |  5 +++++
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index b48dc69..094c3be 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -82,23 +82,6 @@ u16 amd_nb_num(void);
 bool amd_nb_has_feature(unsigned int feature);
 struct amd_northbridge *node_to_amd_nb(int node);
 
-static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
-{
-	struct pci_dev *misc;
-	int i;
-
-	for (i = 0; i != amd_nb_num(); i++) {
-		misc = node_to_amd_nb(i)->misc;
-
-		if (pci_domain_nr(misc->bus) == pci_domain_nr(pdev->bus) &&
-		    PCI_SLOT(misc->devfn) == PCI_SLOT(pdev->devfn))
-			return i;
-	}
-
-	WARN(1, "Unable to find AMD Northbridge id for %s\n", pci_name(pdev));
-	return 0;
-}
-
 static inline bool amd_gart_present(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7dc19c5..cefa8cd 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -150,6 +150,11 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 			  F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
+static u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
+{
+	return PCI_SLOT(pdev->devfn) - AMD_NODE0_PCI_SLOT;
+}
+
 static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
 	if (amd_smn_read(amd_pci_dev_to_node_id(pdev),

