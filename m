Return-Path: <linux-tip-commits+bounces-6471-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C0B439E7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA897C26A0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E6430276C;
	Thu,  4 Sep 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZbNEoZ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h24Kdk02"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D2301025;
	Thu,  4 Sep 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984865; cv=none; b=Nmvmd0t1pKLpq8/6/A8vOZpcOt9j/8BIakWGcoHTQHFWpoRTV9lvCOASf58IZzp42fP69U/az5YS9raPHd4GG8MYq2deq7zr9omi9wqQRCcN5yV8sJrf7HSAqDRxUxS1Yve4sgRGiNl85ftnbJDHsBBnVVvDR6dvkeePyzzuOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984865; c=relaxed/simple;
	bh=hdQ17Lcl5tgZxrgMzcb2RubKMVQWGuB6lTYQTHl+snk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l0izT9feDk4oc/y2QU2X6zkhEotYsBVF5/eNpQHw+dQezmc8rp5XXFwaYiRgaCR9v5Dxtv7QG3CJ7DkZKvrEvN6jDxlFozuWQm40wFsNU1iUaW8WS+3JdU2DaYsqKVoivyU0tHvvNlwdqJo+TvY6MpwOdWCMWFXePeRiJs61DNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZbNEoZ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h24Kdk02; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/Wbdy2mXf3Yqxez0PxkGzh0TZzvq36Y6dQ9dyW762Y=;
	b=OZbNEoZ3UL0jzkJUofvixIVxGMgBRF7BvN1D8VR1/IDPnR8fGhQMBCkzIcsGS+4+1z6ckp
	ymnpvxMKmltUCLmp3U23m82Y+sgx/xv5VdASQQZNhQCzIFE8Jc6J9FGzkdZYsuoPJAaJRL
	wjbo1heiZC2f2Oc0VOna7Y0nkk9sg3v/XC45ljNcOQIicqS3hBxDv6+YBunTkO4jltuunc
	VoWjipszkY9PVtgrHUcP5QUkjgB2cPoid/hy/Tv0BuyJD9fQ/V2P8aB23yGYUxsekiJDIh
	qCjHovwlzyrRsMGhKCW2F+VBinwcb3peQWk58lMMNsBwPPCZDCQxcLRpZQHp1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/Wbdy2mXf3Yqxez0PxkGzh0TZzvq36Y6dQ9dyW762Y=;
	b=h24Kdk02aTDGYR9GLPq/6Eet8iHja4uP6TNFqTYiy4oZWuqPCk8zz/2J2zIIqAbjO31lVJ
	ICdI2m8fkbDtcJDw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Use boot SVSM CA for all startup and init code
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-33-ardb+git@google.com>
References: <20250828102202.1849035-33-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698486066.1920.15634881027010378997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c54604fb7f2522fec5b97e86103ec49e539e80fe
Gitweb:        https://git.kernel.org/tip/c54604fb7f2522fec5b97e86103ec49e539=
e80fe
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:12 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:58:26 +02:00

x86/sev: Use boot SVSM CA for all startup and init code

To avoid having to reason about whether or not to use the per-CPU SVSM calling
area when running startup and init code on the boot CPU, reuse the boot SVSM
calling area as the per-CPU area for the BSP.

Thus, remove the need to make the per-CPU variables and associated state in
sev_cfg accessible to the startup code once confined.

  [ bp: Massage commit message. ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-33-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c      | 13 +--------
 arch/x86/boot/startup/sev-startup.c | 11 +++----
 arch/x86/coco/sev/core.c            | 47 +++++++++++++---------------
 arch/x86/include/asm/sev-internal.h | 16 +----------
 4 files changed, 28 insertions(+), 59 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 0e56741..4873469 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -37,19 +37,6 @@ struct ghcb *boot_ghcb;
=20
 #define __BOOT_COMPRESSED
=20
-extern u64 boot_svsm_caa_pa;
-
-struct svsm_ca *svsm_get_caa(void)
-{
-	/* The decompressor is mapped 1:1 so VA =3D=3D PA */
-	return (struct svsm_ca *)boot_svsm_caa_pa;
-}
-
-u64 svsm_get_caa_pa(void)
-{
-	return boot_svsm_caa_pa;
-}
-
 u8 snp_vmpl;
=20
 /* Include code for early handlers */
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 8009a37..b0fc63f 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -50,9 +50,6 @@ u64 sev_secrets_pa __ro_after_init;
 /* For early boot SVSM communication */
 struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
=20
-DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
-DEFINE_PER_CPU(u64, svsm_caa_pa);
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -153,7 +150,9 @@ void __head early_snp_set_memory_private(unsigned long va=
ddr, unsigned long padd
 					 unsigned long npages)
 {
 	struct psc_desc d =3D {
-		SNP_PAGE_STATE_PRIVATE, svsm_get_caa(), svsm_get_caa_pa()
+		SNP_PAGE_STATE_PRIVATE,
+		rip_rel_ptr(&boot_svsm_ca_page),
+		boot_svsm_caa_pa
 	};
=20
 	/*
@@ -176,7 +175,9 @@ void __head early_snp_set_memory_shared(unsigned long vad=
dr, unsigned long paddr
 					unsigned long npages)
 {
 	struct psc_desc d =3D {
-		SNP_PAGE_STATE_SHARED, svsm_get_caa(), svsm_get_caa_pa()
+		SNP_PAGE_STATE_SHARED,
+		rip_rel_ptr(&boot_svsm_ca_page),
+		boot_svsm_caa_pa
 	};
=20
 	/*
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index a833b2b..9782ebe 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -46,6 +46,25 @@
 #include <asm/cmdline.h>
 #include <asm/msr.h>
=20
+DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+DEFINE_PER_CPU(u64, svsm_caa_pa);
+
+static inline struct svsm_ca *svsm_get_caa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa);
+	else
+		return rip_rel_ptr(&boot_svsm_ca_page);
+}
+
+static inline u64 svsm_get_caa_pa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa_pa);
+	else
+		return boot_svsm_caa_pa;
+}
+
 /* AP INIT values as documented in the APM2  section "Processor Initializati=
on State" */
 #define AP_INIT_CS_LIMIT		0xffff
 #define AP_INIT_DS_LIMIT		0xffff
@@ -1312,7 +1331,8 @@ static void __init alloc_runtime_data(int cpu)
 		struct svsm_ca *caa;
=20
 		/* Allocate the SVSM CA page if an SVSM is present */
-		caa =3D memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE);
+		caa =3D cpu ? memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE)
+			  : &boot_svsm_ca_page;
=20
 		per_cpu(svsm_caa, cpu) =3D caa;
 		per_cpu(svsm_caa_pa, cpu) =3D __pa(caa);
@@ -1366,32 +1386,9 @@ void __init sev_es_init_vc_handling(void)
 		init_ghcb(cpu);
 	}
=20
-	/* If running under an SVSM, switch to the per-cpu CA */
-	if (snp_vmpl) {
-		struct svsm_call call =3D {};
-		unsigned long flags;
-		int ret;
-
-		local_irq_save(flags);
-
-		/*
-		 * SVSM_CORE_REMAP_CA call:
-		 *   RAX =3D 0 (Protocol=3D0, CallID=3D0)
-		 *   RCX =3D New CA GPA
-		 */
-		call.caa =3D svsm_get_caa();
-		call.rax =3D SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
-		call.rcx =3D this_cpu_read(svsm_caa_pa);
-		ret =3D svsm_perform_call_protocol(&call);
-		if (ret)
-			panic("Can't remap the SVSM CA, ret=3D%d, rax_out=3D0x%llx\n",
-			      ret, call.rax_out);
-
+	if (snp_vmpl)
 		sev_cfg.use_cas =3D true;
=20
-		local_irq_restore(flags);
-	}
-
 	sev_es_setup_play_dead();
=20
 	/* Secondary CPUs use the runtime #VC handler */
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-i=
nternal.h
index 9ff8245..f98f080 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -62,22 +62,6 @@ DECLARE_PER_CPU(u64, svsm_caa_pa);
=20
 extern u64 boot_svsm_caa_pa;
=20
-static __always_inline struct svsm_ca *svsm_get_caa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa);
-	else
-		return rip_rel_ptr(&boot_svsm_ca_page);
-}
-
-static __always_inline u64 svsm_get_caa_pa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa_pa);
-	else
-		return boot_svsm_caa_pa;
-}
-
 enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *c=
txt);
 void vc_forward_exception(struct es_em_ctxt *ctxt);
=20

