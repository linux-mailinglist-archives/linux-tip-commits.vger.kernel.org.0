Return-Path: <linux-tip-commits+bounces-3176-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01051A07126
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F1B167217
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F18D2153C7;
	Thu,  9 Jan 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pu6fzVK/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SjhqRw1p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEADDDC;
	Thu,  9 Jan 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414142; cv=none; b=Vg2UgYh13i/hi2QfnH7lGm4N4zYJC82u5DafxM4yNLwDZsbESTmllUd4EW+o5s62G+Ek7hL5RMDepj+PaxuRu7IoiDG39ql53FHFe8+S1PCDU4iEE+O48siruecyQPb1uYB2pxrZhswG5uh2dzo3jrKkgK5kRBxLxT2yYBLRNJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414142; c=relaxed/simple;
	bh=W2l65P6j3W66c1t9B6nRg4c6dRmTGz+IulnogJFIacE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FCi3Ai5xhhTPjUI12ggNXSc7GUeIyRu158cYCo0sAyRtD9rskC//YJY94YiqaKgayKhrTkKE3y5DhD2Vl/wD8xZWFHYWCm/+ZOtXP4wg3ZE4MHlvOFgIcP0EHhoJP4uJCVJjEq0SU2EUzWl3xjHHNdH18+faKsniVXUgL2Bx4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pu6fzVK/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SjhqRw1p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZrQkXL7jSmfvllp3z3CiSbWGCBJlP8vxrdqSRZXHyc=;
	b=Pu6fzVK/vCAWROqyuDcyqa1F7cC17AsDcfdQpuRFfjMg9EGYhnq+t9v99XC8NBOXIBjq64
	us2OUkbdN1aawIogEzn97KyMKcUp1XM0MyNRbgPmDQBpmLo7bdN3o5uiIaGhaCwanhdQHR
	HNrQKgTlSZMeT9/D4gjkNG6TDYyoPicAn+g8tpAnVVv/487H9clgx9b9YPeZ3bSPSUC0an
	Cano8eBQQhTdril7qvgKewuNs5SYpDn7SqLTiP5XawV1ca0wLc+vmgsdGHGkGZMWE8MmRT
	JLxDjsZd4+kCLl+AZIVMG0kIW4w19e+5wwLooKIF3/wjU3+9Q0Y/WOrs/eYiwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZrQkXL7jSmfvllp3z3CiSbWGCBJlP8vxrdqSRZXHyc=;
	b=SjhqRw1psIJexY6AzmMRMXCTUERm40cY29EO74vXnRkpeguyhsmdmARXIIc8xkcR93a1FA
	1msmsGEOK0UygNDg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_node: Update __amd_smn_rw() error paths
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-12-yazen.ghannam@amd.com>
References: <20241206161210.163701-12-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641413843.399.17195681483089891991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     35df797665cb69e68a3a99e499e75e73efbd4f77
Gitweb:        https://git.kernel.org/tip/35df797665cb69e68a3a99e499e75e73efbd4f77
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:12:04 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 11:01:46 +01:00

x86/amd_node: Update __amd_smn_rw() error paths

Use guard(mutex) and convert PCI error codes to common ones.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-12-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_node.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 95e5ca0..0cca541 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -136,28 +136,24 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	int err = -ENODEV;
 
 	if (node >= amd_nb_num())
-		goto out;
+		return err;
 
 	root = node_to_amd_nb(node)->root;
 	if (!root)
-		goto out;
+		return err;
 
-	mutex_lock(&smn_mutex);
+	guard(mutex)(&smn_mutex);
 
 	err = pci_write_config_dword(root, 0x60, address);
 	if (err) {
 		pr_warn("Error programming SMN address 0x%x.\n", address);
-		goto out_unlock;
+		return pcibios_err_to_errno(err);
 	}
 
 	err = (write ? pci_write_config_dword(root, 0x64, *value)
 		     : pci_read_config_dword(root, 0x64, value));
 
-out_unlock:
-	mutex_unlock(&smn_mutex);
-
-out:
-	return err;
+	return pcibios_err_to_errno(err);
 }
 
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value)

