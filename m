Return-Path: <linux-tip-commits+bounces-5642-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5751ABA94D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FE17A2E84
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687A1FAC42;
	Sat, 17 May 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PpqCM8Jj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3sn/8B0T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7B1F4C9B;
	Sat, 17 May 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476178; cv=none; b=iXHim46Zngj2eJGUJrNEt/wnw6wHiZtOLvx6FYz9W+KsNlI9Cdn3FqfgU3zd+6zxb+VTWh0p19WEBPgmYx0TLdiqtY7i5itA3WRBkJjz7jaX9fDoLFQBP9PPq05bPjgQOyjZl/PcfF7QtiC5XqmPOWXdPoPvkKmOTlE+1Sq2ZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476178; c=relaxed/simple;
	bh=0k8hMQ8dlwk0JXLeCWuLodXq477FoCRKSx0pTSBdNUg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ehfgLTVpovxzI/hZTk0lNnQCfYk4YRzUadXsGhR3JF70o/rDVZoz8a2mTnHyruYYz0qVUdTsDVvbF1RUNW5DEatD8FhqfRQNBfqW9oC0NVBsupoiP4TV+9Rc88c4c9goGWys38gbx6D+3p+f0kFpI82ECiEiNpT7jwePtByqJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PpqCM8Jj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3sn/8B0T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxRCgBuWd08phQpNDFasYKRX6iGb2J6y1RH5EFspDr4=;
	b=PpqCM8JjJvRIimEPymnOIZ6r1xyjheQmJT+ag/02vAkUga1shRwZRLpLe5rJQ5z+sZVnCl
	gocK3tG0NdtbTCASgSJXqN9XGuJYuQek+FJ9RqwLwaseZGMVMSQs9sgz7/fYK0L8YwwrJp
	y+DKptQwxZC1AJWND85UAXsW+/DlaWB6utNxrzu3hJFvs5cakBua9/d2X1H+Q4EWhjx31g
	Bm8xHU7fKQQXQHJ5/xJTc42zk3D13mn7/KbkFbSB5VnKSPdi1UF4LZnH4v+3keFf62rBlt
	z/WBov+DR0pcs5PPG3QSjyE5H3ijPiiVn6yY9iScYId2WfOvdbI4q7fIl53CDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxRCgBuWd08phQpNDFasYKRX6iGb2J6y1RH5EFspDr4=;
	b=3sn/8B0TdmytjjAs8lq7/UkYRSr7pa+Dl90otTqptYFdRzt9uK1knaj8r0iFWXehjs3iCQ
	a5y80YReV5cneWDw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix types in
 resctrl_arch_mon_ctx_{alloc,free}() stubs
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-19-james.morse@arm.com>
References: <20250515165855.31452-19-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617349.406.17338266581482000016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     272ed1c28c9db60b9bd50d49feae463df50b3ef6
Gitweb:        https://git.kernel.org/tip/272ed1c28c9db60b9bd50d49feae463df50b3ef6
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:48 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 12:10:51 +02:00

x86/resctrl: Fix types in resctrl_arch_mon_ctx_{alloc,free}() stubs

resctrl_arch_mon_ctx_alloc() and resctrl_arch_mon_ctx_free() take an enum
resctrl_event_id that is already defined in resctrl_types.h to be
accessible to asm/resctrl.h.

The x86 stubs take an int. Fix that.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-19-james.morse@arm.com
---
 arch/x86/include/asm/resctrl.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 7a39728..a2e20fe 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -194,14 +194,16 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
 
 /* x86 can always read an rmid, nothing needs allocating */
 struct rdt_resource;
-static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid)
+static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
+					       enum resctrl_event_id evtid)
 {
 	might_sleep();
 	return NULL;
-};
+}
 
-static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
-					     void *ctx) { };
+static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
+					     enum resctrl_event_id evtid,
+					     void *ctx) { }
 
 u64 resctrl_arch_get_prefetch_disable_bits(void);
 int resctrl_arch_pseudo_lock_fn(void *_plr);

