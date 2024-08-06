Return-Path: <linux-tip-commits+bounces-1950-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EFA948D34
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 12:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33618B27135
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2F51BF33A;
	Tue,  6 Aug 2024 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2WeMi27y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="euyAOOJ3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B31BF331;
	Tue,  6 Aug 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941500; cv=none; b=qfA4Cc0S1WUd3LBjVuyUhTGYapT5Zr5kiIsCppnGAOYxI79AwXC48G1+Rjif1Ky/BfH+0l76UXBMihtnPnuUFZ+UxVximI+grPtsLTOEH1uxNBi2M5/mMDID6oRkGKcosPTjbSuxfdBKEX3W4BQEjizPdDRbG5SiplqdtqTB13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941500; c=relaxed/simple;
	bh=OSQ7I0t9cNd2H0yZwwH2peMtAz0S+tCAuSnSiLxe8Bo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nVO7kK2Q5iEjhL9LpH5b/uyQCihS68SemkvmGrqMf+DfvDs0iMdHnnKCXiPsenV5RfUzCff5xxWpPgyGi+u86TETdMCOY6Gwd3duCN0ocLv0uE0qdaIBtUysgcgtTURmQofP0zeSFj81hgsQLjS81kOsBFG7by/1bL9lT25uers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2WeMi27y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=euyAOOJ3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Aug 2024 10:51:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722941497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoRBUO/y5Ku7e+eK3VOH+lwJM+igrJMA52+dIeFhBcc=;
	b=2WeMi27yxqBshAG5LBeXXIx+/R+xuln5ZmUYIl96BWiNAMq4yVHBIoLXRF4ckML7I/lmMv
	5ZRg+aZeYIaQIO/RHpN7D5ruZt6I6aOMXwl513c7OzVhlrtJ4qRGlXtMZvUVHRHUX9pRp4
	EWznqnL+/e+bZl7yybb3KCmUhYcbXpeHZc8j90yOAlH7Jspoo/l6X+/vIChfEcSN9sn9CP
	DfpRb6ZiSNwdOcvZL3dUq7BvA6luXxW1GgagyiJB2rY8xZ9t3bqNtgjQDChgHWB2m/8Wyb
	fwIUTBKTZqAIakvtZegm5lcSJifGnbQjFPwZa5/jNor1lSHU8mm5LozMbOmAOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722941497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoRBUO/y5Ku7e+eK3VOH+lwJM+igrJMA52+dIeFhBcc=;
	b=euyAOOJ3bsYpvhEXqUxpZp3N7gm5qrc3nAwH80xnVAzqSnWjepGxxOJqE2AWNiYWLLkYP1
	VkHObqXOcJ7N12Aw==
From: "tip-bot2 for Luis Claudio R. Goncalves" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: suggest the fix for "lockdep bfs
 error:-1" on print_bfs_bug
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Zqkmy0lS-9Sw0M9j@uudg.org>
References: <Zqkmy0lS-9Sw0M9j@uudg.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172294149671.2215.14897146884400480880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7886a61ebc1f3998df5950299cbe17272bf32c59
Gitweb:        https://git.kernel.org/tip/7886a61ebc1f3998df5950299cbe17272bf32c59
Author:        Luis Claudio R. Goncalves <lgoncalv@redhat.com>
AuthorDate:    Tue, 30 Jul 2024 14:45:47 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Aug 2024 16:54:41 +02:00

lockdep: suggest the fix for "lockdep bfs error:-1" on print_bfs_bug

When lockdep fails while performing the Breadth-first-search operation
due to lack of memory, hint that increasing the value of the config
switch LOCKDEP_CIRCULAR_QUEUE_BITS should fix the warning.

Preface the scary backtrace with the suggestion:

    [  163.849242] Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:
    [  163.849248] ------------[ cut here ]------------
    [  163.849250] lockdep bfs error:-1
    [  163.849263] WARNING: CPU: 24 PID: 2454 at kernel/locking/lockdep.c:2091 print_bfs_bug+0x27/0x40
    ...

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/Zqkmy0lS-9Sw0M9j@uudg.org
---
 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 726b22c..fee21f3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2067,6 +2067,9 @@ static noinline void print_bfs_bug(int ret)
 	/*
 	 * Breadth-first-search failed, graph got corrupted?
 	 */
+	if (ret == BFS_EQUEUEFULL)
+		pr_warn("Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:\n");
+
 	WARN(1, "lockdep bfs error:%d\n", ret);
 }
 

