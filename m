Return-Path: <linux-tip-commits+bounces-5650-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A5ABA95D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C461416A082
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A72063E7;
	Sat, 17 May 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="waw/ygah";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CElXWe7k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6C202C31;
	Sat, 17 May 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476185; cv=none; b=StLfbWMsnDW6Ebrciceuit8MG8SfHjzLjP6Bb8CnKMwZjA0oUIlsApczb/Y8QpAgcUywuw4RrbpqY3AE8KMnx1l43H/uufGqvcVFz04si0/iUUMK3bYV2NzS0bcYQCTJ4+dtvDWmeD5WTQ8GEmdpklxDbgqzuuJieSzmSlaLqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476185; c=relaxed/simple;
	bh=Lkmb2u6vw0XWrY3oBnpeKrQpH8xGagzMHar7N5TkcQA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QLAnTZQ4Vijrc44WWOtTjqxKPO0ouR3DZn+t6U9CvWVkCUqQVb7Ov/6sCVYny2Fok4ZRIAV+PUUYMqKAUM5sSn22khF2q6PiNJXK3qy+yFNCbuKRbKuXOCFjbbxDLt5j3DmARHDYD0lRoQOV55GVd0lxozdMXGepo/8RMfm2BVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=waw/ygah; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CElXWe7k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50GsA6nPGrDOQOd643MzkdNR1XbUXqMtWskp6opvxpk=;
	b=waw/ygahdQIfzR8tVNTmpuJF4Hfv8z1NBwSJRNue0Z1LGzq1TARlT6+N3SmflcxaQSvnG1
	awf6j50OovgkJ+3bgOCqTtNd1ThOb4Km4qEG5G5Bjd+OoMJ65ZdRMOjbQRP4NnO9JXxJAZ
	Zb9OdJs8rYhnjS1M2mJW7t4sArdYhyE234G0ddK6NOjBuP2rrowXppCfVQJ6CL5pzwkEmY
	v6MXqRZzDGDt9CWn6ImgBttYUv0jbYiW/kJECzHN1cqajM0Y89mtCbBHCEhIlyPKNul29Y
	sfUW3X3GqIzg+Ez7/Dw9J64se785ZMmnTi917KoTThZNs72yGj+JP5SKcSAoMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50GsA6nPGrDOQOd643MzkdNR1XbUXqMtWskp6opvxpk=;
	b=CElXWe7ktFk0Sg7Im3vzCyeq31uA8VTGke4kgXGAqhtmXEebFKdWTNeGC8X0ID3xOBPxbv
	DhCkuHBaH6TlOEAg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move is_mba_sc() out of core.c
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-11-james.morse@arm.com>
References: <20250515165855.31452-11-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618015.406.2567266570638564017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6c72fb8d8bd7bfaafdeda3a91c535ecf52283ec9
Gitweb:        https://git.kernel.org/tip/6c72fb8d8bd7bfaafdeda3a91c535ecf52283ec9
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:40 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 10:06:45 +02:00

x86/resctrl: Move is_mba_sc() out of core.c

is_mba_sc() is defined in core.c, but has no callers there. It does not access
any architecture private structures.

Move this to rdtgroup.c where the majority of callers are. This makes the move
of the filesystem code to /fs/ cleaner.

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
Link: https://lore.kernel.org/20250515165855.31452-11-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 15 ---------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 31538c6..58d7c6a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -164,21 +164,6 @@ static inline void cache_alloc_hsw_probe(void)
 	rdt_alloc_capable = true;
 }
 
-bool is_mba_sc(struct rdt_resource *r)
-{
-	if (!r)
-		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-
-	/*
-	 * The software controller support is only applicable to MBA resource.
-	 * Make sure to check for resource type.
-	 */
-	if (r->rid != RDT_RESOURCE_MBA)
-		return false;
-
-	return r->membw.mba_sc;
-}
-
 /*
  * rdt_get_mb_table() - get a mapping of bandwidth(b/w) percentage values
  * exposed to user interface and the h/w understandable delay values.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cfd846c..e2999f6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1535,6 +1535,21 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	return size;
 }
 
+bool is_mba_sc(struct rdt_resource *r)
+{
+	if (!r)
+		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+
+	/*
+	 * The software controller support is only applicable to MBA resource.
+	 * Make sure to check for resource type.
+	 */
+	if (r->rid != RDT_RESOURCE_MBA)
+		return false;
+
+	return r->membw.mba_sc;
+}
+
 /*
  * rdtgroup_size_show - Display size in bytes of allocated regions
  *

