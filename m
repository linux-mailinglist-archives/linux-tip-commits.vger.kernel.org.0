Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D034718E39
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Jun 2023 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjEaWOP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 31 May 2023 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjEaWON (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 31 May 2023 18:14:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD01A7;
        Wed, 31 May 2023 15:13:52 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685571217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=75xEXZYkgBf0KVBejvdo3FBp4UiCsF9A+ub8bC347UI=;
        b=h+UBO1sRqkXifGr9skxbAh0R7Scj5PBkJZN/pb9gv0jIaSbLogDal7R8gTB2zHMs7kjJUx
        OKszf3/C8KPoKGp3VkBFT9E7Vl/qwUvDaqJNDSor55F/3RbRj1C+dEy4UzECUWBIZJazuI
        ssBe7YNfyRQbwZ79kkk9+Z9X6fS+voT0asHTMfm2WQHOaFMzN5UoZ50p8JehCs3xBeimvN
        WWr8Fz+76dW7ysThHtwEM73YSY/AydLDbRnx0dU/FsFE9MRLuaHd3CIBYlmhVORFzZqNes
        kWo8bbAHBGNOERmJashC4rKb9TU5qLBugZ5LPhicmS5vBweKMZdK50aRH7Mesg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685571217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=75xEXZYkgBf0KVBejvdo3FBp4UiCsF9A+ub8bC347UI=;
        b=BPxCqGxkg+DVCbAA7LwFD6Qz417OkMzK33YdU4Eqpvxl0kFXPa+L+Chy/IVkvF5FfjFFau
        QnFEZ8yEABZtQcAA==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: UV support for sub-NUMA clustering
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168557121635.404.17492521906965225328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     8a50c58519271dd24ba760bb282875f6ad66ee71
Gitweb:        https://git.kernel.org/tip/8a50c58519271dd24ba760bb282875f6ad66ee71
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 19 May 2023 14:07:50 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 May 2023 09:34:59 -07:00

x86/platform/uv: UV support for sub-NUMA clustering

Sub-NUMA clustering (SNC) invalidates previous assumptions of a 1:1
relationship between blades, sockets, and nodes.  Fix these
assumptions and build tables correctly when SNC is enabled.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230519190752.3297140-7-steve.wahl%40hpe.com
---
 arch/x86/include/asm/uv/uv_hub.h   |  22 ++--
 arch/x86/kernel/apic/x2apic_uv_x.c | 162 ++++++++++++++++------------
 2 files changed, 107 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 0acfd17..5fa76c2 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -177,6 +177,7 @@ struct uv_hub_info_s {
 	unsigned short		nr_possible_cpus;
 	unsigned short		nr_online_cpus;
 	short			memory_nid;
+	unsigned short		*node_to_socket;
 };
 
 /* CPU specific info with a pointer to the hub common info struct */
@@ -531,19 +532,18 @@ static inline void *uv_pnode_offset_to_vaddr(int pnode, unsigned long offset)
 {
 	unsigned int m_val = uv_hub_info->m_val;
 	unsigned long base;
-	unsigned short sockid, node;
+	unsigned short sockid;
 
 	if (m_val)
 		return __va(((unsigned long)pnode << m_val) | offset);
 
 	sockid = uv_pnode_to_socket(pnode);
-	node = uv_socket_to_node(sockid);
 
 	/* limit address of previous socket is our base, except node 0 is 0 */
-	if (!node)
+	if (sockid == 0)
 		return __va((unsigned long)offset);
 
-	base = (unsigned long)(uv_hub_info->gr_table[node - 1].limit);
+	base = (unsigned long)(uv_hub_info->gr_table[sockid - 1].limit);
 	return __va(base << UV_GAM_RANGE_SHFT | offset);
 }
 
@@ -650,7 +650,7 @@ static inline int uv_cpu_blade_processor_id(int cpu)
 /* Blade number to Node number (UV2..UV4 is 1:1) */
 static inline int uv_blade_to_node(int blade)
 {
-	return blade;
+	return uv_socket_to_node(blade);
 }
 
 /* Blade number of current cpu. Numnbered 0 .. <#blades -1> */
@@ -662,23 +662,27 @@ static inline int uv_numa_blade_id(void)
 /*
  * Convert linux node number to the UV blade number.
  * .. Currently for UV2 thru UV4 the node and the blade are identical.
- * .. If this changes then you MUST check references to this function!
+ * .. UV5 needs conversion when sub-numa clustering is enabled.
  */
 static inline int uv_node_to_blade_id(int nid)
 {
-	return nid;
+	unsigned short *n2s = uv_hub_info->node_to_socket;
+
+	return n2s ? n2s[nid] : nid;
 }
 
 /* Convert a CPU number to the UV blade number */
 static inline int uv_cpu_to_blade_id(int cpu)
 {
-	return uv_node_to_blade_id(cpu_to_node(cpu));
+	return uv_cpu_hub_info(cpu)->numa_blade_id;
 }
 
 /* Convert a blade id to the PNODE of the blade */
 static inline int uv_blade_to_pnode(int bid)
 {
-	return uv_hub_info_list(uv_blade_to_node(bid))->pnode;
+	unsigned short *s2p = uv_hub_info->socket_to_pnode;
+
+	return s2p ? s2p[bid] : bid;
 }
 
 /* Nid of memory node on blade. -1 if no blade-local memory */
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1bd15b1..10d3bdf 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -546,7 +546,6 @@ unsigned long sn_rtc_cycles_per_second;
 EXPORT_SYMBOL(sn_rtc_cycles_per_second);
 
 /* The following values are used for the per node hub info struct */
-static __initdata unsigned short		*_node_to_pnode;
 static __initdata unsigned short		_min_socket, _max_socket;
 static __initdata unsigned short		_min_pnode, _max_pnode, _gr_table_len;
 static __initdata struct uv_gam_range_entry	*uv_gre_table;
@@ -554,6 +553,7 @@ static __initdata struct uv_gam_parameters	*uv_gp_table;
 static __initdata unsigned short		*_socket_to_node;
 static __initdata unsigned short		*_socket_to_pnode;
 static __initdata unsigned short		*_pnode_to_socket;
+static __initdata unsigned short		*_node_to_socket;
 
 static __initdata struct uv_gam_range_s		*_gr_table;
 
@@ -1293,6 +1293,7 @@ static void __init uv_init_hub_info(struct uv_hub_info_s *hi)
 	hi->nasid_shift		= uv_cpuid.nasid_shift;
 	hi->min_pnode		= _min_pnode;
 	hi->min_socket		= _min_socket;
+	hi->node_to_socket	= _node_to_socket;
 	hi->pnode_to_socket	= _pnode_to_socket;
 	hi->socket_to_node	= _socket_to_node;
 	hi->socket_to_pnode	= _socket_to_pnode;
@@ -1526,6 +1527,11 @@ static void __init free_1_to_1_table(unsigned short **tp, char *tname, int min, 
 	pr_info("UV: %s is 1:1, conversion table removed\n", tname);
 }
 
+/*
+ * Build Socket Tables
+ * If the number of nodes is >1 per socket, socket to node table will
+ * contain lowest node number on that socket.
+ */
 static void __init build_socket_tables(void)
 {
 	struct uv_gam_range_entry *gre = uv_gre_table;
@@ -1552,27 +1558,25 @@ static void __init build_socket_tables(void)
 	/* Allocate and clear tables */
 	if ((alloc_conv_table(nump, &_pnode_to_socket) < 0)
 	    || (alloc_conv_table(nums, &_socket_to_pnode) < 0)
-	    || (alloc_conv_table(numn, &_node_to_pnode) < 0)
+	    || (alloc_conv_table(numn, &_node_to_socket) < 0)
 	    || (alloc_conv_table(nums, &_socket_to_node) < 0)) {
 		kfree(_pnode_to_socket);
 		kfree(_socket_to_pnode);
-		kfree(_node_to_pnode);
+		kfree(_node_to_socket);
 		return;
 	}
 
 	/* Fill in pnode/node/addr conversion list values: */
-	pr_info("UV: GAM Building socket/pnode conversion tables\n");
 	for (; gre->type != UV_GAM_RANGE_TYPE_UNUSED; gre++) {
 		if (gre->type == UV_GAM_RANGE_TYPE_HOLE)
 			continue;
 		i = gre->sockid - minsock;
-		/* Duplicate: */
-		if (_socket_to_pnode[i] != SOCK_EMPTY)
-			continue;
-		_socket_to_pnode[i] = gre->pnode;
+		if (_socket_to_pnode[i] == SOCK_EMPTY)
+			_socket_to_pnode[i] = gre->pnode;
 
 		i = gre->pnode - minpnode;
-		_pnode_to_socket[i] = gre->sockid;
+		if (_pnode_to_socket[i] == SOCK_EMPTY)
+			_pnode_to_socket[i] = gre->sockid;
 
 		pr_info("UV: sid:%02x type:%d nasid:%04x pn:%02x pn2s:%2x\n",
 			gre->sockid, gre->type, gre->nasid,
@@ -1582,34 +1586,29 @@ static void __init build_socket_tables(void)
 
 	/* Set socket -> node values: */
 	lnid = NUMA_NO_NODE;
-	for_each_present_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		int nid = cpu_to_node(cpu);
 		int apicid, sockid;
 
 		if (lnid == nid)
 			continue;
 		lnid = nid;
+
 		apicid = per_cpu(x86_cpu_to_apicid, cpu);
 		sockid = apicid >> uv_cpuid.socketid_shift;
-		_socket_to_node[sockid - minsock] = nid;
-		pr_info("UV: sid:%02x: apicid:%04x node:%2d\n",
-			sockid, apicid, nid);
-	}
 
-	/* Set up physical blade to pnode translation from GAM Range Table: */
-	for (lnid = 0; lnid < num_possible_nodes(); lnid++) {
-		unsigned short sockid;
+		if (_socket_to_node[sockid - minsock] == SOCK_EMPTY)
+			_socket_to_node[sockid - minsock] = nid;
 
-		for (sockid = minsock; sockid <= maxsock; sockid++) {
-			if (lnid == _socket_to_node[sockid - minsock]) {
-				_node_to_pnode[lnid] = _socket_to_pnode[sockid - minsock];
-				break;
-			}
-		}
-		if (sockid > maxsock) {
-			pr_err("UV: socket for node %d not found!\n", lnid);
-			BUG();
-		}
+		if (_node_to_socket[nid] == SOCK_EMPTY)
+			_node_to_socket[nid] = sockid;
+
+		pr_info("UV: sid:%02x: apicid:%04x socket:%02d node:%03x s2n:%03x\n",
+			sockid,
+			apicid,
+			_node_to_socket[nid],
+			nid,
+			_socket_to_node[sockid - minsock]);
 	}
 
 	/*
@@ -1617,6 +1616,7 @@ static void __init build_socket_tables(void)
 	 *   system runs faster by removing corresponding conversion table.
 	 */
 	FREE_1_TO_1_TABLE(_socket_to_node, _min_socket, nums, numn);
+	FREE_1_TO_1_TABLE(_node_to_socket, _min_socket, nums, numn);
 	FREE_1_TO_1_TABLE(_socket_to_pnode, _min_pnode, nums, nump);
 	FREE_1_TO_1_TABLE(_pnode_to_socket, _min_pnode, nums, nump);
 }
@@ -1702,12 +1702,13 @@ static __init int uv_system_init_hubless(void)
 static void __init uv_system_init_hub(void)
 {
 	struct uv_hub_info_s hub_info = {0};
-	int bytes, cpu, nodeid;
+	int bytes, cpu, nodeid, bid;
 	unsigned short min_pnode = USHRT_MAX, max_pnode = 0;
 	char *hub = is_uv5_hub() ? "UV500" :
 		    is_uv4_hub() ? "UV400" :
 		    is_uv3_hub() ? "UV300" :
 		    is_uv2_hub() ? "UV2000/3000" : NULL;
+	struct uv_hub_info_s **uv_hub_info_list_blade;
 
 	if (!hub) {
 		pr_err("UV: Unknown/unsupported UV hub\n");
@@ -1730,9 +1731,12 @@ static void __init uv_system_init_hub(void)
 	build_uv_gr_table();
 	set_block_size();
 	uv_init_hub_info(&hub_info);
-	uv_possible_blades = num_possible_nodes();
-	if (!_node_to_pnode)
+	/* If UV2 or UV3 may need to get # blades from HW */
+	if (is_uv(UV2|UV3) && !uv_gre_table)
 		boot_init_possible_blades(&hub_info);
+	else
+		/* min/max sockets set in decode_gam_rng_tbl */
+		uv_possible_blades = (_max_socket - _min_socket) + 1;
 
 	/* uv_num_possible_blades() is really the hub count: */
 	pr_info("UV: Found %d hubs, %d nodes, %d CPUs\n", uv_num_possible_blades(), num_possible_nodes(), num_possible_cpus());
@@ -1741,79 +1745,98 @@ static void __init uv_system_init_hub(void)
 	hub_info.coherency_domain_number = sn_coherency_id;
 	uv_rtc_init();
 
+	/*
+	 * __uv_hub_info_list[] is indexed by node, but there is only
+	 * one hub_info structure per blade.  First, allocate one
+	 * structure per blade.  Further down we create a per-node
+	 * table (__uv_hub_info_list[]) pointing to hub_info
+	 * structures for the correct blade.
+	 */
+
 	bytes = sizeof(void *) * uv_num_possible_blades();
-	__uv_hub_info_list = kzalloc(bytes, GFP_KERNEL);
-	BUG_ON(!__uv_hub_info_list);
+	uv_hub_info_list_blade = kzalloc(bytes, GFP_KERNEL);
+	if (WARN_ON_ONCE(!uv_hub_info_list_blade))
+		return;
 
 	bytes = sizeof(struct uv_hub_info_s);
-	for_each_node(nodeid) {
+	for_each_possible_blade(bid) {
 		struct uv_hub_info_s *new_hub;
 
-		if (__uv_hub_info_list[nodeid]) {
-			pr_err("UV: Node %d UV HUB already initialized!?\n", nodeid);
-			BUG();
+		/* Allocate & fill new per hub info list */
+		new_hub = (bid == 0) ?  &uv_hub_info_node0
+			: kzalloc_node(bytes, GFP_KERNEL, uv_blade_to_node(bid));
+		if (WARN_ON_ONCE(!new_hub)) {
+			/* do not kfree() bid 0, which is statically allocated */
+			while (--bid > 0)
+				kfree(uv_hub_info_list_blade[bid]);
+			kfree(uv_hub_info_list_blade);
+			return;
 		}
 
-		/* Allocate new per hub info list */
-		new_hub = (nodeid == 0) ?  &uv_hub_info_node0 : kzalloc_node(bytes, GFP_KERNEL, nodeid);
-		BUG_ON(!new_hub);
-		__uv_hub_info_list[nodeid] = new_hub;
-		new_hub = uv_hub_info_list(nodeid);
-		BUG_ON(!new_hub);
+		uv_hub_info_list_blade[bid] = new_hub;
 		*new_hub = hub_info;
 
 		/* Use information from GAM table if available: */
-		if (_node_to_pnode)
-			new_hub->pnode = _node_to_pnode[nodeid];
+		if (uv_gre_table)
+			new_hub->pnode = uv_blade_to_pnode(bid);
 		else /* Or fill in during CPU loop: */
 			new_hub->pnode = 0xffff;
 
-		new_hub->numa_blade_id = uv_node_to_blade_id(nodeid);
+		new_hub->numa_blade_id = bid;
 		new_hub->memory_nid = NUMA_NO_NODE;
 		new_hub->nr_possible_cpus = 0;
 		new_hub->nr_online_cpus = 0;
 	}
 
+	/*
+	 * Now populate __uv_hub_info_list[] for each node with the
+	 * pointer to the struct for the blade it resides on.
+	 */
+
+	bytes = sizeof(void *) * num_possible_nodes();
+	__uv_hub_info_list = kzalloc(bytes, GFP_KERNEL);
+	if (WARN_ON_ONCE(!__uv_hub_info_list)) {
+		for_each_possible_blade(bid)
+			/* bid 0 is statically allocated */
+			if (bid != 0)
+				kfree(uv_hub_info_list_blade[bid]);
+		kfree(uv_hub_info_list_blade);
+		return;
+	}
+
+	for_each_node(nodeid)
+		__uv_hub_info_list[nodeid] = uv_hub_info_list_blade[uv_node_to_blade_id(nodeid)];
+
 	/* Initialize per CPU info: */
 	for_each_possible_cpu(cpu) {
-		int apicid = per_cpu(x86_cpu_to_apicid, cpu);
-		int numa_node_id;
+		int apicid = early_per_cpu(x86_cpu_to_apicid, cpu);
+		unsigned short bid;
 		unsigned short pnode;
 
-		nodeid = cpu_to_node(cpu);
-		numa_node_id = numa_cpu_node(cpu);
 		pnode = uv_apicid_to_pnode(apicid);
+		bid = uv_pnode_to_socket(pnode) - _min_socket;
 
-		uv_cpu_info_per(cpu)->p_uv_hub_info = uv_hub_info_list(nodeid);
+		uv_cpu_info_per(cpu)->p_uv_hub_info = uv_hub_info_list_blade[bid];
 		uv_cpu_info_per(cpu)->blade_cpu_id = uv_cpu_hub_info(cpu)->nr_possible_cpus++;
 		if (uv_cpu_hub_info(cpu)->memory_nid == NUMA_NO_NODE)
 			uv_cpu_hub_info(cpu)->memory_nid = cpu_to_node(cpu);
 
-		/* Init memoryless node: */
-		if (nodeid != numa_node_id &&
-		    uv_hub_info_list(numa_node_id)->pnode == 0xffff)
-			uv_hub_info_list(numa_node_id)->pnode = pnode;
-		else if (uv_cpu_hub_info(cpu)->pnode == 0xffff)
+		if (uv_cpu_hub_info(cpu)->pnode == 0xffff)
 			uv_cpu_hub_info(cpu)->pnode = pnode;
 	}
 
-	for_each_node(nodeid) {
-		unsigned short pnode = uv_hub_info_list(nodeid)->pnode;
+	for_each_possible_blade(bid) {
+		unsigned short pnode = uv_hub_info_list_blade[bid]->pnode;
 
-		/* Add pnode info for pre-GAM list nodes without CPUs: */
-		if (pnode == 0xffff) {
-			unsigned long paddr;
+		if (pnode == 0xffff)
+			continue;
 
-			paddr = node_start_pfn(nodeid) << PAGE_SHIFT;
-			pnode = uv_gpa_to_pnode(uv_soc_phys_ram_to_gpa(paddr));
-			uv_hub_info_list(nodeid)->pnode = pnode;
-		}
 		min_pnode = min(pnode, min_pnode);
 		max_pnode = max(pnode, max_pnode);
-		pr_info("UV: UVHUB node:%2d pn:%02x nrcpus:%d\n",
-			nodeid,
-			uv_hub_info_list(nodeid)->pnode,
-			uv_hub_info_list(nodeid)->nr_possible_cpus);
+		pr_info("UV: HUB:%2d pn:%02x nrcpus:%d\n",
+			bid,
+			uv_hub_info_list_blade[bid]->pnode,
+			uv_hub_info_list_blade[bid]->nr_possible_cpus);
 	}
 
 	pr_info("UV: min_pnode:%02x max_pnode:%02x\n", min_pnode, max_pnode);
@@ -1821,6 +1844,9 @@ static void __init uv_system_init_hub(void)
 	map_mmr_high(max_pnode);
 	map_mmioh_high(min_pnode, max_pnode);
 
+	kfree(uv_hub_info_list_blade);
+	uv_hub_info_list_blade = NULL;
+
 	uv_nmi_setup();
 	uv_cpu_init();
 	uv_setup_proc_files(0);
