Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D63B2A4A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhFXI2j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 04:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhFXI2h (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 04:28:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D23CC061574;
        Thu, 24 Jun 2021 01:26:18 -0700 (PDT)
Date:   Thu, 24 Jun 2021 08:26:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624523175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMPQiwJHr7h6YPCaRxs8HKph9mp0KW/330q30rR8Upc=;
        b=M2AnQ7Xyl76ENc4tNHn1p3FPqElzK8lWztWoqdEkJOxGsBfLTWZm11s6JUYIcfztc5O74q
        XyMjS56k5c18wGzXZDZHtoX0RHng8o1bGPTxYp9djp4wQZ1cnFONFRtfSdO6JZOsjVn2BD
        UqO1kzqG3OzHxryH81Sv8e+ybKSUsBb0mu/+2cLzFd6bXTa+Cbn0njye+ihESq0meSzTDX
        12eK/PYaecbl7Q8/TqiNAvZJH878YXlKhK/rj8EBf1/PWKrlNcpuYgKZnBXBNskgUUz6IZ
        KqxJqC5DycFNQOrh2KOTBfLW3b8iZmcNt3HG7L5J0xVdS6gN08b3vNPA6gMA5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624523175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMPQiwJHr7h6YPCaRxs8HKph9mp0KW/330q30rR8Upc=;
        b=z+2PQpru56FbUr5MsbqbJUcCSE6xPUG65a40vaARPy9ZIvVzu383aLGshv1dYJjzQ94Pmq
        CFEuui/QvqPDzSCw==
From:   "tip-bot2 for Fabio M. De Francesco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix kernel-doc in internal.h
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210618223206.29539-1-fmdefrancesco@gmail.com>
References: <20210618223206.29539-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Message-ID: <162452317423.395.6795057128472550443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     fd2afa70eff057fab57c9e06708b68677b261a0c
Gitweb:        https://git.kernel.org/tip/fd2afa70eff057fab57c9e06708b68677b261a0c
Author:        Fabio M. De Francesco <fmdefrancesco@gmail.com>
AuthorDate:    Sat, 19 Jun 2021 00:32:06 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Jun 2021 10:23:57 +02:00

x86/resctrl: Fix kernel-doc in internal.h

Add description of undocumented parameters. Issues detected by
scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20210618223206.29539-1-fmdefrancesco@gmail.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c4d320d..6a5f60a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -70,6 +70,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
  * @name:		name of the event
+ * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
 	u32			evtid;
@@ -78,10 +79,13 @@ struct mon_evt {
 };
 
 /**
- * struct mon_data_bits - Monitoring details for each event file
- * @rid:               Resource id associated with the event file.
+ * union mon_data_bits - Monitoring details for each event file
+ * @priv:              Used to store monitoring event data in @u
+ *                     as kernfs private data
+ * @rid:               Resource id associated with the event file
  * @evtid:             Event id associated with the event file
  * @domid:             The domain to which the event file belongs
+ * @u:                 Name of the bit fields struct
  */
 union mon_data_bits {
 	void *priv;
@@ -119,6 +123,7 @@ enum rdt_group_type {
  * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
  * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
  *                          allowed AND the allocations are Cache Pseudo-Locked
+ * @RDT_NUM_MODES: Total number of modes
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
@@ -142,7 +147,7 @@ enum rdtgrp_mode {
 
 /**
  * struct mongroup - store mon group's data in resctrl fs.
- * @mon_data_kn		kernlfs node for the mon_data directory
+ * @mon_data_kn:		kernfs node for the mon_data directory
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
@@ -282,11 +287,11 @@ struct rftype {
 /**
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
- * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
+ * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
  * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
- * @prev_bw	The most recent bandwidth in MBps
- * @delta_bw	Difference between the current and previous bandwidth
- * @delta_comp	Indicates whether to compute the delta_bw
+ * @prev_bw:	The most recent bandwidth in MBps
+ * @delta_bw:	Difference between the current and previous bandwidth
+ * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
 	u64	chunks;
@@ -456,11 +461,13 @@ struct rdt_parse_data {
  * @data_width:		Character width of data when displaying
  * @domains:		All domains for this resource
  * @cache:		Cache allocation related data
+ * @membw:		If the component has bandwidth controls, their properties.
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
  * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
+ * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
