Return-Path: <linux-tip-commits+bounces-5652-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE97ABA962
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13226A02FB8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8820AF62;
	Sat, 17 May 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRqpAOyr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HYotn/QS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA72046B3;
	Sat, 17 May 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476186; cv=none; b=HcDAzTLHrCxvxfqef/oiEJPd7xSl92nRZnUHMsd5SxHLct7mW+jAI7ntSORnqEce8HxbNvmYRmI5dkUaqenFGjjradLOSOKvQZJAlnR/yZ/ib/VSTE12GFRq5r3UjxQH/TgCCwJJI+0MGnWUjjlPWzWSk+tHghASRRta0GM+7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476186; c=relaxed/simple;
	bh=rGhqyCzEzZax5EfSeEIBuaMGsLguTzGW8pF2+mepZQw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mKGLr0txWNUF7KAsEiBdKY5M8ft3Wy7ntb3U4z731NBqMKAlWh9jxoFhMEh1Ar0zOjNYYC9bUKpkxinpsurPNOQd45OYEO2PzcerWIHcmFALZqI4bYHnMIIdla43UZ0pOUnQYRsLzVzSN1sJiycVJFBXgeWyWT/Bq7Ayrhhl4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRqpAOyr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HYotn/QS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDk9rgXrdvRMiJsYj2iDRB29Y4A+pbOWmYLjA5nSTLQ=;
	b=gRqpAOyrz0zn5EOnTvPnF9OBB9mi9iJIDHgZ8k0QSOqD8Xk3i+0K8ICeHf4oJW+K7TvrXa
	AT5e7Qs333OFWcJD0xN+BP6G43+MAYCAFOvw9r9GfCBmjjbCdX+ZmWk7TTHLP8XfjIPPsa
	UbGchbEqD1wfZcQmeKgZ4TXxiWHy4P6vBSQReIdSKXMwFMdQEhw5cS5eyDNEK40nqApLXF
	41UFZPLOKoq2XDenlDrRUmpA53HAdJowTn1kOv3OZhrPl2mHLoih4UfEnHSsMpTH4kcmXJ
	+m79+A0RYO5w1Az4sAez0hlLUO/ILpi7ziJoZM9zat/dH5BDU5kprcNZTmQ8XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDk9rgXrdvRMiJsYj2iDRB29Y4A+pbOWmYLjA5nSTLQ=;
	b=HYotn/QSbI4VkXx/XfuDqCT3rQP7PNuO38B+jctLRKJwM0KQ2NhejTUuuJWDFL1oJIJVWI
	6ND+p7VBzWKAlOCw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Resctrl_exit() teardown resctrl but
 leave the mount point
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-9-james.morse@arm.com>
References: <20250515165855.31452-9-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618179.406.8045132395317904616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8c992e24a0627a6ba508184c07766862c8bb3e54
Gitweb:        https://git.kernel.org/tip/8c992e24a0627a6ba508184c07766862c8bb3e54
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:38 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 21:04:49 +02:00

x86/resctrl: Resctrl_exit() teardown resctrl but leave the mount point

resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
resctrl can't be built as a module, and the kernfs helpers are not exported so
this is unlikely to change. MPAM has an error interrupt which indicates the
MPAM driver has gone haywire. Should this occur tasks could run with the wrong
control values, leading to bad performance for important tasks.  In this
scenario the MPAM driver will reset the hardware, but it needs a way to tell
resctrl that no further configuration should be attempted.

In particular, moving tasks between control or monitor groups does not
interact with the architecture code, so there is no opportunity for the arch
code to indicate that the hardware is no-longer functioning.

Using resctrl_exit() for this leaves the system in a funny state as resctrl is
still mounted, but cannot be un-mounted because the sysfs directory that is
typically used has been removed. Dave Martin suggests this may cause systemd
trouble in the future as not all filesystems can be unmounted.

Add calls to remove all the files and directories in resctrl, and remove the
sysfs_remove_mount_point() call that leaves the system in a funny state. When
triggered, this causes all the resctrl files to disappear. resctrl can be
unmounted, but not mounted again.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-9-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 48 ++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 29f76ad..1e48c61 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3078,6 +3078,22 @@ static void rmdir_all_sub(void)
 	kernfs_remove(kn_mondata);
 }
 
+static void resctrl_fs_teardown(void)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/* Cleared by rdtgroup_destroy_root() */
+	if (!rdtgroup_default.kn)
+		return;
+
+	rmdir_all_sub();
+	rdt_pseudo_lock_release();
+	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	closid_exit();
+	schemata_list_destroy();
+	rdtgroup_destroy_root();
+}
+
 static void rdt_kill_sb(struct super_block *sb)
 {
 	struct rdt_resource *r;
@@ -3091,12 +3107,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	for_each_alloc_capable_rdt_resource(r)
 		resctrl_arch_reset_all_ctrls(r);
 
-	rmdir_all_sub();
-	rdt_pseudo_lock_release();
-	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
-	closid_exit();
-	schemata_list_destroy();
-	rdtgroup_destroy_root();
+	resctrl_fs_teardown();
 	if (resctrl_arch_alloc_capable())
 		resctrl_arch_disable_alloc();
 	if (resctrl_arch_mon_capable())
@@ -4127,6 +4138,8 @@ static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
 
 static void rdtgroup_destroy_root(void)
 {
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	kernfs_destroy_root(rdt_root);
 	rdtgroup_default.kn = NULL;
 }
@@ -4441,23 +4454,42 @@ static bool __exit resctrl_online_domains_exist(void)
 	return false;
 }
 
-/*
+/**
  * resctrl_exit() - Remove the resctrl filesystem and free resources.
  *
+ * Called by the architecture code in response to a fatal error.
+ * Removes resctrl files and structures from kernfs to prevent further
+ * configuration.
+ *
  * When called by the architecture code, all CPUs and resctrl domains must be
  * offline. This ensures the limbo and overflow handlers are not scheduled to
  * run, meaning the data structures they access can be freed by
  * resctrl_mon_resource_exit().
+ *
+ * After resctrl_exit() returns, the architecture code should return an
+ * error from all resctrl_arch_ functions that can do this.
+ * resctrl_arch_get_resource() must continue to return struct rdt_resources
+ * with the correct rid field to ensure the filesystem can be unmounted.
  */
 void __exit resctrl_exit(void)
 {
 	cpus_read_lock();
 	WARN_ON_ONCE(resctrl_online_domains_exist());
+
+	mutex_lock(&rdtgroup_mutex);
+	resctrl_fs_teardown();
+	mutex_unlock(&rdtgroup_mutex);
+
 	cpus_read_unlock();
 
 	debugfs_remove_recursive(debugfs_resctrl);
+	debugfs_resctrl = NULL;
 	unregister_filesystem(&rdt_fs_type);
-	sysfs_remove_mount_point(fs_kobj, "resctrl");
+
+	/*
+	 * Do not remove the sysfs mount point added by resctrl_init() so that
+	 * it can be used to umount resctrl.
+	 */
 
 	resctrl_mon_resource_exit();
 }

