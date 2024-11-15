Return-Path: <linux-tip-commits+bounces-2864-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9496A9CDD7C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2024 12:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4C91F2112F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2024 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBB1B6D1B;
	Fri, 15 Nov 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="htTQFj6s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8EZIoZi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE33A1B6CFF;
	Fri, 15 Nov 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670147; cv=none; b=Aw3p7hnSxSMmJSFgyniMtdptis5wimlO97sb6P0u9e3qOr/bkuHxzIfy/msiR6xZq8FxZxnvVjfo4gJFG/SdCqQp0MYwNqQ5K2FGsCPTe7fRFqXdJVm/cHzjSjluKhG/2IiSi3S8qbi8jVhpfhQciEuArgF4+B4wbnBTRz0t9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670147; c=relaxed/simple;
	bh=iUz4e/f1WsbRnt2dlIwiPTK/zcknjk0F9jPGxhK0QXo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R9oHYx7GpWELLwS5V9TcJy74FUdSQz7nc8JeXip9jLeyflQL8c6JC9od5VLLOQpdgglh9ZMX3JkWO+/Q0TsQRBVRSzKBqpufVI2P3QAUl+2x6dFM0wX9tho/CBZ9nSrjrgsNqQbe3+x7m9YcmTWhq5YFClczFrporf3mj+QcSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=htTQFj6s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X8EZIoZi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Nov 2024 11:28:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731670138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odbo5v7558IbijHWfIwHWFaAGKsvkDglP5XwL1ZD9sk=;
	b=htTQFj6sFf2q+Em4SJagM2p/r+4Z3WlhLgACih7n3SXaKFFcXv2CmjeWOM1HBca4HMhabC
	dKlDpAWJLdFAoU9mvEQfxcxzFlL4tp/jZi1aiWy3q8F/sM3gZGK5AIM4QTM/HbF0ZyYJsU
	OFMM7A74JYWMn32uX0eY1ZvmLCmZWYr00k6SrrS62nmyYvU8EWotduOaGSf6rK9SfAUY3l
	0ncN01It1lwWGALs/5CS0NKyG7hlAgbmli783LZIpuwY1Ip8tzTNkRofChn711LfpSKpvX
	Y8AiizTGSDj7TnZqiP2sa45w5j3TV4hWoVj948hammcrW1f/TQuC04cgOPrspQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731670138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odbo5v7558IbijHWfIwHWFaAGKsvkDglP5XwL1ZD9sk=;
	b=X8EZIoZiPbJ+Tz9aLofZrF5BT3z/REaEIA7IgCOSDnLlpc/20+J3jYq24wNPHD5kxP9Mz6
	JOLoaTXWrQO6ybAg==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Clean up unused parameters of functions
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115012131.509226-4-bhe@redhat.com>
References: <20241115012131.509226-4-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173167013661.412.4358459076027862725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     390c9c9e48b821fc53b67dd93ae0f7a1f82a0469
Gitweb:        https://git.kernel.org/tip/390c9c9e48b821fc53b67dd93ae0f7a1f82a0469
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Fri, 15 Nov 2024 09:21:31 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2024 12:03:36 +01:00

x86/mm: Clean up unused parameters of functions

For functions memremap_is_efi_data(), memremap_is_setup_data and
early_memremap_is_setup_data(), their parameter 'size' is not used
and sometime cause confusion. Remove it now.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241115012131.509226-4-bhe@redhat.com
---
 arch/x86/mm/ioremap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 5d1b5e4..71b282e 100644
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
 
@@ -709,14 +708,12 @@ static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
 }
 #undef SD_SIZE
 
-static bool __ref memremap_is_setup_data(resource_size_t phys_addr,
-				   unsigned long size)
+static bool __ref memremap_is_setup_data(resource_size_t phys_addr)
 {
 	return __memremap_is_setup_data(phys_addr, false);
 }
 
-static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
-						unsigned long size)
+static bool __init early_memremap_is_setup_data(resource_size_t phys_addr)
 {
 	return __memremap_is_setup_data(phys_addr, true);
 }
@@ -739,8 +736,8 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 		return false;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		if (memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		if (memremap_is_setup_data(phys_addr) ||
+		    memremap_is_efi_data(phys_addr))
 			return false;
 	}
 
@@ -765,8 +762,8 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 	encrypted_prot = true;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		if (early_memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		if (early_memremap_is_setup_data(phys_addr) ||
+		    memremap_is_efi_data(phys_addr))
 			encrypted_prot = false;
 	}
 

