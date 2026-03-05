Return-Path: <linux-tip-commits+bounces-8370-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HEfJoTnqWnuHQEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8370-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 21:28:52 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29056218237
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 21:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AB5C301C952
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507FD33A02B;
	Thu,  5 Mar 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2kjZA7Wh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRenqnrA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F693338910;
	Thu,  5 Mar 2026 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742519; cv=none; b=QbeV4qXKMnxP5+9ddnBoZi7CJdZwMJVgWaSSJ6pZPrGzlEUXyud6UjER6vx+VAHcQ1tNKVSdJ8Rc8f+GhalfJId73lnW6Wt4p4G4Ffbc5kDjqlq66uDEdzd6yKjjx182Ppvn0l/CHSgNhelBihPyhbgbPWmehV70sfF9G1o6AuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742519; c=relaxed/simple;
	bh=ZkIOBINfp1qt7BUhBSj/OjpfrZY913JBwhHcU2vrtpU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r6El/N0men0VAMGqSURjh2osLo59reQ52RUPXZ4fsCPqfT+WRgCWRgloV5xi3F6CpigvnNx067z7ySkt3LKLq9zJukSWaCCs64FpsB2a6yFEvubCOZ7RpkkiKI6ujTeSnQpNNTMBtZeHJvELe5P1xqvda9+0SHw0rQx1fAY+FYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2kjZA7Wh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRenqnrA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 20:28:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772742514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qwIFVjZFB6brU7RUe0srNLojZVQw9n89AT2LDytJnc=;
	b=2kjZA7WhNOv4WNDQb/QwkY/44i/sXktiwatwhTShKlxF4afOYOn8MDxpKcCDR5oM/LYBnV
	O/tiiMfQQXFj6t2eyYIhALfwf5A5WZEPahOMU15iBKg1W/0PP8TCgs/VuGP89FcxAD82K3
	rpJF8CQdM7wxSj0wAp9HHVX4P5A3GfnOS518y4PUheNwRN2edIP7O+AbUW1ye5jILC3NT7
	Z7kE6OqTnCmYAfUR6/7hrCvFm91vtpUfY219AHpOGhtXKLqi9an7heEjqWw4vQddUnTSf+
	TfUgE7mVFjVSE399A0kJ+oYuyzezj2NLKW3OVKZ6xnt82aYaY2UesqylYPpp5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772742514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qwIFVjZFB6brU7RUe0srNLojZVQw9n89AT2LDytJnc=;
	b=dRenqnrA1JcDeL9U/s9W/lDlTjV8lX8R42NkwCaWXUFanQONN9vzPYQbRnBNKOM4YINk5M
	D/+qOFvgmm6sdkDw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Refactor platform ID enumeration
 into a helper
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260304181018.EB6404F8@davehans-spike.ostc.intel.com>
References: <20260304181018.EB6404F8@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177274251336.1647592.6006755106208766763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 29056218237
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8370-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:replyto,linutronix.de:dkim,msgid.link:url,intel.com:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     238be4ba87605da69de2131e8736be7a0d299e00
Gitweb:        https://git.kernel.org/tip/238be4ba87605da69de2131e8736be7a0d2=
99e00
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 04 Mar 2026 10:10:18 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Mar 2026 12:25:18 -08:00

x86/microcode: Refactor platform ID enumeration into a helper

Today, the only code that cares about the platform ID is the microcode
update code itself. To facilitate storing the platform ID in a more
generic place and using it outside of the microcode update itself, put
the enumeration into a helper function. Mirror
intel_get_microcode_revision()'s naming and location.

But, moving away from intel_collect_cpu_info() means that the model
and family information in CPUID is not readily available. Just call
CPUID again.

Note that the microcode header is a mask of supported platform IDs.
Only stick the ID part in the helper. Leave the 1<<id part in the
microcode handling.

Also note that the PII is weird. It does not really have a platform
ID because it doesn't even have the MSR. Just consider it to be
platform ID 0. Instead of saying >=3DPII, say <=3DPII. The PII is the
real oddball here being the only CPU with Linux microcode updates
but no platform ID. It's worth calling it out by name.

This does subtly change the sig->pf for the PII though from 0x0
to 0x1. Make up for that by ignoring sig->pf when the microcode
update platform mask is 0x0.

[ dhansen: reflow comment for bpetkov ]

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://patch.msgid.link/20260304181018.EB6404F8@davehans-spike.ostc.in=
tel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 54 ++++++++++++++++++++------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index 8744f3a..83c6cd2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -120,19 +120,44 @@ static inline unsigned int exttable_size(struct extende=
d_sigtable *et)
 	return et->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE;
 }
=20
+
+/*
+ * Use CPUID to generate a "vfm" value. Useful before cpuinfo_x86
+ * structures are populated.
+ */
+static u32 intel_cpuid_vfm(void)
+{
+	u32 eax   =3D cpuid_eax(1);
+	u32 fam   =3D x86_family(eax);
+	u32 model =3D x86_model(eax);
+
+	return IFM(fam, model);
+}
+
+static u32 intel_get_platform_id(void)
+{
+	unsigned int val[2];
+
+	/*
+	 * This can be called early. Use CPUID directly instead of
+	 * relying on cpuinfo_x86 which may not be fully initialized.
+	 * The PII does not have MSR_IA32_PLATFORM_ID. Everything
+	 * before _it_ has no microcode (for Linux at least).
+	 */
+	if (intel_cpuid_vfm() <=3D INTEL_PENTIUM_II_KLAMATH)
+		return 0;
+
+	/* get processor flags from MSR 0x17 */
+	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
+
+	return (val[1] >> 18) & 7;
+}
+
 void intel_collect_cpu_info(struct cpu_signature *sig)
 {
 	sig->sig =3D cpuid_eax(1);
-	sig->pf =3D 0;
 	sig->rev =3D intel_get_microcode_revision();
-
-	if (IFM(x86_family(sig->sig), x86_model(sig->sig)) >=3D INTEL_PENTIUM_III_D=
ESCHUTES) {
-		unsigned int val[2];
-
-		/* get processor flags from MSR 0x17 */
-		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-		sig->pf =3D 1 << ((val[1] >> 18) & 7);
-	}
+	sig->pf  =3D 1 << intel_get_platform_id();
 }
 EXPORT_SYMBOL_GPL(intel_collect_cpu_info);
=20
@@ -142,8 +167,15 @@ static inline bool cpu_signatures_match(struct cpu_signa=
ture *s1, unsigned int s
 	if (s1->sig !=3D sig2)
 		return false;
=20
-	/* Processor flags are either both 0 or they intersect. */
-	return ((!s1->pf && !pf2) || (s1->pf & pf2));
+	/*
+	 * Consider an empty mask to match everything. This
+	 * should only occur for one CPU model, the PII.
+	 */
+	if (!pf2)
+		return true;
+
+	/* Is the CPU's platform ID in the signature mask? */
+	return s1->pf & pf2;
 }
=20
 bool intel_find_matching_signature(void *mc, struct cpu_signature *sig)

