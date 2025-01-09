Return-Path: <linux-tip-commits+bounces-3179-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1CA0712E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA03A7EB5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F56215F47;
	Thu,  9 Jan 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7mDoSVK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O5i1r5B6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F7215769;
	Thu,  9 Jan 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414145; cv=none; b=CWn0gm8iRMtJ9n9/9nkmQc7Cd5eUpR5qV9uAnqzs3cpJvCmFzTQmsJFKbv/E6mXGm6+XVRyfCyLLIkgU68PHzbVUhB6oxejhauCEndJOOvB3BQH20hxJzjc8Omp5dfOcv6ynAdJbiIYNOMuLKV9JeNLv2xXVemUvxZVrzcXljSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414145; c=relaxed/simple;
	bh=gSkwaWlxSs7atyY34PNanF0Xd7yhXD1iKJh4rjtHzUE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LXSUptN59avcgCvY0A+JrLxmkHTe7T9M4tPbxQbfhNapCq/E+TujcrwoftR1vJ4OSNNpYJkqDk8nQd/lDoVtPrVV+Drz+zqawk1Eqau9yTKxoiqO0rEDD4N1P2Be+jLyGZ2a4btU1yN7E0DbVaqhh5APa9Jzc6ZG2G0/cUsdLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7mDoSVK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O5i1r5B6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gujQ0VH0fg/JkzhhEa/73WixlVhYOWK9ISFdEuGHoxg=;
	b=V7mDoSVKgLYDNi+sycEeAaK0Rbd03BpNqgqljZusHR3ZogYu/e40CfJ/eyT/T2vBNMIzI0
	DQzA7MqZBYjxywxocka3rIzkkdv9hy7za4zQqsnZwId/36fhu/mpN3kz+uKLK2IYfZfpuv
	Bh2Dj9GB9cmSIRMtY1VST8g2aeej9d+eUCWS7hnlPVGAEK6HB57Pe161B8EmE0GM9bFYR/
	Yyed9EhNTrnCOoeAi5/GI+2KyukSyOGWhf3odPoYgMIUpdt4Kju2Yqp/t/GwttkGU/xPm8
	Ai+CdY91RBWKue286FHsr3IIICxDfhZFOX+uS3j9tRjOu8d/7TiicfpSj0Ad2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gujQ0VH0fg/JkzhhEa/73WixlVhYOWK9ISFdEuGHoxg=;
	b=O5i1r5B6uOnwFyQKK7PtrEF2X0dEx25bjvsU1jIye1z8Vp7/hWao/SSWzNQiH6zqQGGeCC
	v03p7JC3CqUBXiAA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb: Use topology info to get AMD node count
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250107222847.3300430-7-yazen.ghannam@amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641414140.399.13680893516715861605.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     bc7b2e629e0c9251ba96d864a30d34d1497b1b1b
Gitweb:        https://git.kernel.org/tip/bc7b2e629e0c9251ba96d864a30d34d1497b1b1b
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 07 Jan 2025 22:28:41 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:49:20 +01:00

x86/amd_nb: Use topology info to get AMD node count

Currently, the total AMD node count is determined by searching and counting
CPU/node devices using PCI IDs.

However, AMD node information is already available through topology
CPUID/MSRs. The recent topology rework has made this info easier to access.

Replace the node counting code with a simple product of topology info.

Every node/northbridge is expected to have a 'misc' device. Clear everything
out if a 'misc' device isn't found on a node.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250107222847.3300430-7-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_node.h |  5 +++++
 arch/x86/kernel/amd_nb.c        | 22 +++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 3f097dd..419a0ad 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -25,4 +25,9 @@
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
 struct pci_dev *amd_node_get_root(u16 node);
 
+static inline u16 amd_num_nodes(void)
+{
+	return topology_amd_nodes_per_pkg() * topology_max_packages();
+}
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6218a04..6371fe9 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -186,7 +186,6 @@ static int amd_cache_northbridges(void)
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	struct pci_dev *misc;
 	struct amd_northbridge *nb;
-	u16 misc_count = 0;
 	u16 i;
 
 	if (amd_northbridges.num)
@@ -196,25 +195,30 @@ static int amd_cache_northbridges(void)
 		misc_ids = hygon_nb_misc_ids;
 	}
 
-	misc = NULL;
-	while ((misc = next_northbridge(misc, misc_ids)))
-		misc_count++;
-
-	if (!misc_count)
-		return -ENODEV;
+	amd_northbridges.num = amd_num_nodes();
 
-	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
+	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
 
 	amd_northbridges.nb = nb;
-	amd_northbridges.num = misc_count;
 
 	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
+
+		/*
+		 * Each Northbridge must have a 'misc' device.
+		 * If not, then uninitialize everything.
+		 */
+		if (!node_to_amd_nb(i)->misc) {
+			amd_northbridges.num = 0;
+			kfree(nb);
+			return -ENODEV;
+		}
+
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 	}
 

