Return-Path: <linux-tip-commits+bounces-1353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A38FEFD8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Jun 2024 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78ECF1C22346
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Jun 2024 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783A19E7FA;
	Thu,  6 Jun 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5KIury0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9xhHkNLU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FE1ABCC6;
	Thu,  6 Jun 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684829; cv=none; b=W3GVs4b0b5bZdIbzkvsiPbMQ8oFVGeDVQ/fBR4lzsEOO9N05+rDDtGsm5QdPCmpTsw0hfXKRkzTT4BmX4mpAIp0+D7l51H/Uw6P8pt7IIaXyy/808ySxn2pQwAJkb0l5HeUPkeMsBjGmqR0xyudbbsM94I0wxi0AdAyRYeH25Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684829; c=relaxed/simple;
	bh=r6ctxYlFhKPoW9QH9D/dZVqAI1dWiHmDq09+6Bvxatk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j7OVN8tI+R46j399iyHMHWfhE6XFWk2Z7mVH7K1lNqSyMzKsEa2KaGWkFikF7w2sDJQhG0rDZUztvK8lov8RoHLnR5BneVfp2NMUpkeYU2kTOyLXdNpgObvr36UsPc3047i1cAkuEmixC+NguQc/h7JZNudEgxlcryUmpXnTEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5KIury0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9xhHkNLU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Jun 2024 14:40:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717684826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Om1VCSNqPpr0VK3hPFHIBndBdY4QYvPmRknCYRoy2k=;
	b=J5KIury07aNQktjb4f7Yvop/k7/06Tsp/knuerZThA71DsJftZNi3tO+el2zdH4xbf2HHU
	c2y2RRvcdcyz5CAbvftOmKgikYGBnr2Rcj/eWdvD3ORLU7afcuqzfTzIoEUpGLzUQYXGei
	mz67HrW4E7z4qEwHKiG8/QM2FBFYV40FYLFnzm7Et/WzAc6wnnceslJkdEOpkMIlay8e3A
	Va2RGj2kCrFNw4r3SNR+vwlM2iIx816M8uWK2BR5g4UxwWc6nF4YCTBsmzZzZifQ0ByQZ7
	px/eacMUhk9PfyjojNp006mL2sOf6E3NuJ6xU7L+tAw5+k4Pb7HqZM9xnqIYpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717684826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Om1VCSNqPpr0VK3hPFHIBndBdY4QYvPmRknCYRoy2k=;
	b=9xhHkNLU1nAmHB7O+e80QI9cBiKTtkliqqYd9SikO6NeO8IfSmFgiGgU/5iXzgIcBnBI/R
	9Bp/Ae1vy64kKaDQ==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 Marc Zyngier <maz@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240606094238.757649-2-lpieralisi@kernel.org>
References: <20240606094238.757649-2-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171768482381.10875.281989797581205013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ababa16fd9bd0e2727a1c31c4fb68d6be053bddc
Gitweb:        https://git.kernel.org/tip/ababa16fd9bd0e2727a1c31c4fb68d6be053bddc
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 06 Jun 2024 11:42:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 06 Jun 2024 16:30:15 +02:00

irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing

The GIC architecture specification defines a set of registers for
redistributors and ITSes that control the sharebility and cacheability
attributes of redistributors/ITSes initiator ports on the interconnect
(GICR_[V]PROPBASER, GICR_[V]PENDBASER, GITS_BASER<n>).

Architecturally the GIC provides a means to drive shareability and
cacheability attributes signals but it is not mandatory for designs to
wire up the corresponding interconnect signals that control the
cacheability/shareability of transactions.

Redistributors and ITSes interconnect ports can be connected to
non-coherent interconnects that are not able to manage the
shareability/cacheability attributes; this implicitly makes the
redistributors and ITSes non-coherent observers.

To enable non-coherent GIC designs on ACPI based systems, parse the MADT
GICC/GICR/ITS subtables non-coherent flags to determine whether the
respective components are non-coherent observers and force the
shareability attributes to be programmed into the redistributors and
ITSes registers.

An ACPI global function (acpi_get_madt_revision()) is added to retrieve
the MADT revision, in that it is essential to check the MADT revision
before checking for flags that were added with MADT revision 7 so that
if the kernel is booted with an ACPI MADT table with revision < 7 it
skips parsing the newly added flags (that should be zeroed reserved
values for MADT versions < 7 but they could turn out to be buggy and
should be ignored).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240606094238.757649-2-lpieralisi@kernel.org
---
 drivers/acpi/processor_core.c    | 15 +++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c |  4 ++++
 drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
 include/linux/acpi.h             |  3 +++
 4 files changed, 31 insertions(+)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b203cfe..915713c 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
 	return rv;
 }
 
+int __init acpi_get_madt_revision(void)
+{
+	struct acpi_table_header *madt = NULL;
+	int revision;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0, &madt)))
+		return -EINVAL;
+
+	revision = madt->revision;
+
+	acpi_put_table(madt);
+
+	return revision;
+}
+
 static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 40ebf17..af5297e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5600,6 +5600,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 		goto node_err;
 	}
 
+	if (acpi_get_madt_revision() >= 7 &&
+	    (its_entry->flags & ACPI_MADT_ITS_NON_COHERENT))
+		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
+
 	err = its_probe_one(its);
 	if (!err)
 		return 0;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb2765..e4bc5f0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2349,6 +2349,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
+
+	if (acpi_get_madt_revision() >= 7 &&
+	    (redist->flags & ACPI_MADT_GICR_NON_COHERENT))
+		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_request_region(redist->base_address, redist->length, "GICR");
 
 	gic_acpi_register_redist(redist->base_address, redist_base);
@@ -2373,6 +2378,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	gic_request_region(gicc->gicr_base_address, size, "GICR");
 
+	if (acpi_get_madt_revision() >= 7 &&
+	    (gicc->flags & ACPI_MADT_GICC_NON_COHERENT))
+		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 28c3fb2..000d339 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -279,6 +279,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 	return phys_id == PHYS_CPUID_INVALID;
 }
 
+
+int __init acpi_get_madt_revision(void);
+
 /* Validate the processor object's proc_id */
 bool acpi_duplicate_processor_id(int proc_id);
 /* Processor _CTS control */

