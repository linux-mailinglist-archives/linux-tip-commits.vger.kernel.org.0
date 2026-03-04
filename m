Return-Path: <linux-tip-commits+bounces-8346-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKWyBq54p2kshwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8346-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:11:26 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE6C1F8BFB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8976F311581E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 00:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED749620;
	Wed,  4 Mar 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5dOkNcR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqeude8b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB2BA21;
	Wed,  4 Mar 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583014; cv=none; b=QTGJumBSTQDUHKB2TKOaaX7L7PbqsrIp1u15XCRahi5CvXSvfkcXI/V7OQD5IuqVXS0Yo/IMCGodXusWwGiIC/Z7gmMO2eJf+mthHA6xvYOqy4AEceHX0BgqB4rwk/+Ganihesr5lwRf02mphF4trJoQayxJIfyrcQz53Xw47zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583014; c=relaxed/simple;
	bh=n8Z0aU6uhWzNgDDhd0SdUhmzku5dCyDxMT5qFVW6iTs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NUU+303i63NaNG1kJ4smsRHFR+Evp9OUJjR1MzBDY+stdco3cSXBOc+xB1PwFY5J+9X8stsXkQpXkqR1SFkwk1iv2kAvI6yyB6xXhcva8xRTbXyIGEMJ9w/NQnpoiEmP2FUMSO2f9+19DfRBedO873JoxixlPFcc+csacOMPNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5dOkNcR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqeude8b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 00:10:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772583011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7/DKvQX49wJ+W93sGf7W2bn37L5IJDwuHxGoKWbyis=;
	b=t5dOkNcRcQSceKoqGpMTBIqXZZUtmiPKm31bHBMTt3Z8vG7IS1jwWU5Y+xUAncF6KlbwR1
	W2jvQWifB4DmUMzdbr13vx9xCmjrrt2EBcyFHYbH/Qwjej1L45oikeJXeI1vxkLqEW9Xyl
	lOIDu9L9kgyWAS0Ajrm6sVj7EmZARxoXnFWXvKEWavElKgLW3QN3SoknQddcH9zzan4xhv
	FHJS4NcohKqdzCOdfxaCR3zmvnlblrww/h2vmOM4Q9JaR579qnw5rVcjJolbAF+ud+W0bh
	9oBhU9jdetoMPPXNfyE0mYHud0q+/z3ZYhG5/+OaxAJayqQ/ysrPW/U+n8Ch0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772583011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7/DKvQX49wJ+W93sGf7W2bn37L5IJDwuHxGoKWbyis=;
	b=aqeude8bieKTFpDjRjBOYI77Ucp1kxSyXL4RbR/7dNz+SUtPf0G7B/rEc1ZFEyvIyMCz3E
	9SaAVtssuEExAkCg==
From: "tip-bot2 for Xiaoyao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Rename TDX_ATTR_* to TDX_TD_ATTR_*
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303030335.766779-4-xiaoyao.li@intel.com>
References: <20260303030335.766779-4-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177258301028.1647592.16901000461903899339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ABE6C1F8BFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8346-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:replyto]
X-Rspamd-Action: no action

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     28bcd8d83fca2c16b2d596b0dce5c4dbca4f9b50
Gitweb:        https://git.kernel.org/tip/28bcd8d83fca2c16b2d596b0dce5c4dbca4=
f9b50
Author:        Xiaoyao Li <xiaoyao.li@intel.com>
AuthorDate:    Tue, 03 Mar 2026 11:03:34 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 03 Mar 2026 16:06:49 -08:00

x86/tdx: Rename TDX_ATTR_* to TDX_TD_ATTR_*

The macros TDX_ATTR_* and DEF_TDX_ATTR_* are related to TD attributes,
which are TD-scope attributes. Naming them as TDX_ATTR_* can be somewhat
confusing and might mislead people into thinking they are TDX global
things.

Rename TDX_ATTR_* to TDX_TD_ATTR_* to explicitly clarify they are
TD-scope things.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20260303030335.766779-4-xiaoyao.li@intel.com
---
 arch/x86/coco/tdx/debug.c         | 26 ++++++++--------
 arch/x86/coco/tdx/tdx.c           |  8 ++---
 arch/x86/include/asm/shared/tdx.h | 50 +++++++++++++++---------------
 arch/x86/kvm/vmx/tdx.c            |  4 +-
 4 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/x86/coco/tdx/debug.c b/arch/x86/coco/tdx/debug.c
index 28990c2..8e477db 100644
--- a/arch/x86/coco/tdx/debug.c
+++ b/arch/x86/coco/tdx/debug.c
@@ -7,21 +7,21 @@
 #include <linux/printk.h>
 #include <asm/tdx.h>
=20
-#define DEF_TDX_ATTR_NAME(_name) [TDX_ATTR_##_name##_BIT] =3D __stringify(_n=
ame)
+#define DEF_TDX_TD_ATTR_NAME(_name) [TDX_TD_ATTR_##_name##_BIT] =3D __string=
ify(_name)
=20
 static __initdata const char *tdx_attributes[] =3D {
-	DEF_TDX_ATTR_NAME(DEBUG),
-	DEF_TDX_ATTR_NAME(HGS_PLUS_PROF),
-	DEF_TDX_ATTR_NAME(PERF_PROF),
-	DEF_TDX_ATTR_NAME(PMT_PROF),
-	DEF_TDX_ATTR_NAME(ICSSD),
-	DEF_TDX_ATTR_NAME(LASS),
-	DEF_TDX_ATTR_NAME(SEPT_VE_DISABLE),
-	DEF_TDX_ATTR_NAME(MIGRATABLE),
-	DEF_TDX_ATTR_NAME(PKS),
-	DEF_TDX_ATTR_NAME(KL),
-	DEF_TDX_ATTR_NAME(TPA),
-	DEF_TDX_ATTR_NAME(PERFMON),
+	DEF_TDX_TD_ATTR_NAME(DEBUG),
+	DEF_TDX_TD_ATTR_NAME(HGS_PLUS_PROF),
+	DEF_TDX_TD_ATTR_NAME(PERF_PROF),
+	DEF_TDX_TD_ATTR_NAME(PMT_PROF),
+	DEF_TDX_TD_ATTR_NAME(ICSSD),
+	DEF_TDX_TD_ATTR_NAME(LASS),
+	DEF_TDX_TD_ATTR_NAME(SEPT_VE_DISABLE),
+	DEF_TDX_TD_ATTR_NAME(MIGRATABLE),
+	DEF_TDX_TD_ATTR_NAME(PKS),
+	DEF_TDX_TD_ATTR_NAME(KL),
+	DEF_TDX_TD_ATTR_NAME(TPA),
+	DEF_TDX_TD_ATTR_NAME(PERFMON),
 };
=20
 #define DEF_TD_CTLS_NAME(_name) [TD_CTLS_##_name##_BIT] =3D __stringify(_nam=
e)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7b28337..186915a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -238,14 +238,14 @@ static void __noreturn tdx_panic(const char *msg)
  *
  * TDX 1.0 does not allow the guest to disable SEPT #VE on its own. The VMM
  * controls if the guest will receive such #VE with TD attribute
- * TDX_ATTR_SEPT_VE_DISABLE.
+ * TDX_TD_ATTR_SEPT_VE_DISABLE.
  *
  * Newer TDX modules allow the guest to control if it wants to receive SEPT
  * violation #VEs.
  *
  * Check if the feature is available and disable SEPT #VE if possible.
  *
- * If the TD is allowed to disable/enable SEPT #VEs, the TDX_ATTR_SEPT_VE_DI=
SABLE
+ * If the TD is allowed to disable/enable SEPT #VEs, the TDX_TD_ATTR_SEPT_VE=
_DISABLE
  * attribute is no longer reliable. It reflects the initial state of the
  * control for the TD, but it will not be updated if someone (e.g. bootloade=
r)
  * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
@@ -254,14 +254,14 @@ static void __noreturn tdx_panic(const char *msg)
 static void disable_sept_ve(u64 td_attr)
 {
 	const char *msg =3D "TD misconfiguration: SEPT #VE has to be disabled";
-	bool debug =3D td_attr & TDX_ATTR_DEBUG;
+	bool debug =3D td_attr & TDX_TD_ATTR_DEBUG;
 	u64 config, controls;
=20
 	/* Is this TD allowed to disable SEPT #VE */
 	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
 	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {
 		/* No SEPT #VE controls for the guest: check the attribute */
-		if (td_attr & TDX_ATTR_SEPT_VE_DISABLE)
+		if (td_attr & TDX_TD_ATTR_SEPT_VE_DISABLE)
 			return;
=20
 		/* Relax SEPT_VE_DISABLE check for debug TD for backtraces */
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/=
tdx.h
index 11f3cf3..049638e 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -20,31 +20,31 @@
 #define TDG_VM_RD			7
 #define TDG_VM_WR			8
=20
-/* TDX attributes */
-#define TDX_ATTR_DEBUG_BIT		0
-#define TDX_ATTR_DEBUG			BIT_ULL(TDX_ATTR_DEBUG_BIT)
-#define TDX_ATTR_HGS_PLUS_PROF_BIT	4
-#define TDX_ATTR_HGS_PLUS_PROF		BIT_ULL(TDX_ATTR_HGS_PLUS_PROF_BIT)
-#define TDX_ATTR_PERF_PROF_BIT		5
-#define TDX_ATTR_PERF_PROF		BIT_ULL(TDX_ATTR_PERF_PROF_BIT)
-#define TDX_ATTR_PMT_PROF_BIT		6
-#define TDX_ATTR_PMT_PROF		BIT_ULL(TDX_ATTR_PMT_PROF_BIT)
-#define TDX_ATTR_ICSSD_BIT		16
-#define TDX_ATTR_ICSSD			BIT_ULL(TDX_ATTR_ICSSD_BIT)
-#define TDX_ATTR_LASS_BIT		27
-#define TDX_ATTR_LASS			BIT_ULL(TDX_ATTR_LASS_BIT)
-#define TDX_ATTR_SEPT_VE_DISABLE_BIT	28
-#define TDX_ATTR_SEPT_VE_DISABLE	BIT_ULL(TDX_ATTR_SEPT_VE_DISABLE_BIT)
-#define TDX_ATTR_MIGRATABLE_BIT		29
-#define TDX_ATTR_MIGRATABLE		BIT_ULL(TDX_ATTR_MIGRATABLE_BIT)
-#define TDX_ATTR_PKS_BIT		30
-#define TDX_ATTR_PKS			BIT_ULL(TDX_ATTR_PKS_BIT)
-#define TDX_ATTR_KL_BIT			31
-#define TDX_ATTR_KL			BIT_ULL(TDX_ATTR_KL_BIT)
-#define TDX_ATTR_TPA_BIT		62
-#define TDX_ATTR_TPA			BIT_ULL(TDX_ATTR_TPA_BIT)
-#define TDX_ATTR_PERFMON_BIT		63
-#define TDX_ATTR_PERFMON		BIT_ULL(TDX_ATTR_PERFMON_BIT)
+/* TDX TD attributes */
+#define TDX_TD_ATTR_DEBUG_BIT		0
+#define TDX_TD_ATTR_DEBUG		BIT_ULL(TDX_TD_ATTR_DEBUG_BIT)
+#define TDX_TD_ATTR_HGS_PLUS_PROF_BIT	4
+#define TDX_TD_ATTR_HGS_PLUS_PROF	BIT_ULL(TDX_TD_ATTR_HGS_PLUS_PROF_BIT)
+#define TDX_TD_ATTR_PERF_PROF_BIT	5
+#define TDX_TD_ATTR_PERF_PROF		BIT_ULL(TDX_TD_ATTR_PERF_PROF_BIT)
+#define TDX_TD_ATTR_PMT_PROF_BIT	6
+#define TDX_TD_ATTR_PMT_PROF		BIT_ULL(TDX_TD_ATTR_PMT_PROF_BIT)
+#define TDX_TD_ATTR_ICSSD_BIT		16
+#define TDX_TD_ATTR_ICSSD		BIT_ULL(TDX_TD_ATTR_ICSSD_BIT)
+#define TDX_TD_ATTR_LASS_BIT		27
+#define TDX_TD_ATTR_LASS		BIT_ULL(TDX_TD_ATTR_LASS_BIT)
+#define TDX_TD_ATTR_SEPT_VE_DISABLE_BIT	28
+#define TDX_TD_ATTR_SEPT_VE_DISABLE	BIT_ULL(TDX_TD_ATTR_SEPT_VE_DISABLE_BIT)
+#define TDX_TD_ATTR_MIGRATABLE_BIT	29
+#define TDX_TD_ATTR_MIGRATABLE		BIT_ULL(TDX_TD_ATTR_MIGRATABLE_BIT)
+#define TDX_TD_ATTR_PKS_BIT		30
+#define TDX_TD_ATTR_PKS			BIT_ULL(TDX_TD_ATTR_PKS_BIT)
+#define TDX_TD_ATTR_KL_BIT		31
+#define TDX_TD_ATTR_KL			BIT_ULL(TDX_TD_ATTR_KL_BIT)
+#define TDX_TD_ATTR_TPA_BIT		62
+#define TDX_TD_ATTR_TPA			BIT_ULL(TDX_TD_ATTR_TPA_BIT)
+#define TDX_TD_ATTR_PERFMON_BIT		63
+#define TDX_TD_ATTR_PERFMON		BIT_ULL(TDX_TD_ATTR_PERFMON_BIT)
=20
 /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index f38e492..c5065f8 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -75,7 +75,7 @@ void tdh_vp_wr_failed(struct vcpu_tdx *tdx, char *uclass, c=
har *op, u32 field,
 	pr_err("TDH_VP_WR[%s.0x%x]%s0x%llx failed: 0x%llx\n", uclass, field, op, va=
l, err);
 }
=20
-#define KVM_SUPPORTED_TD_ATTRS (TDX_ATTR_SEPT_VE_DISABLE)
+#define KVM_SUPPORTED_TD_ATTRS (TDX_TD_ATTR_SEPT_VE_DISABLE)
=20
 static __always_inline struct kvm_tdx *to_kvm_tdx(struct kvm *kvm)
 {
@@ -707,7 +707,7 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.l1_tsc_scaling_ratio =3D kvm_tdx->tsc_multiplier;
=20
 	vcpu->arch.guest_state_protected =3D
-		!(to_kvm_tdx(vcpu->kvm)->attributes & TDX_ATTR_DEBUG);
+		!(to_kvm_tdx(vcpu->kvm)->attributes & TDX_TD_ATTR_DEBUG);
=20
 	if ((kvm_tdx->xfam & XFEATURE_MASK_XTILE) =3D=3D XFEATURE_MASK_XTILE)
 		vcpu->arch.xfd_no_write_intercept =3D true;

