Return-Path: <linux-tip-commits+bounces-6410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0314EB3FCC1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA23717CE78
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D192F83A0;
	Tue,  2 Sep 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oy0SoIIS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JLoNn9xN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9F2F6199;
	Tue,  2 Sep 2025 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809407; cv=none; b=mi1csGIx7GwAMWUwfjTxFUI4Wsbm99992QG0rBOId8N1C+b+nFclK10Mom+LggBn3uZtkjxzH3sgHU02fP23BCokxGBJXX2THk9ls1EeLULyfucDv3Se+tQBj1UoxkfYGGjksuXqZgckM96bazZGnd9c76KBzZWQjYHIYcjzPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809407; c=relaxed/simple;
	bh=cnWDCin1BPkNhI6qVY1RzxpvdZ18PpappIbqix0fSRg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GM+OO4f3E1jpKiGYJEAiO6AdxIAydlTE/M70eSgpwO5kd7hM0fNWRPkQZz+LOeP+to/0ivMMppXekCY/zPTl63x84pC4o7C1t2ROf3cRdvT7BIOFohZWG2lYmxbX/vwlowWSl1tcuddcR+HTTs1CS5RleHKnv32GYv2DCz+93+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oy0SoIIS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JLoNn9xN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+2CSMK+gkEn2S7+2SzN3LxxlR3Z1UfJ10wA1SJlsok=;
	b=oy0SoIISVG1LPeINAx8+StTL3Br1sqEvFCM4oUeYL3l9nbOUYPDtifceO1X7AwvRPBeQ7q
	d2mqH3vyvfGusRCN1qZI98occpMsQ7yIA/IhLlaeAW0j6EBPF7DpxGFQBYwjlvFbhm/urj
	fpkFtWdN54hZVW5er6SdpwApx6OhvwBeKEy1N4VmQ5pyjXAWWl/ySlt985Zmz8TISidmWF
	F6vi+iDMpppTRNSMhwqDALC7n9IJth0BxjOc1O+ORan4lDe/4UBBVP9ViUp3Wk/50WXD1M
	2ol63KwLBhZcwDPjnzScNeK0WpJXSGj/1vhivWTAN9Qm60PU0U0DKtxQW/ZZUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+2CSMK+gkEn2S7+2SzN3LxxlR3Z1UfJ10wA1SJlsok=;
	b=JLoNn9xNzqiuuvNB+++8wfBBPP1Ac40eoGgMAtaKvf0Z3H+ONeTmL/VGc2Mc5CuiDC0DJ2
	erQgsF+3PnjoeoDg==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Support LAPIC timer for Secure AVIC
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828110926.208866-1-Neeraj.Upadhyay@amd.com>
References: <20250828110926.208866-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680940312.1920.16586369951326903656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ea7d792e11e10f502933c39f3836cb73d35dac36
Gitweb:        https://git.kernel.org/tip/ea7d792e11e10f502933c39f3836cb73d35=
dac36
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:39:26 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 12:47:07 +02:00

x86/apic: Support LAPIC timer for Secure AVIC

Secure AVIC requires the LAPIC timer to be emulated by the hypervisor.  KVM
already supports emulating the LAPIC timer using hrtimers. In order to emulate
it, APIC_LVTT, APIC_TMICT and APIC_TDCR register values need to be propagated
to the hypervisor for arming the timer.  APIC_TMCCT register value has to be
read from the hypervisor, which is required for calibrating the APIC timer.
So, read/write all APIC timer registers from/to the hypervisor.

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828110926.208866-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/coco/sev/core.c            | 26 ++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h          |  2 ++
 arch/x86/kernel/apic/apic.c         |  2 ++
 arch/x86/kernel/apic/x2apic_savic.c |  7 +++++--
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index bb33fc2..da9fa9d 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1108,6 +1108,32 @@ int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd)
 	return 0;
 }
=20
+u64 savic_ghcb_msr_read(u32 reg)
+{
+	u64 msr =3D APIC_BASE_MSR + (reg >> 4);
+	struct pt_regs regs =3D { .cx =3D msr };
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
+	res =3D sev_es_ghcb_handle_msr(ghcb, &ctxt, false);
+	if (res !=3D ES_OK) {
+		pr_err("Secure AVIC MSR (0x%llx) read returned error (%d)\n", msr, res);
+		/* MSR read failures are treated as fatal errors */
+		snp_abort();
+	}
+
+	__sev_put_ghcb(&state);
+
+	return regs.ax | regs.dx << 32;
+}
+
 void savic_ghcb_msr_write(u32 reg, u64 value)
 {
 	u64 msr =3D APIC_BASE_MSR + (reg >> 4);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fa2864e..875c766 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -534,6 +534,7 @@ int snp_svsm_vtpm_send_command(u8 *buffer);
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 enum es_result savic_register_gpa(u64 gpa);
+u64 savic_ghcb_msr_read(u32 reg);
 void savic_ghcb_msr_write(u32 reg, u64 value);
=20
 static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
@@ -609,6 +610,7 @@ static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
 static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPO=
RTED; }
 static inline void savic_ghcb_msr_write(u32 reg, u64 value) { }
+static inline u64 savic_ghcb_msr_read(u32 reg) { return 0; }
=20
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
=20
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 7874284..db18810 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -592,6 +592,8 @@ static void setup_APIC_timer(void)
 						0xF, ~0UL);
 	} else
 		clockevents_register_device(levt);
+
+	apic_update_vector(smp_processor_id(), LOCAL_TIMER_VECTOR, true);
 }
=20
 /*
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index 47dfbf0..bdefe4c 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -67,6 +67,7 @@ static u32 savic_read(u32 reg)
 	case APIC_TMICT:
 	case APIC_TMCCT:
 	case APIC_TDCR:
+		return savic_ghcb_msr_read(reg);
 	case APIC_ID:
 	case APIC_LVR:
 	case APIC_TASKPRI:
@@ -194,10 +195,12 @@ static void savic_write(u32 reg, u32 data)
=20
 	switch (reg) {
 	case APIC_LVTT:
-	case APIC_LVT0:
-	case APIC_LVT1:
 	case APIC_TMICT:
 	case APIC_TDCR:
+		savic_ghcb_msr_write(reg, data);
+		break;
+	case APIC_LVT0:
+	case APIC_LVT1:
 	case APIC_TASKPRI:
 	case APIC_EOI:
 	case APIC_SPIV:

