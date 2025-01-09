Return-Path: <linux-tip-commits+bounces-3175-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D72A07129
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C237A1EB7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5C2153C0;
	Thu,  9 Jan 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jfiqMBEb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hJ1Ar68"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3170C215070;
	Thu,  9 Jan 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414142; cv=none; b=i4z0KZ7oEUioo8Iwbebj+VDGg9U0vD7SbaRZvOOW5hzmXKR7mxjitrThWis15NugARAOovdfrEcmKu4C1jNd+G7yFXS1yxvkcJZkXKg093vfwEv0fqOSbZav26vQfA6y466koRuUCRwNQcWFQItmOa7kcpbKhFwVvR+4Vx/m6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414142; c=relaxed/simple;
	bh=6bNf6VNzU+3owsc+ieb8ORRW0fesVpUzrj4cotzSi2c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jW8sURL4HBDHxFtDT39NFJ4LmDKpMB+TVkySa/5FEPJ1tUR4yT4Kic4DNumrUyO+M3sxP9qg8PgfrlWSoEZDU1MVGJWURg/DDPrNqCCwnYnhlrt6myW3kjSkg2qMKkeudty5dO5DG3VOZA0oini667sJc0AhMhGjH5bDDbRmgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jfiqMBEb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hJ1Ar68; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ebtJl2lMe/n7avyIg4b5M6eThvp0D8KWW/+ESnoMo8=;
	b=jfiqMBEbzqw3kNikt4hCqCMCcCzyNag6BdtwP9GMeCJViRIfMBKV5PPnO3TSvypNbg19Qb
	SFBdGrWA1l7qrkdcmEdTPCqxkS1OthVFOEnRSwJ+k4GGP+9+JVOfcNSk0GfrmmB0ptNltD
	a3u00xHwsX0aljC+DllGg7kHRXyge7EatdviNecSl/1bTPx2xUOeUyanBzRmd7eeRChmPk
	FXuPLlWwO7sEuxeeZBUYqBhR5n8WFRnuEwa/9N0TnF3IPCN0/wlL/MJZ3wqpvrzy57tim8
	tenroU9wfAYSwbD95YvckknA3oEbZg9u4D3aFgepvM+zf75+nLoDEyZixM5f6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ebtJl2lMe/n7avyIg4b5M6eThvp0D8KWW/+ESnoMo8=;
	b=4hJ1Ar683i+Hv9muvqA4y5NK8J57gRUxGGugY6Zf+sieNIGisn2Qp0cohjimy3khGhdFwX
	YCNSESeunVYct3Bw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_node: Remove dependency on AMD_NB
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-13-yazen.ghannam@amd.com>
References: <20241206161210.163701-13-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641413787.399.112041454745027405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     77466b798d59d6761501ff36094cf430d3876549
Gitweb:        https://git.kernel.org/tip/77466b798d59d6761501ff36094cf430d3876549
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:12:05 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 11:02:22 +01:00

x86/amd_node: Remove dependency on AMD_NB

Cache the root devices locally so that there are no more dependencies on
AMD_NB.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-13-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_node.c | 42 ++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0cca541..45077e2 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -8,7 +8,6 @@
  * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
  */
 
-#include <asm/amd_nb.h>
 #include <asm/amd_node.h>
 
 /*
@@ -90,6 +89,8 @@ struct pci_dev *amd_node_get_root(u16 node)
 	return root;
 }
 
+static struct pci_dev **amd_roots;
+
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -135,10 +136,10 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	struct pci_dev *root;
 	int err = -ENODEV;
 
-	if (node >= amd_nb_num())
+	if (node >= amd_num_nodes())
 		return err;
 
-	root = node_to_amd_nb(node)->root;
+	root = amd_roots[node];
 	if (!root)
 		return err;
 
@@ -174,3 +175,38 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 	return __amd_smn_rw(node, address, &value, true);
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
+
+static int amd_cache_roots(void)
+{
+	u16 node, num_nodes = amd_num_nodes();
+
+	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
+	if (!amd_roots)
+		return -ENOMEM;
+
+	for (node = 0; node < num_nodes; node++)
+		amd_roots[node] = amd_node_get_root(node);
+
+	return 0;
+}
+
+static int __init amd_smn_init(void)
+{
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return 0;
+
+	guard(mutex)(&smn_mutex);
+
+	if (amd_roots)
+		return 0;
+
+	err = amd_cache_roots();
+	if (err)
+		return err;
+
+	return 0;
+}
+
+fs_initcall(amd_smn_init);

