Return-Path: <linux-tip-commits+bounces-1358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55C49027CD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jun 2024 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85679281214
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jun 2024 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99D145B09;
	Mon, 10 Jun 2024 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EcMc1WMN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+HMSNBL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0F8F6D;
	Mon, 10 Jun 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040950; cv=none; b=MNYOk2NzTVygqAiEDvCbP+2wrUjRpeENnAAO372+pbwiaW9Pv3e/x62vwPmHqMwM6CjWKVdkekbBAprb/aq+6R94ThQ5t/s7KnhkvGqY4gqyfY0IJ2/xvrAm828+WNjyo2XF0nMnFbOmDsrPfmvOFURPXPQd+s3v5vp4xYLB2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040950; c=relaxed/simple;
	bh=4KpdPppVr5f46r9JZ0o/NAcP8CvOThS90HJkhHc6kzE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XjkyRthsF/hz0htP1gr3S+CVqfqcwrjXnDbbWi52gL1byO/zWC4A6oKNUZFZtkFZ2sTwD2btkuT60P67NSXo4MHP++cg8aUe9l98EJM8A/n8ZIvYEUXe80f69o0wxNsHgdsMCeC7UmRGuUQDhnnpYeuC4TGBfID5WFEcijahdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EcMc1WMN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+HMSNBL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Jun 2024 17:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718040946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2bhZUvnjMisTSpvR8Abe8+PzaSCgII0UCHp/ShjHd4=;
	b=EcMc1WMNFRybhRE5tEUfLwIbmBCbNQeKRwtODHXMxME75Hg/7hVkRQJtR3R6yyo6z8zcOA
	eWDanueqOq8eih5HH6v85I/2Si3kMQa31QoaDxv0KGMwY16AP0RVfk7wjAPOn9Dd1Tir54
	j1v6PJXQKdOCqAw7NMIBoynPpl2tGLvkUQHCaCruqh37e+6vemf57ZK+xW2lCjjUeqkfte
	EqDTOkSQ63fm9k32IR4PmY9DOT0pwUI8feC6+0erHeqnO2wkf8jwvOluQ7zABOXDcVxHnp
	H2hoSx4Geu2IGLEJwJJ5/JJjFY4MiCweDc4gwjwk9CSdHAEhVhl2Iz3Cq8enPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718040946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2bhZUvnjMisTSpvR8Abe8+PzaSCgII0UCHp/ShjHd4=;
	b=g+HMSNBLEG193+Zd4F0WL4ZHURC+SBzdBw677cG8RM2Pu4WcunDS/r5hltVVEeZtCbHCMH
	Zw0zFSToV7sQ7OAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] cacheinfo: Add function to get cacheinfo for a given
 CPU and cache level
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610003927.341707-4-tony.luck@intel.com>
References: <20240610003927.341707-4-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171804094627.10875.11773528048521664924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     685cb1674060c2cb1b9da051a12933c082b8e874
Gitweb:        https://git.kernel.org/tip/685cb1674060c2cb1b9da051a12933c082b8e874
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Sun, 09 Jun 2024 17:39:26 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 10 Jun 2024 08:50:09 +02:00

cacheinfo: Add function to get cacheinfo for a given CPU and cache level

Resctrl open codes a search for information about a given cache level in
a couple of places (and more are on the way).

Provide a new inline function get_cpu_cacheinfo_level() in
<linux/cacheinfo.h> to do the search and return a pointer to the
cacheinfo structure.

Add lockdep_assert_cpus_held() to enforce the comment that cpuhp lock
must be held.

Simplify the existing get_cpu_cacheinfo_id() by using this new function
to do the search.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240610003927.341707-4-tony.luck@intel.com
---
 include/linux/cacheinfo.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2cb15fe..3dde175 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -3,6 +3,7 @@
 #define _LINUX_CACHEINFO_H
 
 #include <linux/bitops.h>
+#include <linux/cpuhplock.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 
@@ -113,23 +114,37 @@ int acpi_get_cache_info(unsigned int cpu,
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
 /*
- * Get the id of the cache associated with @cpu at level @level.
+ * Get the cacheinfo structure for the cache associated with @cpu at
+ * level @level.
  * cpuhp lock must be held.
  */
-static inline int get_cpu_cacheinfo_id(int cpu, int level)
+static inline struct cacheinfo *get_cpu_cacheinfo_level(int cpu, int level)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
 	int i;
 
+	lockdep_assert_cpus_held();
+
 	for (i = 0; i < ci->num_leaves; i++) {
 		if (ci->info_list[i].level == level) {
 			if (ci->info_list[i].attributes & CACHE_ID)
-				return ci->info_list[i].id;
-			return -1;
+				return &ci->info_list[i];
+			return NULL;
 		}
 	}
 
-	return -1;
+	return NULL;
+}
+
+/*
+ * Get the id of the cache associated with @cpu at level @level.
+ * cpuhp lock must be held.
+ */
+static inline int get_cpu_cacheinfo_id(int cpu, int level)
+{
+	struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, level);
+
+	return ci ? ci->id : -1;
 }
 
 #ifdef CONFIG_ARM64

