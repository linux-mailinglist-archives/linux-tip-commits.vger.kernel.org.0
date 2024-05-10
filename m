Return-Path: <linux-tip-commits+bounces-1256-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845678C289E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88209B23E79
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F439161330;
	Fri, 10 May 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZQ8LDcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7iC1ps5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BF1E502;
	Fri, 10 May 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358065; cv=none; b=s56fmAAX1WPkzEyPajNB/ZfbzGKnYWpQ7InsgpYHx55h0LdYl6hiM83t7bySXBETeNUNhqjG2V49OLeqeC9abW6Zxmpp2qradJm0gzLOYfbCvQ0Q8n+m6O8U7VHTKX0Vdd75gPq7M8cRg5TxygduuZfbhIfYYUPub0uRWAPpYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358065; c=relaxed/simple;
	bh=uriNv/tbicAsHGH/8lzuykaR3aB4XaDi4Vv4H2EWtS0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PmQNkTw1RheNJADD1tKK1I/RObzgcptUcPNvShTj5lNsqrF3burShwLvwJgqkGw4Hj3+9AoMvd2JtOTNRUlTcDUsClniTQq+e1TTtC6b+4vhBBpoITIPy0QSE52lFKJ+HjBHG7aRmZ63zpF7R9GBLJO7mrGgkUfnqJffjXR8V2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZQ8LDcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P7iC1ps5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 16:21:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715358061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXtWLU0JCkopjaSTjEo+SeO0z5lrEbcOKl0LSd/R9Uo=;
	b=GZQ8LDcCcACgS07LMKVmoYzVWEOBVT6MvPLWdtH2lw35i5vmcXHMVCvB2tioArNYaS/+jC
	uFr38OKwJCsvu5HACE3HZAVCXDZeBwOX7NL3QeW9RohRTSSbOKTHQHcy+RPBvrJ5GlVLyy
	wBoVL2885ljVFY0MLheJ5EOwV2BBmw+mF629fpvzT2wUso2mITJzcckDOPMniLVoddfKBI
	Y3KdXSuU05CL4Ghzfwgo4KTRlanPwR8m2CHQuBRfsg2ewJBC21QMMboW0CF5Eomfs+OGcj
	hbw6ea3KfZ4Kh7Kh7VGjXcGxNjHvBNJKECT3a9XysnoXoCRydNUUiH1g0vn7Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715358061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXtWLU0JCkopjaSTjEo+SeO0z5lrEbcOKl0LSd/R9Uo=;
	b=P7iC1ps5qz999VK3/cxIz8gF1MYYnQL153YM8W18k4T6DRzn2eAKq34egyDSko0H6f4WrI
	L1+Ao0C6BRCB/nCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology/amd: Ensure that LLC ID is initialized
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CPUZPR04MB63168AC442C12627E827368581292=40PUZPR04MB?=
 =?utf-8?q?6316=2Eapcprd04=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CPUZPR04MB63168AC442C12627E827368581292=40PUZPR04M?=
 =?utf-8?q?B6316=2Eapcprd04=2Eprod=2Eoutlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171535806085.10875.8302194587461271211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5754ace3c3199c162dcee1f3f87a538c46d1c832
Gitweb:        https://git.kernel.org/tip/5754ace3c3199c162dcee1f3f87a538c46d1c832
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 May 2024 21:53:47 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 10 May 2024 17:42:50 +02:00

x86/topology/amd: Ensure that LLC ID is initialized

The original topology evaluation code initialized cpu_data::topo::llc_id
with the die ID initialy and then eventually overwrite it with information
gathered from a CPUID leaf.

The conversion analysis failed to spot that particular detail and omitted
this initial assignment under the assumption that each topology evaluation
path will set it up. That assumption is mostly correct, but turns out to be
wrong in case that the CPUID leaf 0x80000006 does not provide a LLC ID.

In that case, LLC ID is invalid and as a consequence the setup of the
scheduling domain CPU masks is incorrect which subsequently causes the
scheduler core to complain about it during CPU hotplug:

  BUG: arch topology borken
       the CLS domain not a subset of the MC domain

Cure it by reusing legacy_set_llc() and assigning the die ID if the LLC ID
is invalid after all possible parsers have been tried.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Reported-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Link: https://lore.kernel.org/r/PUZPR04MB63168AC442C12627E827368581292@PUZPR04MB6316.apcprd04.prod.outlook.com
---
 arch/x86/kernel/cpu/topology_amd.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index a7aa6ef..ce2d507 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -119,7 +119,7 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 	return true;
 }
 
-static bool parse_fam10h_node_id(struct topo_scan *tscan)
+static void parse_fam10h_node_id(struct topo_scan *tscan)
 {
 	union {
 		struct {
@@ -131,20 +131,20 @@ static bool parse_fam10h_node_id(struct topo_scan *tscan)
 	} nid;
 
 	if (!boot_cpu_has(X86_FEATURE_NODEID_MSR))
-		return false;
+		return;
 
 	rdmsrl(MSR_FAM10H_NODE_ID, nid.msr);
 	store_node(tscan, nid.nodes_per_pkg + 1, nid.node_id);
 	tscan->c->topo.llc_id = nid.node_id;
-	return true;
 }
 
 static void legacy_set_llc(struct topo_scan *tscan)
 {
 	unsigned int apicid = tscan->c->topo.initial_apicid;
 
-	/* parse_8000_0008() set everything up except llc_id */
-	tscan->c->topo.llc_id = apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
+	/* If none of the parsers set LLC ID then use the die ID for it. */
+	if (tscan->c->topo.llc_id == BAD_APICID)
+		tscan->c->topo.llc_id = apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
 }
 
 static void topoext_fixup(struct topo_scan *tscan)
@@ -187,10 +187,7 @@ static void parse_topology_amd(struct topo_scan *tscan)
 		return;
 
 	/* Try the NODEID MSR */
-	if (parse_fam10h_node_id(tscan))
-		return;
-
-	legacy_set_llc(tscan);
+	parse_fam10h_node_id(tscan);
 }
 
 void cpu_parse_topology_amd(struct topo_scan *tscan)
@@ -198,6 +195,7 @@ void cpu_parse_topology_amd(struct topo_scan *tscan)
 	tscan->amd_nodes_per_pkg = 1;
 	topoext_fixup(tscan);
 	parse_topology_amd(tscan);
+	legacy_set_llc(tscan);
 
 	if (tscan->amd_nodes_per_pkg > 1)
 		set_cpu_cap(tscan->c, X86_FEATURE_AMD_DCM);

