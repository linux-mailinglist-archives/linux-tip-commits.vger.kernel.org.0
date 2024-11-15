Return-Path: <linux-tip-commits+bounces-2865-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BEF9CDD7E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2024 12:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5546C1F22F8E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2024 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763DB1B85D0;
	Fri, 15 Nov 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dcvoi7z8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CuIjcvkj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC41B6D0D;
	Fri, 15 Nov 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670148; cv=none; b=XcxPkUW66qaSSm2wB1V/CEFBFx9tip5taAQuq0SRDVc4n6u0OWFHuhZsJmYcx98OJtO6z0sD6G7+Lx1ZD78wquBdWmityR/tSLjp3lcNVp/RgK2npHFwijUEAVL3X9Cf8lRU/54Dp+UIZdzRbdHhQEI4eOYe1c1CCyW2Tzl/bMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670148; c=relaxed/simple;
	bh=c2lEQEki+tDmtnYfANAbi45ySVVYYM9PD/PO2VAS9lo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oUSYOGDuXNu6Tm0jww0O31c8oleAXkeH+j1SPbBDd0YOVgQ7ZPAUGlXGlnjDm+KII8rRDM8nJIn+HTg/KJWruXl6mXtRmek/HaJmeqRlFmtf+k6FeV/u2JD6RzrCx2Km19v+EQhpdzXZwXoKEfG0U3OkaSd7iyr8HXuQfi2OzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dcvoi7z8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CuIjcvkj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Nov 2024 11:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731670139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayJsQXR7D2BVc4mirQFvrt8/W9WwDGO5lHH9o0gZYXM=;
	b=Dcvoi7z82F2fD0S+DrA9eVHumfB2tuDzD+6T9rQPsNMakl1E00y+jQP1UHuCWylG2ynqdq
	fYtm+woh1KfkYWPNg0PWkOiVM7DzrH2Od9ZlCcOZjs+LqTwV0LmjAX0FCKtBRBYjsyevR/
	NpaBvBcN/GyjTl9osnA+W8wr7SbBavWH+X39rGECFDCyBHN+E9CVPJAbH2jPaY3qD1j5py
	P+5JaZg/ri8xaLG2Ye7feTDQ1qLAeI4oZAgq/rlz1qlPHIV9h7wu5d/KsV9nosW8WfP4WH
	dO2/RQ5t2/JgYxU3pY1QBXQJm1hFtZraTZTrwxj1zGd+BdVnVnZ5aDNVQOQxIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731670139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayJsQXR7D2BVc4mirQFvrt8/W9WwDGO5lHH9o0gZYXM=;
	b=CuIjcvkjLFjMQftaCtjjhnW07LufimOPoYkmTYP1QEpM6sYJaVvaNTNql4H74ijtuo0fWl
	p1w9mnk34BG9h0Bw==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/ioremap: Use helper to implement xxx_is_setup_data()
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115012131.509226-3-bhe@redhat.com>
References: <20241115012131.509226-3-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173167013818.412.18310542662964520039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ca9114c1fbb478f69e2e4508b3c126058c5d5521
Gitweb:        https://git.kernel.org/tip/ca9114c1fbb478f69e2e4508b3c126058c5d5521
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Fri, 15 Nov 2024 09:21:30 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2024 12:03:36 +01:00

x86/ioremap: Use helper to implement xxx_is_setup_data()

This simplifies codes a lot by removing the duplicated code handling.

And also remove the similar code comment above of them.

While at it, add __ref to memremap_is_setup_data() to avoid
the section mismatch warning:

  WARNING: modpost: vmlinux: section mismatch in reference: arch_memremap_can_ram_remap.cold+0x6 (section: .text.unlikely) -> __memremap_is_setup_data (section: .init.text)

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241115012131.509226-3-bhe@redhat.com
---
 arch/x86/mm/ioremap.c | 119 +----------------------------------------
 1 file changed, 3 insertions(+), 116 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 5ef6182..5d1b5e4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -709,129 +709,16 @@ static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
 }
 #undef SD_SIZE
 
-/*
- * Examine the physical address to determine if it is boot data by checking
- * it against the boot params setup_data chain.
- */
-static bool memremap_is_setup_data(resource_size_t phys_addr,
+static bool __ref memremap_is_setup_data(resource_size_t phys_addr,
 				   unsigned long size)
 {
-	struct setup_indirect *indirect;
-	struct setup_data *data;
-	u64 paddr, paddr_next;
-
-	paddr = boot_params.hdr.setup_data;
-	while (paddr) {
-		unsigned int len;
-
-		if (phys_addr == paddr)
-			return true;
-
-		data = memremap(paddr, sizeof(*data),
-				MEMREMAP_WB | MEMREMAP_DEC);
-		if (!data) {
-			pr_warn("failed to memremap setup_data entry\n");
-			return false;
-		}
-
-		paddr_next = data->next;
-		len = data->len;
-
-		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
-			memunmap(data);
-			return true;
-		}
-
-		if (data->type == SETUP_INDIRECT) {
-			memunmap(data);
-			data = memremap(paddr, sizeof(*data) + len,
-					MEMREMAP_WB | MEMREMAP_DEC);
-			if (!data) {
-				pr_warn("failed to memremap indirect setup_data\n");
-				return false;
-			}
-
-			indirect = (struct setup_indirect *)data->data;
-
-			if (indirect->type != SETUP_INDIRECT) {
-				paddr = indirect->addr;
-				len = indirect->len;
-			}
-		}
-
-		memunmap(data);
-
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
-			return true;
-
-		paddr = paddr_next;
-	}
-
-	return false;
+	return __memremap_is_setup_data(phys_addr, false);
 }
 
-/*
- * Examine the physical address to determine if it is boot data by checking
- * it against the boot params setup_data chain (early boot version).
- */
 static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 						unsigned long size)
 {
-	struct setup_indirect *indirect;
-	struct setup_data *data;
-	u64 paddr, paddr_next;
-
-	paddr = boot_params.hdr.setup_data;
-	while (paddr) {
-		unsigned int len, size;
-
-		if (phys_addr == paddr)
-			return true;
-
-		data = early_memremap_decrypted(paddr, sizeof(*data));
-		if (!data) {
-			pr_warn("failed to early memremap setup_data entry\n");
-			return false;
-		}
-
-		size = sizeof(*data);
-
-		paddr_next = data->next;
-		len = data->len;
-
-		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
-			early_memunmap(data, sizeof(*data));
-			return true;
-		}
-
-		if (data->type == SETUP_INDIRECT) {
-			size += len;
-			early_memunmap(data, sizeof(*data));
-			data = early_memremap_decrypted(paddr, size);
-			if (!data) {
-				pr_warn("failed to early memremap indirect setup_data\n");
-				return false;
-			}
-
-			indirect = (struct setup_indirect *)data->data;
-
-			if (indirect->type != SETUP_INDIRECT) {
-				paddr = indirect->addr;
-				len = indirect->len;
-			}
-		}
-
-		early_memunmap(data, size);
-
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
-			return true;
-
-		paddr = paddr_next;
-	}
-
-	return false;
+	return __memremap_is_setup_data(phys_addr, true);
 }
 
 /*

