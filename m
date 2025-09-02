Return-Path: <linux-tip-commits+bounces-6416-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A12B3FCCC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC7F170D9B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326162FB978;
	Tue,  2 Sep 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpfTV8Lt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fdQUhqTb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0E2FABF0;
	Tue,  2 Sep 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809415; cv=none; b=DN1SQd9/9Zsja1UI4NIig/Rt12XzElYwc/zbi06sNwHT9pw6K4LGxJ922oVdMsDomkND5DxcCBZNn3d2TGoEP+tI9ckTh2LgEcE3dGqxJqGMMYfLHmxLXtKKMEQU/hT9/AiEospHVzMsVA/vLUQMwYSbrjiT8Dsiev0YGN5FyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809415; c=relaxed/simple;
	bh=FDGBjFW3rWFtkWQMaiGlBYCsWBSqmwUI390lRUrRqJI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e/1ibndDV7AxPNEQhnykB7vE9mhk8wkCsOqLCfOKfUwARFhTYTHcysTeck09aiYhKK4Ja4NOYVK+ETsfzJ3J5SmD9gvCghPn7DCmTl3OzANXqxO7Qbqzds4VlwsMPAoKR3xCzkagspYcy1yb13xMm5i91edutctH5f/ummMMf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpfTV8Lt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fdQUhqTb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809411;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cb+RHd2fIjxZBADhk651E+w5WH37KTsTNwqv96KmKd0=;
	b=zpfTV8LtzYJb9YtvvbWitFQ72rUUvYU/zCdxth21IXsg4Xo0BtnxvMmiUM87p6jphBPI2t
	/QHnz2S7O1+ZOU7SDnWuKe32yI+2aaYlSYWsJthfiv0m/B9hP3HWk0Pyv0wPRggM88KC7B
	OpzUydUMF4akIjYqMDXSE8mgvDxgbPXYBdp4ClTci0lzkkg/jQ91ZWX+eGNDLYecF+bwHd
	PP0d9/DB0UrZs0Lfsp/9uB7+vY//T6J+cpllsSODpWZrY/bNrg+GjoS6X8Rt8xnpMhSjG3
	+0GJLIDvt5+USn7sTbVrwqlxIgsUt4PqV3ZsYIE1kOpC509oIdX9a9Sf/bAfzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809411;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cb+RHd2fIjxZBADhk651E+w5WH37KTsTNwqv96KmKd0=;
	b=fdQUhqTbBr/ZzdDoGeeiGsziZj6bT3QGjaqsxuG/K4FLiNHZq3woTOZOXHG4+qzPQdtT6J
	0ZQbIqOxG7rn1bAw==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Initialize Secure AVIC APIC backing page
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828070334.208401-3-Neeraj.Upadhyay@amd.com>
References: <20250828070334.208401-3-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680941004.1920.5315092237227767830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b8c3c9f5d0505905e21c03731d1665c67053b47e
Gitweb:        https://git.kernel.org/tip/b8c3c9f5d0505905e21c03731d1665c6705=
3b47e
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 12:33:18 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 31 Aug 2025 21:59:07 +02:00

x86/apic: Initialize Secure AVIC APIC backing page

With Secure AVIC, the APIC backing page is owned and managed by the guest.
Allocate and initialize APIC backing page for all guest CPUs.

The NPT entry for a vCPU's APIC backing page must always be present when the
vCPU is running in order for Secure AVIC to function. A VMEXIT_BUSY is
returned on VMRUN and the vCPU cannot be resumed otherwise.

To handle this, notify GPA of the vCPU's APIC backing page to the hypervisor
by using the SVM_VMGEXIT_SECURE_AVIC GHCB protocol event. Before executing
VMRUN, the hypervisor makes use of this information to make sure the APIC
backing page is mapped in the NPT.

  [ bp: Massage commit message. ]

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828070334.208401-3-Neeraj.Upadhyay@amd.com
---
 arch/x86/coco/sev/core.c            | 22 ++++++++++++++++++-
 arch/x86/include/asm/apic.h         |  1 +-
 arch/x86/include/asm/sev.h          |  2 ++-
 arch/x86/include/uapi/asm/svm.h     |  4 +++-
 arch/x86/kernel/apic/apic.c         |  3 ++-
 arch/x86/kernel/apic/x2apic_savic.c | 35 ++++++++++++++++++++++++++++-
 6 files changed, 67 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index f7a549f..7669aaf 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1108,6 +1108,28 @@ int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd)
 	return 0;
 }
=20
+enum es_result savic_register_gpa(u64 gpa)
+{
+	struct ghcb_state state;
+	struct es_em_ctxt ctxt;
+	enum es_result res;
+	struct ghcb *ghcb;
+
+	guard(irqsave)();
+
+	ghcb =3D __sev_get_ghcb(&state);
+	vc_ghcb_invalidate(ghcb);
+
+	ghcb_set_rax(ghcb, SVM_VMGEXIT_SAVIC_SELF_GPA);
+	ghcb_set_rbx(ghcb, gpa);
+	res =3D sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_SAVIC,
+				  SVM_VMGEXIT_SAVIC_REGISTER_GPA, 0);
+
+	__sev_put_ghcb(&state);
+
+	return res;
+}
+
 static void snp_register_per_cpu_ghcb(void)
 {
 	struct sev_es_runtime_data *data;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 07ba493..44b4080 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -305,6 +305,7 @@ struct apic {
=20
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
+	void	(*setup)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
=20
 	void	(*init_apic_ldr)(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 0223696..9036122 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -533,6 +533,7 @@ int snp_svsm_vtpm_send_command(u8 *buffer);
=20
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
+enum es_result savic_register_gpa(u64 gpa);
=20
 static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 {
@@ -605,6 +606,7 @@ static inline int snp_send_guest_request(struct snp_msg_d=
esc *mdesc,
 static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
+static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPO=
RTED; }
=20
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
=20
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 9c640a5..650e325 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -118,6 +118,10 @@
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018
+#define SVM_VMGEXIT_SAVIC			0x8000001a
+#define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
+#define SVM_VMGEXIT_SAVIC_UNREGISTER_GPA	1
+#define SVM_VMGEXIT_SAVIC_SELF_GPA		~0ULL
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
 #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ff4029b..7874284 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1501,6 +1501,9 @@ static void setup_local_APIC(void)
 		return;
 	}
=20
+	if (apic->setup)
+		apic->setup();
+
 	/*
 	 * If this comes from kexec/kcrash the APIC might be enabled in
 	 * SPIV. Soft disable it before doing further initialization.
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index bea844f..948d894 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -8,17 +8,47 @@
  */
=20
 #include <linux/cc_platform.h>
+#include <linux/percpu-defs.h>
=20
 #include <asm/apic.h>
 #include <asm/sev.h>
=20
 #include "local.h"
=20
+struct secure_avic_page {
+	u8 regs[PAGE_SIZE];
+} __aligned(PAGE_SIZE);
+
+static struct secure_avic_page __percpu *savic_page __ro_after_init;
+
 static int savic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
 	return x2apic_enabled() && cc_platform_has(CC_ATTR_SNP_SECURE_AVIC);
 }
=20
+static void savic_setup(void)
+{
+	void *ap =3D this_cpu_ptr(savic_page);
+	enum es_result res;
+	unsigned long gpa;
+
+	gpa =3D __pa(ap);
+
+	/*
+	 * The NPT entry for a vCPU's APIC backing page must always be
+	 * present when the vCPU is running in order for Secure AVIC to
+	 * function. A VMEXIT_BUSY is returned on VMRUN and the vCPU cannot
+	 * be resumed if the NPT entry for the APIC backing page is not
+	 * present. Notify GPA of the vCPU's APIC backing page to the
+	 * hypervisor by calling savic_register_gpa(). Before executing
+	 * VMRUN, the hypervisor makes use of this information to make sure
+	 * the APIC backing page is mapped in NPT.
+	 */
+	res =3D savic_register_gpa(gpa);
+	if (res !=3D ES_OK)
+		snp_abort();
+}
+
 static int savic_probe(void)
 {
 	if (!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
@@ -30,6 +60,10 @@ static int savic_probe(void)
 		/* unreachable */
 	}
=20
+	savic_page =3D alloc_percpu(struct secure_avic_page);
+	if (!savic_page)
+		snp_abort();
+
 	return 1;
 }
=20
@@ -38,6 +72,7 @@ static struct apic apic_x2apic_savic __ro_after_init =3D {
 	.name				=3D "secure avic x2apic",
 	.probe				=3D savic_probe,
 	.acpi_madt_oem_check		=3D savic_acpi_madt_oem_check,
+	.setup				=3D savic_setup,
=20
 	.dest_mode_logical		=3D false,
=20

