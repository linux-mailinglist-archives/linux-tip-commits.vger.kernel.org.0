Return-Path: <linux-tip-commits+bounces-8365-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGTrC7PUqWmcFwEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8365-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 20:08:35 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 836DE217402
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 20:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB7230CD902
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 19:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F69308F0A;
	Thu,  5 Mar 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmGEYfm4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qe/JbuYU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8B3016F2;
	Thu,  5 Mar 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737659; cv=none; b=dQtRNy9EZb31OTSaE7UYn5WTXzEPP8xRXHDpiatQvArFilPhQrXibe531Eq2u7Wm988wPBk6Fj+L1RiEu/3lSDLuF2facR3Oov/mVxVYJJ+KXFW80/7WVeefzHb+GhQQgEfd1tCfZb158hNo5USpOZ2PJTUyY9JAv8JGv62dO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737659; c=relaxed/simple;
	bh=axG+zIBW6ssfecUC3lNaf6bl8OF1skqutrVDlkhwwz8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=adgy7kjoAWKIgxcvMorND9zCtuNUns29+a1FsTAjHpwX0z/2jHHHKYxKzGJ5vCHKQVvMQOJ1Drvh1ixP0eI/OzGX6Bx7UlL70wBe2435PIAMBLoTnBjrxhzMpyEQ2hau3Tzz0YQd4L8sTOnsutGerLX8l/uUO598pLnzm16nL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmGEYfm4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qe/JbuYU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 19:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772737656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cp2IeNS55szO0baUDI9fZ52QaQXYnx0TLxyyGHHr7BI=;
	b=wmGEYfm4LdP0D7ONqYDtbiyqqupIGe3eIDu9+RlOYpSN3lxU4uCko/iY35En+pojjgE0QE
	mwbZ7KsMipGShmNjliRhTAnq9FDsu5Tl6Sserp2DXtBX/KUEhtnibZuuOAGADjBiRw2mT9
	2OFiRQMs99ml/C5g1PvOTYqraYcccTWeJe484EYwSweeo4no7v9FOvZ3vcubrrT4g+6/43
	CqgqWzkgXvq0WjkMj0yPFjkgPxbv6/vwmJ1s4yxTSxCbJ/BMcdFRBednJshdv1EyKB9rNP
	Q20kDoUYQuEcXBLfQdxYASlPsc5+3fdjZysSkooiOu7bwaTHDkIoXfXsUL8JvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772737656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cp2IeNS55szO0baUDI9fZ52QaQXYnx0TLxyyGHHr7BI=;
	b=Qe/JbuYUgxiF3PihWDJgEVxVn6NHT4Gbv+fHiZHFFhAPMTn1SqtWKJdOD7f+JljrgNpD3x
	Hyp32pMkC0ATvnCg==
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
Message-ID: <177273765504.1647592.6727522916584514244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 836DE217402
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8365-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,intel.com:email,msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     da67a0320397125fcbb2e856a31889150c648f3a
Gitweb:        https://git.kernel.org/tip/da67a0320397125fcbb2e856a31889150c6=
48f3a
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 04 Mar 2026 10:10:18 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Mar 2026 10:41:10 -08:00

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

--

Changes from v3:
 * Handle the empty platform mask on the PII

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

