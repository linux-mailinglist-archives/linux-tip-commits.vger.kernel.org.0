Return-Path: <linux-tip-commits+bounces-3183-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30209A07136
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBF0188A97A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465B121638F;
	Thu,  9 Jan 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGOBxeJe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nvd+lMeI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B3215F55;
	Thu,  9 Jan 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414147; cv=none; b=VLJDtHsvpXDuA2AK0zmZDtAVQy2GpO1lqSS+5ZpsNG9AIwlNYohAdNdAwWl80vNFp5a1kmfn5O0w/0qhAG0eKPKZhips9Kd7iZbWa6W1tL38yV/ooO/nzhjml+M9BpdQj05jYQpSpCotGS3+RtMoc8+td/O7VNTOENCyoCLoftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414147; c=relaxed/simple;
	bh=e/+sacZCFkCG39s9IXFa/5m+tHptiwllXatX10ooLCs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rKKdgDLRh92MttB8FgohkRpbqIcSsxeKW4R7avnm7IEwDQNISHNEbufLXc71ZtfQ9a5uCCInnmpmTCeyT+jcjRTmcLrYqMclOqXdYwvacVsZQ/FnMtR4y+LVKkjKfCZRRLIsT55JqROQsZofpo0HWjEzArhxgUkTK3/zkFJTCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGOBxeJe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nvd+lMeI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEhzFSjfKm9huY+OCyP30FGfY8EvzWxYgL387e1fO7Y=;
	b=TGOBxeJekV9wXjIFdhgXJpNjnGKY7wm5d48z5PjSFP4ySfOGFr6unzZJtWStl95BjnCrcc
	qhczhRcluXUS4PbtroF9mzRP/9gYnr6NDVbSKvbzLPQcgbovdj875KnOQnc3XZ+mUzoMUW
	3d55W0RSWpZyXXtYmZq5jzEyTRL8AcoY6sLTbm1izx5vUW8RIsWRApR39ZESxlDs/mbn/Q
	ybzdiuPNjFg+85mojQgbGQLD/L96IaCQBBOwRg/XTLQcIULQ7oQSAkGKaoLdXSMb+aqYFg
	k0783iuiFWU9l8FWRmRtS6/MY3lRm7CGFxQIIFkkP78aOejnTKwNOr8ENJDfHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEhzFSjfKm9huY+OCyP30FGfY8EvzWxYgL387e1fO7Y=;
	b=Nvd+lMeIFf5Aq+Kt+qxHNVkR2B7qTtEzlKh16rvO9dZo/vKVvQdQwBQMBiLo/XOzjA2gbH
	FUgOR3uXkMEgymBQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb: Clean up early_is_amd_nb()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-4-yazen.ghannam@amd.com>
References: <20241206161210.163701-4-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641414349.399.5243780810714383252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     e13f51b51814e2527c51998d2dae594ef9cb633a
Gitweb:        https://git.kernel.org/tip/e13f51b51814e2527c51998d2dae594ef9cb633a
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:11:56 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:47:22 +01:00

x86/amd_nb: Clean up early_is_amd_nb()

The check for early_is_amd_nb() is only useful for systems with GART or
the NB_CFG register.

Zen-based systems (both AMD and Hygon) have neither, so return early for
them.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-4-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 37b8244..ee20071 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -385,7 +385,6 @@ static int amd_cache_northbridges(void)
  */
 bool __init early_is_amd_nb(u32 device)
 {
-	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
@@ -393,11 +392,11 @@ bool __init early_is_amd_nb(u32 device)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return false;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		misc_ids = hygon_nb_misc_ids;
+	if (cpu_feature_enabled(X86_FEATURE_ZEN))
+		return false;
 
 	device >>= 16;
-	for (id = misc_ids; id->vendor; id++)
+	for (id = amd_nb_misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
 			return true;
 	return false;

