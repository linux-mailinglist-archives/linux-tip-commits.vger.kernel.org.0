Return-Path: <linux-tip-commits+bounces-3065-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0359F17C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ACC188F8EE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27701A8F7F;
	Fri, 13 Dec 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ST5X2QOL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHiR3c7p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E591A3034;
	Fri, 13 Dec 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123768; cv=none; b=MQklFuA+hVu+Hl2TqFkp8veFaB/VQxzDSzEapdiJ23jYuCLBdZQXZxWBfS/0TdyKFOugCkatT3eDzdzvsmD/+TI8xpROVBAN710mlfenUNkWI6qIrkeX+xauYsZjxBNxBpWCv0Cxbfj4BjMYF6EyUzAwiiTCGktCs6I+QQZAGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123768; c=relaxed/simple;
	bh=dkH7wpZOcBRmvRAjerJDUqjXLjSFDNWcdr/unNBVUoQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NXsGCjnshZFGcqC3K0+KuBgZhfrpEeuu4CdLpI8iK/rGwUw0OpxWaHWqpGXQ6iW58xEF5MCzGyJUCvalQBoICZUbeC5o0zl9e0WHSG3ugf74UNJYPY4rP+1yf8F6LgkRvi9G+FIh0o99VOW5/6A6fD2ik9QYsVuf/Me9zcrw/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ST5X2QOL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHiR3c7p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvM2mveZK9BWYre1CV9gORvKBV/5eMtlLRtAaTvlmGY=;
	b=ST5X2QOL2BPvre+qE2WBx7piqsOLnBtaYex+loMbjtNIjH6l036ixAiO1QcXrwEu5c+y9T
	axDAOuSLXMCsgD5rY+h49fTUFPHmLrb7wRLM2dsuBBua7iphGrIJObHr7F3JA0P4yjCZzf
	qzEKdKHnJQiUpku3cQoW6mOqZIvc7iXlZJkT6tPIiOmhwTdXLmRax1q0vf9MSjwBRIgkC3
	g9bxB+b8yJngnK9rUxwPlKaXR+BwotKqmoVcb8AGelcBevA4o0Zt9Kox47g1JJG63xs5iS
	wCzjwi+6Srehpl/NXUyXB9orXsM90k4xw9hAIgbfnKDi55I6Gffvd900k4it5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvM2mveZK9BWYre1CV9gORvKBV/5eMtlLRtAaTvlmGY=;
	b=YHiR3c7pQK2TP0/osW7AnZNeC3ZiWTKnDDBdpSEEpHUmgs6a4emahaLdIYqj8q+m7O6aPK
	mFSG4w9LQ38Jp+Cg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Introduce resctrl_file_fflags_init() to
 initialize fflags
Cc: Babu Moger <babu.moger@amd.com>, Tony Luck <tony.luck@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206163148.83828-2-tony.luck@intel.com>
References: <20241206163148.83828-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173412376412.412.4974766123437056297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2937f9c361f7a8b230cd599e4af5264798bf4ce7
Gitweb:        https://git.kernel.org/tip/2937f9c361f7a8b230cd599e4af5264798bf4ce7
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 06 Dec 2024 08:31:41 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 09 Dec 2024 21:37:01 +01:00

x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags

thread_throttle_mode_init() and mbm_config_rftype_init() both initialize
fflags for resctrl files.

Adding new files will involve adding another function to initialize
the fflags. This can be simplified by adding a new function
resctrl_file_fflags_init() and passing the file name and flags
to be initialized.

Consolidate fflags initialization into resctrl_file_fflags_init() and
remove thread_throttle_mode_init() and mbm_config_rftype_init().

  [ Tony: Drop __init attribute so resctrl_file_fflags_init() can be used at
    run time. ]

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20241206163148.83828-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 +++-
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +--
 arch/x86/kernel/cpu/resctrl/monitor.c  |  6 ++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 ++-------------
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b681c2e..f3ee585 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -234,7 +234,9 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 955999a..faaff9d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -647,8 +647,7 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_mon_domain *d);
 void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init thread_throttle_mode_init(void);
-void __init mbm_config_rftype_init(const char *config);
+void resctrl_file_fflags_init(const char *config, unsigned long fflags);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5fcb3d6..69bdc11 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1224,11 +1224,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 			mbm_total_event.configurable = true;
-			mbm_config_rftype_init("mbm_total_bytes_config");
+			resctrl_file_fflags_init("mbm_total_bytes_config",
+						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 			mbm_local_event.configurable = true;
-			mbm_config_rftype_init("mbm_local_bytes_config");
+			resctrl_file_fflags_init("mbm_local_bytes_config",
+						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d906a1c..d333570 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2020,24 +2020,13 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-void __init thread_throttle_mode_init(void)
-{
-	struct rftype *rft;
-
-	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
-	if (!rft)
-		return;
-
-	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
-}
-
-void __init mbm_config_rftype_init(const char *config)
+void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
 
 	rft = rdtgroup_get_rftype_by_name(config);
 	if (rft)
-		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
+		rft->fflags = fflags;
 }
 
 /**

