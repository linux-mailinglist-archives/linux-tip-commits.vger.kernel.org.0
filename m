Return-Path: <linux-tip-commits+bounces-3577-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B7A3F8E3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C41A19C0F59
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AC721147D;
	Fri, 21 Feb 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qgpnBNfN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9fvfnMzn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA71212FAA;
	Fri, 21 Feb 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151760; cv=none; b=SOC8DBHNgjxnOVIaf1w8bVUTrwbgI3Rh9RxHIV9utmHJznYEGAIdL4Z5+aWBqKd9rHvInyrx0mh5XPn6I+hxMLed2hR4WJ/tIJOq0LzNzqe9ZzEWOYweYcwIHwrDni3JJL/nDNP6PW+uTaeJjPTy57/raHM3BP2JTDFtR23C3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151760; c=relaxed/simple;
	bh=wlfygCIBa2Rg56FxS0cli0NGsBjDpZlhKsJHZwwpYEA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rUXnAelj3d3jxJpXDMARF+kJAYfO50EOb9Gm0GvBGlb9I6VYRQU0lp/QdUBu0fzFpVNWFDoF16MUh89RsBudrB5liG3PjeYsy5CMYtXlhI705//b1oIxMf2+apRfPhjgpZ1rJEq5aG/AX8YhGgNJXf/w9X1PTJ6Furm2kgWo6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qgpnBNfN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9fvfnMzn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740151755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMqzSq2/WiSAUkdIZXoOJZh/J8hlKw8j+7cAMWhhadM=;
	b=qgpnBNfNqbSjZAuFFhOQ3fzQLEgLjlObMHBycUa89Imv7H1iiCMTCEsWtZEPhWVmYlFxXW
	3YHaiSm3+DIFgqSoPKwBHoWRtVxXjWJyELvdqtJKO2Pt1iLLuJSRCVk5wLJebOJaVJCL2X
	Fe4rXWqXVKlDgwswvBNCJbvX6CXBntqRT0rrZDL7MmG+zcJYIhxPdEJaXKSPjdPsVvFYbR
	i3xYaIcwzVd8GoL+yCs1F8o2UwkqsA3Nkh2Brc7VpfqfpVimSn9ueOk7Oa/PIOnI05gKWI
	qdfZYFWy1YQesUXim+ONJzL+mpR0lLnxxYmmGWVc8x/xfHRlCgCktoUXDIxQ2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740151755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMqzSq2/WiSAUkdIZXoOJZh/J8hlKw8j+7cAMWhhadM=;
	b=9fvfnMznv2emJyNFN5D8r8otfL+Gf1ZusSplvDlvf9k7B6Uc7VBe3qpdPOtsr5XJg75LCA
	xpXazs/BD2jo90Cg==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Split parsing of boot_params into the
 parse_boot_params() helper function
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250214090651.3331663-4-rppt@kernel.org>
References: <20250214090651.3331663-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015175513.10177.1935138758863235926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     d45dd0a9b27ee8be7792ae186bc33ed700144224
Gitweb:        https://git.kernel.org/tip/d45dd0a9b27ee8be7792ae186bc33ed700144224
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Fri, 14 Feb 2025 11:06:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 16:05:00 +01:00

x86/boot: Split parsing of boot_params into the parse_boot_params() helper function

Makes setup_arch() a bit easier to comprehend.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250214090651.3331663-4-rppt@kernel.org
---
 arch/x86/kernel/setup.c | 72 ++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d95946..6fb9a85 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -429,6 +429,46 @@ static void __init parse_setup_data(void)
 	}
 }
 
+/*
+ * Translate the fields of 'struct boot_param' into global variables
+ * representing these parameters.
+ */
+static void __init parse_boot_params(void)
+{
+	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
+	screen_info = boot_params.screen_info;
+	edid_info = boot_params.edid_info;
+#ifdef CONFIG_X86_32
+	apm_info.bios = boot_params.apm_bios_info;
+	ist_info = boot_params.ist_info;
+#endif
+	saved_video_mode = boot_params.hdr.vid_mode;
+	bootloader_type = boot_params.hdr.type_of_loader;
+	if ((bootloader_type >> 4) == 0xe) {
+		bootloader_type &= 0xf;
+		bootloader_type |= (boot_params.hdr.ext_loader_type+0x10) << 4;
+	}
+	bootloader_version  = bootloader_type & 0xf;
+	bootloader_version |= boot_params.hdr.ext_loader_ver << 4;
+
+#ifdef CONFIG_BLK_DEV_RAM
+	rd_image_start = boot_params.hdr.ram_size & RAMDISK_IMAGE_START_MASK;
+#endif
+#ifdef CONFIG_EFI
+	if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
+		     EFI32_LOADER_SIGNATURE, 4)) {
+		set_bit(EFI_BOOT, &efi.flags);
+	} else if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
+		     EFI64_LOADER_SIGNATURE, 4)) {
+		set_bit(EFI_BOOT, &efi.flags);
+		set_bit(EFI_64BIT, &efi.flags);
+	}
+#endif
+
+	if (!boot_params.hdr.root_flags)
+		root_mountflags &= ~MS_RDONLY;
+}
+
 static void __init memblock_x86_reserve_range_setup_data(void)
 {
 	struct setup_indirect *indirect;
@@ -806,35 +846,7 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_olpc_ofw_pgd();
 
-	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
-	screen_info = boot_params.screen_info;
-	edid_info = boot_params.edid_info;
-#ifdef CONFIG_X86_32
-	apm_info.bios = boot_params.apm_bios_info;
-	ist_info = boot_params.ist_info;
-#endif
-	saved_video_mode = boot_params.hdr.vid_mode;
-	bootloader_type = boot_params.hdr.type_of_loader;
-	if ((bootloader_type >> 4) == 0xe) {
-		bootloader_type &= 0xf;
-		bootloader_type |= (boot_params.hdr.ext_loader_type+0x10) << 4;
-	}
-	bootloader_version  = bootloader_type & 0xf;
-	bootloader_version |= boot_params.hdr.ext_loader_ver << 4;
-
-#ifdef CONFIG_BLK_DEV_RAM
-	rd_image_start = boot_params.hdr.ram_size & RAMDISK_IMAGE_START_MASK;
-#endif
-#ifdef CONFIG_EFI
-	if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
-		     EFI32_LOADER_SIGNATURE, 4)) {
-		set_bit(EFI_BOOT, &efi.flags);
-	} else if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
-		     EFI64_LOADER_SIGNATURE, 4)) {
-		set_bit(EFI_BOOT, &efi.flags);
-		set_bit(EFI_64BIT, &efi.flags);
-	}
-#endif
+	parse_boot_params();
 
 	x86_init.oem.arch_setup();
 
@@ -858,8 +870,6 @@ void __init setup_arch(char **cmdline_p)
 
 	copy_edd();
 
-	if (!boot_params.hdr.root_flags)
-		root_mountflags &= ~MS_RDONLY;
 	setup_initial_init_mm(_text, _etext, _edata, (void *)_brk_end);
 
 	/*

