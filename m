Return-Path: <linux-tip-commits+bounces-8353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLg6A6dUqGlutQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 16:49:59 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD02203487
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 16:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6823F3078F0F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBEF35AC1B;
	Wed,  4 Mar 2026 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l7WyG1Mi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aeTi1/ga"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8834DB41;
	Wed,  4 Mar 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639181; cv=none; b=Za/rCRjQpwf2edQBcBD3xwCSeneF/JOV/83aGpooxzi/W0Y7wTa0bI1D1JEoueOvzFs23NNL46pF33CxO2MuDKlA3rRNqonp4jHUJBFuzelZl3sxjXX5ims9I2ePWPQpTMXGSgkm2pIpcp9e1EiQOBGInWW9/I7dhFIlrM57aBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639181; c=relaxed/simple;
	bh=eVaQNM1BRA5s5n9zdgS3DT88Z98xzrYbNnG9YbgAVqU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NGWn6ThOxw1OpjXspG14zcXtl/NSenmszlqy3j2deKMS4x7FXammXzl6LSljwH9K8ueIphtHN/FN2p6hhFK8mSXuwGfRzpZs880d1Acl5m34LxOaGWh3LKIEPWcLoNXPCyNxyfDJWUcSIBDiKL8EEmxtPooGVsG04Yl7aoYzXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l7WyG1Mi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aeTi1/ga; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 15:46:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772639178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPBAst//8aC3iUWKBxS18uq/C1ceYS0e/47GpPsKNiA=;
	b=l7WyG1MioCYI5RF1h3Q3mPQ4vwm/+TVh0u0DKUPaK+RXiO0klO3Eie3wAnFXfMANNr0xn4
	XcSsTdLw3N0ruMV+BcZIrZCb6jfoiQiF7GmoZ47j9OUUjgSgO2pyZdS/vjXgr/pf+7EI7g
	OhUqLJsHHnRvOTAuS9vHD9j5f17KhSqjnWZ46Ss0/cpNEcs8AmABwqVPMAzmlVUMzlDQWb
	lCrcZdcpZXqwzCf6WkRUVKTzirI0xz6AnBA3UiHhooQumhR7KJw7qcHG0RHrr1Skz4yqab
	vx06nuWqStshYUxg5kw1C3hfONdb3ZN5gkoihbP9S8EfdQC4xpNZFvatgXHtyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772639178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPBAst//8aC3iUWKBxS18uq/C1ceYS0e/47GpPsKNiA=;
	b=aeTi1/gaDC5BKVfVR2ca57rc4o0ypLDjNvz/WY3u5gGZy2/EEowdm+VU3FBBXYVEZyfbLR
	xAadQ4P9quzxJkDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topo: Add topology_num_nodes_per_package()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Zhang Rui <rui.zhang@intel.com>,
 Chen Yu <yu.c.chen@intel.com>, Kyle Meyer <kyle.meyer@hpe.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303110100.004091624@infradead.org>
References: <20260303110100.004091624@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177263917741.1647592.6052405676787219709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9DD02203487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8353-lists,linux-tip-commits=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,infradead.org:email,amd.com:email,intel.com:email,linutronix.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ae6730ff42b3a13d94b405edeb5e40108b6d21b6
Gitweb:        https://git.kernel.org/tip/ae6730ff42b3a13d94b405edeb5e40108b6=
d21b6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 03 Mar 2026 11:55:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Mar 2026 16:35:08 +01:00

x86/topo: Add topology_num_nodes_per_package()

Use the MADT and SRAT table data to compute __num_nodes_per_package.

Specifically, SRAT has already been parsed in x86_numa_init(), which is called
before acpi_boot_init() which parses MADT. So both are available in
topology_init_possible_cpus().

This number is useful to divinate the various Intel CoD/SNC and AMD NPS modes,
since the platforms are failing to provide this otherwise.

Doing it this way is independent of the number of online CPUs and
other such shenanigans.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Link: https://patch.msgid.link/20260303110100.004091624@infradead.org
---
 arch/x86/include/asm/topology.h |  6 ++++++
 arch/x86/kernel/cpu/common.c    |  3 +++
 arch/x86/kernel/cpu/topology.c  | 13 +++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1fadf0c..0ba9bdb 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -155,6 +155,7 @@ extern unsigned int __max_logical_packages;
 extern unsigned int __max_threads_per_core;
 extern unsigned int __num_threads_per_package;
 extern unsigned int __num_cores_per_package;
+extern unsigned int __num_nodes_per_package;
=20
 const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
 enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
@@ -179,6 +180,11 @@ static inline unsigned int topology_num_threads_per_pack=
age(void)
 	return __num_threads_per_package;
 }
=20
+static inline unsigned int topology_num_nodes_per_package(void)
+{
+	return __num_nodes_per_package;
+}
+
 #ifdef CONFIG_X86_LOCAL_APIC
 int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
 #else
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261c..a8ff437 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -95,6 +95,9 @@ EXPORT_SYMBOL(__max_dies_per_package);
 unsigned int __max_logical_packages __ro_after_init =3D 1;
 EXPORT_SYMBOL(__max_logical_packages);
=20
+unsigned int __num_nodes_per_package __ro_after_init =3D 1;
+EXPORT_SYMBOL(__num_nodes_per_package);
+
 unsigned int __num_cores_per_package __ro_after_init =3D 1;
 EXPORT_SYMBOL(__num_cores_per_package);
=20
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 23190a7..eafcb1f 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -31,6 +31,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/smp.h>
+#include <asm/numa.h>
=20
 #include "cpu.h"
=20
@@ -492,11 +493,19 @@ void __init topology_init_possible_cpus(void)
 	set_nr_cpu_ids(allowed);
=20
 	cnta =3D domain_weight(TOPO_PKG_DOMAIN);
-	cntb =3D domain_weight(TOPO_DIE_DOMAIN);
 	__max_logical_packages =3D cnta;
+
+	pr_info("Max. logical packages: %3u\n", __max_logical_packages);
+
+	cntb =3D num_phys_nodes();
+	__num_nodes_per_package =3D DIV_ROUND_UP(cntb, cnta);
+
+	pr_info("Max. logical nodes:    %3u\n", cntb);
+	pr_info("Num. nodes per package:%3u\n", __num_nodes_per_package);
+
+	cntb =3D domain_weight(TOPO_DIE_DOMAIN);
 	__max_dies_per_package =3D 1U << (get_count_order(cntb) - get_count_order(c=
nta));
=20
-	pr_info("Max. logical packages: %3u\n", cnta);
 	pr_info("Max. logical dies:     %3u\n", cntb);
 	pr_info("Max. dies per package: %3u\n", __max_dies_per_package);
=20

