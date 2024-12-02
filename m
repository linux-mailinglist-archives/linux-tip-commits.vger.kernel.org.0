Return-Path: <linux-tip-commits+bounces-2927-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F29E0018
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A816389C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D120967A;
	Mon,  2 Dec 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2lWPyglh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCmRHRL3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8EB20897E;
	Mon,  2 Dec 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138091; cv=none; b=LOJmGlvNjjUSs5/vdSTEwLFu8DZOkBnNvZsntX1Qft1uvZTa9pjlVE/mqtPTPeridy3h27Nth9jDNbknKKj8ymUzxTpcxLtz+pihCGBSTlLx2wDr0otRqOYTL+H8CmZW+dNHLXKOBh7/q8zlKCJvRveZvumxecitB/SmM4IZdKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138091; c=relaxed/simple;
	bh=ADP+Op/2sDIC+Sq51CifTqfRCa4ABhRCOJH80YTdZys=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oIHfSJvhJ+ZqKpoIz9daCtDmKkWDqbjS7cXJk2onaDnqecM6vM5ljZ9Rnp/nJliYooVHXTXh7fOlM5+7vgPeuA6nwhDH4QSAV2G10thEereWWZdx/BniaVIA8ru6KWLPVz5hLsUyNRhHe+s/FET2N/HKpz1Wa9nwGU1H91TayOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2lWPyglh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCmRHRL3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSxss/MTd3EUUDl49RIxuV17IF2K3lVlXhUxg5+FocU=;
	b=2lWPyglhLAxSmfXSsBKs3Db2DsYcdmQZnlP1Kg71R+aXiqtIS5UrZXgBWysVWP5ioeUd1R
	X/4E5koY+PC/N0Etsk7RRCb4yxnEzLYM6pc49AaPA6Sb2whJNfoxMsovH+/oy/rN9IbqRL
	GSoLnU5h1Dhlr82jJUymeSgkaLCWvY28B7s1yP0DNKE42oeYZavUnkcaMIILXFc+bDJnI+
	h1pGaNI9BOEisK0JjIQ4SLAwDycKsUvG2kdZlX6tvMuIZHgFchkbk5yoSH5tsZj6oMxg7l
	wUoThkoz5MfmvI+rg55isOr51QtV/r8LFq6UnG5rKSWNGiSwfZNZRDDF3E1SGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSxss/MTd3EUUDl49RIxuV17IF2K3lVlXhUxg5+FocU=;
	b=WCmRHRL3qoZK53yViDrKdOVm7c8dMOAPxRtximNqTdIJZcSliZaylhrxJtOfkpcBU8n2du
	90GXPKmLdARv2UAQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/core: Update kernel boot parameters for LAZY preempt.
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241122173557.MYOtT95Q@linutronix.de>
References: <20241122173557.MYOtT95Q@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808754.412.8236870383786854735.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f66e4a996582d59b6f5ce88078b0ad2a328aa532
Gitweb:        https://git.kernel.org/tip/f66e4a996582d59b6f5ce88078b0ad2a328aa532
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 22 Nov 2024 18:35:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:28 +01:00

sched/core: Update kernel boot parameters for LAZY preempt.

Update the documentation for the `preempt=' parameter which now also
accepts `lazy'.

Fixes: 7c70cb94d29cd ("sched: Add Lazy preemption model")
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20241122173557.MYOtT95Q@linutronix.de
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dc663c0..3872bc6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4822,6 +4822,11 @@
 			       can be preempted anytime.  Tasks will also yield
 			       contended spinlocks (if the critical section isn't
 			       explicitly preempt disabled beyond the lock itself).
+			lazy - Scheduler controlled. Similar to full but instead
+			       of preempting the task immediately, the task gets
+			       one HZ tick time to yield itself before the
+			       preemption will be forced. One preemption is when the
+			       task returns to user space.
 
 	print-fatal-signals=
 			[KNL] debug: print fatal signals

