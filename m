Return-Path: <linux-tip-commits+bounces-8348-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eObgLu14p2kshwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8348-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:12:29 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F041F8C36
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B069C31542C5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD4257843;
	Wed,  4 Mar 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJFiSYYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gNUUuC9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20B1DF27D;
	Wed,  4 Mar 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583017; cv=none; b=tZ1WYOQL1kPO015H9KVFJRfEeuzIfs7EkpEeLJIWW/iZ/I1RIbxh4O/BoPXdvso+r3u+hj8dWN32nz0vq+YULVSULSwwm2JNZTikv5KaJM7YcmoBu5tYKPWE1j8ilLvbX7DL1R3wrfbIv/xDmfNJt5TKEb9I5/FDkR9KV8js6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583017; c=relaxed/simple;
	bh=PUOnaAGtXSBfZopH9ovh9SjgwUtUz4IXwQ8WUeTooBE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qsjYLfC9x0mVS+BQiL91ySgrxa4BpNKQcRdRMdXVuQEMcHOaGzt5Zo7RthX3YuQ/ObjkCNg3KGrN+G2AJw2jZOAxKQhJlyyOYY0scm/4851YghTbMUzcePUCOWlKoM6U5NsCStKQY8UpLCPtXfI0xdfx7YVMgfRxOdV6G+VsW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJFiSYYs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0gNUUuC9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 00:10:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772583012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHckHPphORfz2jWz88e1+HczYBRhCffWpfCFGd101xw=;
	b=gJFiSYYshlHbTcYKNro5x6zvhuu2UhR5iL+mswhJWjWUitsppGn3NNaoeFaq+6uGPvSEs3
	WSeh0GsxWcFub6JMRi3xDO+GfeyYk09kXNJQ9A7bOkPmha4KaDWeAqvi3YIqVvEFtX+H9c
	mj9o//0XXwH7cGTwUnhUEOS8D3/oM9ZB41+YqiJoT8UBdy7zQz3eUnOyS4Op88r+mel42+
	i3P4c87LK+ReorkKCyr0BChIwzuzJorccEcyYBamnDiEL9GjLXxUncY2yRMskaaamYaY7M
	hjl/oShrLHV1wOXruwTpOOuakcjCo2GpN+3NdBXrglPKJle6wDErvyWAfiHX3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772583012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHckHPphORfz2jWz88e1+HczYBRhCffWpfCFGd101xw=;
	b=0gNUUuC9iRMxR55Dcf/8dX6boUc1SRJGJpmEKoGLNyyn6KUm37vWqy6TWarNemAq5hTdr6
	4zM4v0MPk+93ifDA==
From: "tip-bot2 for Xiaoyao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] KVM/TDX: Remove redundant definitions of TDX_TD_ATTR_*
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303030335.766779-3-xiaoyao.li@intel.com>
References: <20260303030335.766779-3-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177258301135.1647592.10137417955905121496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 34F041F8C36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8348-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:replyto]
X-Rspamd-Action: no action

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     87686987193e8465a7ecbd7a3012efe20f1f293d
Gitweb:        https://git.kernel.org/tip/87686987193e8465a7ecbd7a3012efe20f1=
f293d
Author:        Xiaoyao Li <xiaoyao.li@intel.com>
AuthorDate:    Tue, 03 Mar 2026 11:03:33 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 03 Mar 2026 16:06:49 -08:00

KVM/TDX: Remove redundant definitions of TDX_TD_ATTR_*

There are definitions of TD attributes bits inside asm/shared/tdx.h as
TDX_ATTR_*.

Remove KVM's definitions and use the ones in asm/shared/tdx.h

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20260303030335.766779-3-xiaoyao.li@intel.com
---
 arch/x86/kvm/vmx/tdx.c      | 4 ++--
 arch/x86/kvm/vmx/tdx_arch.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c5065f8..f38e492 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -75,7 +75,7 @@ void tdh_vp_wr_failed(struct vcpu_tdx *tdx, char *uclass, c=
har *op, u32 field,
 	pr_err("TDH_VP_WR[%s.0x%x]%s0x%llx failed: 0x%llx\n", uclass, field, op, va=
l, err);
 }
=20
-#define KVM_SUPPORTED_TD_ATTRS (TDX_TD_ATTR_SEPT_VE_DISABLE)
+#define KVM_SUPPORTED_TD_ATTRS (TDX_ATTR_SEPT_VE_DISABLE)
=20
 static __always_inline struct kvm_tdx *to_kvm_tdx(struct kvm *kvm)
 {
@@ -707,7 +707,7 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.l1_tsc_scaling_ratio =3D kvm_tdx->tsc_multiplier;
=20
 	vcpu->arch.guest_state_protected =3D
-		!(to_kvm_tdx(vcpu->kvm)->attributes & TDX_TD_ATTR_DEBUG);
+		!(to_kvm_tdx(vcpu->kvm)->attributes & TDX_ATTR_DEBUG);
=20
 	if ((kvm_tdx->xfam & XFEATURE_MASK_XTILE) =3D=3D XFEATURE_MASK_XTILE)
 		vcpu->arch.xfd_no_write_intercept =3D true;
diff --git a/arch/x86/kvm/vmx/tdx_arch.h b/arch/x86/kvm/vmx/tdx_arch.h
index a30e880..350143b 100644
--- a/arch/x86/kvm/vmx/tdx_arch.h
+++ b/arch/x86/kvm/vmx/tdx_arch.h
@@ -75,12 +75,6 @@ struct tdx_cpuid_value {
 	u32 edx;
 } __packed;
=20
-#define TDX_TD_ATTR_DEBUG		BIT_ULL(0)
-#define TDX_TD_ATTR_SEPT_VE_DISABLE	BIT_ULL(28)
-#define TDX_TD_ATTR_PKS			BIT_ULL(30)
-#define TDX_TD_ATTR_KL			BIT_ULL(31)
-#define TDX_TD_ATTR_PERFMON		BIT_ULL(63)
-
 #define TDX_EXT_EXIT_QUAL_TYPE_MASK	GENMASK(3, 0)
 #define TDX_EXT_EXIT_QUAL_TYPE_PENDING_EPT_VIOLATION  6
 /*

