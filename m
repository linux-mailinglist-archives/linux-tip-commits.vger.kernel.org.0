Return-Path: <linux-tip-commits+bounces-1467-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FFE90E7BA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C18289258
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 10:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCB81AD7;
	Wed, 19 Jun 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RFpGFGXD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYGFFKPZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC878172D;
	Wed, 19 Jun 2024 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791266; cv=none; b=KXZUJBBO8hfTaDa1vbTCFvhSq1ysFEoZa6g2IxgFwpRbIHDabodKg0/QU52YynLGOdw1kNpxdmO+fyKpYbtx94H4K7YupwyjiFU5B+NBpil8cE6HtNlWgUFSZi1kwgsxKW3lKEsYRPNvGc4n7aMZahQPmOUGqcu7jyrEtzLszlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791266; c=relaxed/simple;
	bh=56gWdS0r3P034qfTC6dEx+ZsazGXwm3BzZXrHXMJoBo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pXpMTGifVlmlezBht2wxDDgKrCKt7pYyO6/XtWnLS8oV3qJnl0D8GBFwggOGGiQTT0Gvq2Nrhbs2W6IZ2Ja+xVaBnK9AJDrrRBNZEnp7PJpX1sjuiiHupwOC55l8bZ00K41SPw7wtPMjwoWYx7xG1e1JuyPMfd8gtfWhm0gq2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RFpGFGXD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BYGFFKPZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Jun 2024 09:55:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718790924;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39Ej7f2gzTXs2rXC0Yka/eWP1xrNbSB7cIs9Yf9GBIk=;
	b=RFpGFGXDrgxrFyGvqlsaVfaJwMVlv00oo1E9gHsj+WEcApIOZy+rINvIGkooNBDW2EvlDS
	S2FNEx9aT2qLc03CFbaDWOE57X9tory8M6ekORRjz3Qu2gfaO0b33zvTiXgp3MGaYuMYdo
	nuTZx5UOztS+H4dV5GmeD5ImSAWI52W7SC3G6sn2dJWbgE+WvwNEb12f6MptaZRbeabLse
	odYsxdw1BPxMA42s6ZyXALylaZP3oG9q1vOq1C9p5E2hikPY6eX5lqB3ra4pJsYeQ6qh2D
	TWfsaBD4IJF06lAJeIoeKns9ookRIvHrXnURZbcjzSxcfRyJEKAahKcb9aZb2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718790924;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39Ej7f2gzTXs2rXC0Yka/eWP1xrNbSB7cIs9Yf9GBIk=;
	b=BYGFFKPZFTmPF5UoRGB5zEsLLY+L4j3Wk6HnBuBh4Cq2CFp4ov09GI3rGgjs7RBbCIKfWE
	tnCNDFTtMFaOPCAw==
From: "tip-bot2 for Dave Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Don't try to free nonexistent RMIDs
Cc: Dave Martin <Dave.Martin@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240618140152.83154-1-Dave.Martin@arm.com>
References: <20240618140152.83154-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     739c9765793e5794578a64aab293c58607f1826a
Gitweb:        https://git.kernel.org/tip/739c9765793e5794578a64aab293c58607f1826a
Author:        Dave Martin <Dave.Martin@arm.com>
AuthorDate:    Tue, 18 Jun 2024 15:01:52 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 19 Jun 2024 11:39:09 +02:00

x86/resctrl: Don't try to free nonexistent RMIDs

Commit

  6791e0ea3071 ("x86/resctrl: Access per-rmid structures by index")

adds logic to map individual monitoring groups into a global index space used
for tracking allocated RMIDs.

Attempts to free the default RMID are ignored in free_rmid(), and this works
fine on x86.

With arm64 MPAM, there is a latent bug here however: on platforms with no
monitors exposed through resctrl, each control group still gets a different
monitoring group ID as seen by the hardware, since the CLOSID always forms part
of the monitoring group ID.

This means that when removing a control group, the code may try to free this
group's default monitoring group RMID for real.  If there are no monitors
however, the RMID tracking table rmid_ptrs[] would be a waste of memory and is
never allocated, leading to a splat when free_rmid() tries to dereference the
table.

One option would be to treat RMID 0 as special for every CLOSID, but this would
be ugly since bookkeeping still needs to be done for these monitoring group IDs
when there are monitors present in the hardware.

Instead, add a gating check of resctrl_arch_mon_capable() in free_rmid(), and
just do nothing if the hardware doesn't have monitors.

This fix mirrors the gating checks already present in
mkdir_rdt_prepare_rmid_alloc() and elsewhere.

No functional change on x86.

  [ bp: Massage commit message. ]

Fixes: 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by index")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240618140152.83154-1-Dave.Martin@arm.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2345e68..366f496 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -519,7 +519,8 @@ void free_rmid(u32 closid, u32 rmid)
 	 * allows architectures that ignore the closid parameter to avoid an
 	 * unnecessary check.
 	 */
-	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+	if (!resctrl_arch_mon_capable() ||
+	    idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 						RESCTRL_RESERVED_RMID))
 		return;
 

