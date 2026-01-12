Return-Path: <linux-tip-commits+bounces-7880-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E3D110DB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F9BF3039DD1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F289346AC7;
	Mon, 12 Jan 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GTYIdGSF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttdqnooe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D70343D62;
	Mon, 12 Jan 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205003; cv=none; b=VY/qJBUgaSVx6aIUH1h7aXc0oKjwIInT5ejDx5u7/Iz/NFF+p4R3b7gqoOjSaMxpb7g/MM6HEZ8XhZMZA3C/HAfyV5vY2jN23v2xcCPamZ0K5W/6EPNQoL3qE4ldTMEuIHwgUG/WIZtE2uPpnraHy8DWzDHLCkrjz0jabXe4S04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205003; c=relaxed/simple;
	bh=VXSSWn2J2cg2qrGwaPo6LI0sErcnPBM5cZHob3raxjk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NZQ+2bcy1zhLtSi5aXjhqiAanA8QMXZVoopslFkNDeo0PcuMKR+NoEII5NbLJ+xNQsAdGYT/59lCpLbqQXUwwnO5dt1R2vRdO9r+lXtpDd5TVFBdtvNOPJ4/rPEv35X/PU8wXARxwX3vGIgRc1xD6wDI5KVvjBQJCw8r5DhnSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GTYIdGSF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttdqnooe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJuILlrpunqc4UPc6wGsuX/ucGiLWqbTQ+oapuTh41c=;
	b=GTYIdGSFUvj1jdGB9LVY4zjto2Fvt+ZCclKClWBebzLAEne7xBypFRL/qCGK1z9jyYVftD
	HKdF8HvWnbWhaSFZlBRclJAtdv/pfeGvTRhzmmDl0JsNzPkm9GlFGI2JuHCOaApBadpjQ4
	Fw/J3cnY4rFyrOCwnl5Tp8Kl7Yp/eKwnzHvdkrkYqF5m7qScMmHQjY4QO2Dkr87TuZ/aKD
	gj8U90n3JsF/FWv7tRZowqHsx3XTF9JJCRrDl+GqPlQp7PSN1wtd8BsUQFvLD9feHMO55+
	2i6b+/wlrpU1X5cOhY1qL240csU+gNvLO+uOLDngdCGntGNmbRuTXqqcOJr3rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJuILlrpunqc4UPc6wGsuX/ucGiLWqbTQ+oapuTh41c=;
	b=ttdqnooemqr84kQpHmT65Ech8e+lHavUFJdtoJNJJSCo4oilUZJ8K2Zteh18O6XCbfd7KS
	G5vTC9BRhrJBGfCQ==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add CBB PMON support for
 Diamond Rapids
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-6-zide.chen@intel.com>
References: <20251231224233.113839-6-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820499256.510.2331749491019073395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     66e2075426f3220857eb3987c803764c82cef851
Gitweb:        https://git.kernel.org/tip/66e2075426f3220857eb3987c803764c82c=
ef851
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:22 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:24 +01:00

perf/x86/intel/uncore: Add CBB PMON support for Diamond Rapids

On DMR, PMON units inside the Core Building Block (CBB) are enumerated
separately from those in the Integrated Memory and I/O Hub (IMH).

A new per-CBB MSR (0x710) is introduced for discovery table enumeration.

For counter control registers, the tid_en bit (bit 16) exists on CBO,
SBO, and Santa, but it is not used by any events.  Mark this bit as
reserved.

Similarly, disallow extended umask (bits 32=E2=80=9363) on Santa and sNCU.

Additionally, ignore broken SB2UCIE unit.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-6-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c           |  2 +-
 arch/x86/events/intel/uncore.h           |  1 +-
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 arch/x86/events/intel/uncore_snbep.c     | 52 +++++++++++++++++++++--
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 40cf9bf..08e5dd4 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1837,6 +1837,8 @@ static const struct uncore_plat_init dmr_uncore_init __=
initconst =3D {
 	.domain[0].base_is_pci =3D true,
 	.domain[0].discovery_base =3D DMR_UNCORE_DISCOVERY_TABLE_DEVICE,
 	.domain[0].units_ignore =3D dmr_uncore_imh_units_ignore,
+	.domain[1].discovery_base =3D CBB_UNCORE_DISCOVERY_MSR,
+	.domain[1].units_ignore =3D dmr_uncore_cbb_units_ignore,
 };
=20
 static const struct uncore_plat_init generic_uncore_init __initconst =3D {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 1e4b3a2..83d01a9 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -615,6 +615,7 @@ extern struct event_constraint uncore_constraint_empty;
 extern int spr_uncore_units_ignore[];
 extern int gnr_uncore_units_ignore[];
 extern int dmr_uncore_imh_units_ignore[];
+extern int dmr_uncore_cbb_units_ignore[];
=20
 /* uncore_snb.c */
 int snb_uncore_pci_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel=
/uncore_discovery.h
index 618788c..63b8f76 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -2,6 +2,8 @@
=20
 /* Store the full address of the global discovery table */
 #define UNCORE_DISCOVERY_MSR			0x201e
+/* Base address of uncore perfmon discovery table for CBB domain */
+#define CBB_UNCORE_DISCOVERY_MSR		0x710
=20
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index 4b72560..df17353 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6807,6 +6807,28 @@ static struct intel_uncore_type dmr_uncore_hamvf =3D {
 	.attr_update		=3D uncore_alias_groups,
 };
=20
+static struct intel_uncore_type dmr_uncore_cbo =3D {
+	.name			=3D "cbo",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_santa =3D {
+	.name			=3D "santa",
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_cncu =3D {
+	.name			=3D "cncu",
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_sncu =3D {
+	.name			=3D "sncu",
+	.attr_update		=3D uncore_alias_groups,
+};
+
 static struct intel_uncore_type dmr_uncore_ula =3D {
 	.name			=3D "ula",
 	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
@@ -6814,6 +6836,20 @@ static struct intel_uncore_type dmr_uncore_ula =3D {
 	.attr_update		=3D uncore_alias_groups,
 };
=20
+static struct intel_uncore_type dmr_uncore_dda =3D {
+	.name			=3D "dda",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_sbo =3D {
+	.name			=3D "sbo",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
 static struct intel_uncore_type dmr_uncore_ubr =3D {
 	.name			=3D "ubr",
 	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
@@ -6902,10 +6938,15 @@ static struct intel_uncore_type *dmr_uncores[UNCORE_D=
MR_NUM_UNCORE_TYPES] =3D {
 	NULL, NULL, NULL,
 	NULL, NULL,
 	&dmr_uncore_hamvf,
-	NULL,
-	NULL, NULL, NULL,
+	&dmr_uncore_cbo,
+	&dmr_uncore_santa,
+	&dmr_uncore_cncu,
+	&dmr_uncore_sncu,
 	&dmr_uncore_ula,
-	NULL, NULL, NULL, NULL,
+	&dmr_uncore_dda,
+	NULL,
+	&dmr_uncore_sbo,
+	NULL,
 	NULL, NULL, NULL,
 	&dmr_uncore_ubr,
 	NULL,
@@ -6923,6 +6964,11 @@ int dmr_uncore_imh_units_ignore[] =3D {
 	UNCORE_IGNORE_END
 };
=20
+int dmr_uncore_cbb_units_ignore[] =3D {
+	0x25,		/* SB2UCIE */
+	UNCORE_IGNORE_END
+};
+
 int dmr_uncore_pci_init(void)
 {
 	uncore_pci_uncores =3D uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL,

