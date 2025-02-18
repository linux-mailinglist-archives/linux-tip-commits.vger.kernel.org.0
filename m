Return-Path: <linux-tip-commits+bounces-3403-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA330A39706
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA31898CD9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DBB22C336;
	Tue, 18 Feb 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVYdItDC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VDS1jo92"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3722F38E;
	Tue, 18 Feb 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870737; cv=none; b=O11lVhM4JJZF+OGsZuZPcVV/NKSfgQUGnNu4jGe+dwPDagFUD4s9Sq/Wf8KHJXoFNvuMuIn0S6uxKqCzkWjuILnj4Ir5KaUZmG8zCN2IvqNIfhi1cJv1oMD04iTa+XM9dwKKLDXnD+lTC0574gXDrQ1rHLwIAyccfumOEbY6i4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870737; c=relaxed/simple;
	bh=g8/Ra1OfuDnP9DvajmFqUww70TEtRSMHRewrOwq48AE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nyTvoAsnwNIz3s7QkZ8ivbnsSrUCdGMMwlayvCME1yylTjnYXa192o8csTNBQ5W8QveK1L3LWUySWWw34lkG/cY9GH+aMa2OnawFkgcfQnUHxnSTheTBKaEajBvhQ5E8ThvZihCFUP5FmDxx/Ep2GbzKDa/Spi+3VgK7QVbXVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iVYdItDC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VDS1jo92; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:25:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739870734;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpZw4quKaBa3GbZsGkhAacOe5mrBlBDvoaj2nTa+3G0=;
	b=iVYdItDCgd2+m/3cmfGi+PAAeHbMvqTKebcMnk+GXvuvRHMxTmHsaM1hYuPSf/WSWq/11W
	+p+j9CengwWVrJA7aywd3ipP47u5A2b71eQRhiI4R5lmov62S7op++dWR5268rGpg3k1K1
	sNN7fDMX6V4off+fcsBUTGhv0zp5+AGoqgaZB9vWZkFVNFbMPjuycju44NKDjts8TdBD7u
	w1K/tZcLDTqWfGQ9+GFg4lr/HMl6UCX2T+y1IqqxtnfpH+VWCug6awLMMOZvCnRlvEWARy
	1cR/kGuoaiTRo71ufiNSUqOfN0QWeD1KkyGfNw3LeVDTwQGCCHyqd2KYS2Iobg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739870734;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpZw4quKaBa3GbZsGkhAacOe5mrBlBDvoaj2nTa+3G0=;
	b=VDS1jo92sXeJhjSInrp5sasNNQCKdQ5C21jfP4+kl8wgMVA/VN49EDYnMv8O5+L9kKthtH
	0zOC4sEra+D4uuDA==
From: "tip-bot2 for Benjamin Segall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-timers: Invoke cond_resched() during exit_itimers()
Cc: Ben Segall <bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <xm2634gg2n23.fsf@google.com>
References: <xm2634gg2n23.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987072878.10177.11121566897445550577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f99c5bb396b8d1424ed229d1ffa6f596e3b9c36b
Gitweb:        https://git.kernel.org/tip/f99c5bb396b8d1424ed229d1ffa6f596e3b9c36b
Author:        Benjamin Segall <bsegall@google.com>
AuthorDate:    Fri, 14 Feb 2025 14:12:20 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:12:49 +01:00

posix-timers: Invoke cond_resched() during exit_itimers()

exit_itimers() loops through every timer in the process to delete it.  This
requires taking the system-wide hash_lock for each of these timers, and
contends with other processes trying to create or delete timers.

When a process creates hundreds of thousands of timers, and then exits
while other processes contend with it, this can trigger softlockups on
CONFIG_PREEMPT=n.

Add a cond_resched() invocation into the loop to allow the system to make
progress.

Signed-off-by: Ben Segall <bsegall@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/xm2634gg2n23.fsf@google.com
---
 kernel/time/posix-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1b675ae..44ba7db 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1099,8 +1099,10 @@ void exit_itimers(struct task_struct *tsk)
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	/* The timers are not longer accessible via tsk::signal */
-	while (!hlist_empty(&timers))
+	while (!hlist_empty(&timers)) {
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+		cond_resched();
+	}
 
 	/*
 	 * There should be no timers on the ignored list. itimer_delete() has

