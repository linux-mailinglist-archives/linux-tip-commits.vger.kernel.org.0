Return-Path: <linux-tip-commits+bounces-5644-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC97DABA953
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDB16DFA5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D911FECB4;
	Sat, 17 May 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PaeGXO8a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7DBGOAnJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084181F8AC5;
	Sat, 17 May 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476180; cv=none; b=kOzfSRLG5SRA5ybS9vBH8NP/c+0gmB14OyyhI/yX+JomYsPW8p3dXliXyPDEG1wVoBAYJDDYg8EyEGqL9+pTFx50L47CQkoWY+tZUvXfhQOF3f29EjXEXqvox/D5KWfxvorcIJCvldtLmAcXQUaHBj5zGl7ftc/a2hCJQp59W5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476180; c=relaxed/simple;
	bh=dTYk4lT4h5B/92Ero/wx2v+tPc/wZXx63I9XkaikwCs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NEyVr/IE1SMADeO5p6aiSrbFsqK5076YEfvoOcnNJp0NHv8Kagkn5nFnERz2z9Xel7k9OwZOGu5cmD771aNn57G6aNlLdLZKUq2D3zI40QVwpHknIJv0OsaEqqAGwx8o2nOIeaDk7qOpA2DNjzBdj63dF0JMn4xJuM/IOXSpY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PaeGXO8a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7DBGOAnJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDqo1OK3jGIzsQiyb35nm3Px6+B2HXUFWxf1TnvttJM=;
	b=PaeGXO8a8B7pXMw0mj5hlNEeTdWTbKVkK2lD9XOaTni8NAFEDmzqTOqDbZm+fgj0NVBFQ3
	D2cLWGcP+2Vl/nfqCPxTRPiVvvdOUia9RhCmnPQ2AATSZCDQoOdgj+ckVl12Ahn6QYvXtB
	eYgFAgxwnKX4TLmwIAEDe69WHbgfa8zhFsXoDbpsJb8mmFYVQRnOdAcSF5z+IAvNDuZnRu
	aPso6ytjB1t8e9AtJ3qMHHKGZASu4/GatkWfRmyRirOCbxPvoU+ndf9vBN46zGv7ubDQFW
	8QBu9CQGVYBpYPsgtYWe5EdxYAenN+rhvDmV8HB6iDsGNo1znrvGf0FHfwVcHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDqo1OK3jGIzsQiyb35nm3Px6+B2HXUFWxf1TnvttJM=;
	b=7DBGOAnJgXLp1OYEo6B92vWYqGyDIaIqJjezfLB99WEEjSsfWWQ7gW2ebvaUdZpLg+aSYZ
	ImgPjzDouCZKM8CQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-17-james.morse@arm.com>
References: <20250515165855.31452-17-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617519.406.1424586072173757662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3d95a49b365e06d1b4c4e5a426fdc70449a334f3
Gitweb:        https://git.kernel.org/tip/3d95a49b365e06d1b4c4e5a426fdc70449a334f3
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:46 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 11:35:23 +02:00

x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl

Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
on definitions in x86's internal.h.

Move definitions in internal.h that need to be shared between the
filesystem and architecture code to header files that fs/resctrl can
include.

Doing this separately means the filesystem code only moves between files
of the same name, instead of having these changes mixed in too.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-17-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  9 ---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  5 +++++
 include/linux/resctrl.h                |  3 +++
 include/linux/resctrl_types.h          |  3 +++
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 348895d..dc63ac5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -16,8 +16,6 @@
 #define CQM_LIMBOCHECK_INTERVAL	1000
 
 #define MBM_CNTR_WIDTH_BASE		24
-#define MBM_OVERFLOW_INTERVAL		1000
-#define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
@@ -396,13 +394,6 @@ extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 extern enum resctrl_event_id mba_mbps_default_event;
 
-static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
-{
-	return rdt_resources_all[l].cdp_enabled;
-}
-
-int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
-
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
 
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3a4a0bb..ac4baf1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2541,6 +2541,11 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].cdp_enabled;
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5c7c8bf..b9d1f29 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -403,6 +403,9 @@ static inline u32 resctrl_get_config_index(u32 closid,
 	}
 }
 
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index 69bf740..a66e793 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -7,6 +7,9 @@
 #ifndef __LINUX_RESCTRL_TYPES_H
 #define __LINUX_RESCTRL_TYPES_H
 
+#define MAX_MBA_BW			100u
+#define MBM_OVERFLOW_INTERVAL		1000
+
 /* Reads to Local DRAM Memory */
 #define READS_TO_LOCAL_MEM		BIT(0)
 

