Return-Path: <linux-tip-commits+bounces-7881-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB9D1112D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE0E30A7681
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBA344047;
	Mon, 12 Jan 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mP+5/tM6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aiXnSMQQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0134404E;
	Mon, 12 Jan 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205006; cv=none; b=WMsYl56hPTu0PoZsNXM594AgR7nePf21PY3Gx05e9/kLdnw/LM+88DvtEsw3KG/jYISKoRrzJTmUjUvjF5iiyecBphaMhUALndFmKrUsRjKShIX3/3kFfTS9/1T2JGaB9ss7cm98wzCYpmfxevywxsu/9XUXh5waClYsgPKABJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205006; c=relaxed/simple;
	bh=WskTpS6Ns/mMGCZHfZmFlHiAPk+Z7gs2epR5w4tBC50=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oMif6rOL0xbt7qttNeAif5qd1Zwbn1AbaKPtHLGzttBeW3MvuN8Z3FHiNvWHn02lkCEFIetCRbv8ioc5pUQFjZ24NLRm0doZoNNo0L31lBir4jNA9RHEvCvFFltka3/aT4b73oht163tbPmQ6a+PRdhHwhmixqK8S5t8t19cH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mP+5/tM6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aiXnSMQQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zf1N6L9/zO3ddBU3LVH419jRxzJ+YYxEzfT3BlCNsVw=;
	b=mP+5/tM6pS1mdqL1fJdk9Ym/8zV9bjqybBZsyfv8Ly8V9C+76siOabcYqdLUjrfyqFgrym
	hfJA+aMtLl96IBZUcYFZ9uVQArTz4pUNXaB6Wzvp9imyKQgsrHRpqYoVbb/4qzcC8GLMuz
	PCQSyvEyFcab2JYCWhT2U7DN1UudtlDsTo2+snZpNl44MkHdkzQpOB7yd0SlcLDZkD/1Bh
	Nj4ZhxwzsJwV/LGR3Hf36KF3ABb9jR4cco7z/gmclN/87qYA9jf+u3JK41E50LP7rigi2h
	7Uf7MS20LnC2moLKefeAA8vDyspQzL9y4WGq/KbP/Fk3TX9N/OoPC6q4p7pwmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zf1N6L9/zO3ddBU3LVH419jRxzJ+YYxEzfT3BlCNsVw=;
	b=aiXnSMQQJWW/5c44IMrGD3Fzm4EVcIKt/ec0ntdLek5HbAb74oINtgw698klys6F8QkINU
	2f3qZPH3yqBjbjCA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/uncore: Remove has_generic_discovery_table()
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-4-zide.chen@intel.com>
References: <20251231224233.113839-4-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820499474.510.2116670737281813064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1897336728b4ab0229fb73bb6f1e94cfe914afa9
Gitweb:        https://git.kernel.org/tip/1897336728b4ab0229fb73bb6f1e94cfe91=
4afa9
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:20 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:23 +01:00

perf/x86/intel/uncore: Remove has_generic_discovery_table()

In the !x86_match_cpu() fallback path, has_generic_discovery_table()
is removed because it does not handle multiple PCI devices.  Instead,
use PCI_ANY_ID in generic_uncore_init[] to probe all PCI devices.

For MSR portals, only probe MSR 0x201e to keep the fallback simple, as
this path is best-effort only.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-4-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c           |  3 ++-
 arch/x86/events/intel/uncore_discovery.c | 42 ++++-------------------
 2 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 78a03af..2387b1a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1835,6 +1835,9 @@ static const struct uncore_plat_init generic_uncore_ini=
t __initconst =3D {
 	.cpu_init =3D intel_uncore_generic_uncore_cpu_init,
 	.pci_init =3D intel_uncore_generic_uncore_pci_init,
 	.mmio_init =3D intel_uncore_generic_uncore_mmio_init,
+	.domain[0].base_is_pci =3D true,
+	.domain[0].discovery_base =3D PCI_ANY_ID,
+	.domain[1].discovery_base =3D UNCORE_DISCOVERY_MSR,
 };
=20
 static const struct x86_cpu_id intel_uncore_match[] __initconst =3D {
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel=
/uncore_discovery.c
index 25b6a65..aaa0810 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -12,24 +12,6 @@
 static struct rb_root discovery_tables =3D RB_ROOT;
 static int num_discovered_types[UNCORE_ACCESS_MAX];
=20
-static bool has_generic_discovery_table(void)
-{
-	struct pci_dev *dev;
-	int dvsec;
-
-	dev =3D pci_get_device(PCI_VENDOR_ID_INTEL, UNCORE_DISCOVERY_TABLE_DEVICE, =
NULL);
-	if (!dev)
-		return false;
-
-	/* A discovery table device has the unique capability ID. */
-	dvsec =3D pci_find_next_ext_capability(dev, 0, UNCORE_EXT_CAP_ID_DISCOVERY);
-	pci_dev_put(dev);
-	if (dvsec)
-		return true;
-
-	return false;
-}
-
 static int logical_die_id;
=20
 static int get_device_die_id(struct pci_dev *dev)
@@ -358,12 +340,7 @@ static bool uncore_discovery_pci(struct uncore_discovery=
_domain *domain)
 	struct pci_dev *dev =3D NULL;
 	bool parsed =3D false;
=20
-	if (domain->discovery_base)
-		device =3D domain->discovery_base;
-	else if (has_generic_discovery_table())
-		device =3D UNCORE_DISCOVERY_TABLE_DEVICE;
-	else
-		device =3D PCI_ANY_ID;
+	device =3D domain->discovery_base;
=20
 	/*
 	 * Start a new search and iterates through the list of
@@ -406,7 +383,7 @@ static bool uncore_discovery_msr(struct uncore_discovery_=
domain *domain)
 {
 	unsigned long *die_mask;
 	bool parsed =3D false;
-	int cpu, die, msr;
+	int cpu, die;
 	u64 base;
=20
 	die_mask =3D kcalloc(BITS_TO_LONGS(uncore_max_dies()),
@@ -414,16 +391,13 @@ static bool uncore_discovery_msr(struct uncore_discover=
y_domain *domain)
 	if (!die_mask)
 		return false;
=20
-	msr =3D domain->discovery_base ?
-	      domain->discovery_base : UNCORE_DISCOVERY_MSR;
-
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		die =3D topology_logical_die_id(cpu);
 		if (__test_and_set_bit(die, die_mask))
 			continue;
=20
-		if (rdmsrq_safe_on_cpu(cpu, msr, &base))
+		if (rdmsrq_safe_on_cpu(cpu, domain->discovery_base, &base))
 			continue;
=20
 		if (!base)
@@ -446,10 +420,12 @@ bool uncore_discovery(struct uncore_plat_init *init)
=20
 	for (i =3D 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
 		domain =3D &init->domain[i];
-		if (!domain->base_is_pci)
-			ret |=3D uncore_discovery_msr(domain);
-		else
-			ret |=3D uncore_discovery_pci(domain);
+		if (domain->discovery_base) {
+			if (!domain->base_is_pci)
+				ret |=3D uncore_discovery_msr(domain);
+			else
+				ret |=3D uncore_discovery_pci(domain);
+		}
 	}
=20
 	return ret;

