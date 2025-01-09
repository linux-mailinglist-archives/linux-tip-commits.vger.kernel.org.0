Return-Path: <linux-tip-commits+bounces-3182-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBA1A07132
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2219C16727F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA559215F7A;
	Thu,  9 Jan 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBotxR+C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pDOsUYak"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6C21578B;
	Thu,  9 Jan 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414146; cv=none; b=KmaKH1ZwgLdfJZYUkHxG8lSaTFlnC6TxSxzgS/bSre36/710i9fBhqRpPzHNAb+tO0ip3LVkwsUDd/g8hVQ1qziszHXDlFMCwJ1G7n25ri/9ip2/ZcNeS8O99xCMIOBLu5S8VInB0/gUqV32EUgXlg2+T2HjiLb3BI026L5I0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414146; c=relaxed/simple;
	bh=nG741xrNuMBf4EuzaIWb8Q+RhkXT8PkKPV/3HbTVzFQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bSAoKhR18iO8dlvcCZpTfl5LfEG+yHu47KoJ7yDChs4Qq/zcuZd2RbkK6oLo2dHlFC0tJnM9otx7DunmwwdAYQ0hUaGlwJ8JfImxdl8kz7EKXvDnRRD1iUTr/+6M13aeWPlKq6djRz1afLHzNsRl/nLAE7gDetlC4MrOsqE/6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBotxR+C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pDOsUYak; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62FggQR8X+CqzDYqaxkBSIxzYYsk5knCRZrx998vL24=;
	b=hBotxR+Cd1lFq/RRlbUIT84XOJIa97/aXai8xFI0sNykypjkxwPsM5RZ22KRIReecNvwqc
	OcV7QZfiT3wlZJaLY1FKxP0ch/t/Q3QZJ7XE8qYLROOfcSvdRLMjzvo5hUR/c7yVtaxUFd
	AClBCr4MdIQnIUYMCKArLTzgGvEavvZvo+GbTFKEAng/+NozJmRuf0xXqy7p3GS/D0obWX
	Q/vCiFlG41pe2nnuqctmlaa6G8I7TgAk8qi32nPd41SAF6sqY3jwj6n/PGHXiRgi61/4b1
	xcr8+ZvfyKVgqj9uO1bAsRwVKlvjA7TwKnmZ3GrfEfi6LQnOoDa/+RnT7dCttw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62FggQR8X+CqzDYqaxkBSIxzYYsk5knCRZrx998vL24=;
	b=pDOsUYak90hRCJMal5YQCPAaOS1o/kWySuiN34XcNPACxc7CaAUgZ5iuzi6tiqhQiQVCIO
	nKM1AcpX5yAto4Bg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb: Simplify function 4 search
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-6-yazen.ghannam@amd.com>
References: <20241206161210.163701-6-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641414241.399.3246889531031987277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     962f1970a32430ce6c75ea23cbc59d68346481fd
Gitweb:        https://git.kernel.org/tip/962f1970a32430ce6c75ea23cbc59d68346481fd
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:11:58 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:47:50 +01:00

x86/amd_nb: Simplify function 4 search

Use the newly added helper function to look up a CPU/Node function to
find "function 4" devices.

Thus, avoid the need to regularly add new PCI IDs for basic discovery.
The unique PCI IDs are still useful in case of quirks or functional
changes. And they should be used only in such a manner.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-6-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_nb.h |  2 +-
 arch/x86/kernel/amd_nb.c      | 66 +---------------------------------
 2 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index d0caac2..b48dc69 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -4,7 +4,7 @@
 
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <linux/refcount.h>
+#include <asm/amd_node.h>
 
 struct amd_nb_bus_dev_range {
 	u8 bus;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index ee20071..7a62c5a 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -30,26 +30,6 @@
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
-#define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4	0x1494
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4	0x144c
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4	0x1444
-#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4	0x1728
-#define PCI_DEVICE_ID_AMD_19H_DF_F4		0x1654
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4	0x14b1
-#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4	0x167d
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4	0x166e
-#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
-#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
-#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
-#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
-#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4	0x16fc
-#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4	0x124c
-#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4	0x12bc
-#define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
-#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
-
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -73,8 +53,6 @@ static const struct pci_device_id amd_root_ids[] = {
 	{}
 };
 
-#define PCI_DEVICE_ID_AMD_CNB17H_F4     0x1704
-
 static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
@@ -107,35 +85,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id amd_nb_link_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
-	{}
-};
-
 static const struct pci_device_id hygon_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{}
@@ -146,11 +95,6 @@ static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id hygon_nb_link_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F4) },
-	{}
-};
-
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -275,13 +219,11 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-
 static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	const struct pci_device_id *link_ids = amd_nb_link_ids;
 	const struct pci_device_id *root_ids = amd_root_ids;
-	struct pci_dev *root, *misc, *link;
+	struct pci_dev *root, *misc;
 	struct amd_northbridge *nb;
 	u16 roots_per_misc = 0;
 	u16 misc_count = 0;
@@ -294,7 +236,6 @@ static int amd_cache_northbridges(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		root_ids = hygon_root_ids;
 		misc_ids = hygon_nb_misc_ids;
-		link_ids = hygon_nb_link_ids;
 	}
 
 	misc = NULL;
@@ -328,14 +269,13 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 	amd_northbridges.num = misc_count;
 
-	link = misc = root = NULL;
+	misc = root = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
-		node_to_amd_nb(i)->link = link =
-			next_northbridge(link, link_ids);
+		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 
 		/*
 		 * If there are more PCI root devices than data fabric/

