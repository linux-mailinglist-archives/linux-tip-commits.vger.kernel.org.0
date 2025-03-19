Return-Path: <linux-tip-commits+bounces-4368-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CEAA68ADC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BD0173A66
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425425D544;
	Wed, 19 Mar 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a8ma1AyI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3u08Np7K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507625CC9D;
	Wed, 19 Mar 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382237; cv=none; b=FRkuejQRV70tLpxC+qmaekA/8v9aWgEBR/we+Hd1Y5LxiuKp9luGNrs+xoAt7e5FgL9xuYgur1TZ7LdMNB1Ql+eSYaKnBl9zFR5TQ8HxHJopgiV1VCn4nx0Zys4s5mXLenA6DxnHi2yw0bKhv4CZz1itGdIOB+o4pyHhpEB9Pig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382237; c=relaxed/simple;
	bh=u8iDaWqBrSzrHPpCy+67WvIZ5gCuw+XbGeoyEol+JfM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H0ScXareYRAWRxrRqHpyGleKGKyr4UuDTDAftmHt0bLVyM7hYJiTxdg3R2geYdS4K3SSUd1ihuXpZc0K8Inww1l3/Afr3zHN8Vr2iqOFxWV4oDEkRr5WDUIm/G1rJdFpshB3I3PMkmykI+raMagw99PlIWBjVMY9okfbFy8qPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a8ma1AyI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3u08Np7K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=040beFsXr1i2X/Lou6+0mibXGxylvoFUEk4HfwvCUNo=;
	b=a8ma1AyIPqaT4YIrIqx/ruAXs3LJRxlJr6QvRxJuhAKqURbPT9EEib14SAe0Fz+vva9xHr
	qFajl7ltJ5VxB/D7C9mvB5mJmEWRrsp7wy5PgFAnVLamfDBjRXoUGq/itMBRtteeFwfpHo
	eyXbDX92YR6Ct3GcSBomCtLuciiJO0tMGTTrhNJSrqHG8Bow0PziKAz5XSqbsv6DGAijKY
	IFlYO4wriyClieFwMGuDc5Gm8m1E4PFaKowOIZOYfs/H2wdNv4bqs3hmWA6D6twiDJeD75
	65Cha+xke3RYszT8wyOcz0yRFTVFYkY5szHeznT+i/fKFu7pDL239PTgHHxOhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=040beFsXr1i2X/Lou6+0mibXGxylvoFUEk4HfwvCUNo=;
	b=3u08Np7KW8GNcpzTKMFoKoghV4S2ypAFL8DWFmu93q/fRdOgXP7MaftrRiruZBW2pG+m5w
	wKbQT3Xm0JtfDyDw==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/amd_node: Add SMN offsets to exclusive region access
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250130-wip-x86-amd-nb-cleanup-v4-2-b5cc997e471b@amd.com>
References: <20250130-wip-x86-amd-nb-cleanup-v4-2-b5cc997e471b@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223258.14745.18098609826988797661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     83518453074d1f3eadbf7e61652b608a60087317
Gitweb:        https://git.kernel.org/tip/83518453074d1f3eadbf7e61652b608a60087317
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Thu, 30 Jan 2025 19:48:56 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:18:23 +01:00

x86/amd_node: Add SMN offsets to exclusive region access

Offsets 0x60 and 0x64 are used internally by kernel drivers that call
the amd_smn_read() and amd_smn_write() functions. If userspace accesses
the regions at the same time as the kernel it may cause malfunctions in
drivers using the offsets.

Add these offsets to the exclusions so that the kernel is tainted if a
non locked down userspace tries to access them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250130-wip-x86-amd-nb-cleanup-v4-2-b5cc997e471b@amd.com
---
 arch/x86/kernel/amd_node.c | 41 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 65045f2..ac57194 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -93,6 +93,7 @@ static struct pci_dev **amd_roots;
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
+static bool smn_exclusive;
 
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
@@ -149,6 +150,9 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	if (!root)
 		return err;
 
+	if (!smn_exclusive)
+		return err;
+
 	guard(mutex)(&smn_mutex);
 
 	err = pci_write_config_dword(root, i_off, address);
@@ -202,6 +206,39 @@ static int amd_cache_roots(void)
 	return 0;
 }
 
+static int reserve_root_config_spaces(void)
+{
+	struct pci_dev *root = NULL;
+	struct pci_bus *bus = NULL;
+
+	while ((bus = pci_find_next_bus(bus))) {
+		/* Root device is Device 0 Function 0 on each Primary Bus. */
+		root = pci_get_slot(bus, 0);
+		if (!root)
+			continue;
+
+		if (root->vendor != PCI_VENDOR_ID_AMD &&
+		    root->vendor != PCI_VENDOR_ID_HYGON)
+			continue;
+
+		pci_dbg(root, "Reserving PCI config space\n");
+
+		/*
+		 * There are a few SMN index/data pairs and other registers
+		 * that shouldn't be accessed by user space.
+		 * So reserve the entire PCI config space for simplicity rather
+		 * than covering specific registers piecemeal.
+		 */
+		if (!pci_request_config_region_exclusive(root, 0, PCI_CFG_SPACE_SIZE, NULL)) {
+			pci_err(root, "Failed to reserve config space\n");
+			return -EEXIST;
+		}
+	}
+
+	smn_exclusive = true;
+	return 0;
+}
+
 static int __init amd_smn_init(void)
 {
 	int err;
@@ -218,6 +255,10 @@ static int __init amd_smn_init(void)
 	if (err)
 		return err;
 
+	err = reserve_root_config_spaces();
+	if (err)
+		return err;
+
 	return 0;
 }
 

