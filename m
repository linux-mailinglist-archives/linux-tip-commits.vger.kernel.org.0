Return-Path: <linux-tip-commits+bounces-6417-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B53B3FCD1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065B32C4894
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8162FC017;
	Tue,  2 Sep 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fl3+VbeX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5EBNhaFN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B92FC004;
	Tue,  2 Sep 2025 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809417; cv=none; b=T2L94J6gkpakgOygngCaZlGpYjD8DMyJKFhtx3H7P4kNeCLU2v0xiU5WCJNp37LVKghzo9mApTyeNUjcmbDIDURf7ZVuD4mut81ZWb1fo69K6ZM9oujPKbC/iZuyM3axW6z+F3gsIx0i/IvCdsfe6TjjGsKVJL/b1fMkiN0xNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809417; c=relaxed/simple;
	bh=B64rETJTPBBD4sxpiY4YbJvaiMKXgN9a9azN92gxM6M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AmOYUdIktRhqTm4ckvDU0ozS5I2SfzEr8W15mkThpgOTBafExP5aHKM7Umb+eU6aHCYMQJdE/dkKT6lt0LqEjfUaAArLkiy3g+uNM34ZaTzNOcUBX2FQQllIvkYn70jgSG9zi29+cfW1uNv0cQEfxbOmSEIYIVh8dp5Qe3jiElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fl3+VbeX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5EBNhaFN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aei6jSFEQvtY8u06n0U2CWpBgoi9QMzM7ydL0tOrFQU=;
	b=Fl3+VbeX5xenTUjA2A3S2zIl7W7Uov8nPBob8jAe9UOQJCj9oTPl5eNeEz0A+4D6uRfGwU
	3DIxPGrZYf2VHiWiHtVxE1c0kcbcxvX8vBXwi09uRrjcWiUqcRtjzsxg1klGTy9VDNm0xa
	Z7C1k3MLAIOo3rzf/SR8pRXM8o4s3xrReoWltsUSbL7zakVvKyYQfbBpa0HwBR6sFpzZe1
	KjycIpdgy9Wwt9wfH+WmKPgGZzUka1IUUVfQcHX4Z30bjoQhHdLqR++3mxCgSguNnWomjn
	tdy3kGub5I/eqxVrtn6wT7dRkwzq5RlVC4x5eCL7IFRchCgN6WvL+mnUK7jhCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aei6jSFEQvtY8u06n0U2CWpBgoi9QMzM7ydL0tOrFQU=;
	b=5EBNhaFNwGuDSjWl+SGSb0HanpL8KVuba/jhmlXE0OMZmdXXIzIFXaMf8mPrMx3cDZtTZy
	g4LuBAo3fGL/dcDg==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Add new driver for Secure AVIC
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828070334.208401-2-Neeraj.Upadhyay@amd.com>
References: <20250828070334.208401-2-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680941131.1920.6153825045228294204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     30c2b98aa84c76f2ae60e66dd4ec2d9497713359
Gitweb:        https://git.kernel.org/tip/30c2b98aa84c76f2ae60e66dd4ec2d94977=
13359
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 12:33:17 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 28 Aug 2025 17:57:19 +02:00

x86/apic: Add new driver for Secure AVIC

The Secure AVIC feature provides SEV-SNP guests hardware acceleration for
performance sensitive APIC accesses while securely managing the guest-owned
APIC state through the use of a private APIC backing page.=20

This helps prevent the hypervisor from generating unexpected interrupts for
a vCPU or otherwise violate architectural assumptions around the APIC
behavior.

Add a new x2APIC driver that will serve as the base of the Secure AVIC
support. It is initially the same as the x2APIC physical driver (without IPI
callbacks), but will be modified as features are implemented.

As the new driver does not implement Secure AVIC features yet, if the
hypervisor sets the Secure AVIC bit in SEV_STATUS, maintain the existing
behavior to enforce the guest termination.

  [ bp: Massage commit message. ]

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828070334.208401-2-Neeraj.Upadhyay@amd.com
---
 arch/x86/Kconfig                    | 13 ++++++-
 arch/x86/boot/compressed/sev.c      |  1 +-
 arch/x86/coco/core.c                |  3 +-
 arch/x86/coco/sev/core.c            |  1 +-
 arch/x86/include/asm/msr-index.h    |  4 +-
 arch/x86/kernel/apic/Makefile       |  1 +-
 arch/x86/kernel/apic/x2apic_savic.c | 63 ++++++++++++++++++++++++++++-
 include/linux/cc_platform.h         |  8 ++++-
 8 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/apic/x2apic_savic.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890f..e329527 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -483,6 +483,19 @@ config X86_X2APIC
=20
 	  If in doubt, say Y.
=20
+config AMD_SECURE_AVIC
+	bool "AMD Secure AVIC"
+	depends on AMD_MEM_ENCRYPT && X86_X2APIC
+	help
+	  Enable this to get AMD Secure AVIC support on guests that have this featu=
re.
+
+	  AMD Secure AVIC provides hardware acceleration for performance sensitive
+	  APIC accesses and support for managing guest owned APIC state for SEV-SNP
+	  guests. Secure AVIC does not support xAPIC mode. It has functional
+	  dependency on x2apic being enabled in the guest.
+
+	  If you don't know what to do here, say N.
+
 config X86_POSTED_MSI
 	bool "Enable MSI and MSI-x delivery by posted interrupts"
 	depends on X86_64 && IRQ_REMAP
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index fd1b67d..74e083f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -235,6 +235,7 @@ bool sev_es_check_ghcb_fault(unsigned long address)
 				 MSR_AMD64_SNP_VMSA_REG_PROT |		\
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
+				 MSR_AMD64_SNP_SECURE_AVIC |		\
 				 MSR_AMD64_SNP_RESERVED_MASK)
=20
 /*
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index d4610af..989ca9f 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -104,6 +104,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_HOST_SEV_SNP:
 		return cc_flags.host_sev_snp;
=20
+	case CC_ATTR_SNP_SECURE_AVIC:
+		return sev_status & MSR_AMD64_SNP_SECURE_AVIC;
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 14ef590..f7a549f 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -79,6 +79,7 @@ static const char * const sev_status_feat_names[] =3D {
 	[MSR_AMD64_SNP_IBS_VIRT_BIT]		=3D "IBSVirt",
 	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	=3D "VMSARegProt",
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		=3D "SMTProt",
+	[MSR_AMD64_SNP_SECURE_AVIC_BIT]		=3D "SecureAVIC",
 };
=20
 /*
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index b65c3ba..2a6d4fd 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -699,7 +699,9 @@
 #define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
 #define MSR_AMD64_SNP_SMT_PROT_BIT	17
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
-#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
+#define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		19
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
index 52d1808..581db89 100644
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -18,6 +18,7 @@ ifeq ($(CONFIG_X86_64),y)
 # APIC probe will depend on the listing order here
 obj-$(CONFIG_X86_NUMACHIP)	+=3D apic_numachip.o
 obj-$(CONFIG_X86_UV)		+=3D x2apic_uv_x.o
+obj-$(CONFIG_AMD_SECURE_AVIC)	+=3D x2apic_savic.o
 obj-$(CONFIG_X86_X2APIC)	+=3D x2apic_phys.o
 obj-$(CONFIG_X86_X2APIC)	+=3D x2apic_cluster.o
 obj-y				+=3D apic_flat_64.o
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
new file mode 100644
index 0000000..bea844f
--- /dev/null
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Secure AVIC Support (SEV-SNP Guests)
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ * Author: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
+ */
+
+#include <linux/cc_platform.h>
+
+#include <asm/apic.h>
+#include <asm/sev.h>
+
+#include "local.h"
+
+static int savic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	return x2apic_enabled() && cc_platform_has(CC_ATTR_SNP_SECURE_AVIC);
+}
+
+static int savic_probe(void)
+{
+	if (!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		return 0;
+
+	if (!x2apic_mode) {
+		pr_err("Secure AVIC enabled in non x2APIC mode\n");
+		snp_abort();
+		/* unreachable */
+	}
+
+	return 1;
+}
+
+static struct apic apic_x2apic_savic __ro_after_init =3D {
+
+	.name				=3D "secure avic x2apic",
+	.probe				=3D savic_probe,
+	.acpi_madt_oem_check		=3D savic_acpi_madt_oem_check,
+
+	.dest_mode_logical		=3D false,
+
+	.disable_esr			=3D 0,
+
+	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
+
+	.max_apic_id			=3D UINT_MAX,
+	.x2apic_set_max_apicid		=3D true,
+	.get_apic_id			=3D x2apic_get_apic_id,
+
+	.calc_dest_apicid		=3D apic_default_calc_apicid,
+
+	.nmi_to_offline_cpu		=3D true,
+
+	.read				=3D native_apic_msr_read,
+	.write				=3D native_apic_msr_write,
+	.eoi				=3D native_apic_msr_eoi,
+	.icr_read			=3D native_x2apic_icr_read,
+	.icr_write			=3D native_x2apic_icr_write,
+};
+
+apic_driver(apic_x2apic_savic);
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 0bf7d33..7fcec02 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -96,6 +96,14 @@ enum cc_attr {
 	 * enabled to run SEV-SNP guests.
 	 */
 	CC_ATTR_HOST_SEV_SNP,
+
+	/**
+	 * @CC_ATTR_SNP_SECURE_AVIC: Secure AVIC mode is active.
+	 *
+	 * The host kernel is running with the necessary features enabled
+	 * to run SEV-SNP guests with full Secure AVIC capabilities.
+	 */
+	CC_ATTR_SNP_SECURE_AVIC,
 };
=20
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM

