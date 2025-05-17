Return-Path: <linux-tip-commits+bounces-5655-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C3ABA96A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226BD1BA1951
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEDC20E314;
	Sat, 17 May 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ww3lC2lL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W7kuNS2y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3420B806;
	Sat, 17 May 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476189; cv=none; b=f656MobvqW15LWae2cCDJ+dncoMgzkr4/OIAATil64pY+sPMys4G4+3d7PPvIBOZrWtQcn8BYgugAQIQu6gCFG6woUScoT6v0Rgk7UoJYZMgVt0manWKIcVHeyVKAeMUAx7KaLm97DEvJu8ougJmU3k6UHmrJzhQUYkfYzfnDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476189; c=relaxed/simple;
	bh=Aadu4Amz7jABiXDeyV/b/1//CboMCLvFZZgcCx/u/Q0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IxcoWah+kuwdwCI7j5IKmznEPB1/PSv12RdFS87loEbDnA9Zgq/+aq9cBYoEgtqKQKU59WZwIqQmY/TSle1gGptx8t+bhExAf5JEihmjeujNtJNmQVU9a+ws5JNrapoto0mkNuc88oz6kta2Manrx/Kp4SOEn0pWr2f2yfd0/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ww3lC2lL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W7kuNS2y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oY7K1eKZeDytEF7Q1hoEGwRzbrMVpyd3G/6SzEmpFw=;
	b=Ww3lC2lLJ9ECn3uh50syU27c2TdHrEBZdcOuvmWFUae8noSYLGjheDk1uQk3/BTya4gh2g
	D027FU0udUh4mllE4FnvvRMlVVuVzQRKhbahtcZNYBAm3krV8qwWwsltMiXaP5FUaDjWbJ
	7ubNQBstuYGf/sCz/LrrFwsHw5tccK0g+3BsQxAGoMBWckZ2VxzJRAPXfKoaUAot9p7iyf
	4JAR39yYKRmNQPshZVJTYPJM9iukNRrWV/Ma4Hqj7sRkCbcJiim6rUZTz737lkAlrggB0J
	52vPzaAYtTxksxoS4sOKBIjkNAi6+5JwaeauAB/+gQKzddddyhFHmy/3il43gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oY7K1eKZeDytEF7Q1hoEGwRzbrMVpyd3G/6SzEmpFw=;
	b=W7kuNS2yiBMFW4BxMIQUqqO0O1gMqGTaCQkB+ThqS5cly3bYWMRaO691INiOYyUx37nUd/
	EcbzPEwc7mtYMBCw==
From: "tip-bot2 for Amit Singh Tomar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Remove the limit on the number of CLOSID
Cc: Amit Singh Tomar <amitsinght@marvell.com>,
 James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Fenghua Yu <fenghuay@nvidia.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-6-james.morse@arm.com>
References: <20250515165855.31452-6-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618413.406.12367096845853509284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     dcb1d3d3b77bdb30d2ec97f540d58ee35f1b1c82
Gitweb:        https://git.kernel.org/tip/dcb1d3d3b77bdb30d2ec97f540d58ee35f1b1c82
Author:        Amit Singh Tomar <amitsinght@marvell.com>
AuthorDate:    Thu, 15 May 2025 16:58:35 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 20:55:40 +02:00

x86/resctrl: Remove the limit on the number of CLOSID

Resctrl allocates and finds free CLOSID values using the bits of a u32.
This restricts the number of control groups that can be created by
user-space.

MPAM has an architectural limit of 2^16 CLOSID values, Intel x86 could
be extended beyond 32 values. There is at least one MPAM platform which
supports more than 32 CLOSID values.

Replace the fixed size bitmap with calls to the bitmap API to allocate
an array of a sufficient size.

ffs() returns '1' for bit 0, hence the existing code subtracts 1 from
the index to get the CLOSID value. find_first_bit() returns the bit
number which does not need adjusting.

  [ morse: fixed the off-by-one in the allocator and the wrong not-found
    value. Removed the limit. Rephrase the commit message. ]

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-6-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 51 +++++++++++++++++--------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cc4a541..53213ca 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -130,8 +130,8 @@ static bool resctrl_is_mbm_event(int e)
 }
 
 /*
- * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
- * we can keep a bitmap of free CLOSIDs in a single integer.
+ * Trivial allocator for CLOSIDs. Use BITMAP APIs to manipulate a bitmap
+ * of free CLOSIDs.
  *
  * Using a global CLOSID across all resources has some advantages and
  * some drawbacks:
@@ -144,7 +144,7 @@ static bool resctrl_is_mbm_event(int e)
  * - Our choices on how to configure each resource become progressively more
  *   limited as the number of resources grows.
  */
-static unsigned long closid_free_map;
+static unsigned long *closid_free_map;
 static int closid_free_map_len;
 
 int closids_supported(void)
@@ -152,20 +152,35 @@ int closids_supported(void)
 	return closid_free_map_len;
 }
 
-static void closid_init(void)
+static int closid_init(void)
 {
 	struct resctrl_schema *s;
-	u32 rdt_min_closid = 32;
+	u32 rdt_min_closid = ~0;
+
+	/* Monitor only platforms still call closid_init() */
+	if (list_empty(&resctrl_schema_all))
+		return 0;
 
 	/* Compute rdt_min_closid across all resources */
 	list_for_each_entry(s, &resctrl_schema_all, list)
 		rdt_min_closid = min(rdt_min_closid, s->num_closid);
 
-	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
+	closid_free_map = bitmap_alloc(rdt_min_closid, GFP_KERNEL);
+	if (!closid_free_map)
+		return -ENOMEM;
+	bitmap_fill(closid_free_map, rdt_min_closid);
 
 	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
-	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
+	__clear_bit(RESCTRL_RESERVED_CLOSID, closid_free_map);
 	closid_free_map_len = rdt_min_closid;
+
+	return 0;
+}
+
+static void closid_exit(void)
+{
+	bitmap_free(closid_free_map);
+	closid_free_map = NULL;
 }
 
 static int closid_alloc(void)
@@ -182,12 +197,11 @@ static int closid_alloc(void)
 			return cleanest_closid;
 		closid = cleanest_closid;
 	} else {
-		closid = ffs(closid_free_map);
-		if (closid == 0)
+		closid = find_first_bit(closid_free_map, closid_free_map_len);
+		if (closid == closid_free_map_len)
 			return -ENOSPC;
-		closid--;
 	}
-	__clear_bit(closid, &closid_free_map);
+	__clear_bit(closid, closid_free_map);
 
 	return closid;
 }
@@ -196,7 +210,7 @@ void closid_free(int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	__set_bit(closid, &closid_free_map);
+	__set_bit(closid, closid_free_map);
 }
 
 /**
@@ -210,7 +224,7 @@ bool closid_allocated(unsigned int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	return !test_bit(closid, &closid_free_map);
+	return !test_bit(closid, closid_free_map);
 }
 
 /**
@@ -2765,20 +2779,22 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out_ctx;
 	}
 
-	closid_init();
+	ret = closid_init();
+	if (ret)
+		goto out_schemata_free;
 
 	if (resctrl_arch_mon_capable())
 		flags |= RFTYPE_MON;
 
 	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
-		goto out_schemata_free;
+		goto out_closid_exit;
 
 	kernfs_activate(rdtgroup_default.kn);
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret < 0)
-		goto out_schemata_free;
+		goto out_closid_exit;
 
 	if (resctrl_arch_mon_capable()) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
@@ -2829,6 +2845,8 @@ out_mongrp:
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
+out_closid_exit:
+	closid_exit();
 out_schemata_free:
 	schemata_list_destroy();
 out_ctx:
@@ -3076,6 +3094,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	closid_exit();
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
 	if (resctrl_arch_alloc_capable())

