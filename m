Return-Path: <linux-tip-commits+bounces-1401-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F390B317
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FAEB30356
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CA1A5314;
	Mon, 17 Jun 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkTuIvLD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="57XUZurf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218981A92F3;
	Mon, 17 Jun 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630823; cv=none; b=j9m4KD1SFFjj6NjpADEDKsydc3KpNFxeZrP1aoz16dfMpnzh5ya3MOG57YyvG19NT1CNZlsng9hxznycVkTJoNZkwaXOXPRAeG5Zps8bKBaEiQB3uw8NPsBbYVs4f+fRVvNg3dVvDSK4TzI22xGNVEYvbNztdWxft4rPIN8TWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630823; c=relaxed/simple;
	bh=SdVsJ6L/9rb/Sy/wmxJEimcEbJHhawwqkwqnvH5htC4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D7eD4MGx43z5s7ekW9EqygV/sC6KWnbTlFmC1gsWRIasjmhOj2NSVz+LYLsb3/NwoBe1MrypHxAEv8RvN6A+pZ6bomrPyWitbOgGyq3OdwsHCDPzjth8mJBLyvjpME9bHAZbiLoY2EW3B68Tl0DUwl5oYNEg5nCQNe1sVs4a6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkTuIvLD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=57XUZurf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:27:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718630820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUtI/9RKIXnQcM74XUylgCsWNRYB5FbCggWcLkU1G1M=;
	b=VkTuIvLDSIqh6zXccE+rw2BtiD2aq8zr835nY3J6KmmKuWVaUmbIKSo9a3Mb2nNeoaRxFh
	leZSKoswQDO/mzDqP+shA+wKh9tYll1E9LKVzddyyVv+Koop5mWqfFwGL2+ojIu+NvUSsl
	sKQ4Nl6tjdG3NleEW4VMGwYP61tqTIH529uo4PG390LBI6sFhRf1dSAtdr82kr5M2I+x2n
	8Z4B7Ig4s+m87vGhX7NVeUExywwD3/XzRqOUp6Bbgy5TGsdFqSJlsPddilSVO6SVcJrt4r
	AXGgtyDsz/T1oOZSakct3cIEF9R1cnpU65iXoL/9EUnQyFEnkkNr1vMz4fvgIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718630820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUtI/9RKIXnQcM74XUylgCsWNRYB5FbCggWcLkU1G1M=;
	b=57XUZurf77fXTBdKtH+jblzitgJzG6bGFKUj7GpMWROHbqFCo+FDMC3878e/pBPQ5+h+0i
	ejZhqeRCPse6b2CQ==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Use str_plural() to fix Coccinelle warnings
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240508154225.309703-2-thorsten.blum@toblux.com>
References: <20240508154225.309703-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863082016.10875.7195591265773977724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     c4df15931cb72556fea93bd763ada88e56cbd8e5
Gitweb:        https://git.kernel.org/tip/c4df15931cb72556fea93bd763ada88e56cbd8e5
Author:        Thorsten Blum <thorsten.blum@toblux.com>
AuthorDate:    Wed, 08 May 2024 17:42:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:17:44 +02:00

smp: Use str_plural() to fix Coccinelle warnings

Fixes the following two Coccinelle/coccicheck warnings reported by
string_choices.cocci:

	opportunity for str_plural(num_cpus)
	opportunity for str_plural(num_nodes)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240508154225.309703-2-thorsten.blum@toblux.com

---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebc..1848357 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
+#include <linux/string_choices.h>
 
 #include <trace/events/ipi.h>
 #define CREATE_TRACE_POINTS
@@ -982,8 +983,7 @@ void __init smp_init(void)
 	num_nodes = num_online_nodes();
 	num_cpus  = num_online_cpus();
 	pr_info("Brought up %d node%s, %d CPU%s\n",
-		num_nodes, (num_nodes > 1 ? "s" : ""),
-		num_cpus,  (num_cpus  > 1 ? "s" : ""));
+		num_nodes, str_plural(num_nodes), num_cpus, str_plural(num_cpus));
 
 	/* Any cleanup work */
 	smp_cpus_done(setup_max_cpus);

