Return-Path: <linux-tip-commits+bounces-5653-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55908ABA966
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9011BA1D30
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44CC20B80C;
	Sat, 17 May 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJekmwA0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wYPU5NU1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF167205AC1;
	Sat, 17 May 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476186; cv=none; b=UzpI5eocf82N4caEjjbjorUUBQmDlxLEsnRrMobzARWjOCa4tuM5dM4FbYaYeY2oi4nHlvmlwfy7L5ZlQOq+CtfouLxcACLO4EVjDFGuHQa/mm0Hjrlf00jyUyGwKQoVRXqZ5KrtwJMQZ5lsKZIVo9TwWk7MQSYjXGhU/C4ss0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476186; c=relaxed/simple;
	bh=QQf1o9ifPefvEdQYHmV3eUANvfeMQPAFnbjn1kC20qI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z3K3UGEu7a5RNbo8olQxsv8nc2RDKvl5O5kPCOyYDV3TUr0jbbPb1OY7QqnbnC/xBvnc8yEOLUdCuGVsjW3AmQjUWlL+hsk+lJiXNew6vtpBsgM5bkYQDP39y5SOW4LtUnNLPM7JDTuJwtsBV7cS7DQ5gVsQHj94zkUxANwsfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJekmwA0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wYPU5NU1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGuIzAJWeDZWSrlVnpD9xq9d1+D9VuqNGm4KIKObcio=;
	b=RJekmwA0zYSQMhaU4efe+PEHZJFtt0QMaxP469cXM8/LG+w8J8n85JiXk+WtDDchHvvVag
	tr9LLZfODD3pGB9zpYvvyUq4WgvGcxxsJo+f0vKaQCo+j7us4htMaNYJ4Kn7LINIE7VxUX
	o3g66NHjK/bynVot+TDvn0ZwIBwtWb0IoMQRwrWJvrQZEwiBHMJI30v/km3RpGY/afSWog
	/DzGcqjp8EonOEDOGM8YzjDBlb4urtFxpvfQUoEAWd0VYrL2T7b/t2MqoJ8C4G3oJu3Ria
	t0nSd3bv8tgyy86B2w816KP2fb1TsmgdzDSYiUXbr5hSA/gp742Cj11GS3HN+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGuIzAJWeDZWSrlVnpD9xq9d1+D9VuqNGm4KIKObcio=;
	b=wYPU5NU1UkJd1zWm8zNp+qIAbt2/FjBdZCd3uh2qlCBQxtWBa9rmyNC9Y+D39+zrOV5HeD
	74Jj7v9msFiWnxCw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Check all domains are offline in resctrl_exit()
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Fenghua Yu <fenghuay@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-8-james.morse@arm.com>
References: <20250515165855.31452-8-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618259.406.16878539358798396377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8eb7ad66badc71e0d8547cf6195a2a6190090152
Gitweb:        https://git.kernel.org/tip/8eb7ad66badc71e0d8547cf6195a2a6190090152
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:37 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 21:02:21 +02:00

x86/resctrl: Check all domains are offline in resctrl_exit()

resctrl_exit() removes things like the resctrl mount point directory
and unregisters the filesystem prior to freeing data structures that
were allocated during resctrl_init().

This assumes that there are no online domains when resctrl_exit() is
called. If any domain were online, the limbo or overflow handler could
be scheduled to run.

Add a check for any online control or monitor domains, and document that
the architecture code is required to offline all monitor and control
domains before calling resctrl_exit().

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-8-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 +++++++++++++++++++++++++-
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 88197af..29f76ad 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4420,8 +4420,41 @@ cleanup_mountpoint:
 	return ret;
 }
 
+static bool __exit resctrl_online_domains_exist(void)
+{
+	struct rdt_resource *r;
+
+	/*
+	 * Only walk capable resources to allow resctrl_arch_get_resource()
+	 * to return dummy 'not capable' resources.
+	 */
+	for_each_alloc_capable_rdt_resource(r) {
+		if (!list_empty(&r->ctrl_domains))
+			return true;
+	}
+
+	for_each_mon_capable_rdt_resource(r) {
+		if (!list_empty(&r->mon_domains))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * resctrl_exit() - Remove the resctrl filesystem and free resources.
+ *
+ * When called by the architecture code, all CPUs and resctrl domains must be
+ * offline. This ensures the limbo and overflow handlers are not scheduled to
+ * run, meaning the data structures they access can be freed by
+ * resctrl_mon_resource_exit().
+ */
 void __exit resctrl_exit(void)
 {
+	cpus_read_lock();
+	WARN_ON_ONCE(resctrl_online_domains_exist());
+	cpus_read_unlock();
+
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");

