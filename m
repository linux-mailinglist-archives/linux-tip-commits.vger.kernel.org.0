Return-Path: <linux-tip-commits+bounces-6456-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C0AB439C2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574D65A21C3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305142FB61F;
	Thu,  4 Sep 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJmO78dG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dxuOLcGa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD72F39CB;
	Thu,  4 Sep 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984842; cv=none; b=BvA/8OPuWZXq3WVIMpiNaEd2+9w4SH4ZMZAkUVCo0InJTSuNNHmlP9b78CxifpYRgEN/6gx1SS/mNkXmRasYOlHOOUCOdHd8yAo3lDoEp9cNe1XvW3G+ba//3qdlwQrhYNVjxUvhDtdAPGQX/mv70VUCVy94qQLGMVwAHRGJr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984842; c=relaxed/simple;
	bh=vH8OQO2zhTiU2L9n0ByWe7OQbc1NvYBW1mZuRH1VKnM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oApr7nznTHNVz2aGZHbDeEiLWwLiasZUhaC4cT3l+OADGxTa1nQTg41+bM7E+9sbWG5ykVdwYQxzse80kbH5rbrfZJUff2eQLCnnaR+Yt2GRCNnnW+k8ujBI4bBZ8L+gBWyhoE3qvl5sD4yobaU5UYtuLyD5KIPJaoNnY/0FvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJmO78dG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dxuOLcGa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1VV5v4APnlO6JsG0BWoYhfYHX9oFBrp29imJ3fkiWvE=;
	b=xJmO78dG1m2cxOSq2RcE8sHmxki61nfKWYQV00JoYiTzogGjxjXEBEcQcGTSPasqSXWHvx
	UKdbm2VOMo+A8NbNvahLWVraub4NrVJ8+T0sqvC0sCONPXK8lNVBzE91WbL6DkYFu88/97
	soiNyjHPDN1M7FUx735EAVZex5TR4qJ0T8j3+wvWxoCB/KmczvnLgkhmr6R7Re8nZHnquC
	osHkcGAfyX6wAADFVyJn2jFmeCF6RUIshLMFzSbTrzbbNlWp04lIVYnEH2cfY2k0K35FBX
	Vud81ZXV60BavQwsD9mhUxEd6s+JO/i+YMqbxoeoWFxEmDjPfuC2Z/0KGrNTfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1VV5v4APnlO6JsG0BWoYhfYHX9oFBrp29imJ3fkiWvE=;
	b=dxuOLcGa2/FIv8ukFlorlkU1zUmDbN3MA/iM7CDDARNwSaYNJAg7tXBw9YQsVT0CGs9BVM
	HWvKW89DN3+LZMDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/savic: Do not use snp_abort()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698483743.1920.18154640171454268117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     d4bc3b11c12b41fdb5650f5ad797de97f8dce869
Gitweb:        https://git.kernel.org/tip/d4bc3b11c12b41fdb5650f5ad797de97f8d=
ce869
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 03 Sep 2025 17:42:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Sep 2025 13:12:51 +02:00

x86/apic/savic: Do not use snp_abort()

This function is going away so replace the callsites with the equivalent
functionality. Add a new SAVIC-specific termination reason. If more
granularity is needed there, it will be revisited in the future.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/coco/sev/core.c            | 4 ++--
 arch/x86/include/asm/sev-common.h   | 1 +
 arch/x86/kernel/apic/x2apic_savic.c | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b64f430..e858e29 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1129,7 +1129,7 @@ u64 savic_ghcb_msr_read(u32 reg)
 	if (res !=3D ES_OK) {
 		pr_err("Secure AVIC MSR (0x%llx) read returned error (%d)\n", msr, res);
 		/* MSR read failures are treated as fatal errors */
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 	}
=20
 	__sev_put_ghcb(&state);
@@ -1159,7 +1159,7 @@ void savic_ghcb_msr_write(u32 reg, u64 value)
 	if (res !=3D ES_OK) {
 		pr_err("Secure AVIC MSR (0x%llx) write returned error (%d)\n", msr, res);
 		/* MSR writes should never fail. Any failure is fatal error for SNP guest =
*/
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 	}
=20
 	__sev_put_ghcb(&state);
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-com=
mon.h
index 0020d77..01a6e4d 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -208,6 +208,7 @@ struct snp_psc_desc {
 #define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but CAA is not page aligned=
 */
 #define GHCB_TERM_SECURE_TSC		10	/* Secure TSC initialization failed */
 #define GHCB_TERM_SVSM_CA_REMAP_FAIL	11	/* SVSM is present but CA could not =
be remapped */
+#define GHCB_TERM_SAVIC_FAIL		12	/* Secure AVIC-specific failure */
=20
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
=20
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index b846de0..dbc5678 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -363,7 +363,7 @@ static void savic_setup(void)
 	 */
 	res =3D savic_register_gpa(gpa);
 	if (res !=3D ES_OK)
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
=20
 	native_wrmsrq(MSR_AMD64_SAVIC_CONTROL,
 		      gpa | MSR_AMD64_SAVIC_EN | MSR_AMD64_SAVIC_ALLOWEDNMI);
@@ -376,13 +376,13 @@ static int savic_probe(void)
=20
 	if (!x2apic_mode) {
 		pr_err("Secure AVIC enabled in non x2APIC mode\n");
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 		/* unreachable */
 	}
=20
 	savic_page =3D alloc_percpu(struct secure_avic_page);
 	if (!savic_page)
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
=20
 	return 1;
 }

