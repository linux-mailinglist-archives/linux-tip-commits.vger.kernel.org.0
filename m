Return-Path: <linux-tip-commits+bounces-7777-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD785CEBF79
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Dec 2025 13:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B20B3037501
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Dec 2025 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0D232863C;
	Wed, 31 Dec 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H0BYAjue";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9U8r+8cY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F6327C0F;
	Wed, 31 Dec 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183945; cv=none; b=tMDW03k0evxdhS7EDxGkwRkwi81ELoErbUdVz9LGIvi3edIJhr8w5kLwENppJOeJDQBUsarlaxCqyosr5VbjgA8lzTx1A1ONbHGhEBPhZYOr7jcN1LyTvmmUrwXnta36L9WRnRvYFiHK4WR/JdqUKGPJ/qGiGTsVM01s6YZmmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183945; c=relaxed/simple;
	bh=dPx+P12JFPvM+2Na2njThJICBrodFtF0oKRRmI1Wwlw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uayq01CYguZipCpKwT2cY9LTLoJbjZuxP0xUCk4L6cePGUCggm7zvvD9l9tB9p6u1yRaqiSpjTfr6iMhzt514A4zO4JgZav3jHq9F7IRhx4gs0w65xEECCbr3g5jWdqtIvZPxd8mj9/+eGafvNjGk5ufAkRdFCMIZyHNM19R2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H0BYAjue; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9U8r+8cY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Dec 2025 12:25:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767183934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcoFnXejKdDnaAIVHX/SIxUhl7ff+ulJqhx/FyEVynA=;
	b=H0BYAjueuI5t7UFtRHMEGU6aj2C6JfqWdsQoF6CvuiFdGhfVqbaTHgDOh8/HoNJBm9TMqQ
	o6n84ueYdAPrXYejMNrmsP6eO+5SsmmJIXmvMUttq0Ny4H9EDqztvAmXwoRYN3/GnrEfuk
	aV8/TgquXBedEIKQ8Zai3mbNvJhzXlHZV//eQG/v0OwhlyrZo/WbJ1ArRZyiYzom7rBChM
	gw/gHdp4KVYYiSbH1RUZj2q36nHf9JBl2Io5eu9WZEjgNUe8Zrgo1sIaWnFJYGnvVEVZAh
	bGkEcozI0xAa4IPQA6F2E910wwP46Mr6zI4m719l+wVnRRloCA4wBA8D8U0jww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767183934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcoFnXejKdDnaAIVHX/SIxUhl7ff+ulJqhx/FyEVynA=;
	b=9U8r+8cY+9oTLjezcgK9HtkicH+AOvHLkZyQc6dcRfLV7IvtxCj8cOjPz3xMJzeaQEtekx
	rdOuEFh8NPZJrmDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Carve out the SVSM code into a separate
 compilation unit
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251204124809.31783-4-bp@kernel.org>
References: <20251204124809.31783-4-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176718393016.510.1404017986821087235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e21279b73ef6c7d27237912c914f2db0c5a74786
Gitweb:        https://git.kernel.org/tip/e21279b73ef6c7d27237912c914f2db0c5a=
74786
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 04 Dec 2025 13:48:08 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Dec 2025 13:18:23 +01:00

x86/sev: Carve out the SVSM code into a separate compilation unit

Move the SVSM-related machinery into a separate compilation unit in
order to keep sev/core.c slim and "on-topic".

No functional changes.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251204124809.31783-4-bp@kernel.org
---
 arch/x86/coco/sev/Makefile   |   2 +-
 arch/x86/coco/sev/core.c     | 377 +----------------------------------
 arch/x86/coco/sev/internal.h |  29 +++-
 arch/x86/coco/sev/svsm.c     | 362 +++++++++++++++++++++++++++++++++-
 4 files changed, 392 insertions(+), 378 deletions(-)
 create mode 100644 arch/x86/coco/sev/svsm.c

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 3b8ae21..fb8ffed 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-obj-y +=3D core.o noinstr.o vc-handle.o
+obj-y +=3D core.o noinstr.o vc-handle.o svsm.o
=20
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlini=
ng
 UBSAN_SANITIZE_noinstr.o	:=3D n
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 4e618e5..379e0c0 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -55,40 +55,6 @@ SYM_PIC_ALIAS(sev_hv_features);
 u64 sev_secrets_pa __ro_after_init;
 SYM_PIC_ALIAS(sev_secrets_pa);
=20
-/* For early boot SVSM communication */
-struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
-SYM_PIC_ALIAS(boot_svsm_ca_page);
-
-/*
- * SVSM related information:
- *   During boot, the page tables are set up as identity mapped and later
- *   changed to use kernel virtual addresses. Maintain separate virtual and
- *   physical addresses for the CAA to allow SVSM functions to be used during
- *   early boot, both with identity mapped virtual addresses and proper kern=
el
- *   virtual addresses.
- */
-u64 boot_svsm_caa_pa __ro_after_init;
-SYM_PIC_ALIAS(boot_svsm_caa_pa);
-
-DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
-DEFINE_PER_CPU(u64, svsm_caa_pa);
-
-static inline struct svsm_ca *svsm_get_caa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa);
-	else
-		return rip_rel_ptr(&boot_svsm_ca_page);
-}
-
-static inline u64 svsm_get_caa_pa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa_pa);
-	else
-		return boot_svsm_caa_pa;
-}
-
 /* AP INIT values as documented in the APM2  section "Processor Initializati=
on State" */
 #define AP_INIT_CS_LIMIT		0xffff
 #define AP_INIT_DS_LIMIT		0xffff
@@ -218,95 +184,6 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
=20
-static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *c=
all)
-{
-	struct es_em_ctxt ctxt;
-	u8 pending =3D 0;
-
-	vc_ghcb_invalidate(ghcb);
-
-	/*
-	 * Fill in protocol and format specifiers. This can be called very early
-	 * in the boot, so use rip-relative references as needed.
-	 */
-	ghcb->protocol_version =3D ghcb_version;
-	ghcb->ghcb_usage       =3D GHCB_DEFAULT_USAGE;
-
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
-	ghcb_set_sw_exit_info_1(ghcb, 0);
-	ghcb_set_sw_exit_info_2(ghcb, 0);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-
-	svsm_issue_call(call, &pending);
-
-	if (pending)
-		return -EINVAL;
-
-	switch (verify_exception_info(ghcb, &ctxt)) {
-	case ES_OK:
-		break;
-	case ES_EXCEPTION:
-		vc_forward_exception(&ctxt);
-		fallthrough;
-	default:
-		return -EINVAL;
-	}
-
-	return svsm_process_result_codes(call);
-}
-
-static int svsm_perform_call_protocol(struct svsm_call *call)
-{
-	struct ghcb_state state;
-	unsigned long flags;
-	struct ghcb *ghcb;
-	int ret;
-
-	flags =3D native_local_irq_save();
-
-	if (sev_cfg.ghcbs_initialized)
-		ghcb =3D __sev_get_ghcb(&state);
-	else if (boot_ghcb)
-		ghcb =3D boot_ghcb;
-	else
-		ghcb =3D NULL;
-
-	do {
-		ret =3D ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : __pi_svsm_perform_msr_protocol(call);
-	} while (ret =3D=3D -EAGAIN);
-
-	if (sev_cfg.ghcbs_initialized)
-		__sev_put_ghcb(&state);
-
-	native_local_irq_restore(flags);
-
-	return ret;
-}
-
-static inline void __pval_terminate(u64 pfn, bool action, unsigned int page_=
size,
-				    int ret, u64 svsm_ret)
-{
-	WARN(1, "PVALIDATE failure: pfn: 0x%llx, action: %u, size: %u, ret: %d, svs=
m_ret: 0x%llx\n",
-	     pfn, action, page_size, ret, svsm_ret);
-
-	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
-}
-
-static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64=
 svsm_ret)
-{
-	unsigned int page_size;
-	bool action;
-	u64 pfn;
-
-	pfn =3D pc->entry[pc->cur_index].pfn;
-	action =3D pc->entry[pc->cur_index].action;
-	page_size =3D pc->entry[pc->cur_index].page_size;
-
-	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
-}
-
 static void pval_pages(struct snp_psc_desc *desc)
 {
 	struct psc_entry *e;
@@ -343,152 +220,6 @@ static void pval_pages(struct snp_psc_desc *desc)
 	}
 }
=20
-static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
-					struct svsm_pvalidate_call *pc)
-{
-	struct svsm_pvalidate_entry *pe;
-
-	/* Nothing in the CA yet */
-	pc->num_entries =3D 0;
-	pc->cur_index   =3D 0;
-
-	pe =3D &pc->entry[0];
-
-	while (pfn < pfn_end) {
-		pe->page_size =3D RMP_PG_SIZE_4K;
-		pe->action    =3D action;
-		pe->ignore_cf =3D 0;
-		pe->rsvd      =3D 0;
-		pe->pfn       =3D pfn;
-
-		pe++;
-		pfn++;
-
-		pc->num_entries++;
-		if (pc->num_entries =3D=3D SVSM_PVALIDATE_MAX_COUNT)
-			break;
-	}
-
-	return pfn;
-}
-
-static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned i=
nt desc_entry,
-				       struct svsm_pvalidate_call *pc)
-{
-	struct svsm_pvalidate_entry *pe;
-	struct psc_entry *e;
-
-	/* Nothing in the CA yet */
-	pc->num_entries =3D 0;
-	pc->cur_index   =3D 0;
-
-	pe =3D &pc->entry[0];
-	e  =3D &desc->entries[desc_entry];
-
-	while (desc_entry <=3D desc->hdr.end_entry) {
-		pe->page_size =3D e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
-		pe->action    =3D e->operation =3D=3D SNP_PAGE_STATE_PRIVATE;
-		pe->ignore_cf =3D 0;
-		pe->rsvd      =3D 0;
-		pe->pfn       =3D e->gfn;
-
-		pe++;
-		e++;
-
-		desc_entry++;
-		pc->num_entries++;
-		if (pc->num_entries =3D=3D SVSM_PVALIDATE_MAX_COUNT)
-			break;
-	}
-
-	return desc_entry;
-}
-
-static void svsm_pval_pages(struct snp_psc_desc *desc)
-{
-	struct svsm_pvalidate_entry pv_4k[VMGEXIT_PSC_MAX_ENTRY];
-	unsigned int i, pv_4k_count =3D 0;
-	struct svsm_pvalidate_call *pc;
-	struct svsm_call call =3D {};
-	unsigned long flags;
-	bool action;
-	u64 pc_pa;
-	int ret;
-
-	/*
-	 * This can be called very early in the boot, use native functions in
-	 * order to avoid paravirt issues.
-	 */
-	flags =3D native_local_irq_save();
-
-	/*
-	 * The SVSM calling area (CA) can support processing 510 entries at a
-	 * time. Loop through the Page State Change descriptor until the CA is
-	 * full or the last entry in the descriptor is reached, at which time
-	 * the SVSM is invoked. This repeats until all entries in the descriptor
-	 * are processed.
-	 */
-	call.caa =3D svsm_get_caa();
-
-	pc =3D (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa =3D svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
-
-	/* Protocol 0, Call ID 1 */
-	call.rax =3D SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
-	call.rcx =3D pc_pa;
-
-	for (i =3D 0; i <=3D desc->hdr.end_entry;) {
-		i =3D svsm_build_ca_from_psc_desc(desc, i, pc);
-
-		do {
-			ret =3D svsm_perform_call_protocol(&call);
-			if (!ret)
-				continue;
-
-			/*
-			 * Check if the entry failed because of an RMP mismatch (a
-			 * PVALIDATE at 2M was requested, but the page is mapped in
-			 * the RMP as 4K).
-			 */
-
-			if (call.rax_out =3D=3D SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
-			    pc->entry[pc->cur_index].page_size =3D=3D RMP_PG_SIZE_2M) {
-				/* Save this entry for post-processing at 4K */
-				pv_4k[pv_4k_count++] =3D pc->entry[pc->cur_index];
-
-				/* Skip to the next one unless at the end of the list */
-				pc->cur_index++;
-				if (pc->cur_index < pc->num_entries)
-					ret =3D -EAGAIN;
-				else
-					ret =3D 0;
-			}
-		} while (ret =3D=3D -EAGAIN);
-
-		if (ret)
-			svsm_pval_terminate(pc, ret, call.rax_out);
-	}
-
-	/* Process any entries that failed to be validated at 2M and validate them =
at 4K */
-	for (i =3D 0; i < pv_4k_count; i++) {
-		u64 pfn, pfn_end;
-
-		action  =3D pv_4k[i].action;
-		pfn     =3D pv_4k[i].pfn;
-		pfn_end =3D pfn + 512;
-
-		while (pfn < pfn_end) {
-			pfn =3D svsm_build_ca_from_pfn_range(pfn, pfn_end, action, pc);
-
-			ret =3D svsm_perform_call_protocol(&call);
-			if (ret)
-				svsm_pval_terminate(pc, ret, call.rax_out);
-		}
-	}
-
-	native_local_irq_restore(flags);
-}
-
 static void pvalidate_pages(struct snp_psc_desc *desc)
 {
 	struct psc_entry *e;
@@ -1589,56 +1320,6 @@ static int __init report_snp_info(void)
 }
 arch_initcall(report_snp_info);
=20
-static void update_attest_input(struct svsm_call *call, struct svsm_attest_c=
all *input)
-{
-	/* If (new) lengths have been returned, propagate them up */
-	if (call->rcx_out !=3D call->rcx)
-		input->manifest_buf.len =3D call->rcx_out;
-
-	if (call->rdx_out !=3D call->rdx)
-		input->certificates_buf.len =3D call->rdx_out;
-
-	if (call->r8_out !=3D call->r8)
-		input->report_buf.len =3D call->r8_out;
-}
-
-int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
-			      struct svsm_attest_call *input)
-{
-	struct svsm_attest_call *ac;
-	unsigned long flags;
-	u64 attest_call_pa;
-	int ret;
-
-	if (!snp_vmpl)
-		return -EINVAL;
-
-	local_irq_save(flags);
-
-	call->caa =3D svsm_get_caa();
-
-	ac =3D (struct svsm_attest_call *)call->caa->svsm_buffer;
-	attest_call_pa =3D svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer=
);
-
-	*ac =3D *input;
-
-	/*
-	 * Set input registers for the request and set RDX and R8 to known
-	 * values in order to detect length values being returned in them.
-	 */
-	call->rax =3D call_id;
-	call->rcx =3D attest_call_pa;
-	call->rdx =3D -1;
-	call->r8 =3D -1;
-	ret =3D svsm_perform_call_protocol(call);
-	update_attest_input(call, input);
-
-	local_irq_restore(flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
-
 static int snp_issue_guest_request(struct snp_guest_req *req)
 {
 	struct snp_req_data *input =3D &req->input;
@@ -1703,64 +1384,6 @@ e_restore_irq:
 	return ret;
 }
=20
-/**
- * snp_svsm_vtpm_probe() - Probe if SVSM provides a vTPM device
- *
- * Check that there is SVSM and that it supports at least TPM_SEND_COMMAND
- * which is the only request used so far.
- *
- * Return: true if the platform provides a vTPM SVSM device, false otherwise.
- */
-static bool snp_svsm_vtpm_probe(void)
-{
-	struct svsm_call call =3D {};
-
-	/* The vTPM device is available only if a SVSM is present */
-	if (!snp_vmpl)
-		return false;
-
-	call.caa =3D svsm_get_caa();
-	call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
-
-	if (svsm_perform_call_protocol(&call))
-		return false;
-
-	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
-	return call.rcx_out & BIT_ULL(8);
-}
-
-/**
- * snp_svsm_vtpm_send_command() - Execute a vTPM operation on SVSM
- * @buffer: A buffer used to both send the command and receive the response.
- *
- * Execute a SVSM_VTPM_CMD call as defined by
- * "Secure VM Service Module for SEV-SNP Guests" Publication # 58019 Revisio=
n: 1.00
- *
- * All command request/response buffers have a common structure as specified=
 by
- * the following table:
- *     Byte      Size   =C2=A0=C2=A0 =C2=A0In/Out=C2=A0=C2=A0=C2=A0=C2=A0Des=
cription
- *     Offset=C2=A0=C2=A0=C2=A0=C2=A0(Bytes)
- *     0x000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0In=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
Platform command
-=C2=A0*=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Platform command response size
- *
- * Each command can build upon this common request/response structure to cre=
ate
- * a structure specific to the command. See include/linux/tpm_svsm.h for more
- * details.
- *
- * Return: 0 on success, -errno on failure
- */
-int snp_svsm_vtpm_send_command(u8 *buffer)
-{
-	struct svsm_call call =3D {};
-
-	call.caa =3D svsm_get_caa();
-	call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_CMD);
-	call.rcx =3D __pa(buffer);
-
-	return svsm_perform_call_protocol(&call);
-}
-EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
-
 static struct platform_device sev_guest_device =3D {
 	.name		=3D "sev-guest",
 	.id		=3D -1,
diff --git a/arch/x86/coco/sev/internal.h b/arch/x86/coco/sev/internal.h
index af991f1..039326b 100644
--- a/arch/x86/coco/sev/internal.h
+++ b/arch/x86/coco/sev/internal.h
@@ -66,6 +66,9 @@ extern u64 boot_svsm_caa_pa;
=20
 enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *c=
txt);
 void vc_forward_exception(struct es_em_ctxt *ctxt);
+void svsm_pval_pages(struct snp_psc_desc *desc);
+int svsm_perform_call_protocol(struct svsm_call *call);
+bool snp_svsm_vtpm_probe(void);
=20
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
@@ -87,4 +90,30 @@ enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, s=
truct es_em_ctxt *ctxt
 u64 get_hv_features(void);
=20
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
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
+static inline void __pval_terminate(u64 pfn, bool action, unsigned int page_=
size,
+				    int ret, u64 svsm_ret)
+{
+	WARN(1, "PVALIDATE failure: pfn: 0x%llx, action: %u, size: %u, ret: %d, svs=
m_ret: 0x%llx\n",
+	     pfn, action, page_size, ret, svsm_ret);
+
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
 #endif /* __X86_COCO_SEV_INTERNAL_H__ */
diff --git a/arch/x86/coco/sev/svsm.c b/arch/x86/coco/sev/svsm.c
new file mode 100644
index 0000000..2acf4a7
--- /dev/null
+++ b/arch/x86/coco/sev/svsm.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SVSM support code
+ */
+
+#include <linux/types.h>
+
+#include <asm/sev.h>
+
+#include "internal.h"
+
+/* For early boot SVSM communication */
+struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
+SYM_PIC_ALIAS(boot_svsm_ca_page);
+
+/*
+ * SVSM related information:
+ *   During boot, the page tables are set up as identity mapped and later
+ *   changed to use kernel virtual addresses. Maintain separate virtual and
+ *   physical addresses for the CAA to allow SVSM functions to be used during
+ *   early boot, both with identity mapped virtual addresses and proper kern=
el
+ *   virtual addresses.
+ */
+u64 boot_svsm_caa_pa __ro_after_init;
+SYM_PIC_ALIAS(boot_svsm_caa_pa);
+
+DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+DEFINE_PER_CPU(u64, svsm_caa_pa);
+
+static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *c=
all)
+{
+	struct es_em_ctxt ctxt;
+	u8 pending =3D 0;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/*
+	 * Fill in protocol and format specifiers. This can be called very early
+	 * in the boot, so use rip-relative references as needed.
+	 */
+	ghcb->protocol_version =3D ghcb_version;
+	ghcb->ghcb_usage       =3D GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+
+	svsm_issue_call(call, &pending);
+
+	if (pending)
+		return -EINVAL;
+
+	switch (verify_exception_info(ghcb, &ctxt)) {
+	case ES_OK:
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	return svsm_process_result_codes(call);
+}
+
+int svsm_perform_call_protocol(struct svsm_call *call)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	flags =3D native_local_irq_save();
+
+	if (sev_cfg.ghcbs_initialized)
+		ghcb =3D __sev_get_ghcb(&state);
+	else if (boot_ghcb)
+		ghcb =3D boot_ghcb;
+	else
+		ghcb =3D NULL;
+
+	do {
+		ret =3D ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
+			   : __pi_svsm_perform_msr_protocol(call);
+	} while (ret =3D=3D -EAGAIN);
+
+	if (sev_cfg.ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	native_local_irq_restore(flags);
+
+	return ret;
+}
+
+static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
+					struct svsm_pvalidate_call *pc)
+{
+	struct svsm_pvalidate_entry *pe;
+
+	/* Nothing in the CA yet */
+	pc->num_entries =3D 0;
+	pc->cur_index   =3D 0;
+
+	pe =3D &pc->entry[0];
+
+	while (pfn < pfn_end) {
+		pe->page_size =3D RMP_PG_SIZE_4K;
+		pe->action    =3D action;
+		pe->ignore_cf =3D 0;
+		pe->rsvd      =3D 0;
+		pe->pfn       =3D pfn;
+
+		pe++;
+		pfn++;
+
+		pc->num_entries++;
+		if (pc->num_entries =3D=3D SVSM_PVALIDATE_MAX_COUNT)
+			break;
+	}
+
+	return pfn;
+}
+
+static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned i=
nt desc_entry,
+				       struct svsm_pvalidate_call *pc)
+{
+	struct svsm_pvalidate_entry *pe;
+	struct psc_entry *e;
+
+	/* Nothing in the CA yet */
+	pc->num_entries =3D 0;
+	pc->cur_index   =3D 0;
+
+	pe =3D &pc->entry[0];
+	e  =3D &desc->entries[desc_entry];
+
+	while (desc_entry <=3D desc->hdr.end_entry) {
+		pe->page_size =3D e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		pe->action    =3D e->operation =3D=3D SNP_PAGE_STATE_PRIVATE;
+		pe->ignore_cf =3D 0;
+		pe->rsvd      =3D 0;
+		pe->pfn       =3D e->gfn;
+
+		pe++;
+		e++;
+
+		desc_entry++;
+		pc->num_entries++;
+		if (pc->num_entries =3D=3D SVSM_PVALIDATE_MAX_COUNT)
+			break;
+	}
+
+	return desc_entry;
+}
+
+static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64=
 svsm_ret)
+{
+	unsigned int page_size;
+	bool action;
+	u64 pfn;
+
+	pfn =3D pc->entry[pc->cur_index].pfn;
+	action =3D pc->entry[pc->cur_index].action;
+	page_size =3D pc->entry[pc->cur_index].page_size;
+
+	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
+}
+
+void svsm_pval_pages(struct snp_psc_desc *desc)
+{
+	struct svsm_pvalidate_entry pv_4k[VMGEXIT_PSC_MAX_ENTRY];
+	unsigned int i, pv_4k_count =3D 0;
+	struct svsm_pvalidate_call *pc;
+	struct svsm_call call =3D {};
+	unsigned long flags;
+	bool action;
+	u64 pc_pa;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags =3D native_local_irq_save();
+
+	/*
+	 * The SVSM calling area (CA) can support processing 510 entries at a
+	 * time. Loop through the Page State Change descriptor until the CA is
+	 * full or the last entry in the descriptor is reached, at which time
+	 * the SVSM is invoked. This repeats until all entries in the descriptor
+	 * are processed.
+	 */
+	call.caa =3D svsm_get_caa();
+
+	pc =3D (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pc_pa =3D svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	/* Protocol 0, Call ID 1 */
+	call.rax =3D SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx =3D pc_pa;
+
+	for (i =3D 0; i <=3D desc->hdr.end_entry;) {
+		i =3D svsm_build_ca_from_psc_desc(desc, i, pc);
+
+		do {
+			ret =3D svsm_perform_call_protocol(&call);
+			if (!ret)
+				continue;
+
+			/*
+			 * Check if the entry failed because of an RMP mismatch (a
+			 * PVALIDATE at 2M was requested, but the page is mapped in
+			 * the RMP as 4K).
+			 */
+
+			if (call.rax_out =3D=3D SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
+			    pc->entry[pc->cur_index].page_size =3D=3D RMP_PG_SIZE_2M) {
+				/* Save this entry for post-processing at 4K */
+				pv_4k[pv_4k_count++] =3D pc->entry[pc->cur_index];
+
+				/* Skip to the next one unless at the end of the list */
+				pc->cur_index++;
+				if (pc->cur_index < pc->num_entries)
+					ret =3D -EAGAIN;
+				else
+					ret =3D 0;
+			}
+		} while (ret =3D=3D -EAGAIN);
+
+		if (ret)
+			svsm_pval_terminate(pc, ret, call.rax_out);
+	}
+
+	/* Process any entries that failed to be validated at 2M and validate them =
at 4K */
+	for (i =3D 0; i < pv_4k_count; i++) {
+		u64 pfn, pfn_end;
+
+		action  =3D pv_4k[i].action;
+		pfn     =3D pv_4k[i].pfn;
+		pfn_end =3D pfn + 512;
+
+		while (pfn < pfn_end) {
+			pfn =3D svsm_build_ca_from_pfn_range(pfn, pfn_end, action, pc);
+
+			ret =3D svsm_perform_call_protocol(&call);
+			if (ret)
+				svsm_pval_terminate(pc, ret, call.rax_out);
+		}
+	}
+
+	native_local_irq_restore(flags);
+}
+
+static void update_attest_input(struct svsm_call *call, struct svsm_attest_c=
all *input)
+{
+	/* If (new) lengths have been returned, propagate them up */
+	if (call->rcx_out !=3D call->rcx)
+		input->manifest_buf.len =3D call->rcx_out;
+
+	if (call->rdx_out !=3D call->rdx)
+		input->certificates_buf.len =3D call->rdx_out;
+
+	if (call->r8_out !=3D call->r8)
+		input->report_buf.len =3D call->r8_out;
+}
+
+int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
+			      struct svsm_attest_call *input)
+{
+	struct svsm_attest_call *ac;
+	unsigned long flags;
+	u64 attest_call_pa;
+	int ret;
+
+	if (!snp_vmpl)
+		return -EINVAL;
+
+	local_irq_save(flags);
+
+	call->caa =3D svsm_get_caa();
+
+	ac =3D (struct svsm_attest_call *)call->caa->svsm_buffer;
+	attest_call_pa =3D svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer=
);
+
+	*ac =3D *input;
+
+	/*
+	 * Set input registers for the request and set RDX and R8 to known
+	 * values in order to detect length values being returned in them.
+	 */
+	call->rax =3D call_id;
+	call->rcx =3D attest_call_pa;
+	call->rdx =3D -1;
+	call->r8 =3D -1;
+	ret =3D svsm_perform_call_protocol(call);
+	update_attest_input(call, input);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
+
+/**
+ * snp_svsm_vtpm_send_command() - Execute a vTPM operation on SVSM
+ * @buffer: A buffer used to both send the command and receive the response.
+ *
+ * Execute a SVSM_VTPM_CMD call as defined by
+ * "Secure VM Service Module for SEV-SNP Guests" Publication # 58019 Revisio=
n: 1.00
+ *
+ * All command request/response buffers have a common structure as specified=
 by
+ * the following table:
+ *     Byte      Size   =C2=A0=C2=A0 =C2=A0In/Out=C2=A0=C2=A0=C2=A0=C2=A0Des=
cription
+ *     Offset=C2=A0=C2=A0=C2=A0=C2=A0(Bytes)
+ *     0x000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0In=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
Platform command
+=C2=A0*=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Platform command response size
+ *
+ * Each command can build upon this common request/response structure to cre=
ate
+ * a structure specific to the command. See include/linux/tpm_svsm.h for more
+ * details.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int snp_svsm_vtpm_send_command(u8 *buffer)
+{
+	struct svsm_call call =3D {};
+
+	call.caa =3D svsm_get_caa();
+	call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_CMD);
+	call.rcx =3D __pa(buffer);
+
+	return svsm_perform_call_protocol(&call);
+}
+EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
+
+/**
+ * snp_svsm_vtpm_probe() - Probe if SVSM provides a vTPM device
+ *
+ * Check that there is SVSM and that it supports at least TPM_SEND_COMMAND
+ * which is the only request used so far.
+ *
+ * Return: true if the platform provides a vTPM SVSM device, false otherwise.
+ */
+bool snp_svsm_vtpm_probe(void)
+{
+	struct svsm_call call =3D {};
+
+	/* The vTPM device is available only if a SVSM is present */
+	if (!snp_vmpl)
+		return false;
+
+	call.caa =3D svsm_get_caa();
+	call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
+
+	if (svsm_perform_call_protocol(&call))
+		return false;
+
+	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
+	return call.rcx_out & BIT_ULL(8);
+}

