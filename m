Return-Path: <linux-tip-commits+bounces-4161-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351BAA5E29F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD16A189758B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA6C25F7B7;
	Wed, 12 Mar 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMsbgRqa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6rqbt5+P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414925E47B;
	Wed, 12 Mar 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800041; cv=none; b=NjE63O+j9KFbGCNTE6CbFYahGbJRhXwB6FTfDoRGJbyWY86V6HMDgAc46jzuyo4JjtDgNJ3gQxiWnVSZLYqWNmqHD5V+2nacEzc3GTqn3h515PWYg2bRu8dL3pPC9J9obXG3cln9O2jxDqg5/o77idwIDvn8okKFigMb7JhB5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800041; c=relaxed/simple;
	bh=Es2c0s7vxbhxr/C7eN06Pm9WRIVoZxQZ7FzgURqj/Cw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VOux07tzydn65JzdIwUO7x++F+OfSD48SMjdQrEmy2Plca1xlfgF8zdIbVsGoWPmdUM0w48zV9dYBeI/UIX61q4hBbpanbiysiR7wjzbAv4TBZYIJaS5EZkuAYHGiRqhT0ZuXCJbDU4sC0plG/gu5EKF3CA4CCTiDMWZhl84uIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMsbgRqa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6rqbt5+P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMHHVUzTZQAeAbXSlk8G3JP8hJJ0AEBirdjZIGtO3us=;
	b=gMsbgRqa+N9JkICGManB+zLmHNM+mkRk/6ErQx9GO6LjIob6j/9EF+ws4nooi7PGwyq8Wd
	19Mw0tJ8Ut1jhlzCtoebfxpWcx8AiFE2YwQvZ5z5/GPknSw5s1GR82azGcucYQ6XY/3q/2
	rmgQajITm6ADwNp9RMqTysKzK6zyRLwITfIcprf7DOo7LX23J2HZaEx8DR0NIXd0bqOyy2
	Ul0Xk43KU+5JXZz0qnduhrMQac9e/6v4/pX7PUCiJ62ml7M7SLswvoy4lCWxVish1zI9sX
	mbewm0f7T8jytP6YnP7/1jPFqjIhOVTwMewJkDCHOPurGGVYCUKxy+fiWAIGUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMHHVUzTZQAeAbXSlk8G3JP8hJJ0AEBirdjZIGtO3us=;
	b=6rqbt5+P1fyEKqICYKjoHPaqNZJDxkgcL3vCXdafmgANNTgTni+vNXezep/Ck7h8CAElgK
	xFruEL+N7glZL4DQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add max_bw to struct resctrl_membw
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-8-james.morse@arm.com>
References: <20250311183715.16445-8-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003592.14745.7367404008398105750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     634ebb98b929443ea1a5502c93f26d01aedbd5c8
Gitweb:        https://git.kernel.org/tip/634ebb98b929443ea1a5502c93f26d01aedbd5c8
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:52 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:41 +01:00

x86/resctrl: Add max_bw to struct resctrl_membw

__rdt_get_mem_config_amd() and __get_mem_config_intel() both use the
default_ctrl property as a maximum value. This is because the MBA schema works
differently between these platforms. Doing this complicates determining
whether the default_ctrl property belongs to the arch code, or can be derived
from the schema format.

Deriving the maximum or default value from the schema format would avoid the
architecture code having to tell resctrl such obvious things as the maximum
percentage is 100, and the maximum bitmap is all ones.

Maximum bandwidth is always going to vary per platform. Add max_bw as
a special case. This is currently used for the maximum MBA percentage on Intel
platforms, but can be removed from the architecture code if 'percentage'
becomes a schema format resctrl supports directly.

This value isn't needed for other schema formats.

This will allow the default_ctrl to be generated from the schema properties
when it is needed.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-8-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 2 ++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 include/linux/resctrl.h                   | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 754fb65..4504a12 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -212,6 +212,7 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 	hw_res->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
+	r->membw.max_bw = MAX_MBA_BW;
 	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
 		r->membw.delay_linear = true;
@@ -250,6 +251,7 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
 	hw_res->num_closid = edx + 1;
 	r->default_ctrl = 1 << eax;
+	r->membw.max_bw = 1 << eax;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 59610b2..23a01ea 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -63,9 +63,9 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 		return true;
 	}
 
-	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+	if (bw < r->membw.min_bw || bw > r->membw.max_bw) {
 		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
-				    bw, r->membw.min_bw, r->default_ctrl);
+				    bw, r->membw.min_bw, r->membw.max_bw);
 		return false;
 	}
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e1a982a..465f3cf 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -165,6 +165,7 @@ enum membw_throttle_mode {
 /**
  * struct resctrl_membw - Memory bandwidth allocation related data
  * @min_bw:		Minimum memory bandwidth percentage user can request
+ * @max_bw:		Maximum memory bandwidth value, used as the reset value
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
  * @arch_needs_linear:	True if we can't configure non-linear resources
@@ -175,6 +176,7 @@ enum membw_throttle_mode {
  */
 struct resctrl_membw {
 	u32				min_bw;
+	u32				max_bw;
 	u32				bw_gran;
 	u32				delay_linear;
 	bool				arch_needs_linear;

