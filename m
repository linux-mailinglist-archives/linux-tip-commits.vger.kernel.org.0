Return-Path: <linux-tip-commits+bounces-6479-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D19B439EF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F060F5A361E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E2F3074A8;
	Thu,  4 Sep 2025 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pf/F+4oO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UPoInhsQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC46305E21;
	Thu,  4 Sep 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984875; cv=none; b=LRudw3Iq5UTfKnRE8JLAnYFbi5KhzqXdi9N1JvAVhCLi+wyxm69T3xP2H1z1QJWcGkC2NPb7cs/dVBUW9DYNkgC1gXS+eGxNSK1qZqtuTNbxveACUc3/gxcjBvStOoHsoauUJbTl2gaC6irgKd1d9vPl2XfnHmxG4uVs6eAxbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984875; c=relaxed/simple;
	bh=rO6fk/O/YIsKIfzkCk7PdAG+sPHA4yfylgj9AV64bYc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mhz7usZY3bzvsk8PSPjDVcUO/avj7eLgBvoHohR+/uTKhxRszDARqcP7Cy3I+3vsjPnGDWIpyKYYE5ZzlwrJwuYDmyIKb97ESBO685iAkLeA8D3OZ0ba8vX7QbOU9J/ABhuk4bVQ8eHWJtXI/DcV540tNvUgmXznk/MZLvB9D/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pf/F+4oO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UPoInhsQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1t028Rt+FADfdTkjqrlR0lWQ/CNiWH+pXfeYdlYbfI4=;
	b=pf/F+4oO8I/woVns/exbAlMHMlsx9g+CXjPELGYrjnuHHERA+ckrPN1x0t1/1N30APafSI
	sjyunHiULqp65xBF83pEpElH41XlovyMp5MWrHQFng6utESrsdwrLf/9dpqKOJBJRdKuAD
	dl5M+sJZsEaHjfIKGXxrNqcUAYNZ35cCkgd0ul8Mf2glAiRZ5ir/EDOv1B8DcSMIuJ66lH
	9N6cRNq0ttnpEqOj9/5o0sIp8evbPJ6aRxguwVHA0+9uKPiPoFVE+I6kpiVqONua/seIxe
	Zd8JLgyuEjScs4RMyuJMYdRoS4mphm4egPcUOH5OdViAEQSz83l+OUblyHfrpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1t028Rt+FADfdTkjqrlR0lWQ/CNiWH+pXfeYdlYbfI4=;
	b=UPoInhsQ0RlFuXclBn+AdBYSMERi9w2hSUFem8y8mH6rwpt1tLJaPnjo4CEdOVSyv4JCHO
	QgRltzlxK5ppUHCg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Separate MSR and GHCB based snp_cpuid() via a
 callback
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-25-ardb+git@google.com>
References: <20250828102202.1849035-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698487002.1920.4172345467008884231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e2e29752357f32feb69a68e9e6e7361405b3f289
Gitweb:        https://git.kernel.org/tip/e2e29752357f32feb69a68e9e6e7361405b=
3f289
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:04 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 28 Aug 2025 16:52:05 +02:00

x86/sev: Separate MSR and GHCB based snp_cpuid() via a callback

There are two distinct callers of snp_cpuid(): the MSR protocol and the GHCB
page based interface.

The snp_cpuid() logic does not care about the distinction, which only matters
at a lower level. But the fact that it supports both interfaces means that the
GHCB page based logic is pulled into the early startup code where PA to VA
conversions are problematic, given that it runs from the 1:1 mapping of memor=
y.

So keep snp_cpuid() itself in the startup code, but factor out the hypervisor
calls via a callback, so that the GHCB page handling can be moved out.

Code refactoring only - no functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/20250828102202.1849035-25-ardb+git@google.com
---
 arch/x86/boot/startup/sev-shared.c | 59 +++++------------------------
 arch/x86/coco/sev/vc-shared.c      | 49 +++++++++++++++++++++++-
 arch/x86/include/asm/sev.h         |  3 +-
 3 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index a34cd19..ed88dfe 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -342,44 +342,7 @@ static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 	return ret;
 }
=20
-static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, s=
truct cpuid_leaf *leaf)
-{
-	u32 cr4 =3D native_read_cr4();
-	int ret;
-
-	ghcb_set_rax(ghcb, leaf->fn);
-	ghcb_set_rcx(ghcb, leaf->subfn);
-
-	if (cr4 & X86_CR4_OSXSAVE)
-		/* Safe to read xcr0 */
-		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
-	else
-		/* xgetbv will cause #UD - use reset value for xcr0 */
-		ghcb_set_xcr0(ghcb, 1);
-
-	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
-	if (ret !=3D ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) &&
-	      ghcb_rbx_is_valid(ghcb) &&
-	      ghcb_rcx_is_valid(ghcb) &&
-	      ghcb_rdx_is_valid(ghcb)))
-		return ES_VMM_ERROR;
=20
-	leaf->eax =3D ghcb->save.rax;
-	leaf->ebx =3D ghcb->save.rbx;
-	leaf->ecx =3D ghcb->save.rcx;
-	leaf->edx =3D ghcb->save.rdx;
-
-	return ES_OK;
-}
-
-static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct c=
puid_leaf *leaf)
-{
-	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
-		    : __sev_cpuid_hv_msr(leaf);
-}
=20
 /*
  * This may be called early while still running on the initial identity
@@ -484,21 +447,21 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
=20
-static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct =
cpuid_leaf *leaf)
+static void snp_cpuid_hv_msr(void *ctx, struct cpuid_leaf *leaf)
 {
-	if (sev_cpuid_hv(ghcb, ctxt, leaf))
+	if (__sev_cpuid_hv_msr(leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
=20
 static int __head
-snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-		      struct cpuid_leaf *leaf)
+snp_cpuid_postprocess(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
+		      void *ctx, struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv =3D *leaf;
=20
 	switch (leaf->fn) {
 	case 0x1:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_fn(ctx, &leaf_hv);
=20
 		/* initial APIC ID */
 		leaf->ebx =3D (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0=
));
@@ -517,7 +480,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctx=
t *ctxt,
 		break;
 	case 0xB:
 		leaf_hv.subfn =3D 0;
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_fn(ctx, &leaf_hv);
=20
 		/* extended APIC ID */
 		leaf->edx =3D leaf_hv.edx;
@@ -565,7 +528,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctx=
t *ctxt,
 		}
 		break;
 	case 0x8000001E:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_fn(ctx, &leaf_hv);
=20
 		/* extended APIC ID */
 		leaf->eax =3D leaf_hv.eax;
@@ -586,8 +549,8 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctx=
t *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return val=
ue
  * should be treated as fatal by caller.
  */
-int __head
-snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *lea=
f)
+int __head snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
+		     void *ctx, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table =3D snp_cpuid_get_table();
=20
@@ -621,7 +584,7 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, str=
uct cpuid_leaf *leaf)
 			return 0;
 	}
=20
-	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
+	return snp_cpuid_postprocess(cpuid_fn, ctx, leaf);
 }
=20
 /*
@@ -648,7 +611,7 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned =
long exit_code)
 	leaf.fn =3D fn;
 	leaf.subfn =3D subfn;
=20
-	ret =3D snp_cpuid(NULL, NULL, &leaf);
+	ret =3D snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
=20
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index 2c0ab0f..b4688f6 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -409,15 +409,62 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb,=
 struct es_em_ctxt *ctxt)
 	return ret;
 }
=20
+static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, s=
truct cpuid_leaf *leaf)
+{
+	u32 cr4 =3D native_read_cr4();
+	int ret;
+
+	ghcb_set_rax(ghcb, leaf->fn);
+	ghcb_set_rcx(ghcb, leaf->subfn);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #UD - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret !=3D ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	leaf->eax =3D ghcb->save.rax;
+	leaf->ebx =3D ghcb->save.rbx;
+	leaf->ecx =3D ghcb->save.rcx;
+	leaf->edx =3D ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+struct cpuid_ctx {
+	struct ghcb *ghcb;
+	struct es_em_ctxt *ctxt;
+};
+
+static void snp_cpuid_hv_ghcb(void *p, struct cpuid_leaf *leaf)
+{
+	struct cpuid_ctx *ctx =3D p;
+
+	if (__sev_cpuid_hv_ghcb(ctx->ghcb, ctx->ctxt, leaf))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
+}
+
 static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
+	struct cpuid_ctx ctx =3D { ghcb, ctxt };
 	struct pt_regs *regs =3D ctxt->regs;
 	struct cpuid_leaf leaf;
 	int ret;
=20
 	leaf.fn =3D regs->ax;
 	leaf.subfn =3D regs->cx;
-	ret =3D snp_cpuid(ghcb, ctxt, &leaf);
+	ret =3D snp_cpuid(snp_cpuid_hv_ghcb, &ctx, &leaf);
 	if (!ret) {
 		regs->ax =3D leaf.eax;
 		regs->bx =3D leaf.ebx;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 0223696..e4622e4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -552,7 +552,8 @@ struct cpuid_leaf {
 	u32 edx;
 };
=20
-int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf =
*leaf);
+int snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
+	      void *ctx, struct cpuid_leaf *leaf);
=20
 void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
 enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,

