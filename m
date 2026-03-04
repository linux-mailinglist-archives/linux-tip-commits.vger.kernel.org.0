Return-Path: <linux-tip-commits+bounces-8345-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGIzJ3l4p2kshwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8345-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:10:33 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB21F8BD8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58F073002524
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BD1643B;
	Wed,  4 Mar 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HCBHzOm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F4LmqLY3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE03E55A;
	Wed,  4 Mar 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583014; cv=none; b=i4v6YBSaFxbCPba5rmNKD9xPzWBTWvGEDhARUA5YskkF+m+0HAv7tQXtjcGquPMPbdMaAYipCId0i1SUgc2z/dlh0Kp+RnOQDLVGHaq0/cSbETlHxi0TNhllFtKb+hmQR+GtH6CYKtVJmhLQcjaPW4YGPIYYeDyTGNKu/ZtjOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583014; c=relaxed/simple;
	bh=uauyNhVbS1479+WQkZq9xCK91hEWmOyydAaT+ZGpYjw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y+FmUVPZ05o2HZscf5O60P90NOkGkns3BnNaoI5vKaq0KDXH3te0APSQYczzVpMIb+1b1ByhdHR4puOPUXEFLghzatfnfPyFT+Q1bSZJW9rVuwy14XwJd0TRlNQWloVFWtUtOqUMr9ESQ2yToissCAK2Pv6GzliO7gkVYTa07v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HCBHzOm9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F4LmqLY3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 00:10:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772583010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6zaF44kQRZ0sxtT48g/RKtGMgpFe14FCPQFpIo47CM=;
	b=HCBHzOm9dgefs+huuJf5LQqkcn0KnkE1Js7MbugcNvrXYJze1DK6U81y3/OdNeQhpdB0H0
	CZmjge1+f++nhuRijQrO0fbKhdQAw4YI+elOZYN7koK0A6Zjn/remNpn7BzDP2N+xb1Rcd
	XxCf0LbbRaWOF2bjfFXaDjxy6sDSVV9RKBhEGw+AhtWM1YtScf7TX3cXGRakwuSl0u8MhK
	8QfJGqgC5InGgjumdc1AnPWx1V+QDRDG+D1A4Mj8M6T5QZxDMjrrkfPc3KYxUk+jhFW/e/
	CBflTNEEtGcqqsiKZiCTG5FQbJv3CM65H2drX6uW18Y3GcLohgo/jIan/nnz1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772583010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6zaF44kQRZ0sxtT48g/RKtGMgpFe14FCPQFpIo47CM=;
	b=F4LmqLY3KJKFePWgZv424RlyVpMlp1rxe5AoLUrNs8AzD4C10/tIaIBxBfieOOC1Z3/mTN
	PNQ8ZfH54P1yqjBA==
From: "tip-bot2 for Xiaoyao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] KVM/TDX: Rename KVM_SUPPORTED_TD_ATTRS to
 KVM_SUPPORTED_TDX_TD_ATTRS
Cc: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303030335.766779-5-xiaoyao.li@intel.com>
References: <20260303030335.766779-5-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177258300919.1647592.7343640484458685898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 99DB21F8BD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8345-lists,linux-tip-commits=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linutronix.de:dkim,vger.kernel.org:replyto]
X-Rspamd-Action: no action

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     3256e41f02623edc4b90a77b70191f83dcdea6cc
Gitweb:        https://git.kernel.org/tip/3256e41f02623edc4b90a77b70191f83dcd=
ea6cc
Author:        Xiaoyao Li <xiaoyao.li@intel.com>
AuthorDate:    Tue, 03 Mar 2026 11:03:35 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 03 Mar 2026 16:06:49 -08:00

KVM/TDX: Rename KVM_SUPPORTED_TD_ATTRS to KVM_SUPPORTED_TDX_TD_ATTRS

Rename KVM_SUPPORTED_TD_ATTRS to KVM_SUPPORTED_TDX_TD_ATTRS to include
"TDX" in the name, making it clear that it pertains to TDX.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20260303030335.766779-5-xiaoyao.li@intel.com
---
 arch/x86/kvm/vmx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c5065f8..eaeda1c 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -75,7 +75,7 @@ void tdh_vp_wr_failed(struct vcpu_tdx *tdx, char *uclass, c=
har *op, u32 field,
 	pr_err("TDH_VP_WR[%s.0x%x]%s0x%llx failed: 0x%llx\n", uclass, field, op, va=
l, err);
 }
=20
-#define KVM_SUPPORTED_TD_ATTRS (TDX_TD_ATTR_SEPT_VE_DISABLE)
+#define KVM_SUPPORTED_TDX_TD_ATTRS (TDX_TD_ATTR_SEPT_VE_DISABLE)
=20
 static __always_inline struct kvm_tdx *to_kvm_tdx(struct kvm *kvm)
 {
@@ -89,7 +89,7 @@ static __always_inline struct vcpu_tdx *to_tdx(struct kvm_v=
cpu *vcpu)
=20
 static u64 tdx_get_supported_attrs(const struct tdx_sys_info_td_conf *td_con=
f)
 {
-	u64 val =3D KVM_SUPPORTED_TD_ATTRS;
+	u64 val =3D KVM_SUPPORTED_TDX_TD_ATTRS;
=20
 	if ((val & td_conf->attributes_fixed1) !=3D td_conf->attributes_fixed1)
 		return 0;

