Return-Path: <linux-tip-commits+bounces-1944-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C770A947CA1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC9284097
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810513A256;
	Mon,  5 Aug 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bxm7eI/z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EaFuG68l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3150137750;
	Mon,  5 Aug 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867234; cv=none; b=UU/hI4hdXADRwv38MjCYrGrgYML8rrcqVCRTod2Nye9QGtevi0mbhQ5poiVluawoIIoyX1bcOvHnnwaLKhrV5Hgakhp5lVst7LCxYPUBWoNt+/n95g4jA1odi6ThmcotuGV/4dmqSgF0Ed7xKlHAlz8zntISth5D6N6cfh3CtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867234; c=relaxed/simple;
	bh=rcDxQB4m8RGNPHnsunM2CoYgFsF3gyvcIb4BxctXQyk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NYeyHCCdMR9DYA3NnRs7rOOz1zO2m6EBeGR1imiWqd8Ph8EakdmWq9EC2yLlya031PSx4zAjX+hPsAz0JvFPbrha9daXkU6tDFdNsT6dgDnZQGPHRzB83epDsyeB3W1dtuWAmNJa5mj/5fNP0D6bV7dzoYFck0GqX4aOMqV18lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bxm7eI/z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EaFuG68l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 14:13:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722867231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rd/rgQfK0gPHw3MoFq+tHkAIrxdIJNLLihzqO6uhT4E=;
	b=Bxm7eI/zt3CwX1qKre8fWXc1vkwRmCaqYUz2qCGWmX+ISTfPN5Q26uESpq+Gflr5CNmONz
	typDKJ6AsXtMSFFUzfWd9sPiZvxcCd79S91mCSjL7hdsWuiA2k9YAxN/Fli/A1Nu9cq4XB
	syOLF97zE47vaj/N6jCpHMTUmABbtXYex6XxERFA7jxaFgo1Dwzbzs5FOi9GWX72SaGLuz
	pfYl6QUxPwVD+fbLsLQT0p7oOMe2esHXoPuBuIU4KNpuGZXw1cwuMJK5JDiCsKaoKKz6f+
	717qADLOBvkWX8zAOE7cbyzjiCEsY7PWQxykN81rBaYsymAf0MAun6Ua8KIVxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722867231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rd/rgQfK0gPHw3MoFq+tHkAIrxdIJNLLihzqO6uhT4E=;
	b=EaFuG68lu58jw6kLeOMg1B5hB4F/El9iiSdc4XVoDjpe+4E9te2c0liX6x4lHo1IILz0lx
	7RQf87kp6OITNeDA==
From: "tip-bot2 for Tao Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Cc: Tao Liu <ltao@redhat.com>, Steve Wahl <steve.wahl@hpe.com>,
 Thomas Gleixner <tglx@linutronix.de>, Pavin Joseph <me@pavinjoseph.com>,
 Sarah Brofeldt <srhb@dbc.dk>, Eric Hagberg <ehagberg@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240717213121.3064030-2-steve.wahl@hpe.com>
References: <20240717213121.3064030-2-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172286723075.2215.6922141553022541297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     5760929f6545c651682de3c2c6c6786816b17bb1
Gitweb:        https://git.kernel.org/tip/5760929f6545c651682de3c2c6c6786816b17bb1
Author:        Tao Liu <ltao@redhat.com>
AuthorDate:    Wed, 17 Jul 2024 16:31:20 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Aug 2024 16:09:31 +02:00

x86/kexec: Add EFI config table identity mapping for kexec kernel

A kexec kernel boot failure is sometimes observed on AMD CPUs due to an
unmapped EFI config table array.  This can be seen when "nogbpages" is on
the kernel command line, and has been observed as a full BIOS reboot rather
than a successful kexec.

This was also the cause of reported regressions attributed to Commit
7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page should
be mapped.") which was subsequently reverted.

To avoid this page fault, explicitly include the EFI config table array in
the kexec identity map.

Further explanation:

The following 2 commits caused the EFI config table array to be
accessed when enabling sev at kernel startup.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

This is in the code that examines whether SEV should be enabled or not, so
it can even affect systems that are not SEV capable.

This may result in a page fault if the EFI config table array's address is
unmapped. Since the page fault occurs before the new kernel establishes its
own identity map and page fault routines, it is unrecoverable and kexec
fails.

Most often, this problem is not seen because the EFI config table array
gets included in the map by the luck of being placed at a memory address
close enough to other memory areas that *are* included in the map created
by kexec.

Both the "nogbpages" command line option and the "use gpbages only where
full GB page should be mapped" change greatly reduce the chance of being
included in the map by luck, which is why the problem appears.

Signed-off-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/all/20240717213121.3064030-2-steve.wahl@hpe.com
---
 arch/x86/kernel/machine_kexec_64.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc0f7f7..9c9ac60 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -87,6 +88,8 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;

