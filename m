Return-Path: <linux-tip-commits+bounces-5879-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D9AAE28E8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Jun 2025 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4367A189CCB8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Jun 2025 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B121F03D7;
	Sat, 21 Jun 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AG7o8d1e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhWkuvOy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6E17BD9;
	Sat, 21 Jun 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750507692; cv=none; b=Kq53NieCq0SyrQvds8vIItS+m1WMJPs99wt7EzdySrww9iE9u5/eHcVHibhab8o5l8fSE6M+WY3VSvYv/SkqtJfh3xkq0tE7Ecxohu1N0uhlX8PMnnqQrZT+qHwNn/BdaMhW2fQoo4K1EzmGe7pSH6wNk2kp6kRhzusp6JJ6LNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750507692; c=relaxed/simple;
	bh=eme3eN0v4jAXtO6uAZL3O4EW4lsug/bRAd0x4+ylYfA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EjQnJ+2Gd8i1Qj6z7nJ9JBkH1LH8cxWIwu0i8bB15svEJ57qX7TUUDWsuIOABCjRK2TR191FH7WGx3g/clUvFJ4tStayS1+Iz+zbPjIZjaZDip86okgIybEgZka+wPKzMeegw9cRQNmUUieBJJNiZ8Cx4TRJ3KNZ4UvXbFaagMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AG7o8d1e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GhWkuvOy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 21 Jun 2025 12:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750507682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/sXKMFK/P5+c+TJ7ezzdyMwrZL/+aZ2ngFHLrqGkRA=;
	b=AG7o8d1evJkN4LjEdn/Pi2pHQnWP39MiztTzvIgWg0Df7rzp6AqrlJ+sLk5QXrcfwvjU2t
	1xCzj+Z5YQeO13eM/irgLhGZRhcuwAE3BgVqiOXqlj6i4EbL4s/q+Brt8dGnp8PBGlAXGh
	hz4zTWeVEDWb2x67/V5voOuWV2BfiT/+ps39Xj11oMkiVKoKxQRfK4Z081zSFMyInTyezx
	mDAfbKEbse3KwS9vn4/yLOTOXSwrAx6Nzh2aBqHpyNgXjYzubfnpklOhuSDeHVu9/t6OcM
	wEgmE2JRZnksrxuBuYFu/ZCwAiJE7+e95FIvEHfwsNrYON5ezKi/xgfYmWgvOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750507682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/sXKMFK/P5+c+TJ7ezzdyMwrZL/+aZ2ngFHLrqGkRA=;
	b=GhWkuvOyWtIMuAyW5BhBJlMx6WMGkjr/BloVgyL61w7e1cBsOJweJ8XkiHE+6iQ3XLge+1
	wT+1Vw3OZ8XXIiBg==
From: "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/efi: Implement support for embedding SBAT data for x86
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603091951.57775-1-vkuznets@redhat.com>
References: <20250603091951.57775-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175050768133.406.17562579654562902112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     61b57d35396a4b4bcca9944644b24fc6015976b5
Gitweb:        https://git.kernel.org/tip/61b57d35396a4b4bcca9944644b24fc6015976b5
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Tue, 03 Jun 2025 11:19:51 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 21 Jun 2025 13:53:44 +02:00

x86/efi: Implement support for embedding SBAT data for x86

Similar to zboot architectures, implement support for embedding SBAT data
for x86. Put '.sbat' section in between '.data' and '.text' as the former
also covers '.bss' and '.pgtable' and thus must be the last one in the
file.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/20250603091951.57775-1-vkuznets@redhat.com
---
 arch/x86/boot/Makefile                 |  2 +-
 arch/x86/boot/compressed/Makefile      |  5 ++++-
 arch/x86/boot/compressed/sbat.S        |  7 ++++++-
 arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++-
 arch/x86/boot/header.S                 | 31 +++++++++++++++++--------
 drivers/firmware/efi/Kconfig           |  2 +-
 6 files changed, 44 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sbat.S

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 640fcac..3f9fb36 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -71,7 +71,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f4f7b22..3a38fdc 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -106,6 +106,11 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-libs-$(CONFIG_X86_64)	+= $(objtree)/arch/x86/boot/startup/lib.a
+vmlinux-objs-$(CONFIG_EFI_SBAT) += $(obj)/sbat.o
+
+ifdef CONFIG_EFI_SBAT
+$(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
+endif
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/compressed/sbat.S b/arch/x86/boot/compressed/sbat.S
new file mode 100644
index 0000000..838f70a
--- /dev/null
+++ b/arch/x86/boot/compressed/sbat.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Embed SBAT data in the kernel.
+ */
+	.pushsection ".sbat", "a", @progbits
+	.incbin CONFIG_EFI_SBAT_FILE
+	.popsection
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3b2bc61..587ce3e 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -43,6 +43,14 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
+#ifdef CONFIG_EFI_SBAT
+	.sbat : ALIGN(0x1000) {
+		_sbat = . ;
+		*(.sbat)
+		_esbat = ALIGN(0x1000);
+		. = _esbat;
+	}
+#endif
 	.data :	ALIGN(0x1000) {
 		_data = . ;
 		*(.data)
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index e1f4fd5..9bea5a1 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -179,15 +179,11 @@ pecompat_fstart:
 #else
 	.set	pecompat_fstart, setup_size
 #endif
-	.ascii	".text"
-	.byte	0
-	.byte	0
-	.byte	0
-	.long	ZO__data
-	.long	setup_size
-	.long	ZO__data			# Size of initialized data
-						# on disk
-	.long	setup_size
+	.ascii	".text\0\0\0"
+	.long	textsize            		# VirtualSize
+	.long	setup_size			# VirtualAddress
+	.long	textsize			# SizeOfRawData
+	.long	setup_size			# PointerToRawData
 	.long	0				# PointerToRelocations
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
@@ -196,6 +192,23 @@ pecompat_fstart:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
+#ifdef CONFIG_EFI_SBAT
+	.ascii	".sbat\0\0\0"
+	.long	ZO__esbat - ZO__sbat            # VirtualSize
+	.long	setup_size + ZO__sbat           # VirtualAddress
+	.long	ZO__esbat - ZO__sbat            # SizeOfRawData
+	.long	setup_size + ZO__sbat           # PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
+
+	.set	textsize, ZO__sbat
+#else
+	.set	textsize, ZO__data
+#endif
+
 	.ascii	".data\0\0\0"
 	.long	ZO__end - ZO__data		# VirtualSize
 	.long	setup_size + ZO__data		# VirtualAddress
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index db8c5c0..16baa03 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -286,7 +286,7 @@ config EFI_SBAT
 
 config EFI_SBAT_FILE
 	string "Embedded SBAT section file path"
-	depends on EFI_ZBOOT
+	depends on EFI_ZBOOT || (EFI_STUB && X86)
 	help
 	  SBAT section provides a way to improve SecureBoot revocations of UEFI
 	  binaries by introducing a generation-based mechanism. With SBAT, older

