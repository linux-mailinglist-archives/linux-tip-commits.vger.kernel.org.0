Return-Path: <linux-tip-commits+bounces-5640-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E1ABA94A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D35A03B65
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EC1F4CA2;
	Sat, 17 May 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQ6IDcUR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4l66ISW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1161EF080;
	Sat, 17 May 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476176; cv=none; b=BHuaeVnTpAaXXN/4OMJAloX+LRE57WzT35KkKwI/xZOxKHBpLcFdOb3CRIqhLrYoOXmI5mMuERVxJQGSg7aAsfHMfm93YHc0N5hDgN5zGIgBBsOAyAnukUwoBcaPMul55n0S9zmE5gSfwdC9u2cGkCtj9XBId0c8kzpVqDpoexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476176; c=relaxed/simple;
	bh=hjxx3qMjVGUBVz0my5IbR1gjuMx3YJk9K2SfmaUg7ho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r2r5UXRR2A+MtqnTJA3I58lZp1X13QuRfXXiZn9LdRV0EFkB6zKrx3D1vXFtWk8+6UXCET/K4f7tdQS4w7teOabl3DlTZHWnMeVAoDbaGvFSMkAysoCgKqQHoRBklD+ALG8kKncVVsw0V+zyMe4CE45TzfNWmhX2a1Y+33GCyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQ6IDcUR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4l66ISW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjiKIXS4Ctw7o2jpa1G+ExSWkLPWd5X7PwjHCHET+Rg=;
	b=fQ6IDcURnboCoOhkfWrA5aWdVS/GfVfFv5M+cQcJQcLkfMTLf738O2It/U06ziiPt5zKzU
	IPUKgWSnym/5Izlldll34EQG22+qTcGhU2p5t0ai/uKNxa5didmvVCpahejQydhNeGGgj7
	im5LidQIfB+Beu13q56xaIQhfqL2esOujFUX8FayDYxGLnYwUjPd2CXUdXAn72JlxLptQV
	EiCkAmpLpsmJxE7BZ7eBw+xzeM0Su4aCGtfLWxdVZTrIUI7Nlc9N/zxKDO7Jylg6FX9ZtZ
	IbQW5W/E/B0TCAEsWFcKSzjaqynXtEYBHR8Ja4wiOWPGeqkp++HViuU8ZTy68Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjiKIXS4Ctw7o2jpa1G+ExSWkLPWd5X7PwjHCHET+Rg=;
	b=Y4l66ISWLihNSBdvJMZZ9d/H2MqEOsgoy6PsdWZ9Ap3lD3jf0GN6STPO3eYN/9Im68Kbl4
	IJwG/3chNMSL/wCQ==
From: "tip-bot2 for Dave Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Squelch whitespace anomalies in resctrl
 core code
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Fenghua Yu <fenghuay@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-21-james.morse@arm.com>
References: <20250515165855.31452-21-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617158.406.10484678256532751863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     556f48a5093b1edb1b8a594af633303269dec329
Gitweb:        https://git.kernel.org/tip/556f48a5093b1edb1b8a594af633303269dec329
Author:        Dave Martin <Dave.Martin@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:50 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 14:09:18 +02:00

x86/resctrl: Squelch whitespace anomalies in resctrl core code

checkpatch.pl complains about some whitespace anomalies in the
resctrl core code.

This doesn't matter, but since this code is about to be factored
out and made generic, this is a good opportunity to fix these
issues and so reduce future checkpatch fuzz.

Fix them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
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
Link: https://lore.kernel.org/20250515165855.31452-21-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ac4baf1..02c5f62 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1024,7 +1024,7 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 }
 
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
@@ -1034,7 +1034,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 }
 
 static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
@@ -1150,7 +1150,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 }
 
 static int rdt_min_bw_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+			   struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
@@ -1185,7 +1185,7 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 }
 
 static int rdt_bw_gran_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+			    struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
@@ -1195,7 +1195,7 @@ static int rdt_bw_gran_show(struct kernfs_open_file *of,
 }
 
 static int rdt_delay_linear_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
 	struct rdt_resource *r = s->res;
@@ -2068,7 +2068,6 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_closid_show,
 		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
 	},
-
 };
 
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
@@ -3628,7 +3627,6 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			goto out;
 		}
-
 	}
 
 	rdtgrp->mode = RDT_MODE_SHAREABLE;

