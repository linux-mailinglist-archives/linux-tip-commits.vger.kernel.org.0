Return-Path: <linux-tip-commits+bounces-6415-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3420FB3FCC7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19DF44E3BF6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80EA2F9C3D;
	Tue,  2 Sep 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PUWT5dYH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lx0DlH9J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092492F360F;
	Tue,  2 Sep 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809413; cv=none; b=ja1hRGiSwJo/sGzkIdEdKBN7wqlvoQ7yc69n3hCX65nAslNdPMaCEYiqM4fK60D5dp29H4IDwI6E0gfvvLsMYcaVz4XJcrcLtaDtwB/dUcs2ezGoPiEsROWF9C/J85+jDkfFC8eBc7kfaoyS3meDKuquH1Dq1glQWXxZoUBuf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809413; c=relaxed/simple;
	bh=XXHIvLEUkJ9F0asjedoAg2bEusjv8ODLv48e29iwp70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ie7MTMvWEVJ/lUy4HrTJ47AO6y4SLGGcaxyuvsZvG1oYoDfdOEl+DdhYaakYv3yNYQvmrESgHLahb7jDiVYjRq8m/QsuEZxjIzbr0uoGvWnshjLQcXa5lhyOTnJpxA6lHkZFX1uaNYT+SoZFXzSTmYs8pKR8VOgdfLaJpeKZQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PUWT5dYH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lx0DlH9J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKSURIpUKEGwpmTic3tWcu2zTATX2OK2vK1gizdC1nE=;
	b=PUWT5dYH5jSljKL0vUFOXUsY5FcNKepvNm5Wknuv76y1u9dNE63rYnoT2q9TBW2hpWNvE0
	B8oL8hKhDGPtPW2OzMSNqFFAG0OZc2nUbAFNGVd7rIMsBt0GWmESe+YkaC6aM9gF+WcD/m
	gF0R+/7zMJLLnBcSeIeEokFfyRucBJf5maPJ/Kcjcaw8PSmH0TeDL1tlvUGI1TfXCwao+Y
	S3PS4AIPtmFeDpzMFXbJm69prCkVQbkKN4pbZ0T3iVRwoABLk6D8Bm+FwJuktwzXXpr0Ab
	KtgzcQpKrcZKi9JaWCiCCMfxZ1J143FnlHrD67x1IkUe3vFWdFyDnZZBH/lWQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKSURIpUKEGwpmTic3tWcu2zTATX2OK2vK1gizdC1nE=;
	b=lx0DlH9JMyJzYUgImd0bgywCCiu3rJl2YUcFbClQ9NK6WYnyxiQTRrgESI1gqntU8s6g3X
	zNNYfxRdjU03ncAw==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Populate .read()/.write() callbacks of
 Secure AVIC driver
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828110255.208779-1-Neeraj.Upadhyay@amd.com>
References: <20250828110255.208779-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680940884.1920.2159466177340458638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c822f58a4fab25944ba66768c1d6c563aa6ac077
Gitweb:        https://git.kernel.org/tip/c822f58a4fab25944ba66768c1d6c563aa6=
ac077
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:32:40 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 31 Aug 2025 22:07:35 +02:00

x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver

Add read() and write() APIC callback functions to read and write the x2APIC
registers directly from the guest APIC backing page of a vCPU.

The x2APIC registers are mapped at an offset within the guest APIC backing
page which is the same as their x2APIC MMIO offset. Secure AVIC adds new
registers such as ALLOWED_IRRs (which are at 4-byte offset within the IRR
register offset range) and NMI_REQ to the APIC register space.

When Secure AVIC is enabled, accessing the guest's APIC registers through
RD/WRMSR results in a #VC exception (for non-accelerated register accesses)
with error code VMEXIT_AVIC_NOACCEL.

The #VC exception handler can read/write the x2APIC register in the guest APIC
backing page to complete the RDMSR/WRMSR. Since doing this would increase the
latency of accessing the x2APIC registers, instead of doing RDMSR/WRMSR based
register accesses and handling reads/writes in the #VC exception, directly
read/write the APIC registers from/to the guest APIC backing page of the vCPU
in read() and write() callbacks of the Secure AVIC APIC driver.

  [ bp: Massage commit message. ]

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828110255.208779-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/include/asm/apicdef.h      |   2 +-
 arch/x86/kernel/apic/x2apic_savic.c | 122 ++++++++++++++++++++++++++-
 2 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 094106b..be39a54 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -135,6 +135,8 @@
 #define		APIC_TDR_DIV_128	0xA
 #define	APIC_EFEAT	0x400
 #define	APIC_ECTRL	0x410
+#define APIC_SEOI	0x420
+#define APIC_IER	0x480
 #define APIC_EILVTn(n)	(0x500 + 0x10 * n)
 #define		APIC_EILVT_NR_AMD_K8	1	/* # of extended interrupts */
 #define		APIC_EILVT_NR_AMD_10H	4
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index 948d894..5479605 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -9,6 +9,7 @@
=20
 #include <linux/cc_platform.h>
 #include <linux/percpu-defs.h>
+#include <linux/align.h>
=20
 #include <asm/apic.h>
 #include <asm/sev.h>
@@ -26,6 +27,123 @@ static int savic_acpi_madt_oem_check(char *oem_id, char *=
oem_table_id)
 	return x2apic_enabled() && cc_platform_has(CC_ATTR_SNP_SECURE_AVIC);
 }
=20
+#define SAVIC_ALLOWED_IRR	0x204
+
+/*
+ * When Secure AVIC is enabled, RDMSR/WRMSR of the APIC registers
+ * result in #VC exception (for non-accelerated register accesses)
+ * with VMEXIT_AVIC_NOACCEL error code. The #VC exception handler
+ * can read/write the x2APIC register in the guest APIC backing page.
+ *
+ * Since doing this would increase the latency of accessing x2APIC
+ * registers, instead of doing RDMSR/WRMSR based accesses and
+ * handling the APIC register reads/writes in the #VC exception handler,
+ * the read() and write() callbacks directly read/write the APIC register
+ * from/to the vCPU's APIC backing page.
+ */
+static u32 savic_read(u32 reg)
+{
+	void *ap =3D this_cpu_ptr(savic_page);
+
+	switch (reg) {
+	case APIC_LVTT:
+	case APIC_TMICT:
+	case APIC_TMCCT:
+	case APIC_TDCR:
+	case APIC_ID:
+	case APIC_LVR:
+	case APIC_TASKPRI:
+	case APIC_ARBPRI:
+	case APIC_PROCPRI:
+	case APIC_LDR:
+	case APIC_SPIV:
+	case APIC_ESR:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+	case APIC_EFEAT:
+	case APIC_ECTRL:
+	case APIC_SEOI:
+	case APIC_IER:
+	case APIC_EILVTn(0) ... APIC_EILVTn(3):
+		return apic_get_reg(ap, reg);
+	case APIC_ICR:
+		return (u32)apic_get_reg64(ap, reg);
+	case APIC_ISR ... APIC_ISR + 0x70:
+	case APIC_TMR ... APIC_TMR + 0x70:
+		if (WARN_ONCE(!IS_ALIGNED(reg, 16),
+			      "APIC register read offset 0x%x not aligned at 16 bytes", reg))
+			return 0;
+		return apic_get_reg(ap, reg);
+	/* IRR and ALLOWED_IRR offset range */
+	case APIC_IRR ... APIC_IRR + 0x74:
+		/*
+		 * Valid APIC_IRR/SAVIC_ALLOWED_IRR registers are at 16 bytes strides from
+		 * their respective base offset. APIC_IRRs are in the range
+		 *
+		 * (0x200, 0x210,  ..., 0x270)
+		 *
+		 * while the SAVIC_ALLOWED_IRR range starts 4 bytes later, in the range
+		 *
+		 * (0x204, 0x214, ..., 0x274).
+		 *
+		 * Filter out everything else.
+		 */
+		if (WARN_ONCE(!(IS_ALIGNED(reg, 16) ||
+				IS_ALIGNED(reg - 4, 16)),
+			      "Misaligned APIC_IRR/ALLOWED_IRR APIC register read offset 0x%x", r=
eg))
+			return 0;
+		return apic_get_reg(ap, reg);
+	default:
+		pr_err("Error reading unknown Secure AVIC reg offset 0x%x\n", reg);
+		return 0;
+	}
+}
+
+#define SAVIC_NMI_REQ		0x278
+
+static void savic_write(u32 reg, u32 data)
+{
+	void *ap =3D this_cpu_ptr(savic_page);
+
+	switch (reg) {
+	case APIC_LVTT:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_TMICT:
+	case APIC_TDCR:
+	case APIC_SELF_IPI:
+	case APIC_TASKPRI:
+	case APIC_EOI:
+	case APIC_SPIV:
+	case SAVIC_NMI_REQ:
+	case APIC_ESR:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVTERR:
+	case APIC_ECTRL:
+	case APIC_SEOI:
+	case APIC_IER:
+	case APIC_EILVTn(0) ... APIC_EILVTn(3):
+		apic_set_reg(ap, reg, data);
+		break;
+	case APIC_ICR:
+		apic_set_reg64(ap, reg, (u64)data);
+		break;
+	/* ALLOWED_IRR offsets are writable */
+	case SAVIC_ALLOWED_IRR ... SAVIC_ALLOWED_IRR + 0x70:
+		if (IS_ALIGNED(reg - 4, 16)) {
+			apic_set_reg(ap, reg, data);
+			break;
+		}
+		fallthrough;
+	default:
+		pr_err("Error writing unknown Secure AVIC reg offset 0x%x\n", reg);
+	}
+}
+
 static void savic_setup(void)
 {
 	void *ap =3D this_cpu_ptr(savic_page);
@@ -88,8 +206,8 @@ static struct apic apic_x2apic_savic __ro_after_init =3D {
=20
 	.nmi_to_offline_cpu		=3D true,
=20
-	.read				=3D native_apic_msr_read,
-	.write				=3D native_apic_msr_write,
+	.read				=3D savic_read,
+	.write				=3D savic_write,
 	.eoi				=3D native_apic_msr_eoi,
 	.icr_read			=3D native_x2apic_icr_read,
 	.icr_write			=3D native_x2apic_icr_write,

