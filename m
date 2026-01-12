Return-Path: <linux-tip-commits+bounces-7886-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B2D110F0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 785D830224A0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C4346E5A;
	Mon, 12 Jan 2026 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HIMOcAOL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/G06eMLm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC833FE27;
	Mon, 12 Jan 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205009; cv=none; b=bjJsOqAqIcaAkcXvEHyP7fr7fNsKa8p+jplvhNt4sf7W6G36+FG0/RHTyNAG4hnTBnHfUiNqo/0cQukinIw0laFwcyFIf/tQzhJekHzqr6Te2TxmTvPbPNe0N/LsZyFZXpGXfM2adDvQmE4jLZ7k8N/TtbIJwTeX4DaDLW5bs5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205009; c=relaxed/simple;
	bh=RlP96uxNCdevkT7ZgQHPtry48I4DCzKgdVfQwMf+g/4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FIrTb8pNf+qljI/sALkqqUCtuyuVrhe6gREEFIaWizwzHWCC/qB0j1wOWuTfX90ewDeT+HpJSmZbq9tqAVgpgiA36jK+nqfxbo9VRS+u9HXn4DdOq3TfwDqImx0zQ6S8xwfmFY75CXGjGmEsN5EVScYm+d39e8mJhxYwzUuDhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HIMOcAOL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/G06eMLm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHaSjTqfzU+8cr3P4QlUZbMMSvgyGEt2Z/dqhCw8I9o=;
	b=HIMOcAOLpgHmuBRuUWop2QybkWlNso8Ys0KNj31kuM/7FAqT0VR5gSTmRaA8jVkRZVck53
	OjV4RMjl4CInH7oz/faCxUrpXT2OaudI8zRXuH1dmMluknM4wupq3NZn0K+hhkPkfXMC6O
	xh8Z4oGSJguMRw3e7pZ0lEZKfiz1TygKKVvc3cdHR2tS6zx2ru0WFbkH2eXJFL5t2m7QeE
	B9WIIMERNY9jrOGPJbZmRcuMilJ/regg5MfI4fXVdG34yhtEdnVn1l9Sgtirx7D3NP346A
	QvIXacW+coLsKem8o95qY/dU8i0LCYGcBKP2M8zLcawipGC3P0gD7+CyFlZyng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHaSjTqfzU+8cr3P4QlUZbMMSvgyGEt2Z/dqhCw8I9o=;
	b=/G06eMLmXtx0oQf7VUU5HAI86qrhzj2CVqvQLJIJmnItXoipN9pjvC/votL63CZvn4XLFo
	hCbsraI14CUb9bAg==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Move uncore discovery init
 struct to header
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-2-zide.chen@intel.com>
References: <20251231224233.113839-2-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820499707.510.14424703621065998666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     098fe55a450b280d8a8584b2511634e1236ba96d
Gitweb:        https://git.kernel.org/tip/098fe55a450b280d8a8584b2511634e1236=
ba96d
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:18 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:23 +01:00

perf/x86/intel/uncore: Move uncore discovery init struct to header

The discovery base MSR or PCI device is platform-specific and must be
defined statically in the per-platform init table and passed to the
discovery code.

Move the definition of struct intel_uncore_init_fun to uncore.h so it
can be accessed by discovery code, and rename it to reflect that it
now carries more than just init callbacks.

Shorten intel_uncore_has_discovery_tables[_pci/msr] to
uncore_discovery[_pci/msr] for improved readability and alignment.

Drop the `intel_` prefix from new names since the code is under the
intel directory and long identifiers make alignment harder.  Further
cleanups will continue removing `intel_` prefixes.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-2-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c           | 72 +++++++++--------------
 arch/x86/events/intel/uncore.h           | 10 +++-
 arch/x86/events/intel/uncore_discovery.c | 12 ++--
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 4 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e228e56..cd56129 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1697,133 +1697,123 @@ err:
 	return ret;
 }
=20
-struct intel_uncore_init_fun {
-	void	(*cpu_init)(void);
-	int	(*pci_init)(void);
-	void	(*mmio_init)(void);
-	/* Discovery table is required */
-	bool	use_discovery;
-	/* The units in the discovery table should be ignored. */
-	int	*uncore_units_ignore;
-};
-
-static const struct intel_uncore_init_fun nhm_uncore_init __initconst =3D {
+static const struct uncore_plat_init nhm_uncore_init __initconst =3D {
 	.cpu_init =3D nhm_uncore_cpu_init,
 };
=20
-static const struct intel_uncore_init_fun snb_uncore_init __initconst =3D {
+static const struct uncore_plat_init snb_uncore_init __initconst =3D {
 	.cpu_init =3D snb_uncore_cpu_init,
 	.pci_init =3D snb_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun ivb_uncore_init __initconst =3D {
+static const struct uncore_plat_init ivb_uncore_init __initconst =3D {
 	.cpu_init =3D snb_uncore_cpu_init,
 	.pci_init =3D ivb_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun hsw_uncore_init __initconst =3D {
+static const struct uncore_plat_init hsw_uncore_init __initconst =3D {
 	.cpu_init =3D snb_uncore_cpu_init,
 	.pci_init =3D hsw_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun bdw_uncore_init __initconst =3D {
+static const struct uncore_plat_init bdw_uncore_init __initconst =3D {
 	.cpu_init =3D snb_uncore_cpu_init,
 	.pci_init =3D bdw_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun snbep_uncore_init __initconst =3D {
+static const struct uncore_plat_init snbep_uncore_init __initconst =3D {
 	.cpu_init =3D snbep_uncore_cpu_init,
 	.pci_init =3D snbep_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun nhmex_uncore_init __initconst =3D {
+static const struct uncore_plat_init nhmex_uncore_init __initconst =3D {
 	.cpu_init =3D nhmex_uncore_cpu_init,
 };
=20
-static const struct intel_uncore_init_fun ivbep_uncore_init __initconst =3D {
+static const struct uncore_plat_init ivbep_uncore_init __initconst =3D {
 	.cpu_init =3D ivbep_uncore_cpu_init,
 	.pci_init =3D ivbep_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun hswep_uncore_init __initconst =3D {
+static const struct uncore_plat_init hswep_uncore_init __initconst =3D {
 	.cpu_init =3D hswep_uncore_cpu_init,
 	.pci_init =3D hswep_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun bdx_uncore_init __initconst =3D {
+static const struct uncore_plat_init bdx_uncore_init __initconst =3D {
 	.cpu_init =3D bdx_uncore_cpu_init,
 	.pci_init =3D bdx_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun knl_uncore_init __initconst =3D {
+static const struct uncore_plat_init knl_uncore_init __initconst =3D {
 	.cpu_init =3D knl_uncore_cpu_init,
 	.pci_init =3D knl_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun skl_uncore_init __initconst =3D {
+static const struct uncore_plat_init skl_uncore_init __initconst =3D {
 	.cpu_init =3D skl_uncore_cpu_init,
 	.pci_init =3D skl_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun skx_uncore_init __initconst =3D {
+static const struct uncore_plat_init skx_uncore_init __initconst =3D {
 	.cpu_init =3D skx_uncore_cpu_init,
 	.pci_init =3D skx_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun icl_uncore_init __initconst =3D {
+static const struct uncore_plat_init icl_uncore_init __initconst =3D {
 	.cpu_init =3D icl_uncore_cpu_init,
 	.pci_init =3D skl_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun tgl_uncore_init __initconst =3D {
+static const struct uncore_plat_init tgl_uncore_init __initconst =3D {
 	.cpu_init =3D tgl_uncore_cpu_init,
 	.mmio_init =3D tgl_uncore_mmio_init,
 };
=20
-static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst =3D {
+static const struct uncore_plat_init tgl_l_uncore_init __initconst =3D {
 	.cpu_init =3D tgl_uncore_cpu_init,
 	.mmio_init =3D tgl_l_uncore_mmio_init,
 };
=20
-static const struct intel_uncore_init_fun rkl_uncore_init __initconst =3D {
+static const struct uncore_plat_init rkl_uncore_init __initconst =3D {
 	.cpu_init =3D tgl_uncore_cpu_init,
 	.pci_init =3D skl_uncore_pci_init,
 };
=20
-static const struct intel_uncore_init_fun adl_uncore_init __initconst =3D {
+static const struct uncore_plat_init adl_uncore_init __initconst =3D {
 	.cpu_init =3D adl_uncore_cpu_init,
 	.mmio_init =3D adl_uncore_mmio_init,
 };
=20
-static const struct intel_uncore_init_fun mtl_uncore_init __initconst =3D {
+static const struct uncore_plat_init mtl_uncore_init __initconst =3D {
 	.cpu_init =3D mtl_uncore_cpu_init,
 	.mmio_init =3D adl_uncore_mmio_init,
 };
=20
-static const struct intel_uncore_init_fun lnl_uncore_init __initconst =3D {
+static const struct uncore_plat_init lnl_uncore_init __initconst =3D {
 	.cpu_init =3D lnl_uncore_cpu_init,
 	.mmio_init =3D lnl_uncore_mmio_init,
 };
=20
-static const struct intel_uncore_init_fun ptl_uncore_init __initconst =3D {
+static const struct uncore_plat_init ptl_uncore_init __initconst =3D {
 	.cpu_init =3D ptl_uncore_cpu_init,
 	.mmio_init =3D ptl_uncore_mmio_init,
 	.use_discovery =3D true,
 };
=20
-static const struct intel_uncore_init_fun icx_uncore_init __initconst =3D {
+static const struct uncore_plat_init icx_uncore_init __initconst =3D {
 	.cpu_init =3D icx_uncore_cpu_init,
 	.pci_init =3D icx_uncore_pci_init,
 	.mmio_init =3D icx_uncore_mmio_init,
 };
=20
-static const struct intel_uncore_init_fun snr_uncore_init __initconst =3D {
+static const struct uncore_plat_init snr_uncore_init __initconst =3D {
 	.cpu_init =3D snr_uncore_cpu_init,
 	.pci_init =3D snr_uncore_pci_init,
 	.mmio_init =3D snr_uncore_mmio_init,
 };
=20
-static const struct intel_uncore_init_fun spr_uncore_init __initconst =3D {
+static const struct uncore_plat_init spr_uncore_init __initconst =3D {
 	.cpu_init =3D spr_uncore_cpu_init,
 	.pci_init =3D spr_uncore_pci_init,
 	.mmio_init =3D spr_uncore_mmio_init,
@@ -1831,7 +1821,7 @@ static const struct intel_uncore_init_fun spr_uncore_in=
it __initconst =3D {
 	.uncore_units_ignore =3D spr_uncore_units_ignore,
 };
=20
-static const struct intel_uncore_init_fun gnr_uncore_init __initconst =3D {
+static const struct uncore_plat_init gnr_uncore_init __initconst =3D {
 	.cpu_init =3D gnr_uncore_cpu_init,
 	.pci_init =3D gnr_uncore_pci_init,
 	.mmio_init =3D gnr_uncore_mmio_init,
@@ -1839,7 +1829,7 @@ static const struct intel_uncore_init_fun gnr_uncore_in=
it __initconst =3D {
 	.uncore_units_ignore =3D gnr_uncore_units_ignore,
 };
=20
-static const struct intel_uncore_init_fun generic_uncore_init __initconst =
=3D {
+static const struct uncore_plat_init generic_uncore_init __initconst =3D {
 	.cpu_init =3D intel_uncore_generic_uncore_cpu_init,
 	.pci_init =3D intel_uncore_generic_uncore_pci_init,
 	.mmio_init =3D intel_uncore_generic_uncore_mmio_init,
@@ -1910,7 +1900,7 @@ MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
 static int __init intel_uncore_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct intel_uncore_init_fun *uncore_init;
+	struct uncore_plat_init *uncore_init;
 	int pret =3D 0, cret =3D 0, mret =3D 0, ret;
=20
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
@@ -1921,16 +1911,16 @@ static int __init intel_uncore_init(void)
=20
 	id =3D x86_match_cpu(intel_uncore_match);
 	if (!id) {
-		if (!uncore_no_discover && intel_uncore_has_discovery_tables(NULL))
-			uncore_init =3D (struct intel_uncore_init_fun *)&generic_uncore_init;
+		if (!uncore_no_discover && uncore_discovery(NULL))
+			uncore_init =3D (struct uncore_plat_init *)&generic_uncore_init;
 		else
 			return -ENODEV;
 	} else {
-		uncore_init =3D (struct intel_uncore_init_fun *)id->driver_data;
+		uncore_init =3D (struct uncore_plat_init *)id->driver_data;
 		if (uncore_no_discover && uncore_init->use_discovery)
 			return -ENODEV;
 		if (uncore_init->use_discovery &&
-		    !intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
+		    !uncore_discovery(uncore_init))
 			return -ENODEV;
 	}
=20
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index d8815ff..568536e 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -47,6 +47,16 @@ struct uncore_event_desc;
 struct freerunning_counters;
 struct intel_uncore_topology;
=20
+struct uncore_plat_init {
+	void	(*cpu_init)(void);
+	int	(*pci_init)(void);
+	void	(*mmio_init)(void);
+	/* Discovery table is required */
+	bool	use_discovery;
+	/* The units in the discovery table should be ignored. */
+	int	*uncore_units_ignore;
+};
+
 struct intel_uncore_type {
 	const char *name;
 	int num_counters;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel=
/uncore_discovery.c
index 330bca2..97f1443 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -350,7 +350,7 @@ static int parse_discovery_table(struct pci_dev *dev, int=
 die,
 	return __parse_discovery_table(addr, die, parsed, ignore);
 }
=20
-static bool intel_uncore_has_discovery_tables_pci(int *ignore)
+static bool uncore_discovery_pci(int *ignore)
 {
 	u32 device, val, entry_id, bar_offset;
 	int die, dvsec =3D 0, ret =3D true;
@@ -399,7 +399,7 @@ err:
 	return ret;
 }
=20
-static bool intel_uncore_has_discovery_tables_msr(int *ignore)
+static bool uncore_discovery_msr(int *ignore)
 {
 	unsigned long *die_mask;
 	bool parsed =3D false;
@@ -432,10 +432,12 @@ static bool intel_uncore_has_discovery_tables_msr(int *=
ignore)
 	return parsed;
 }
=20
-bool intel_uncore_has_discovery_tables(int *ignore)
+bool uncore_discovery(struct uncore_plat_init *init)
 {
-	return intel_uncore_has_discovery_tables_msr(ignore) ||
-	       intel_uncore_has_discovery_tables_pci(ignore);
+	int *ignore =3D init ? init->uncore_units_ignore : NULL;
+
+	return uncore_discovery_msr(ignore) ||
+	       uncore_discovery_pci(ignore);
 }
=20
 void intel_uncore_clear_discovery_tables(void)
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel=
/uncore_discovery.h
index dff75c9..dfc237a 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -136,7 +136,7 @@ struct intel_uncore_discovery_type {
 	u16		num_units;	/* number of units */
 };
=20
-bool intel_uncore_has_discovery_tables(int *ignore);
+bool uncore_discovery(struct uncore_plat_init *init);
 void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);

