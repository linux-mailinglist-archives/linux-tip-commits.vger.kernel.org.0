Return-Path: <linux-tip-commits+bounces-4922-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95241A87132
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 11:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815AB17884E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F26191F6D;
	Sun, 13 Apr 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWmWmd5+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAsHbu7K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D515190477;
	Sun, 13 Apr 2025 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744535432; cv=none; b=YjkI8QkiyPBt+0ie2lCRX29DCveA6b1Drvi2O6GNGYfcRCM7OMIMaqzS12Cn7r13YNM3evb30e6ucssYgMpJCiKaJCV18id5yJP75DIqNbFGsYhAF+bRSG5KQjmTSMYSamrFmQc+1opDrDTsQMy/fNHNQCSbwJ1pQqsDRZN+2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744535432; c=relaxed/simple;
	bh=M91Ziv/GUD1S/JUGG/7+BkLoNSzxaFUzQZQt7JqVgB4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Ob/GVSGxmBi8EwlM9WjXNpEuOuIvEHye93B9LiBG3QPBhtorwlMpqWwOAGrIm70L3b75ELlwCGfrUnBcdw9AXuRRJyJJO+IP6V4Yx7W2NMfhXQ33NUnjcdraUHgI6+pgzV/f4ii1rpJVNbspS1ym1J+VAPsCm9Nlz1oToEEazXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWmWmd5+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAsHbu7K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 09:10:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744535428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+GhzxE9oV+MtsbxJj+jUqe+a3B4qkmLE5/DcGTsXtRQ=;
	b=XWmWmd5+tgW4VITuG6jRYl4fuyF+xYPkSx8likjmslYd+HPD8KEILouf5fF5FBpt4GjfI6
	2ZaIbb8lZixhK5NXh+tjgFh0ZEKQ0Y21XqPwVcTaOLL2872I6BZcCZdB+sCfMAeUkGyl4w
	jI+3ciAcjzLIyjIXVC0KQD3KHdA6iip1yWbiQfLlKzEqxlj10/xVzJcV8hf6uCNpw76jXn
	eznLI2FhHsKBMkpYKAPso9aBnZwbTwqIsuq+dmcrbmcLoP3r3dyLnE6n3mU+KRIMG4gBmt
	Ncj+rg3GakrnsiWZ0lgBbowBSUjq8n5GTVhIQuIm9d25C3KCfmiwLmmrFk70cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744535428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+GhzxE9oV+MtsbxJj+jUqe+a3B4qkmLE5/DcGTsXtRQ=;
	b=QAsHbu7K1nYEeJFrMoY5dAUA+dBootw1BLoEkx9MEF2G3nGsijr6Ena8r5CGQmbnUQSfry
	HnqDtqKdVY6r5bCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] clang-format: Update the ForEachMacros list for v6.15-rc1
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174453542025.31282.3089420335872967217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     d833dc597fdc79b3f5b1ca5817aa7a64897e13d3
Gitweb:        https://git.kernel.org/tip/d833dc597fdc79b3f5b1ca5817aa7a64897e13d3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 13 Apr 2025 11:03:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 13 Apr 2025 11:03:59 +02:00

clang-format: Update the ForEachMacros list for v6.15-rc1

One of my 'git grep' searches tripped on this file listing
an already removed <linux/list.h> primitive.

Refresh it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 .clang-format | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/.clang-format b/.clang-format
index fe1aa1a..86c20ee 100644
--- a/.clang-format
+++ b/.clang-format
@@ -92,6 +92,7 @@ ForEachMacros:
   - '__rq_for_each_bio'
   - '__shost_for_each_device'
   - '__sym_for_each'
+  - '_for_each_counter'
   - 'apei_estatus_for_each_section'
   - 'ata_for_each_dev'
   - 'ata_for_each_link'
@@ -141,11 +142,14 @@ ForEachMacros:
   - 'damon_for_each_target_safe'
   - 'damos_for_each_filter'
   - 'damos_for_each_filter_safe'
+  - 'damos_for_each_ops_filter'
+  - 'damos_for_each_ops_filter_safe'
   - 'damos_for_each_quota_goal'
   - 'damos_for_each_quota_goal_safe'
   - 'data__for_each_file'
   - 'data__for_each_file_new'
   - 'data__for_each_file_start'
+  - 'def_for_each_cpu'
   - 'device_for_each_child_node'
   - 'device_for_each_child_node_scoped'
   - 'dma_fence_array_for_each'
@@ -176,6 +180,7 @@ ForEachMacros:
   - 'drm_for_each_privobj'
   - 'drm_gem_for_each_gpuvm_bo'
   - 'drm_gem_for_each_gpuvm_bo_safe'
+  - 'drm_gpusvm_for_each_range'
   - 'drm_gpuva_for_each_op'
   - 'drm_gpuva_for_each_op_from_reverse'
   - 'drm_gpuva_for_each_op_reverse'
@@ -216,8 +221,10 @@ ForEachMacros:
   - 'for_each_active_dev_scope'
   - 'for_each_active_drhd_unit'
   - 'for_each_active_iommu'
+  - 'for_each_active_irq'
   - 'for_each_active_route'
   - 'for_each_aggr_pgid'
+  - 'for_each_alloc_capable_rdt_resource'
   - 'for_each_and_bit'
   - 'for_each_andnot_bit'
   - 'for_each_available_child_of_node'
@@ -228,6 +235,7 @@ ForEachMacros:
   - 'for_each_btf_ext_rec'
   - 'for_each_btf_ext_sec'
   - 'for_each_bvec'
+  - 'for_each_capable_rdt_resource'
   - 'for_each_card_auxs'
   - 'for_each_card_auxs_safe'
   - 'for_each_card_components'
@@ -241,6 +249,7 @@ ForEachMacros:
   - 'for_each_cgroup_storage_type'
   - 'for_each_child_of_node'
   - 'for_each_child_of_node_scoped'
+  - 'for_each_child_of_node_with_prefix'
   - 'for_each_clear_bit'
   - 'for_each_clear_bit_from'
   - 'for_each_clear_bitrange'
@@ -296,6 +305,7 @@ ForEachMacros:
   - 'for_each_group_member_head'
   - 'for_each_hstate'
   - 'for_each_hwgpio'
+  - 'for_each_hwgpio_in_range'
   - 'for_each_if'
   - 'for_each_inject_fn'
   - 'for_each_insn'
@@ -304,6 +314,7 @@ ForEachMacros:
   - 'for_each_intid'
   - 'for_each_iommu'
   - 'for_each_ip_tunnel_rcu'
+  - 'for_each_irq_desc'
   - 'for_each_irq_nr'
   - 'for_each_lang'
   - 'for_each_link_ch_maps'
@@ -324,6 +335,8 @@ ForEachMacros:
   - 'for_each_missing_reg'
   - 'for_each_mle_subelement'
   - 'for_each_mod_mem_type'
+  - 'for_each_mon_capable_rdt_resource'
+  - 'for_each_mp_bvec'
   - 'for_each_net'
   - 'for_each_net_continue_reverse'
   - 'for_each_net_rcu'
@@ -351,6 +364,7 @@ ForEachMacros:
   - 'for_each_node_by_name'
   - 'for_each_node_by_type'
   - 'for_each_node_mask'
+  - 'for_each_node_numadist'
   - 'for_each_node_state'
   - 'for_each_node_with_cpus'
   - 'for_each_node_with_property'
@@ -359,6 +373,8 @@ ForEachMacros:
   - 'for_each_of_allnodes'
   - 'for_each_of_allnodes_from'
   - 'for_each_of_cpu_node'
+  - 'for_each_of_graph_port'
+  - 'for_each_of_graph_port_endpoint'
   - 'for_each_of_pci_range'
   - 'for_each_old_connector_in_state'
   - 'for_each_old_crtc_in_state'
@@ -372,9 +388,11 @@ ForEachMacros:
   - 'for_each_oldnew_plane_in_state_reverse'
   - 'for_each_oldnew_private_obj_in_state'
   - 'for_each_online_cpu'
+  - 'for_each_online_cpu_wrap'
   - 'for_each_online_node'
   - 'for_each_online_pgdat'
   - 'for_each_or_bit'
+  - 'for_each_page_ext'
   - 'for_each_path'
   - 'for_each_pci_bridge'
   - 'for_each_pci_dev'
@@ -382,8 +400,10 @@ ForEachMacros:
   - 'for_each_physmem_range'
   - 'for_each_populated_zone'
   - 'for_each_possible_cpu'
+  - 'for_each_possible_cpu_wrap'
   - 'for_each_present_blessed_reg'
   - 'for_each_present_cpu'
+  - 'for_each_present_section_nr'
   - 'for_each_prime_number'
   - 'for_each_prime_number_from'
   - 'for_each_probe_cache_entry'
@@ -396,6 +416,7 @@ ForEachMacros:
   - 'for_each_prop_dlc_cpus'
   - 'for_each_prop_dlc_platforms'
   - 'for_each_property_of_node'
+  - 'for_each_rdt_resource'
   - 'for_each_reg'
   - 'for_each_reg_filtered'
   - 'for_each_reloc'
@@ -434,10 +455,10 @@ ForEachMacros:
   - 'for_each_subelement_id'
   - 'for_each_sublist'
   - 'for_each_subsystem'
+  - 'for_each_suite'
   - 'for_each_supported_activate_fn'
   - 'for_each_supported_inject_fn'
   - 'for_each_sym'
-  - 'for_each_test'
   - 'for_each_thread'
   - 'for_each_token'
   - 'for_each_unicast_dest_pgid'
@@ -499,8 +520,10 @@ ForEachMacros:
   - 'idr_for_each_entry_continue'
   - 'idr_for_each_entry_continue_ul'
   - 'idr_for_each_entry_ul'
+  - 'iio_for_each_active_channel'
   - 'in_dev_for_each_ifa_rcu'
   - 'in_dev_for_each_ifa_rtnl'
+  - 'in_dev_for_each_ifa_rtnl_net'
   - 'inet_bind_bucket_for_each'
   - 'interval_tree_for_each_span'
   - 'intlist__for_each_entry'
@@ -542,7 +565,6 @@ ForEachMacros:
   - 'list_for_each_prev'
   - 'list_for_each_prev_safe'
   - 'list_for_each_rcu'
-  - 'list_for_each_reverse'
   - 'list_for_each_safe'
   - 'llist_for_each'
   - 'llist_for_each_entry'
@@ -552,6 +574,7 @@ ForEachMacros:
   - 'map__for_each_symbol'
   - 'map__for_each_symbol_by_name'
   - 'mas_for_each'
+  - 'mas_for_each_rev'
   - 'mci_for_each_dimm'
   - 'media_device_for_each_entity'
   - 'media_device_for_each_intf'
@@ -561,10 +584,15 @@ ForEachMacros:
   - 'media_pipeline_for_each_entity'
   - 'media_pipeline_for_each_pad'
   - 'mlx5_lag_for_each_peer_mdev'
+  - 'mptcp_for_each_subflow'
   - 'msi_domain_for_each_desc'
   - 'msi_for_each_desc'
   - 'mt_for_each'
+  - 'nanddev_io_for_each_block'
   - 'nanddev_io_for_each_page'
+  - 'neigh_for_each_in_bucket'
+  - 'neigh_for_each_in_bucket_rcu'
+  - 'neigh_for_each_in_bucket_safe'
   - 'netdev_for_each_lower_dev'
   - 'netdev_for_each_lower_private'
   - 'netdev_for_each_lower_private_rcu'
@@ -604,11 +632,11 @@ ForEachMacros:
   - 'perf_evlist__for_each_entry_safe'
   - 'perf_evlist__for_each_evsel'
   - 'perf_evlist__for_each_mmap'
+  - 'perf_evsel_for_each_per_thread_period_safe'
   - 'perf_hpp_list__for_each_format'
   - 'perf_hpp_list__for_each_format_safe'
   - 'perf_hpp_list__for_each_sort_list'
   - 'perf_hpp_list__for_each_sort_list_safe'
-  - 'perf_tool_event__for_each_event'
   - 'plist_for_each'
   - 'plist_for_each_continue'
   - 'plist_for_each_entry'
@@ -627,7 +655,6 @@ ForEachMacros:
   - 'rdma_for_each_block'
   - 'rdma_for_each_port'
   - 'rdma_umem_for_each_dma_block'
-  - 'resort_rb__for_each_entry'
   - 'resource_list_for_each_entry'
   - 'resource_list_for_each_entry_safe'
   - 'rhl_for_each_entry_rcu'
@@ -658,6 +685,7 @@ ForEachMacros:
   - 'shost_for_each_device'
   - 'sk_for_each'
   - 'sk_for_each_bound'
+  - 'sk_for_each_bound_safe'
   - 'sk_for_each_entry_offset_rcu'
   - 'sk_for_each_from'
   - 'sk_for_each_rcu'
@@ -680,7 +708,11 @@ ForEachMacros:
   - 'tb_property_for_each'
   - 'tcf_act_for_each_action'
   - 'tcf_exts_for_each_action'
+  - 'test_suite__for_each_test_case'
+  - 'tool_pmu__for_each_event'
+  - 'ttm_bo_lru_for_each_reserved_guarded'
   - 'ttm_resource_manager_for_each_res'
+  - 'udp_lrpa_for_each_entry_rcu'
   - 'udp_portaddr_for_each_entry'
   - 'udp_portaddr_for_each_entry_rcu'
   - 'usb_hub_for_each_child'
@@ -691,6 +723,7 @@ ForEachMacros:
   - 'v4l2_m2m_for_each_src_buf_safe'
   - 'virtio_device_for_each_vq'
   - 'while_for_each_ftrace_op'
+  - 'workloads__for_each'
   - 'xa_for_each'
   - 'xa_for_each_marked'
   - 'xa_for_each_range'

