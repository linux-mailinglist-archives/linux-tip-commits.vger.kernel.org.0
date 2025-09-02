Return-Path: <linux-tip-commits+bounces-6403-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F13CB3FCB6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B254E38BD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18472F3C1F;
	Tue,  2 Sep 2025 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJAUTbrs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6/VMtaVV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D02ED846;
	Tue,  2 Sep 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809399; cv=none; b=LkcsVik42zvnuLj3bqQqv/s4rGA2kaXo3yTnwbuRmbC/FRMZHkNxdf8mFKwGKz73zqpo+6clDo+5G5gKeiUiJDPgugBxqdRNDIpUT4SgjJq+DYqz5X3+159hqcQmv5WVB7CWi+qfK9xhye/LY66y+YM8Hbo3fYTLtI5LPfDShdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809399; c=relaxed/simple;
	bh=D9+SdiaxeQm3k7ZHxrQldN6YHiM7ftYRG2TAaa7eSPw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dS4VvV0waG30qVDH1OOkPFOZrlhfvUw8ugoZdAL0vAe09l1xKlfIOvfpIKwmqYDDIBi1wfHaOt+w7DlpOKY5ecZ6Eq/OiMwg194alaZ9/njLIwBzO1NwT9ZNxcSahK/0LNz2HYNkV15FMGVGGMKKihC3cxUVm0FR9ajRsbdRApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJAUTbrs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6/VMtaVV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuYJ5YKSHeoRYSR+BPwlReMcoIvl2EmIgwowVG0UNcc=;
	b=jJAUTbrs5xGVoI3/XhgPbmZyO/s7nG4Olt7e7+JAqyuoy8TaP6OlX4m+5qx8OM4pks0dW3
	W6EeAMjsU3571bsFQ7f/B6baw7GLrsNrXa+1Cf2lyuYrYzQWupZilMy7D4XxaTIwusN3w7
	x5V1TXl1QvIx0jYtlSP3pOLcF7afu/9aHCrJro8Yr/nWDgWZjMiZWrzvvJzVMCR7cxu3xr
	8djAEV7XDb27NBCuwYOB0Dg8ULHOVMW1MRmx5/vmiudw4fHXcv4wmTlczo7MbwFa1UEWTr
	KsW4vLdzakmPoZNRYcldHWhtn63UypiV5pq3uNiSWROSSLjw/kBPhEaytxGCbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuYJ5YKSHeoRYSR+BPwlReMcoIvl2EmIgwowVG0UNcc=;
	b=6/VMtaVVEBw5hiNWN+/cGuQJrxyOTo1fdSPyTTi5x+ArkyUh+GdUgvxMEPR+Ve0oKfnHtq
	lOXiv2UOY9yGpJCg==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Add kexec support for Secure AVIC
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250828112008.209013-1-Neeraj.Upadhyay@amd.com>
References: <20250828112008.209013-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680939487.1920.9058886504765322524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c8018325dd3e7c75c19b1e9263c358c4c96214f9
Gitweb:        https://git.kernel.org/tip/c8018325dd3e7c75c19b1e9263c358c4c96=
214f9
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:50:08 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 13:06:08 +02:00

x86/apic: Add kexec support for Secure AVIC

Add a apic->teardown() callback to disable Secure AVIC before rebooting into
the new kernel. This ensures that the new kernel does not access the old APIC
backing page which was allocated by the previous kernel.

Such accesses can happen if there are any APIC accesses done during the guest
boot before Secure AVIC driver probe is done by the new kernel (as Secure AVIC
would have remained enabled in the Secure AVIC control MSR).

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828112008.209013-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/coco/sev/core.c            | 23 +++++++++++++++++++++++
 arch/x86/include/asm/apic.h         |  1 +
 arch/x86/include/asm/sev.h          |  2 ++
 arch/x86/kernel/apic/apic.c         |  3 +++
 arch/x86/kernel/apic/x2apic_savic.c |  8 ++++++++
 5 files changed, 37 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index e474061..b64f430 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1187,6 +1187,29 @@ enum es_result savic_register_gpa(u64 gpa)
 	return res;
 }
=20
+enum es_result savic_unregister_gpa(u64 *gpa)
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
+	res =3D sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_SAVIC,
+				  SVM_VMGEXIT_SAVIC_UNREGISTER_GPA, 0);
+	if (gpa && res =3D=3D ES_OK)
+		*gpa =3D ghcb->save.rbx;
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
index 0683318..a26e66d 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -306,6 +306,7 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	void	(*setup)(void);
+	void	(*teardown)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
=20
 	void	(*init_apic_ldr)(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 875c766..46915dd 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -534,6 +534,7 @@ int snp_svsm_vtpm_send_command(u8 *buffer);
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 enum es_result savic_register_gpa(u64 gpa);
+enum es_result savic_unregister_gpa(u64 *gpa);
 u64 savic_ghcb_msr_read(u32 reg);
 void savic_ghcb_msr_write(u32 reg, u64 value);
=20
@@ -609,6 +610,7 @@ static inline int snp_svsm_vtpm_send_command(u8 *buffer) =
{ return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
 static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPO=
RTED; }
+static inline enum es_result savic_unregister_gpa(u64 *gpa) { return ES_UNSU=
PPORTED; }
 static inline void savic_ghcb_msr_write(u32 reg, u64 value) { }
 static inline u64 savic_ghcb_msr_read(u32 reg) { return 0; }
=20
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index db18810..680d305 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1170,6 +1170,9 @@ void disable_local_APIC(void)
 	if (!apic_accessible())
 		return;
=20
+	if (apic->teardown)
+		apic->teardown();
+
 	apic_soft_disable();
=20
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index d76faea..36e6d0d 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -330,6 +330,13 @@ static void savic_eoi(void)
 	}
 }
=20
+static void savic_teardown(void)
+{
+	/* Disable Secure AVIC */
+	native_wrmsrq(MSR_AMD64_SAVIC_CONTROL, 0);
+	savic_unregister_gpa(NULL);
+}
+
 static void savic_setup(void)
 {
 	void *ap =3D this_cpu_ptr(savic_page);
@@ -385,6 +392,7 @@ static struct apic apic_x2apic_savic __ro_after_init =3D {
 	.probe				=3D savic_probe,
 	.acpi_madt_oem_check		=3D savic_acpi_madt_oem_check,
 	.setup				=3D savic_setup,
+	.teardown			=3D savic_teardown,
=20
 	.dest_mode_logical		=3D false,
=20

