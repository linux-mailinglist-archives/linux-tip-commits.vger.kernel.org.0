Return-Path: <linux-tip-commits+bounces-1749-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B1093EE0D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839251C2181C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 07:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57F12D773;
	Mon, 29 Jul 2024 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NwYabrEP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bg2qfh2h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499685628;
	Mon, 29 Jul 2024 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236896; cv=none; b=RLzdeZzD/4DbSmBe3bWz1fasZdTsibDx7S+zS5b++eg3Nj3e4NPShWYjo/AZ4kjNQcBoD5XoeGe6HasgjT1UQWh12QB6Wr3xMYs/P3eQXtkL/Y5i1+/pspJAD/G+FcG0Tlu4gLByxpBwkq+isuYRFQsA6fA9zzJjPLQr39rH6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236896; c=relaxed/simple;
	bh=NIBJ8PBVyMLpYO9gGUc3TQsJ8Zu+KXqntyGDIKDDGYY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZhHI2e9nH4VqmlsenT0EmO0XNrugH1Q28PuS5dq1DznSlbjzpNwHueRN66VejBYpry3lJRUpN7Du53DQF+8w8+ZZKYLulOzwzPFEJ9atnXkL7VAoZ9fDNzL9K+p09RTAYM2hQJACKLDnsjOKV4Cql/c/4Lcfw3muJBDzpRs1UxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NwYabrEP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bg2qfh2h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 07:08:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722236892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WAkfkQNKRcEiAnVN0Dag5MeNrZa9WG9cwMoDC0BQc=;
	b=NwYabrEPg+6Dhb4tBAuAsTGRADvfjREcCFSxo1+XEH8HraW10oNAmvgb1vvjitl76TZ95W
	JZnLDnQQ8rTWtiErCHtZJpOpQ1pu1kssPNJWR18lOZ/xDQq/UoSp7lu2eQdDJk9GCNuFF8
	wspmud0+83/thkLa5JGBOAV54PcE9ZVXhLrmjluaCsxsVTpfn9hWZgQJXRaJ7hQc+fd1f/
	fj4n0M0scWgeREcomPw8TNUQklQ35uYNP8iNdN3iJpYZgQHlWmpqlv8BgM0dOvmgmrwQvK
	MBNdAV9eOAx1RweV7KJX2zBE9kQNbcL/I3kTadC2ejZliWrDR/yNVEcoPj+Evw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722236892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WAkfkQNKRcEiAnVN0Dag5MeNrZa9WG9cwMoDC0BQc=;
	b=bg2qfh2hHwWMTAMb8f6nuHS8L2hhE5KtkesYivicNwgfKPVFxpeXz7hwdrBO6nkWaRUa59
	zS/DhxwqrmxYKFBA==
From: "tip-bot2 for Shyam Sundar S K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240722092801.3480266-1-Shyam-sundar.S-k@amd.com>
References: <20240722092801.3480266-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172223689196.2215.5686884363030580616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     59c34008d3bdeef4c8ebc0ed2426109b474334d4
Gitweb:        https://git.kernel.org/tip/59c34008d3bdeef4c8ebc0ed2426109b474334d4
Author:        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
AuthorDate:    Mon, 22 Jul 2024 14:58:01 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jul 2024 08:53:49 +02:00

x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h

Add new PCI device IDs into the root IDs and miscellaneous IDs lists to
provide support for the latest generation of AMD 1Ah family 60h processor
models.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20240722092801.3480266-1-Shyam-sundar.S-k@amd.com
---
 arch/x86/kernel/amd_nb.c | 3 +++
 drivers/hwmon/k10temp.c  | 1 +
 include/linux/pci_ids.h  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 059e5c1..61eadde 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -26,6 +26,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
 #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
 #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
+#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
@@ -63,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
 	{}
@@ -95,6 +97,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 543526b..f96b91e 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -548,6 +548,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e388c8b..91182aa 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -580,6 +580,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
+#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b

