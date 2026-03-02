Return-Path: <linux-tip-commits+bounces-8335-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLUGJ7NppWkaAQYAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8335-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 11:42:59 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9A1D6BBB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 11:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254BB300B055
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Mar 2026 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D481330D29;
	Mon,  2 Mar 2026 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KuPyROme";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z8f//cXP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0C318EE1;
	Mon,  2 Mar 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447549; cv=none; b=XVZL5xeopYF0wkvGtwSb6wIFStQ00ItuXNRJcOKc6w93q10t6aLc4TTSe/YCo4OfJUip0uuZFu45GfEJ5tdSggQiYGQ4g2pzjQQe24gtb5x8A3VCG31anOehFlvmK/LvIieLCqMNi2CUl25PHmD59vX8CQHqmhyOrgvT6DgB1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447549; c=relaxed/simple;
	bh=aO57Ou1MH+quxkiL25nMckAqwDtDBBl9XzSzP4oRZqY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aFxwi6BN+Jt0EvzxxbPYzhUuz/6cxIjlyaUgnRIv8p8bfNiUMZGP7SVF2U7nRP7l2JVF7ndgoOHstHB2IDpqBeqgFtPmIZvULxPWrsrtqNJvqViLGkwB6vzEpscSFtS+CBc9WW/GncJMULqIxC0JB0BAvmhPGjn/gFfmAtb2kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KuPyROme; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z8f//cXP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Mar 2026 10:32:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772447546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryPwT1BqglLr23CRv5b6zRB5alFrzbQu8J/OLcWz/k8=;
	b=KuPyROme+rgQEcm4kwolRlaPgHwnqOxYOo2U6P5anhXQhYk69RWWIVH3RVENf+CfMUomqR
	jtCih1HSDr95y0OunKkw2Xox3/OEmuG9/slN1sBkEO/tNNINxdf7OEGV0oJBlvHTF+sqjn
	0t6RS3wb1dVLcvSMJlvQNOnG0u82MEtuwKFFtvH0aTVO255XJfZN/dk8XtbXi1QE+lHc05
	K5/emDchJMOQDuGh28OiQzWe564HRwJWp9K1tqopx0ZlixuAdnavlZVgaZ8nmdNLm7tzUj
	OS9RiqQ0bNRhU9e6x8gU0AYsALcMJQ2vgBpCIaMMwbhJ9gdOHiqaqNdqh1zcmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772447546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryPwT1BqglLr23CRv5b6zRB5alFrzbQu8J/OLcWz/k8=;
	b=Z8f//cXPWYSN9/H0DWRQKj8ElcGG+xjqfkDWr+h934kqQ9dzYceV2ykpIuD8d28CGFuFbC
	81CoCusABKuAPjBg==
From: "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Allow IBPB-on-Entry feature for SNP guests
Cc: Kim Phillips <kim.phillips@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, stable@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260203222405.4065706-2-kim.phillips@amd.com>
References: <20260203222405.4065706-2-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177244754464.1647592.8698682194686122019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-8335-lists,linux-tip-commits=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,vger.kernel.org:replyto,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,msgid.link:url]
X-Rspamd-Queue-Id: F3D9A1D6BBB
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9073428bb204d921ae15326bb7d4558d9d269aab
Gitweb:        https://git.kernel.org/tip/9073428bb204d921ae15326bb7d4558d9d2=
69aab
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 03 Feb 2026 16:24:03 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Mar 2026 11:08:59 +01:00

x86/sev: Allow IBPB-on-Entry feature for SNP guests

The SEV-SNP IBPB-on-Entry feature does not require a guest-side
implementation. It was added in Zen5 h/w, after the first SNP Zen
implementation, and thus was not accounted for when the initial set of SNP
features were added to the kernel.

In its abundant precaution, commit

  8c29f0165405 ("x86/sev: Add SEV-SNP guest feature negotiation support")

included SEV_STATUS' IBPB-on-Entry bit as a reserved bit, thereby masking
guests from using the feature.

Allow guests to make use of IBPB-on-Entry when supported by the hypervisor, as
the bit is now architecturally defined and safe to expose.

Fixes: 8c29f0165405 ("x86/sev: Add SEV-SNP guest feature negotiation support")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20260203222405.4065706-2-kim.phillips@amd.com
---
 arch/x86/boot/compressed/sev.c   | 1 +
 arch/x86/coco/sev/core.c         | 1 +
 arch/x86/include/asm/msr-index.h | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 46b5472..e468476 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -188,6 +188,7 @@ bool sev_es_check_ghcb_fault(unsigned long address)
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
 				 MSR_AMD64_SNP_SECURE_AVIC |		\
+				 MSR_AMD64_SNP_RESERVED_BITS19_22 |	\
 				 MSR_AMD64_SNP_RESERVED_MASK)
=20
 #ifdef CONFIG_AMD_SECURE_AVIC
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 907981b..7ed3da9 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -89,6 +89,7 @@ static const char * const sev_status_feat_names[] =3D {
 	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	=3D "VMSARegProt",
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		=3D "SMTProt",
 	[MSR_AMD64_SNP_SECURE_AVIC_BIT]		=3D "SecureAVIC",
+	[MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT]	=3D "IBPBOnEntry",
 };
=20
 /*
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index da5275d..6673601 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -740,7 +740,10 @@
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
 #define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
 #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
-#define MSR_AMD64_SNP_RESV_BIT		19
+#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
+#define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
+#define MSR_AMD64_SNP_IBPB_ON_ENTRY	BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		24
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 #define MSR_AMD64_SAVIC_CONTROL		0xc0010138
 #define MSR_AMD64_SAVIC_EN_BIT		0

