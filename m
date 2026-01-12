Return-Path: <linux-tip-commits+bounces-7882-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E837D11102
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09D57303E7D6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2828346AE6;
	Mon, 12 Jan 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQ8BB8HZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wo0QAAgy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0E3446B8;
	Mon, 12 Jan 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205006; cv=none; b=JU35frcZeeSqtuKSSwkvzY09YMp+OzP60tBUYwXZ1dRUAa3xYB0S1meJ9w1aZhgJXoIgousst3DjVZTd8SkqdjEirYn2AoinqJig22DjLhKli4NPUcfnq4a+yI1G9bq8mbl1gnWye1W2nRTKn4g7XBI08i8WdjJHhwNR0jzfCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205006; c=relaxed/simple;
	bh=SaU1IPyNjNDHeHy6Mrt4qL/nMku7VfFReMkpNM/C9xY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TcfyTbelNtyV4L7bAdizzM8/Fr0Hcvteq2QXzXMXfZoQAtbgyEC7ktaQV79h+0dvjZvOSF1FXT2XEstDoZeZTo34qpLlwHu3PWw40rIRNEZAICHFcGhZzp1B6HlU4jR+WI//BkA8oxmM+jt98nHLQPA6S8WSQ/6AT4SoFeoJMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQ8BB8HZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wo0QAAgy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLoMENkeaqhlttsqmHKPgxvPjjX4ZLFLEM3d0xHEHQM=;
	b=LQ8BB8HZo1fRoAwoMI7uITmtQyvBmKuJXHUx9mdUWD8DuJJvMPNsxxKH+jbN2z5wK7qlyR
	PtWXujZRlB4QizYW53Z+PndKEcvXq4vXJJVEFFFvIqrXHphHxXzrYbrgBQOaA06+yz/Eyv
	/8umtZrcRCJ7/PRp5zlIgc3DlNNpPMv26UeJgwv0MwyjPHsIIb0piwh1F2TQyo5sgT4he9
	a5oAo73iAxwEQVyxJltTQDvGoI5tD6BPbR0ZTw1oVGUcQ9n5xAypVpFwvxWSObLqQdClRP
	5WyMTtKRYIRo2Q1BaL4inQi0O9RnzAnWY1LJ0E/dZbRSSxiTq7uA6AuBG1xWAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLoMENkeaqhlttsqmHKPgxvPjjX4ZLFLEM3d0xHEHQM=;
	b=Wo0QAAgyB1/lx83XHSxALS3TXhJdikimHYRXiaoIzndcBDWcSjSiKSsEO2XGQLPxtpRwuP
	xeetahG1kxYYakCA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support per-platform
 discovery base devices
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-3-zide.chen@intel.com>
References: <20251231224233.113839-3-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820499578.510.4758372433181769925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e75462f6c7eaa5affd922c9a14591cdd5e3ab63d
Gitweb:        https://git.kernel.org/tip/e75462f6c7eaa5affd922c9a14591cdd5e3=
ab63d
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:19 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:23 +01:00

perf/x86/intel/uncore: Support per-platform discovery base devices

On DMR platforms, IMH discovery tables are enumerated via PCI, while
CBB domains use MSRs, unlike earlier platforms which relied on either
PCI or MSR exclusively.

DMR also uses different MSRs and PCI devices, requiring support for
multiple, platform-specific discovery bases.

Introduce struct uncore_discovery_domain to hold the discovery base and
other domain-specific configuration.

Move uncore_units_ignore into uncore_discovery_domain so a single
structure can be passed to uncore_discovery_[pci/msr].

No functional change intended.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-3-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c           | 31 ++++++++-----
 arch/x86/events/intel/uncore.h           | 15 ++++--
 arch/x86/events/intel/uncore_discovery.c | 57 ++++++++++++++---------
 3 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index cd56129..78a03af 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1798,7 +1798,7 @@ static const struct uncore_plat_init lnl_uncore_init __=
initconst =3D {
 static const struct uncore_plat_init ptl_uncore_init __initconst =3D {
 	.cpu_init =3D ptl_uncore_cpu_init,
 	.mmio_init =3D ptl_uncore_mmio_init,
-	.use_discovery =3D true,
+	.domain[0].discovery_base =3D UNCORE_DISCOVERY_MSR,
 };
=20
 static const struct uncore_plat_init icx_uncore_init __initconst =3D {
@@ -1817,16 +1817,18 @@ static const struct uncore_plat_init spr_uncore_init =
__initconst =3D {
 	.cpu_init =3D spr_uncore_cpu_init,
 	.pci_init =3D spr_uncore_pci_init,
 	.mmio_init =3D spr_uncore_mmio_init,
-	.use_discovery =3D true,
-	.uncore_units_ignore =3D spr_uncore_units_ignore,
+	.domain[0].base_is_pci =3D true,
+	.domain[0].discovery_base =3D UNCORE_DISCOVERY_TABLE_DEVICE,
+	.domain[0].units_ignore =3D spr_uncore_units_ignore,
 };
=20
 static const struct uncore_plat_init gnr_uncore_init __initconst =3D {
 	.cpu_init =3D gnr_uncore_cpu_init,
 	.pci_init =3D gnr_uncore_pci_init,
 	.mmio_init =3D gnr_uncore_mmio_init,
-	.use_discovery =3D true,
-	.uncore_units_ignore =3D gnr_uncore_units_ignore,
+	.domain[0].base_is_pci =3D true,
+	.domain[0].discovery_base =3D UNCORE_DISCOVERY_TABLE_DEVICE,
+	.domain[0].units_ignore =3D gnr_uncore_units_ignore,
 };
=20
 static const struct uncore_plat_init generic_uncore_init __initconst =3D {
@@ -1897,6 +1899,16 @@ static const struct x86_cpu_id intel_uncore_match[] __=
initconst =3D {
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
=20
+static bool uncore_use_discovery(struct uncore_plat_init *config)
+{
+	for (int i =3D 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
+		if (config->domain[i].discovery_base)
+			return true;
+	}
+
+	return false;
+}
+
 static int __init intel_uncore_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -1911,15 +1923,14 @@ static int __init intel_uncore_init(void)
=20
 	id =3D x86_match_cpu(intel_uncore_match);
 	if (!id) {
-		if (!uncore_no_discover && uncore_discovery(NULL))
-			uncore_init =3D (struct uncore_plat_init *)&generic_uncore_init;
-		else
+		uncore_init =3D (struct uncore_plat_init *)&generic_uncore_init;
+		if (uncore_no_discover || !uncore_discovery(uncore_init))
 			return -ENODEV;
 	} else {
 		uncore_init =3D (struct uncore_plat_init *)id->driver_data;
-		if (uncore_no_discover && uncore_init->use_discovery)
+		if (uncore_no_discover && uncore_use_discovery(uncore_init))
 			return -ENODEV;
-		if (uncore_init->use_discovery &&
+		if (uncore_use_discovery(uncore_init) &&
 		    !uncore_discovery(uncore_init))
 			return -ENODEV;
 	}
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 568536e..1574ffc 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -47,14 +47,21 @@ struct uncore_event_desc;
 struct freerunning_counters;
 struct intel_uncore_topology;
=20
+struct uncore_discovery_domain {
+	/* MSR address or PCI device used as the discovery base */
+	u32	discovery_base;
+	bool	base_is_pci;
+	/* The units in the discovery table should be ignored. */
+	int	*units_ignore;
+};
+
+#define UNCORE_DISCOVERY_DOMAINS	2
 struct uncore_plat_init {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
 	void	(*mmio_init)(void);
-	/* Discovery table is required */
-	bool	use_discovery;
-	/* The units in the discovery table should be ignored. */
-	int	*uncore_units_ignore;
+
+	struct uncore_discovery_domain domain[UNCORE_DISCOVERY_DOMAINS];
 };
=20
 struct intel_uncore_type {
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel=
/uncore_discovery.c
index 97f1443..25b6a65 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -259,23 +259,24 @@ uncore_insert_box_info(struct uncore_unit_discovery *un=
it,
 }
=20
 static bool
-uncore_ignore_unit(struct uncore_unit_discovery *unit, int *ignore)
+uncore_ignore_unit(struct uncore_unit_discovery *unit,
+		   struct uncore_discovery_domain *domain)
 {
 	int i;
=20
-	if (!ignore)
+	if (!domain || !domain->units_ignore)
 		return false;
=20
-	for (i =3D 0; ignore[i] !=3D UNCORE_IGNORE_END ; i++) {
-		if (unit->box_type =3D=3D ignore[i])
+	for (i =3D 0; domain->units_ignore[i] !=3D UNCORE_IGNORE_END ; i++) {
+		if (unit->box_type =3D=3D domain->units_ignore[i])
 			return true;
 	}
=20
 	return false;
 }
=20
-static int __parse_discovery_table(resource_size_t addr, int die,
-				   bool *parsed, int *ignore)
+static int __parse_discovery_table(struct uncore_discovery_domain *domain,
+				   resource_size_t addr, int die, bool *parsed)
 {
 	struct uncore_global_discovery global;
 	struct uncore_unit_discovery unit;
@@ -314,7 +315,7 @@ static int __parse_discovery_table(resource_size_t addr, =
int die,
 		if (unit.access_type >=3D UNCORE_ACCESS_MAX)
 			continue;
=20
-		if (uncore_ignore_unit(&unit, ignore))
+		if (uncore_ignore_unit(&unit, domain))
 			continue;
=20
 		uncore_insert_box_info(&unit, die);
@@ -325,9 +326,9 @@ static int __parse_discovery_table(resource_size_t addr, =
int die,
 	return 0;
 }
=20
-static int parse_discovery_table(struct pci_dev *dev, int die,
-				 u32 bar_offset, bool *parsed,
-				 int *ignore)
+static int parse_discovery_table(struct uncore_discovery_domain *domain,
+				 struct pci_dev *dev, int die,
+				 u32 bar_offset, bool *parsed)
 {
 	resource_size_t addr;
 	u32 val;
@@ -347,17 +348,19 @@ static int parse_discovery_table(struct pci_dev *dev, i=
nt die,
 	}
 #endif
=20
-	return __parse_discovery_table(addr, die, parsed, ignore);
+	return __parse_discovery_table(domain, addr, die, parsed);
 }
=20
-static bool uncore_discovery_pci(int *ignore)
+static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
 {
 	u32 device, val, entry_id, bar_offset;
 	int die, dvsec =3D 0, ret =3D true;
 	struct pci_dev *dev =3D NULL;
 	bool parsed =3D false;
=20
-	if (has_generic_discovery_table())
+	if (domain->discovery_base)
+		device =3D domain->discovery_base;
+	else if (has_generic_discovery_table())
 		device =3D UNCORE_DISCOVERY_TABLE_DEVICE;
 	else
 		device =3D PCI_ANY_ID;
@@ -386,7 +389,7 @@ static bool uncore_discovery_pci(int *ignore)
 			if (die < 0)
 				continue;
=20
-			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
+			parse_discovery_table(domain, dev, die, bar_offset, &parsed);
 		}
 	}
=20
@@ -399,11 +402,11 @@ err:
 	return ret;
 }
=20
-static bool uncore_discovery_msr(int *ignore)
+static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
 {
 	unsigned long *die_mask;
 	bool parsed =3D false;
-	int cpu, die;
+	int cpu, die, msr;
 	u64 base;
=20
 	die_mask =3D kcalloc(BITS_TO_LONGS(uncore_max_dies()),
@@ -411,19 +414,22 @@ static bool uncore_discovery_msr(int *ignore)
 	if (!die_mask)
 		return false;
=20
+	msr =3D domain->discovery_base ?
+	      domain->discovery_base : UNCORE_DISCOVERY_MSR;
+
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		die =3D topology_logical_die_id(cpu);
 		if (__test_and_set_bit(die, die_mask))
 			continue;
=20
-		if (rdmsrq_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
+		if (rdmsrq_safe_on_cpu(cpu, msr, &base))
 			continue;
=20
 		if (!base)
 			continue;
=20
-		__parse_discovery_table(base, die, &parsed, ignore);
+		__parse_discovery_table(domain, base, die, &parsed);
 	}
=20
 	cpus_read_unlock();
@@ -434,10 +440,19 @@ static bool uncore_discovery_msr(int *ignore)
=20
 bool uncore_discovery(struct uncore_plat_init *init)
 {
-	int *ignore =3D init ? init->uncore_units_ignore : NULL;
+	struct uncore_discovery_domain *domain;
+	bool ret =3D false;
+	int i;
=20
-	return uncore_discovery_msr(ignore) ||
-	       uncore_discovery_pci(ignore);
+	for (i =3D 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
+		domain =3D &init->domain[i];
+		if (!domain->base_is_pci)
+			ret |=3D uncore_discovery_msr(domain);
+		else
+			ret |=3D uncore_discovery_pci(domain);
+	}
+
+	return ret;
 }
=20
 void intel_uncore_clear_discovery_tables(void)

