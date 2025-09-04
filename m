Return-Path: <linux-tip-commits+bounces-6460-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2320FB439CB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17071B24F17
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D112FE04F;
	Thu,  4 Sep 2025 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbXnZ55w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxdRkzr5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71542FDC28;
	Thu,  4 Sep 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984853; cv=none; b=ou4AlgBG4VmdpAgRIl4FvN4jmNXwg2L7YXIFwDESYgsCbiJ6GFOrjrhBGrRgVXaqYBpNZeCVk74JctXKBOfK5kANK/O1dpjLCZHsLkLKZFD5zvl2P93ms8QpfYZ5fEMlyg0AvIlcxAISxcDrn/t4CSrBwQC2h6hDjMnHsDuGpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984853; c=relaxed/simple;
	bh=Pz0HlUwTwU9zyUHt6HKr+b3omze8zgEdMdXf0hB7JK4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jvh7dF1jctNOYapjxwq4PK14IIBte7RC6HsOFw9AEUZ3BfwYuB1zmqwsGa6nEjxcrmFbB153SscRjs9maZLED07MngMG4iMIH3ygSD8dTM96FIyNW5Oc0XsvKqDGa9rxa5fZkbd12COczA1UmiWbbEPLs/PUcii0C/uF4InrPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbXnZ55w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxdRkzr5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984849;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1dN4Ek3JdmO+ATd/DXvB0FcIXP54CDDtixWWABntSQ=;
	b=MbXnZ55wsKNVkBeDaDhg43CglhgbIcTfzzFlsqT71Su41CJBwb9HKSYE/w+/PMVQ8p9Evo
	4tugDooD8ubVQh52Rw12HKxC4db4JXTWNLLK6tiFNDa4K72unQ9UMVZZ/qxnEag/BWe7vk
	lQ6jz3bWwW5mA67ibt7YVkiLknLGQJVYzmi2AlX8Q8sznRZtjJXDvHbHCY1Kw9oYGH/6Fq
	BbzHKxBVtxmUuJ9sZ4Pj+U26LXLWRKEigI00lnDjHW9wtCk4K3X8XGE84Q+78Ydw6x53n2
	rqwCbhmIrMeAyegL1TO1lAWlo+QMdAzPnG05jDDcb/78rUin+i6dFr8Xe5s5vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984849;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1dN4Ek3JdmO+ATd/DXvB0FcIXP54CDDtixWWABntSQ=;
	b=WxdRkzr5Vu7mKhNvkvUhB1VgBw+SiovL/1HBFhZTUBrF5EltiU/ubsAfHL0tBoPr97VTW7
	eBT5pbf9w0tOWhCw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] efistub/x86: Remap inittext read-execute when needed
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-44-ardb+git@google.com>
References: <20250828102202.1849035-44-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698484811.1920.14659741352475485090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e7b88bc0051c5062bdd73b58837cf277d0057358
Gitweb:        https://git.kernel.org/tip/e7b88bc0051c5062bdd73b58837cf277d00=
57358
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:23 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 18:05:42 +02:00

efistub/x86: Remap inittext read-execute when needed

Recent EFI x86 systems are more strict when it comes to mapping boot
images, and require that mappings are either read-write or read-execute.

Now that the boot code is being cleaned up and refactored, most of it is
being moved into .init.text [where it arguably belongs] but that implies
that when booting on such strict EFI firmware, we need to take care to
map .init.text (and the .altinstr_aux section that follows it)
read-execute as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-44-ardb+git@google.com
---
 arch/x86/boot/compressed/Makefile       | 2 +-
 arch/x86/boot/compressed/misc.c         | 2 ++
 arch/x86/include/asm/boot.h             | 2 ++
 arch/x86/kernel/vmlinux.lds.S           | 2 ++
 drivers/firmware/efi/libstub/x86-stub.c | 4 +++-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Mak=
efile
index 3a38fdc..7465758 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -73,7 +73,7 @@ LDFLAGS_vmlinux +=3D -T
 hostprogs	:=3D mkpiggy
 HOST_EXTRACFLAGS +=3D -I$(srctree)/tools/include
=20
-sed-voffset :=3D -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rod=
ata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset :=3D -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rod=
ata\|_sinittext\|__inittext_end\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\=
1,UL)/p'
=20
 quiet_cmd_voffset =3D VOFFSET $@
       cmd_voffset =3D $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 94b5991..0f41ca0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -332,6 +332,8 @@ static size_t parse_elf(void *output)
 }
=20
 const unsigned long kernel_text_size =3D VO___start_rodata - VO__text;
+const unsigned long kernel_inittext_offset =3D VO__sinittext - VO__text;
+const unsigned long kernel_inittext_size =3D VO___inittext_end - VO__sinitte=
xt;
 const unsigned long kernel_total_size =3D VO__end - VO__text;
=20
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 02b23aa..f7b67cb 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -82,6 +82,8 @@
 #ifndef __ASSEMBLER__
 extern unsigned int output_len;
 extern const unsigned long kernel_text_size;
+extern const unsigned long kernel_inittext_offset;
+extern const unsigned long kernel_inittext_size;
 extern const unsigned long kernel_total_size;
=20
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_ad=
dr,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 5d5e3a9..4277efb 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -227,6 +227,8 @@ SECTIONS
 	 */
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
 		*(.altinstr_aux)
+		. =3D ALIGN(PAGE_SIZE);
+		__inittext_end =3D .;
 	}
=20
 	INIT_DATA_SECTION(16)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/l=
ibstub/x86-stub.c
index cafc90d..0d05eac 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -788,7 +788,9 @@ static efi_status_t efi_decompress_kernel(unsigned long *=
kernel_entry,
=20
 	*kernel_entry =3D addr + entry;
=20
-	return efi_adjust_memory_range_protection(addr, kernel_text_size);
+	return efi_adjust_memory_range_protection(addr, kernel_text_size) ?:
+	       efi_adjust_memory_range_protection(addr + kernel_inittext_offset,
+						  kernel_inittext_size);
 }
=20
 static void __noreturn enter_kernel(unsigned long kernel_addr,

