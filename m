Return-Path: <linux-tip-commits+bounces-4639-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411B2A7A3C4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6042D1895B9F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677B24E4A1;
	Thu,  3 Apr 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+/G1Ytl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oi7ANQvo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BF2441A7;
	Thu,  3 Apr 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687221; cv=none; b=Rhydq9Cgqj9HNGMb2FhR4SeOGJ+ZW+zWcmJnavqnDrTc+f5nfT5USXpDVhbZfcmrd6KGlVzlzoi8eXBISLl7lNfAWB3nBOPCLcp5qFKzSoBL1TvGnW+ZvsbEZdAlgvI4bf4ZVSYu531b4gH+8UvFFU6e3T7YVbiuxlobpWwwVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687221; c=relaxed/simple;
	bh=V09QYGy9WvMyptysyuxnjEZNRDE5mU1Edv5d/IFvE2Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=brk1BWYqQ1IaXK23jTHAYOO/TgBwsfAtQhVdpy35v/1oiL9SC2M9y23ItRQGTdcQ7W56IUbXYd68M48ZVQMdFKGUOwjoF2aspFtmcCJ1ftjc0e7znACzTv7ZL3L8KsTzAmVbABFuH3QpFsxfKwo7Nhq3DmgFFyP52ZD8aipt2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+/G1Ytl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oi7ANQvo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqo3zAorG1aMhSEebspaI0g5rNtRC8E11v6m4l17RnI=;
	b=l+/G1Ytlg6q5gtQqJhwatiZl5Gr7U40+G1Bq38ES8crO2qL7QXr4ul3TL9x+bRs79NE0T3
	UzfoCaTxK15/uQEU9LladbX9yjPUGLxA05LH9KEMFO4it1weHwOUe70AxE89wghop6yPrp
	KsniKrJDdYnZ2YIt4EGUwOraeXkUbkG+gF4rusWnzGLggPQ3vWmU72ezlYPFsi6HGSji97
	3wjoyLM5jGJ0MlrykY+1aP6fUVQWadcYjxLQAuBmd6gUP1TUo2BQjs+F3B5SVWmPvUFqjy
	DoRLTn1zePTzePxiRzGT1Ihe5ZkMLY+w0qYo8TvjOlJeC+lpwopEZFvSg65Gxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqo3zAorG1aMhSEebspaI0g5rNtRC8E11v6m4l17RnI=;
	b=oi7ANQvojYXSJEOTPiUown0JvSrLmXYMea5xPAM3wD4cR3TbdRqVC4BFtccop7vUfPLNRb
	fmk31touXteLkmCA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Improve NMI duration console printouts
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-10-sohil.mehta@intel.com>
References: <20250327234629.3953536-10-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368721780.30396.7072042211093296234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     f2e01dcf6df2d12e86c363ea9c37d53994d89dd6
Gitweb:        https://git.kernel.org/tip/f2e01dcf6df2d12e86c363ea9c37d53994d89dd6
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:29 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:26:38 +02:00

x86/nmi: Improve NMI duration console printouts

Convert the last remaining printk() in nmi.c to pr_info(). Along with
it, use timespec macros to calculate the NMI handler duration.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-10-sohil.mehta@intel.com
---
 arch/x86/kernel/nmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 59ed74e..be93ec7 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -119,12 +119,12 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 
 	action->max_duration = duration;
 
-	remainder_ns = do_div(duration, (1000 * 1000));
-	decimal_msecs = remainder_ns / 1000;
+	/* Convert duration from nsec to msec */
+	remainder_ns = do_div(duration, NSEC_PER_MSEC);
+	decimal_msecs = remainder_ns / NSEC_PER_USEC;
 
-	printk_ratelimited(KERN_INFO
-		"INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
-		action->handler, duration, decimal_msecs);
+	pr_info_ratelimited("INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
+			    action->handler, duration, decimal_msecs);
 }
 
 static int nmi_handle(unsigned int type, struct pt_regs *regs)

