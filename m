Return-Path: <linux-tip-commits+bounces-3519-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2FA39DEB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 14:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FEC3B6CDC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040AF264A91;
	Tue, 18 Feb 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4cmqIPcX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0G5iqVI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C913AA5D;
	Tue, 18 Feb 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885975; cv=none; b=TR6V8I8p0tPBYhSb4pWsp2ZtbS/TaXnY9S6EnDmM1TEXjP2IR6l4NTe61E9cpW5OvPIFz2DRd1LhxZyG/wybp8UYHFEjPfvsiwWoeUwkWQhWy12Kc3RAgChk1er21Khbr9FOGwIy6Hn05+Jw8NlCvHV1R2UTSPxqBCmuygKtAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885975; c=relaxed/simple;
	bh=P+wp9Z0Kq49qbyhLBtGAoQKmA+JudhtJS06AH2wJoD4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OhPkE/0kbQVYWqw00H0WqIg6lLwQbuX/Ix3RNb5LPo/Atd+ZjIi6NQ5Tqx43q9nvzqN+WzmerEaUskx0Lg7Aw2CJsn7T2lA9lAgBNEigapmOBgZHj0VE9e6lZDyoif2ROj+YgUC5kmXW0mmIXx92eoH2ToRTNMJnafgJpU7kXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4cmqIPcX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0G5iqVI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 13:39:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739885966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMzBF0jtVAA1oW0J2YNqmVVNzPDBIy2RLgOUNYMK1Ho=;
	b=4cmqIPcXH73XyQjHCzxaVWSlI+YgvitUVuzBO0AtYBlnZaOr0/fMfk7mVHqLSAPEKVhO3x
	boIktjcr0Jq2X5hiLJPQB1mpvbA4rdEaVDIWavTyvGg3v5WBlmsKOO9AlLJjUq2wnH384y
	X4NEco+GhDPvHeOBOdXEkSY6UoZBM8CBrEHL58GoapKoc8f1GDpMVJUJXXFnBAp9XpKSMw
	pfimhQy+2UaYViiEeuIrGTflroIkn7y/6etfnAxQ6zpsYwjMNdZb01wPR8/MCG9wSi3kv+
	UaIZL+JijQLc4MiXsMyWBsFox2gA/j93Tf3MO5R7t0KaS0Siv8eV3bg9qj2iZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739885966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMzBF0jtVAA1oW0J2YNqmVVNzPDBIy2RLgOUNYMK1Ho=;
	b=D0G5iqVIA4t+Z1pg3lMCaQO1nM7RDfcQiZRI0Kj4Huk1TdGXD4Bb77OUzKdd36A1wXtCwz
	Nsitj54k2KqPYkAg==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/amd_node: Add SMN offsets to exclusive region access
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250130-wip-x86-amd-nb-cleanup-v4-2-b5cc997e471b@amd.com>
References: <20250130-wip-x86-amd-nb-cleanup-v4-2-b5cc997e471b@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988596611.10177.6639076594105931502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     bebe0afb74514ae51f4f348b28326c658b02209d
Gitweb:        https://git.kernel.org/tip/bebe0afb74514ae51f4f348b28326c658b02209d
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Thu, 30 Jan 2025 19:48:56 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Feb 2025 10:06:10 +01:00

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
 

