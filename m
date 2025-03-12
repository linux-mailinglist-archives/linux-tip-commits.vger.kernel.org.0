Return-Path: <linux-tip-commits+bounces-4167-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CCEA5E2AD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54737189DFBF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD5025E817;
	Wed, 12 Mar 2025 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G7n/vzGN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fj+rHpMB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552CF261396;
	Wed, 12 Mar 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800047; cv=none; b=sOQSX+hHB4OkR7tURVHUpnNnHXXKaA2p1aHgpkLAyDFUeqDOXoSkL6BzNeQC6Xf3fnSlnaKcSSzxRGLwleaL62pLDszZPlqVWlUfUCHX96OXM4srTG5FM1SMCy/j54UW2cyogbBT8vUJ5aXngKgRLuF9uBXUqdojHQfpUiDw8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800047; c=relaxed/simple;
	bh=zY/E3+MMfZT/Z6oKxlt3ZG+OX/yaxpNhbyP2yPPIoSI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZBg0T8ARz8vRdEaYO4yiDLik7mh+TSEy8daVGsE4fZzfkV+x2JZDf/AxxS+7DGMydOvNMGXbPj5JqpeLnDs5svVqcTIyOSM+Nry0uFrJRkyTEKVZfwn5D/h/+hRua2Yu9ohaVZZuYd+40+T/hJty3svmAWRUxdqHR4YNEFENDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G7n/vzGN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fj+rHpMB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RreJT1/950Dby68fooq9s1rkdrwZswaf+2hQ7LS+KUs=;
	b=G7n/vzGNFFW90Y22CctVyg/OJ1M0gMnqkrGmgcjDk67e0B1eZFSWg39w2Np2DP5H7g1+18
	ZiOdmOjGTGaRBoFym8UMbnKmvhWGqonN2Px/in9u/28N5ie8EbaRJpSjDuyogvAE7RrIff
	jijHiA6LlAJE92Qw8U87L9yThPvlezu51MKdDN/lp67rAZBLW2ay2f2NqiKk20AkPntorO
	hyh+zSN6ibTD7Ieoszkf0/e2Kwpmn1mNCM0srVgQfdQyIcyU0MhE3zCp31eKvX39KLxzG7
	e3nPEKZ/+Xb13uin8+DLj0h5ohegoMkAvUOp6VkC7pkkaq4f5x72r/YzNsW/PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RreJT1/950Dby68fooq9s1rkdrwZswaf+2hQ7LS+KUs=;
	b=fj+rHpMB5pn9RnomNnUTBt737kEOq3gOuVe8oKN3LMMM0Xu0G3xYoaIHLT4/zrbxFjajrM
	sZch27JxI9r0cIAA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix allocation of cleanest CLOSID on
 platforms with no monitors
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 David Hildenbrand <david@redhat.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-2-james.morse@arm.com>
References: <20250311183715.16445-2-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180004175.14745.2700864391580765240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     a121798ae669351ec0697c94f71c3a692b2a755b
Gitweb:        https://git.kernel.org/tip/a121798ae669351ec0697c94f71c3a692b2a755b
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:46 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:21:48 +01:00

x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no monitors

Commit

  6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid")

added logic that causes resctrl to search for the CLOSID with the fewest dirty
cache lines when creating a new control group, if requested by the arch code.
This depends on the values read from the llc_occupancy counters. The logic is
applicable to architectures where the CLOSID effectively forms part of the
monitoring identifier and so do not allow complete freedom to choose an unused
monitoring identifier for a given CLOSID.

This support missed that some platforms may not have these counters.  This
causes a NULL pointer dereference when creating a new control group as the
array was not allocated by dom_data_init().

As this feature isn't necessary on platforms that don't have cache occupancy
monitors, add this to the check that occurs when a new control group is
allocated.

Fixes: 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid")
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-2-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6419e04..04b653d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -157,7 +157,8 @@ static int closid_alloc(void)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
+	    is_llc_occupancy_enabled()) {
 		cleanest_closid = resctrl_find_cleanest_closid();
 		if (cleanest_closid < 0)
 			return cleanest_closid;

