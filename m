Return-Path: <linux-tip-commits+bounces-2515-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB389A36A4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4881F24ECB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF018E349;
	Fri, 18 Oct 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8ZWERC0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A3BomSMM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE418CC1F;
	Fri, 18 Oct 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235279; cv=none; b=Lf919G1QMB34hqovdvaUcaS+eFxXoyRMO/tjmU7AxI7ObsqkO3Vz5smOWyeN5RN2wwpk/eQaJzm3sDTbbJZ3KTROQRJ13g66IaoU2WXzxX3p0enTA+zL/FjlvNsrIAH3hkhDvZ/4VzDrk8teD1CFJPyxKxJLu9TFnUi8UkYlLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235279; c=relaxed/simple;
	bh=4Eg6jJxkUe1zguxpT+sHGa9SmH42lvM827z6uqxQfOo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XHRPwue2Bk4AzS+zGi490u2tNOvKpAbgB8mjpGspnzuSPMVzdux7mUto4BKGEzU77Z1nfwnXc2kmPed0O506ejLVK1GKZrT+Y7utOT+JEeghzxyZXF3cz42YWwZrMP+NKTP1K9YkwxiirDqUugIZRR26LQtT4GB6Judq8OQLSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8ZWERC0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A3BomSMM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Oct 2024 07:07:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729235266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBYzrUoNn2cW1GFwPCcuKKgzfaVpl/ta/5wqaOKRBH4=;
	b=h8ZWERC0Cor6Vt8oPJOA26ZCrRJwSSQyAhjzQj15FxDl2MhGP8k9nVLASXDeTKAERqeUsm
	ZNjJhgfD1/ypiVhU6jxA85vWyyePUufQHF3zfThRsmXG30kxWdbGZCzkVCWdlACIY1IjDE
	QRXtwGOB5yRtLSb4qx/Eiggg6bmyFoaD+3Q5K4ofXc9YtAZFf9lKZOFJZr3iLIt0HjPLJ3
	FNaE3hH26yzIC/+6qMuSHZVvT5fI1wIE+vNrW1yQ7OlU9o9q7JboILv+lX6vXDY5if2OdX
	29ImsYRGs1FO7NOEHhq2AeXQ8bdmCrEBIlc5xsBUoULSKl45jINrvr52ovWDUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729235266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBYzrUoNn2cW1GFwPCcuKKgzfaVpl/ta/5wqaOKRBH4=;
	b=A3BomSMMn6ygjp4e8qb3Z4Jt9R/QQ7buw7IzjrNGnUvd3g6ipIXhiyZ69BNbF9ZSuQGp6u
	Iu1NnMnecUa1SUAQ==
From: "tip-bot2 for Zhongqiu Han" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: idle: Optimize the generic idle loop by
 removing needless memory barrier
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009093745.9504-1-quic_zhonhan@quicinc.com>
References: <20241009093745.9504-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172923526546.1442.670768403460396409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8e113df990c9df70fc6d83ebd53ee1b2867c23c4
Gitweb:        https://git.kernel.org/tip/8e113df990c9df70fc6d83ebd53ee1b2867c23c4
Author:        Zhongqiu Han <quic_zhonhan@quicinc.com>
AuthorDate:    Wed, 09 Oct 2024 17:37:45 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Oct 2024 12:52:40 +02:00

sched: idle: Optimize the generic idle loop by removing needless memory barrier

The memory barrier rmb() in generic idle loop do_idle() function is not
needed, it doesn't order any load instruction, just remove it as needless
rmb() can cause performance impact.

The rmb() was introduced by the tglx/history.git commit f2f1b44c75c4
("[PATCH] Remove RCU abuse in cpu_idle()") to order the loads between
cpu_idle_map and pm_idle. It pairs with wmb() in function cpu_idle_wait().

And then with the removal of cpu_idle_state in function cpu_idle() and
wmb() in function cpu_idle_wait() in commit 783e391b7b5b ("x86: Simplify
cpu_idle_wait"), rmb() no longer has a reason to exist.

After that, commit d16699123434 ("idle: Implement generic idle function")
implemented a generic idle function cpu_idle_loop() which resembles the
functionality found in arch/. And it retained the rmb() in generic idle
loop in file kernel/cpu/idle.c.

And at last, commit cf37b6b48428 ("sched/idle: Move cpu/idle.c to
sched/idle.c") moved cpu/idle.c to sched/idle.c. And commit c1de45ca831a
("sched/idle: Add support for tasks that inject idle") renamed function
cpu_idle_loop() to do_idle().

History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241009093745.9504-1-quic_zhonhan@quicinc.com
---
 kernel/sched/idle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d2f096b..ab911d1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -271,7 +271,6 @@ static void do_idle(void)
 	tick_nohz_idle_enter();
 
 	while (!need_resched()) {
-		rmb();
 
 		/*
 		 * Interrupts shouldn't be re-enabled from that point on until

