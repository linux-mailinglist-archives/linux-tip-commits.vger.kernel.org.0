Return-Path: <linux-tip-commits+bounces-8354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKdjE7dUqGlutQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 16:50:15 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA82034A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 16:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55246307B86C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E635B62A;
	Wed,  4 Mar 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIlJwWjm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8dfgJdo+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D8355F54;
	Wed,  4 Mar 2026 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639182; cv=none; b=Oxn+/O1kMm4kzpawYY45G0iCkcz3fKnS+TxYb7BPODdY4MIi3gy8KG6vU1c7VJubsrM8M3iqhg9QVSCt+bJvRbBeb5MDG5fKmD/o5SSdYL5HkbqkTZDlSmhZbjKaM1o+YMaV3BGYFheg1qKIiRf7tA4DesMbPNspyD6XBmdm1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639182; c=relaxed/simple;
	bh=YpsjGVT2GG7gvVy7hRT7J3EKzIdMcEd8QTy7xGzLoW4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IfUVoYncmrh/+xgC3vKCoG79Q10aKxTp2R0a6T+4L99AvULATw9aWaPL1kF1OgRnhCZadK81wegHLu+zMj+UErthGfziG8bfdWUzE2QO5cot3Q50Mx+I79sR6FHW353GSagWpoboAy9gjK5c7d9DEv0gFXg/1JpkJlIbjLvloBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIlJwWjm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8dfgJdo+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 15:46:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772639179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S85m3Kouu9jsvUaWpFBEJlifaMpWcaQjqKpjDQ27UDo=;
	b=TIlJwWjmoydGSnarOCz7kEhmJKLGN3IlprHnBkzQ+MJew7eZfrQYI+QaLNUzCReUFXhYAb
	P83+N7lAGbhzvedaQEbyuyjBKqM7URVVwQGGWE1vbks+D9K4AngLGi7SRpCryWDPYcanQl
	LxIRmaaEl0gKMPH5+AtEeQOpSeLWSexfc55+rZ4pb4NFZGfncElp7zU/Kw08n9joKkRo2c
	moXj5bmnG6ChrLC9EClftdhCgereEkzOg5x8pxg2nKTEaF7QV04TwC4cJn+ku1XfvavGSD
	leCcfvjjHnMaCXwBp0Z204GRfIQx0pYquH2GLKtqwBGRBE/ydVG5p7bcdWYMjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772639179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S85m3Kouu9jsvUaWpFBEJlifaMpWcaQjqKpjDQ27UDo=;
	b=8dfgJdo+YrO/phBMo7xotE4T9UpbI5H6ee04U3t38LjrKPqjcegNL0Frg6bhP4k94I4Acz
	ND0qwi305qJ6i2BQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/numa: Store extra copy of numa_nodes_parsed
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Chen Yu <yu.c.chen@intel.com>, Kyle Meyer <kyle.meyer@hpe.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303110059.889884023@infradead.org>
References: <20260303110059.889884023@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177263917853.1647592.12464023213187529025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F1EA82034A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8354-lists,linux-tip-commits=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,infradead.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,amd.com:email,hpe.com:email]
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     48084cc153a5b0fbf0aa98d47670d3be0b9f64d5
Gitweb:        https://git.kernel.org/tip/48084cc153a5b0fbf0aa98d47670d3be0b9=
f64d5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 03 Mar 2026 11:55:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Mar 2026 16:35:08 +01:00

x86/numa: Store extra copy of numa_nodes_parsed

The topology setup code needs to know the total number of physical
nodes enumerated in SRAT; however NUMA_EMU can cause the existing
numa_nodes_parsed bitmap to be fictitious. Therefore, keep a copy of
the bitmap specifically to retain the physical node count.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Link: https://patch.msgid.link/20260303110059.889884023@infradead.org
---
 arch/x86/include/asm/numa.h | 6 ++++++
 arch/x86/mm/numa.c          | 8 ++++++++
 arch/x86/mm/srat.c          | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index 53ba39c..a9063f3 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -22,6 +22,7 @@ extern int numa_off;
  */
 extern s16 __apicid_to_node[MAX_LOCAL_APIC];
 extern nodemask_t numa_nodes_parsed __initdata;
+extern nodemask_t numa_phys_nodes_parsed __initdata;
=20
 static inline void set_apicid_to_node(int apicid, s16 node)
 {
@@ -48,6 +49,7 @@ extern void __init init_cpu_to_node(void);
 extern void numa_add_cpu(unsigned int cpu);
 extern void numa_remove_cpu(unsigned int cpu);
 extern void init_gi_nodes(void);
+extern int num_phys_nodes(void);
 #else	/* CONFIG_NUMA */
 static inline void numa_set_node(int cpu, int node)	{ }
 static inline void numa_clear_node(int cpu)		{ }
@@ -55,6 +57,10 @@ static inline void init_cpu_to_node(void)		{ }
 static inline void numa_add_cpu(unsigned int cpu)	{ }
 static inline void numa_remove_cpu(unsigned int cpu)	{ }
 static inline void init_gi_nodes(void)			{ }
+static inline int num_phys_nodes(void)
+{
+	return 1;
+}
 #endif	/* CONFIG_NUMA */
=20
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 7a97327..99d0a93 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -48,6 +48,8 @@ s16 __apicid_to_node[MAX_LOCAL_APIC] =3D {
 	[0 ... MAX_LOCAL_APIC-1] =3D NUMA_NO_NODE
 };
=20
+nodemask_t numa_phys_nodes_parsed __initdata;
+
 int numa_cpu_node(int cpu)
 {
 	u32 apicid =3D early_per_cpu(x86_cpu_to_apicid, cpu);
@@ -57,6 +59,11 @@ int numa_cpu_node(int cpu)
 	return NUMA_NO_NODE;
 }
=20
+int __init num_phys_nodes(void)
+{
+	return bitmap_weight(numa_phys_nodes_parsed.bits, MAX_NUMNODES);
+}
+
 cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
 EXPORT_SYMBOL(node_to_cpumask_map);
=20
@@ -210,6 +217,7 @@ static int __init dummy_numa_init(void)
 	       0LLU, PFN_PHYS(max_pfn) - 1);
=20
 	node_set(0, numa_nodes_parsed);
+	node_set(0, numa_phys_nodes_parsed);
 	numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
=20
 	return 0;
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 6f8e0f2..44ca666 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -57,6 +57,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_=
affinity *pa)
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
+	node_set(node, numa_phys_nodes_parsed);
 	pr_debug("SRAT: PXM %u -> APIC 0x%04x -> Node %u\n", pxm, apic_id, node);
 }
=20
@@ -97,6 +98,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affi=
nity *pa)
=20
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
+	node_set(node, numa_phys_nodes_parsed);
 	pr_debug("SRAT: PXM %u -> APIC 0x%02x -> Node %u\n", pxm, apic_id, node);
 }
=20

