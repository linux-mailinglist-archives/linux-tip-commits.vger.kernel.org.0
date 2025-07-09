Return-Path: <linux-tip-commits+bounces-6050-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A166AFE86E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9701C8197F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B92DA771;
	Wed,  9 Jul 2025 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OmLYyDVP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fshjc86T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FA2D9786;
	Wed,  9 Jul 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062100; cv=none; b=DSkG2vBNAGe6cgW/pKP3j3zSjHRK07LAlWQHmVtGl83yG4tcRTtHn525w23z8De2sahdp4agav85C2X2lF2wtcnJGK9kdg6vWIOm7SlX4s5lInrd+hsW4cwzBeoAvyKsFOeA/bRYwmjj8uo5hbcRoPyKoeEooo4WPShjnSTdi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062100; c=relaxed/simple;
	bh=ATSJA6reEMoL8B5l+A8Fm/zJIyVsZxhpEoYSjc9Hjfw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WTQfgLWU4AeczLxhaoPB3cv03dZfkeLyaqeHogsR7io9AK7WjQbzX5XH9PKR9rMkv+kwJDPTiyhXB6qQsZsEjXh6p6KG9eRGvBpApyRmNFCSZLBiE+Qvy2T0WNnhPGrDx5MEc1SldhZcFi109gPAznRFREhGg9NFQS2YZb1yJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OmLYyDVP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fshjc86T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 11:54:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752062097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6g9MXcdJBCmsq+n0c1xzzRknZg5YY7Iu70FRS8Hi4lM=;
	b=OmLYyDVPiczEVBJnqHqZ2nMwSO3O2eRpoRrSQ89S7GNplRNKjZiusgy92p3pOXN6tJ9vOG
	w3ZV+URlWQy59dqVOkMxDZ+7cof9C6xlu6FkvwAgfCtNIZUJXnARvdkWuFKgdZna3IpvGK
	ap4n/ZOvfDw3H/z8vJ5Us2+vQN9lTQ6B+zCf3OuaaQFk3Y/7j5mdg5JP0U6zSCJmblFX/J
	XywUvec2PX7wlPNz451jiDNkb30fUNuMsUOJ+vqep4jg+oCJTKCdddGLhFKJ1rmbzLJNV8
	QXcRYehBtj4BJJo7QpqHFNShPq5haWJxw+Zy0wSM1AA1dIIDETXX47XcKlCZYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752062097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6g9MXcdJBCmsq+n0c1xzzRknZg5YY7Iu70FRS8Hi4lM=;
	b=Fshjc86TUsKjiHvwNnkmDnOzy4/DUlq9EbgsjGYgj87D9jqP95DMBKl40V4or7cPwEb2Nv
	b+E15tCb4gdUq8BA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support MSR portal for
 discovery tables
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707201750.616527-2-kan.liang@linux.intel.com>
References: <20250707201750.616527-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175206209614.406.7998285905755467042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cf002dafedd06241175e4dbce39ba90a4b75822c
Gitweb:        https://git.kernel.org/tip/cf002dafedd06241175e4dbce39ba90a4b75822c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 07 Jul 2025 13:17:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:19 +02:00

perf/x86/intel/uncore: Support MSR portal for discovery tables

Starting from the Panther Lake, the discovery table mechanism is also
supported in client platforms. The difference is that the portal of the
global discovery table is retrieved from an MSR.

The layout of discovery tables are the same as the server platforms.
Factor out __parse_discovery_table() to parse discover tables.

The uncore PMON is Die scope. Need to parse the discovery tables for
each die.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250707201750.616527-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c | 87 +++++++++++++++++------
 arch/x86/events/intel/uncore_discovery.h |  3 +-
 2 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 18a3022..9a78a31 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -274,32 +274,15 @@ uncore_ignore_unit(struct uncore_unit_discovery *unit, int *ignore)
 	return false;
 }
 
-static int parse_discovery_table(struct pci_dev *dev, int die,
-				 u32 bar_offset, bool *parsed,
-				 int *ignore)
+static int __parse_discovery_table(resource_size_t addr, int die,
+				   bool *parsed, int *ignore)
 {
 	struct uncore_global_discovery global;
 	struct uncore_unit_discovery unit;
 	void __iomem *io_addr;
-	resource_size_t addr;
 	unsigned long size;
-	u32 val;
 	int i;
 
-	pci_read_config_dword(dev, bar_offset, &val);
-
-	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
-		return -EINVAL;
-
-	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
-#ifdef CONFIG_PHYS_ADDR_T_64BIT
-	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		u32 val2;
-
-		pci_read_config_dword(dev, bar_offset + 4, &val2);
-		addr |= ((resource_size_t)val2) << 32;
-	}
-#endif
 	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
 	io_addr = ioremap(addr, size);
 	if (!io_addr)
@@ -342,7 +325,32 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	return 0;
 }
 
-bool intel_uncore_has_discovery_tables(int *ignore)
+static int parse_discovery_table(struct pci_dev *dev, int die,
+				 u32 bar_offset, bool *parsed,
+				 int *ignore)
+{
+	resource_size_t addr;
+	u32 val;
+
+	pci_read_config_dword(dev, bar_offset, &val);
+
+	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
+		return -EINVAL;
+
+	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		u32 val2;
+
+		pci_read_config_dword(dev, bar_offset + 4, &val2);
+		addr |= ((resource_size_t)val2) << 32;
+	}
+#endif
+
+	return __parse_discovery_table(addr, die, parsed, ignore);
+}
+
+static bool intel_uncore_has_discovery_tables_pci(int *ignore)
 {
 	u32 device, val, entry_id, bar_offset;
 	int die, dvsec = 0, ret = true;
@@ -391,6 +399,45 @@ err:
 	return ret;
 }
 
+static bool intel_uncore_has_discovery_tables_msr(int *ignore)
+{
+	unsigned long *die_mask;
+	bool parsed = false;
+	int cpu, die;
+	u64 base;
+
+	die_mask = kcalloc(BITS_TO_LONGS(uncore_max_dies()),
+			   sizeof(unsigned long), GFP_KERNEL);
+	if (!die_mask)
+		return false;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		die = topology_logical_die_id(cpu);
+		if (__test_and_set_bit(die, die_mask))
+			continue;
+
+		if (rdmsrq_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
+			continue;
+
+		if (!base)
+			continue;
+
+		__parse_discovery_table(base, die, &parsed, ignore);
+	}
+
+	cpus_read_unlock();
+
+	kfree(die_mask);
+	return parsed;
+}
+
+bool intel_uncore_has_discovery_tables(int *ignore)
+{
+	return intel_uncore_has_discovery_tables_msr(ignore) ||
+	       intel_uncore_has_discovery_tables_pci(ignore);
+}
+
 void intel_uncore_clear_discovery_tables(void)
 {
 	struct intel_uncore_discovery_type *type, *next;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 0e94aa7..690f737 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+/* Store the full address of the global discovery table */
+#define UNCORE_DISCOVERY_MSR			0x201e
+
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
 /* Capability ID for a discovery table device */

