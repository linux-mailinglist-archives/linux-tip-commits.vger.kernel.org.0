Return-Path: <linux-tip-commits+bounces-3018-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA699E848B
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Dec 2024 11:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0881884A97
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Dec 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B7213D897;
	Sun,  8 Dec 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN4YNrOP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNF/zbDZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20713775E;
	Sun,  8 Dec 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733654398; cv=none; b=OXnmLchqjND84+IGNb1QoIEyyceaPubnIUx8y+3Mn/z4pZ/3zvl7FNGWZJZtRhqIeHgKhZVHo32qyI815LjimAHsJJiwoc/RUnuxxlaKqgncsEElKUb0oeGb47tPHc8iTcKaA1pE+X6mVQ8vRGOz+H6tNotuWpGZEoVqi10p3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733654398; c=relaxed/simple;
	bh=qXgVo4IdJBgGJGCdRtap0Cad6hdqqb1GpggbVpzjccA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uo5/vJ1EZDXFI9IgK7O2kGqwODZ3yA/fuBva5iyW0UInHUcl5Bh9drLQgqUYqq9xZyNGhKhTJRn/b4AGp6wVls37NGvUCuBj0mmBkj0ss3RX3PWKd9c4nW+x0arb5ixUl54SEl8vCgg2ABq2nwy5zAcGaGsvsD1bCrJX9C3GSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN4YNrOP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wNF/zbDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Dec 2024 10:39:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733654394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8R/oSGSSJekDATy864IKJ47uSCw+avVyC3RfNaLLSvU=;
	b=LN4YNrOPU2FQ7A5Y8uaYMHwp6+zTorPRAKEfDT7SCYKupk0weNPE/k4iabG8ggP+OOZV2i
	dJxGYkNiDqSR8R9tWh5V2qCkAEwDv7gu4bWgRgvuIaliHHBqinUTlS2V3tdOJvve1RllLR
	Q46UB04Zbmcywotdn1SqlcQC8L1wm+OsiO6UGEVmIkUwQKz37kR6+xsMgtUvaQsfIFtASm
	T/dusxP1ERmPqxPLl7SIsPRI0SpHruGOg4fLrIsDLZF4c9CbXrWf52gd44KzoLQZeiJ2WX
	fdwgydqUJ4B9nonrNpqpKgSfxB5HcSfKpGMQy6M/ZUmG2tj0g6fhjtS1DtEWfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733654394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8R/oSGSSJekDATy864IKJ47uSCw+avVyC3RfNaLLSvU=;
	b=wNF/zbDZA89d/+3qr5Om4JpB0hdkYKPEbOFNrqzl20/q6/XANbWsRet4weqLNKwdB0VIgw
	vmvDNz4XMgfghgAA==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/ioremap: Simplify setup_data mapping variants
Cc: Baoquan He <bhe@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241123114221.149383-2-bhe@redhat.com>
References: <20241123114221.149383-2-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173365439295.412.3471804594271433202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     095ac6fa19500fecd7c62e755dee45bb303d4d43
Gitweb:        https://git.kernel.org/tip/095ac6fa19500fecd7c62e755dee45bb303d4d43
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Sat, 23 Nov 2024 19:42:19 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 07 Dec 2024 17:23:15 +01:00

x86/ioremap: Simplify setup_data mapping variants

memremap_is_setup_data() and early_memremap_is_setup_data() share
completely the same process and handling, except for the differing
memremap/unmap invocations.

Add a helper __memremap_is_setup_data() extracting the common part and
simplify a lot of code while at it.

Mark __memremap_is_setup_data() as __ref to suppress this section
mismatch warning:

  WARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x5f (section: .text) ->
  early_memunmap (section: .init.text)

  [ bp: Massage a bit. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241123114221.149383-2-bhe@redhat.com
---
 arch/x86/mm/ioremap.c | 106 +++++++++++++----------------------------
 1 file changed, 35 insertions(+), 71 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 8d29163..fe44e81 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -632,42 +632,54 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
  * Examine the physical address to determine if it is boot data by checking
  * it against the boot params setup_data chain.
  */
-static bool memremap_is_setup_data(resource_size_t phys_addr,
-				   unsigned long size)
+static bool __ref __memremap_is_setup_data(resource_size_t phys_addr, bool early)
 {
+	unsigned int setup_data_sz = sizeof(struct setup_data);
 	struct setup_indirect *indirect;
 	struct setup_data *data;
 	u64 paddr, paddr_next;
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len;
+		unsigned int len, size;
 
 		if (phys_addr == paddr)
 			return true;
 
-		data = memremap(paddr, sizeof(*data),
-				MEMREMAP_WB | MEMREMAP_DEC);
+		if (early)
+			data = early_memremap_decrypted(paddr, setup_data_sz);
+		else
+			data = memremap(paddr, setup_data_sz, MEMREMAP_WB | MEMREMAP_DEC);
 		if (!data) {
-			pr_warn("failed to memremap setup_data entry\n");
+			pr_warn("failed to remap setup_data entry\n");
 			return false;
 		}
 
+		size = setup_data_sz;
+
 		paddr_next = data->next;
 		len = data->len;
 
 		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
-			memunmap(data);
+		    (phys_addr < (paddr + setup_data_sz + len))) {
+			if (early)
+				early_memunmap(data, setup_data_sz);
+			else
+				memunmap(data);
 			return true;
 		}
 
 		if (data->type == SETUP_INDIRECT) {
-			memunmap(data);
-			data = memremap(paddr, sizeof(*data) + len,
-					MEMREMAP_WB | MEMREMAP_DEC);
+			size += len;
+			if (early) {
+				early_memunmap(data, setup_data_sz);
+				data = early_memremap_decrypted(paddr, size);
+			} else {
+				memunmap(data);
+				data = memremap(paddr, size, MEMREMAP_WB | MEMREMAP_DEC);
+			}
 			if (!data) {
-				pr_warn("failed to memremap indirect setup_data\n");
+				pr_warn("failed to remap indirect setup_data\n");
 				return false;
 			}
 
@@ -679,7 +691,10 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			}
 		}
 
-		memunmap(data);
+		if (early)
+			early_memunmap(data, size);
+		else
+			memunmap(data);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
 			return true;
@@ -690,67 +705,16 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 	return false;
 }
 
-/*
- * Examine the physical address to determine if it is boot data by checking
- * it against the boot params setup_data chain (early boot version).
- */
+static bool memremap_is_setup_data(resource_size_t phys_addr,
+				   unsigned long size)
+{
+	return __memremap_is_setup_data(phys_addr, false);
+}
+
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

