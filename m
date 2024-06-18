Return-Path: <linux-tip-commits+bounces-1443-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E966890C857
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DE51F21CDF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E08B202C8C;
	Tue, 18 Jun 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wIlYHHwW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ji6ujO85"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765741FF82E;
	Tue, 18 Jun 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703910; cv=none; b=PuYC+YBUmfRw6UrF35dr7QZrpN7/fxNOKSgo35gUB3rmotA1eii86VT5Ryvvnq7/YIV3r1SmpkaFUKaQeVStgIquTo8kSHYglDuAavsyGuo1j4qii3YS0FKsRsa2H2LVCvx6RH8I0mlkNwncdvgbI8GpQoBlq/AcVNFUL2zhuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703910; c=relaxed/simple;
	bh=ash5BuxARrjckuXDl9MzudF+QRvhHG2JIGAMjw22NIY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I6CxcqIxHCiAwEiZpShOImz3E2YILCke8CFhDNIf5Dg7RjinhzOB+FW7PLV1PHKPYMYqQraE66Mk1+UPbKAT7Y3hET7HYTqYTWuvv4esQxV7VBHKNBdaVHFzYChRmnqwLe2zjGtWdc5aqXE9kjJOVzBwwPWRNLZOAeEMTD0yUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wIlYHHwW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ji6ujO85; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8J26BaQHJXd2+Nj4c3CzWvjcVgX2j+8LdBajASC8ALE=;
	b=wIlYHHwWRW2A59e9JkwmIkVgGr4CC4WT/3lWMdcYTR3oTb9m6GihtD6CadUHizgtiZdMnP
	OKDQL0O8NSMoUVSDps1me/ASxL1AvJ5JOiCgUaDT5cPMNBTcjg4zDiKeFD2l4OXD8rD1mD
	PwdO+mB+MNqAdjFkz6hZcJ8JaCDjk7CnPrMbNfuTcdMF2EW39I48Rz9vhQqrvg0gXISZbZ
	ImFBo1Ze4ldo5OlSj9V8fMWmfT4YlMrFJRRCnBAzPQXermXT0d491NqclVBppDTr8XXsgK
	3aX/XYnUF83hG5O/2LAxa4i9we1EiZYbEZBGan/sjECJtMxtAXMvdHwh+K3Fug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8J26BaQHJXd2+Nj4c3CzWvjcVgX2j+8LdBajASC8ALE=;
	b=ji6ujO85x0VDi7wmc+1YLbcpMVq6HJ8/M6w9w+mXpsf/hy3bzTVH27NYsErFurx/6t7lwV
	ZDU3y/ezXDLsseAA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] virt: sev-guest: Choose the VMPCK key based on executing VMPL
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb88081c5d88263176849df8ea93e90a404619cab=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cb88081c5d88263176849df8ea93e90a404619cab=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870389916.10875.6793094727664703359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     eb65f96cb332d577b490ab9c9f5f8de8c0316076
Gitweb:        https://git.kernel.org/tip/eb65f96cb332d577b490ab9c9f5f8de8c0316076
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:51 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:42:57 +02:00

virt: sev-guest: Choose the VMPCK key based on executing VMPL

Currently, the sev-guest driver uses the vmpck-0 key by default. When an
SVSM is present, the kernel is running at a VMPL other than 0 and the
vmpck-0 key is no longer available. If a specific vmpck key has not be
requested by the user via the vmpck_id module parameter, choose the
vmpck key based on the active VMPL level.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/b88081c5d88263176849df8ea93e90a404619cab.1717600736.git.thomas.lendacky@amd.com
---
 Documentation/virt/coco/sev-guest.rst   | 11 +++++++++++
 arch/x86/include/asm/sev.h              | 11 +++++++++--
 arch/x86/kernel/sev-shared.c            |  3 ++-
 drivers/virt/coco/sev-guest/sev-guest.c | 17 ++++++++++++++---
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index e1eaf6a..9d00967 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -204,6 +204,17 @@ has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
 Otherwise, guest owner attestation provides no assurance that the kernel wasn't
 fed incorrect values at some point during boot.
 
+4. SEV Guest Driver Communication Key
+=====================================
+
+Communication between an SEV guest and the SEV firmware in the AMD Secure
+Processor (ASP, aka PSP) is protected by a VM Platform Communication Key
+(VMPCK). By default, the sev-guest driver uses the VMPCK associated with the
+VM Privilege Level (VMPL) at which the guest is running. Should this key be
+wiped by the sev-guest driver (see the driver for reasons why a VMPCK can be
+wiped), a different key can be used by reloading the sev-guest driver and
+specifying the desired key using the vmpck_id module parameter.
+
 
 Reference
 ---------
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1d0b1b2..9c6f269 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -237,6 +237,9 @@ struct svsm_call {
 #define SVSM_CORE_DELETE_VCPU		3
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+
+extern u8 snp_vmpl;
+
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
 static __always_inline void sev_es_ist_enter(struct pt_regs *regs)
@@ -319,7 +322,10 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_update_svsm_ca(void);
-#else
+
+#else	/* !CONFIG_AMD_MEM_ENCRYPT */
+
+#define snp_vmpl 0
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
@@ -349,7 +355,8 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
-#endif
+
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 #ifdef CONFIG_KVM_AMD_SEV
 bool snp_probe_rmptable_info(void);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2f50910..71de531 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -36,7 +36,8 @@
  *   early boot, both with identity mapped virtual addresses and proper kernel
  *   virtual addresses.
  */
-static u8 snp_vmpl __ro_after_init;
+u8 snp_vmpl __ro_after_init;
+EXPORT_SYMBOL_GPL(snp_vmpl);
 static struct svsm_ca *boot_svsm_caa __ro_after_init;
 static u64 boot_svsm_caa_pa __ro_after_init;
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 654290a..4597042 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -2,7 +2,7 @@
 /*
  * AMD Secure Encrypted Virtualization (SEV) guest driver interface
  *
- * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
  *
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  */
@@ -70,8 +70,15 @@ struct snp_guest_dev {
 	u8 *vmpck;
 };
 
-static u32 vmpck_id;
-module_param(vmpck_id, uint, 0444);
+/*
+ * The VMPCK ID represents the key used by the SNP guest to communicate with the
+ * SEV firmware in the AMD Secure Processor (ASP, aka PSP). By default, the key
+ * used will be the key associated with the VMPL at which the guest is running.
+ * Should the default key be wiped (see snp_disable_vmpck()), this parameter
+ * allows for using one of the remaining VMPCKs.
+ */
+static int vmpck_id = -1;
+module_param(vmpck_id, int, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
 /* Mutex to serialize the shared buffer access and command handling. */
@@ -923,6 +930,10 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!snp_dev)
 		goto e_unmap;
 
+	/* Adjust the default VMPCK key based on the executing VMPL level */
+	if (vmpck_id == -1)
+		vmpck_id = snp_vmpl;
+
 	ret = -EINVAL;
 	snp_dev->vmpck = get_vmpck(vmpck_id, secrets, &snp_dev->os_area_msg_seqno);
 	if (!snp_dev->vmpck) {

