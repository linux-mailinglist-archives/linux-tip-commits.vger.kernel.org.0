Return-Path: <linux-tip-commits+bounces-3017-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD949E848A
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Dec 2024 11:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DAC164696
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Dec 2024 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AEC13B7A3;
	Sun,  8 Dec 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vD9bItM8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avESljuX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BEC73176;
	Sun,  8 Dec 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733654397; cv=none; b=R9Dsxh6O9LIgrSijh8mxspoBGXcb3mLeZPNy/dfFg5xZKc6IxIb4lIgb8i/F6HcoN0GXdx7GC5hVLIwckINTZXSuctEZBBXYolO9Z/vQFYkXbkPAgGviE/Mp0lVYb4I1EMsBCNihFJbQJktceUbYtiyGV1JEU+HrVwhqgctzTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733654397; c=relaxed/simple;
	bh=z6g8/OvXOzcUlBVjnX9AK9paTVWKiayvLi6Wvh6WibQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CbqyNT9h5mwyKlbiRQIqAQa3sug/fuiAbppxknmwZTSV4fskKuGp6LbIssWsfgp96WuXd/ZXMX0dZtDBzcaiEYyD6xTv1FlDoT7Bgyy+WjwI7wcTo7ZPXscoi4eH6doXL/mLSwNFEs6P6kLoZ5cjTljIHmT8HXrZzne4vkAaNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vD9bItM8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avESljuX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Dec 2024 10:39:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733654393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nNlN14WuL0f3BgbnJ7xAfbrU0AM6CharpQNe3NsKeM=;
	b=vD9bItM8rqfguDBBbTDpYNm+eXz9fjDDfE943hW6w4jnSGAkHL/NYBFhoeSwN2QA84T5qA
	+ZcvR26PKyg98X3V9ZZrygHwFkWr+HU83vIm3Bm1KrOtGN4vfPoOh91aV8y2Mk+xlrz47Q
	VL5FOYabzta1ZpqQVOu6yLFes0aU2U4m+Ig4e6a+2weNaBvMEFrV/NZcHVQSo0KIjfJ7Kq
	PlCnOhW02s11hewFuLR+FK1++xl4G/IteKTzc4EvnkhmZDPV8ObPdUN/kJkHe3WqsmuBDU
	7Pj17J2eU35k5yma2ib13+RsBYjrwEa1JPlDoiy7/KgN+hye+x7CBd16NdXX/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733654393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nNlN14WuL0f3BgbnJ7xAfbrU0AM6CharpQNe3NsKeM=;
	b=avESljuXJtxmVIDcUkvM9ZJFzvFVQYKDlxihUm1ke6q8Z+STfSs2eydJm3iC/rdGpi/hX+
	aKuNsbfD+x633+Dg==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/ioremap: Remove unused size parameter in
 remapping functions
Cc: Baoquan He <bhe@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241123114221.149383-4-bhe@redhat.com>
References: <20241123114221.149383-4-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173365439185.412.2290612586300143779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     525077ae7145cc868b69282f85bed2be8ecd1ed5
Gitweb:        https://git.kernel.org/tip/525077ae7145cc868b69282f85bed2be8ecd1ed5
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Sat, 23 Nov 2024 19:42:21 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 07 Dec 2024 17:23:23 +01:00

x86/ioremap: Remove unused size parameter in remapping functions

The size parameter of functions memremap_is_efi_data(),
memremap_is_setup_data() and early_memremap_is_setup_data() is not used.
Remove it.

  [ bp: Massage commit message. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241123114221.149383-4-bhe@redhat.com
---
 arch/x86/mm/ioremap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index fe44e81..38ff779 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -593,8 +593,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
  * Examine the physical address to determine if it is EFI data. Check
  * it against the boot params structure and EFI tables and memory types.
  */
-static bool memremap_is_efi_data(resource_size_t phys_addr,
-				 unsigned long size)
+static bool memremap_is_efi_data(resource_size_t phys_addr)
 {
 	u64 paddr;
 
@@ -705,14 +704,12 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr, bool early
 	return false;
 }
 
-static bool memremap_is_setup_data(resource_size_t phys_addr,
-				   unsigned long size)
+static bool memremap_is_setup_data(resource_size_t phys_addr)
 {
 	return __memremap_is_setup_data(phys_addr, false);
 }
 
-static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
-						unsigned long size)
+static bool __init early_memremap_is_setup_data(resource_size_t phys_addr)
 {
 	return __memremap_is_setup_data(phys_addr, true);
 }
@@ -735,8 +732,8 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 		return false;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		if (memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		if (memremap_is_setup_data(phys_addr) ||
+		    memremap_is_efi_data(phys_addr))
 			return false;
 	}
 
@@ -761,8 +758,8 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 	encrypted_prot = true;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		if (early_memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		if (early_memremap_is_setup_data(phys_addr) ||
+		    memremap_is_efi_data(phys_addr))
 			encrypted_prot = false;
 	}
 

