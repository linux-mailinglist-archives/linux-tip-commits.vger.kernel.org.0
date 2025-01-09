Return-Path: <linux-tip-commits+bounces-3174-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F583A07124
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB626188A872
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C739215170;
	Thu,  9 Jan 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iPv/rmYF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7av7hhZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D2214802;
	Thu,  9 Jan 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414141; cv=none; b=hXUoERERauSy2P4M3LjKlEm+yRVxjIIhIX65ZYcULsoJkXGj31VKv1tH1eSeJyqpRLJSrBesBJRZWaMdlrpLLvQuV+FVJ9RLJPOSr6j9fM4oBhVJHdh+yhHko/mRaQIVmGuUj1v7OOiW1cJqyuLs9HBY4S0sHZg+PHOQPbfog3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414141; c=relaxed/simple;
	bh=akTiprM+0S8ZODOA0ndiBp+JN2NQxbka0Rycx6iTZz0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bk21RXVDbu4sfCe7DXJhAxcECLRuk4rlCsL6xS3EHVkuHGehbJ07hjCgXhds3Bfk1Atye1ge7ErI6EaqAkZ9cgftpRno6KlxOwOnsaL3MGmTdeJfkdVq3ntm3HPYRIlfpPvPWa7ZSOVRDFOcwyfWzT4mySr1/gjFiwSRhvtBoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iPv/rmYF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f7av7hhZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQvzedb7ye/+B9TZp9+aWeOnWUhoAx1n6CEBXhnnPeE=;
	b=iPv/rmYF8vqLogWjAN+5DpQ9OTyoo8PqN+GpM+YEVmTDB0Ton0/Fi4k2aMg7EN0gEJdI3s
	Ezz1JVhs1QMaWL2odPIFtI7wmUtQXIQfgCqBnedr3LeqyvssSf8CgbWtQiHN8D6f5YYi4n
	UGhdYz8dvAZao67DotFqm8Zr1hI0S/agzQXQrvz4devFZvw37XDKyQckE5Nr+m2DikH/7y
	baBD84U7LxMGNOJH0pGiY7wam4hXh1bsyP7cMWAelZb3EMHC070XvaJym20WQDBouz2SIn
	9H/BklfLHzxDXJxn6dSgxIt8tD/X8F6YcsjgG8P9CSVnDQq5qoh7q5JvCZ54jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQvzedb7ye/+B9TZp9+aWeOnWUhoAx1n6CEBXhnnPeE=;
	b=f7av7hhZ+2NSp0+rKaOsjjK2hzkXaU2GJ27BXWbXSqb0CiwQLLVxH++dTZnzPwECXCG3Q7
	c9D0HUDM86yK1+CA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_node: Use defines for SMN register offsets
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-14-yazen.ghannam@amd.com>
References: <20241206161210.163701-14-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641413501.399.16131094642462094910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     79821b907f8d7fbc991554fc940075dc1b29a0f4
Gitweb:        https://git.kernel.org/tip/79821b907f8d7fbc991554fc940075dc1b29a0f4
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:12:06 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 11:02:28 +01:00

x86/amd_node: Use defines for SMN register offsets

There are more than one SMN index/data pair available for software use.
The register offsets are different, but the protocol is the same.

Use defines for the SMN offset values and allow the index/data offsets
to be passed to the read/write helper function.

This eases code reuse with other SMN users in the kernel.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-14-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_node.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 45077e2..d2ec7fd 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -94,6 +94,9 @@ static struct pci_dev **amd_roots;
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
+#define SMN_INDEX_OFFSET	0x60
+#define SMN_DATA_OFFSET		0x64
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -131,7 +134,7 @@ static DEFINE_MUTEX(smn_mutex);
  * the operation is considered a success, and the caller does their own
  * checking.
  */
-static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
+static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, bool write)
 {
 	struct pci_dev *root;
 	int err = -ENODEV;
@@ -145,21 +148,21 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 	guard(mutex)(&smn_mutex);
 
-	err = pci_write_config_dword(root, 0x60, address);
+	err = pci_write_config_dword(root, i_off, address);
 	if (err) {
 		pr_warn("Error programming SMN address 0x%x.\n", address);
 		return pcibios_err_to_errno(err);
 	}
 
-	err = (write ? pci_write_config_dword(root, 0x64, *value)
-		     : pci_read_config_dword(root, 0x64, value));
+	err = (write ? pci_write_config_dword(root, d_off, *value)
+		     : pci_read_config_dword(root, d_off, value));
 
 	return pcibios_err_to_errno(err);
 }
 
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	int err = __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address, value, false);
 
 	if (PCI_POSSIBLE_ERROR(*value)) {
 		err = -ENODEV;
@@ -172,7 +175,7 @@ EXPORT_SYMBOL_GPL(amd_smn_read);
 
 int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 {
-	return __amd_smn_rw(node, address, &value, true);
+	return __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address, &value, true);
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 

