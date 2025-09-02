Return-Path: <linux-tip-commits+bounces-6412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DFB3FCCD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD54E4BE0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A72F8BF9;
	Tue,  2 Sep 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fKy7ulBT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3Prs9qy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE352F90C5;
	Tue,  2 Sep 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809410; cv=none; b=ZRl1cnWwVBca0BGjezKUUfDtDvPT2NoMvlw1Sjc6lnjir/Qo50TwC3ydXHrxFASwOH7LY9FqDPmhm2PdV05wTTA4E2LvABil59XUgO54yVd0k5+jAPKMqxrRyw4iEJ0UtH3bb6xZW8qqHQpPpG533jEqQWBOpV2h39BMy4mfS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809410; c=relaxed/simple;
	bh=VhPSinWoi1QU7xzNbDwasXedVphV2HOIlmQ9wALa6Lo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h+aXDsKyOGYX6IqrDc2Dl+Suot2UhrC/CDyDFvnxYCU2C3yHWiGC8w3aDEW7xhkiuB9ZoG3KwChfP9ccTAJrk9aB3RY2hj349t6+/yMxuEss3rigitXX0TmCqoQDLQiH5r19Z3az1cHWw0qwYAIji5E4jrnweWXThzthUvXeGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fKy7ulBT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3Prs9qy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/olEYmczeGGn8j5ybKrR0cdIOMJfRrrFLlEGOpvn9F4=;
	b=fKy7ulBT+FApVfoLtq6Q4AavO0B5oSpI18d3EII+Mi4nkR0LdRj1GnIvL/YEWbAtc/zcgS
	fr67WkFBXWdZa6iNB3E4uehhBLNCKlX01FhujNwTjJUuIgyXGe7Nd1ad+rOckoArOugCZy
	dpFvTd3QpV9/IDEdB7fCAppCBRIf5HnOOy1/k2vrek/pSTTbGrRpyLMav6FWHKX9ShbPYh
	ylZLAZSFvcPLOPIjqTNipWo0VQUbt1O7mmH2ElPxxb7fl/pyIkw2XIx4XU7y88W5/M+TA5
	nQRRgqVtN32b2YBt0UFzzdIPTvQ2EGLQjZJlXCmcZDYcPlnnc+zryNFA3w0XqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/olEYmczeGGn8j5ybKrR0cdIOMJfRrrFLlEGOpvn9F4=;
	b=q3Prs9qyts9LjDZMBRZEcXeEOVJjAWquxBLBC8D9kK4bfXqvsjqPvzGPPWTqYwTqD6u1Nl
	aO/TMFOaR1/A/qDw==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Add support to send IPI for Secure AVIC
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828110824.208851-1-Neeraj.Upadhyay@amd.com>
References: <20250828110824.208851-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680940421.1920.5918401836718884054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2c6978ea1a85603fe7d401f7bb3a1fbcab21fde2
Gitweb:        https://git.kernel.org/tip/2c6978ea1a85603fe7d401f7bb3a1fbcab2=
1fde2
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:38:24 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 12:45:18 +02:00

x86/apic: Add support to send IPI for Secure AVIC

Secure AVIC hardware accelerates only Self-IPI, i.e. on WRMSR to APIC_SELF_IPI
and APIC_ICR (with destination shorthand equal to Self) registers, hardware
takes care of updating the APIC_IRR in the APIC backing page of the vCPU.

For other IPI types (cross-vCPU, broadcast IPIs), software needs to take care
of updating the APIC_IRR state of the target vCPUs and to ensure that the
target vCPUs notice the new pending interrupt.

Add new callbacks in the Secure AVIC driver for sending IPI requests.  These
callbacks update the IRR in the target guest vCPU's APIC backing page. To
ensure that the remote vCPU notices the new pending interrupt, reuse the GHCB
MSR handling code in vc_handle_msr() to issue APIC_ICR MSR-write GHCB protocol
event to the hypervisor.

For Secure AVIC guests, on APIC_ICR write MSR exits, the hypervisor notifies
the target vCPU by either sending an AVIC doorbell (if target vCPU is running)
or by waking up the non-running target vCPU.

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828110824.208851-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/coco/sev/core.c            |  28 +++++-
 arch/x86/coco/sev/vc-handle.c       |  11 +-
 arch/x86/include/asm/sev-internal.h |   2 +-
 arch/x86/include/asm/sev.h          |   2 +-
 arch/x86/kernel/apic/x2apic_savic.c | 138 ++++++++++++++++++++++++++-
 5 files changed, 173 insertions(+), 8 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 7669aaf..bb33fc2 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1108,6 +1108,34 @@ int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd)
 	return 0;
 }
=20
+void savic_ghcb_msr_write(u32 reg, u64 value)
+{
+	u64 msr =3D APIC_BASE_MSR + (reg >> 4);
+	struct pt_regs regs =3D {
+		.cx =3D msr,
+		.ax =3D lower_32_bits(value),
+		.dx =3D upper_32_bits(value)
+	};
+	struct es_em_ctxt ctxt =3D { .regs =3D &regs };
+	struct ghcb_state state;
+	enum es_result res;
+	struct ghcb *ghcb;
+
+	guard(irqsave)();
+
+	ghcb =3D __sev_get_ghcb(&state);
+	vc_ghcb_invalidate(ghcb);
+
+	res =3D sev_es_ghcb_handle_msr(ghcb, &ctxt, true);
+	if (res !=3D ES_OK) {
+		pr_err("Secure AVIC MSR (0x%llx) write returned error (%d)\n", msr, res);
+		/* MSR writes should never fail. Any failure is fatal error for SNP guest =
*/
+		snp_abort();
+	}
+
+	__sev_put_ghcb(&state);
+}
+
 enum es_result savic_register_gpa(u64 gpa)
 {
 	struct ghcb_state state;
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index c3b4acb..c1aa10c 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -402,14 +402,10 @@ static enum es_result __vc_handle_secure_tsc_msrs(struc=
t es_em_ctxt *ctxt, bool=20
 	return ES_OK;
 }
=20
-static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ct=
xt)
+enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *=
ctxt, bool write)
 {
 	struct pt_regs *regs =3D ctxt->regs;
 	enum es_result ret;
-	bool write;
-
-	/* Is it a WRMSR? */
-	write =3D ctxt->insn.opcode.bytes[1] =3D=3D 0x30;
=20
 	switch (regs->cx) {
 	case MSR_SVSM_CAA:
@@ -439,6 +435,11 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, s=
truct es_em_ctxt *ctxt)
 	return ret;
 }
=20
+static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ct=
xt)
+{
+	return sev_es_ghcb_handle_msr(ghcb, ctxt, ctxt->insn.opcode.bytes[1] =3D=3D=
 0x30);
+}
+
 static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
 {
 	int trapnr =3D ctxt->fi.vector;
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-i=
nternal.h
index 3dfd306..6876655 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -97,6 +97,8 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
 }
=20
+enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *=
ctxt, bool write);
+
 void snp_register_ghcb_early(unsigned long paddr);
 bool sev_es_negotiate_protocol(void);
 bool sev_es_check_cpu_features(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9036122..fa2864e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -534,6 +534,7 @@ int snp_svsm_vtpm_send_command(u8 *buffer);
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 enum es_result savic_register_gpa(u64 gpa);
+void savic_ghcb_msr_write(u32 reg, u64 value);
=20
 static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 {
@@ -607,6 +608,7 @@ static inline int snp_svsm_vtpm_send_command(u8 *buffer) =
{ return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
 static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPO=
RTED; }
+static inline void savic_ghcb_msr_write(u32 reg, u64 value) { }
=20
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
=20
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index 942d3aa..47dfbf0 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/cc_platform.h>
+#include <linux/cpumask.h>
 #include <linux/percpu-defs.h>
 #include <linux/align.h>
=20
@@ -120,6 +121,73 @@ static u32 savic_read(u32 reg)
=20
 #define SAVIC_NMI_REQ		0x278
=20
+/*
+ * On WRMSR to APIC_SELF_IPI register by the guest, Secure AVIC hardware
+ * updates the APIC_IRR in the APIC backing page of the vCPU. In addition,
+ * hardware evaluates the new APIC_IRR update for interrupt injection to
+ * the vCPU. So, self IPIs are hardware-accelerated.
+ */
+static inline void self_ipi_reg_write(unsigned int vector)
+{
+	native_apic_msr_write(APIC_SELF_IPI, vector);
+}
+
+static void send_ipi_dest(unsigned int cpu, unsigned int vector)
+{
+	update_vector(cpu, APIC_IRR, vector, true);
+}
+
+static void send_ipi_allbut(unsigned int vector)
+{
+	unsigned int cpu, src_cpu;
+
+	guard(irqsave)();
+
+	src_cpu =3D raw_smp_processor_id();
+
+	for_each_cpu(cpu, cpu_online_mask) {
+		if (cpu =3D=3D src_cpu)
+			continue;
+		send_ipi_dest(cpu, vector);
+	}
+}
+
+static inline void self_ipi(unsigned int vector)
+{
+	u32 icr_low =3D APIC_SELF_IPI | vector;
+
+	native_x2apic_icr_write(icr_low, 0);
+}
+
+static void savic_icr_write(u32 icr_low, u32 icr_high)
+{
+	unsigned int dsh, vector;
+	u64 icr_data;
+
+	dsh =3D icr_low & APIC_DEST_ALLBUT;
+	vector =3D icr_low & APIC_VECTOR_MASK;
+
+	switch (dsh) {
+	case APIC_DEST_SELF:
+		self_ipi(vector);
+		break;
+	case APIC_DEST_ALLINC:
+		self_ipi(vector);
+		fallthrough;
+	case APIC_DEST_ALLBUT:
+		send_ipi_allbut(vector);
+		break;
+	default:
+		send_ipi_dest(icr_high, vector);
+		break;
+	}
+
+	icr_data =3D ((u64)icr_high) << 32 | icr_low;
+	if (dsh !=3D APIC_DEST_SELF)
+		savic_ghcb_msr_write(APIC_ICR, icr_data);
+	apic_set_reg64(this_cpu_ptr(savic_page), APIC_ICR, icr_data);
+}
+
 static void savic_write(u32 reg, u32 data)
 {
 	void *ap =3D this_cpu_ptr(savic_page);
@@ -130,7 +198,6 @@ static void savic_write(u32 reg, u32 data)
 	case APIC_LVT1:
 	case APIC_TMICT:
 	case APIC_TDCR:
-	case APIC_SELF_IPI:
 	case APIC_TASKPRI:
 	case APIC_EOI:
 	case APIC_SPIV:
@@ -146,7 +213,10 @@ static void savic_write(u32 reg, u32 data)
 		apic_set_reg(ap, reg, data);
 		break;
 	case APIC_ICR:
-		apic_set_reg64(ap, reg, (u64)data);
+		savic_icr_write(data, 0);
+		break;
+	case APIC_SELF_IPI:
+		self_ipi_reg_write(data);
 		break;
 	/* ALLOWED_IRR offsets are writable */
 	case SAVIC_ALLOWED_IRR ... SAVIC_ALLOWED_IRR + 0x70:
@@ -160,6 +230,61 @@ static void savic_write(u32 reg, u32 data)
 	}
 }
=20
+static void send_ipi(u32 dest, unsigned int vector, unsigned int dsh)
+{
+	unsigned int icr_low;
+
+	icr_low =3D __prepare_ICR(dsh, vector, APIC_DEST_PHYSICAL);
+	savic_icr_write(icr_low, dest);
+}
+
+static void savic_send_ipi(int cpu, int vector)
+{
+	u32 dest =3D per_cpu(x86_cpu_to_apicid, cpu);
+
+	send_ipi(dest, vector, 0);
+}
+
+static void send_ipi_mask(const struct cpumask *mask, unsigned int vector, b=
ool excl_self)
+{
+	unsigned int cpu, this_cpu;
+
+	guard(irqsave)();
+
+	this_cpu =3D raw_smp_processor_id();
+
+	for_each_cpu(cpu, mask) {
+		if (excl_self && cpu =3D=3D this_cpu)
+			continue;
+		send_ipi(per_cpu(x86_cpu_to_apicid, cpu), vector, 0);
+	}
+}
+
+static void savic_send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	send_ipi_mask(mask, vector, false);
+}
+
+static void savic_send_ipi_mask_allbutself(const struct cpumask *mask, int v=
ector)
+{
+	send_ipi_mask(mask, vector, true);
+}
+
+static void savic_send_ipi_allbutself(int vector)
+{
+	send_ipi(0, vector, APIC_DEST_ALLBUT);
+}
+
+static void savic_send_ipi_all(int vector)
+{
+	send_ipi(0, vector, APIC_DEST_ALLINC);
+}
+
+static void savic_send_ipi_self(int vector)
+{
+	self_ipi_reg_write(vector);
+}
+
 static void savic_update_vector(unsigned int cpu, unsigned int vector, bool =
set)
 {
 	update_vector(cpu, SAVIC_ALLOWED_IRR, vector, set);
@@ -231,13 +356,20 @@ static struct apic apic_x2apic_savic __ro_after_init =
=3D {
=20
 	.calc_dest_apicid		=3D apic_default_calc_apicid,
=20
+	.send_IPI			=3D savic_send_ipi,
+	.send_IPI_mask			=3D savic_send_ipi_mask,
+	.send_IPI_mask_allbutself	=3D savic_send_ipi_mask_allbutself,
+	.send_IPI_allbutself		=3D savic_send_ipi_allbutself,
+	.send_IPI_all			=3D savic_send_ipi_all,
+	.send_IPI_self			=3D savic_send_ipi_self,
+
 	.nmi_to_offline_cpu		=3D true,
=20
 	.read				=3D savic_read,
 	.write				=3D savic_write,
 	.eoi				=3D native_apic_msr_eoi,
 	.icr_read			=3D native_x2apic_icr_read,
-	.icr_write			=3D native_x2apic_icr_write,
+	.icr_write			=3D savic_icr_write,
=20
 	.update_vector			=3D savic_update_vector,
 };

