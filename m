Return-Path: <linux-tip-commits+bounces-2923-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0A9E00E7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946FFB2BF50
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53059207A2C;
	Mon,  2 Dec 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rfX7hfmu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UdGiuvB1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA950204F9E;
	Mon,  2 Dec 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138088; cv=none; b=KUOL3+cKKah+0zLfPfQKu4iH3innI5vLIiJf3UWaGppAadTxXTJOB4kjAlvm20223L8FtPrn8CFs49+Li/QBDQM3kRsuy4E7LsSwzwh49eiIT0dktBvjTFt1OgLaN8xKbamEHsMyXErQQYn5kaQSvDX/2GdnJr1L1IQ+yLj5Zqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138088; c=relaxed/simple;
	bh=M+5aLAffVur5UasY6awNe/gU7msUg26ECGQQKEXkRiQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ee3m4m+tV2nWlWqB+GCK8iXib4ZO9WiGWgUYPRi9ia0gNsxDS+7X1gSVKgfZwahl758fACugJtxWDFb+L5/90ncnK3LJoYoXGh0PwQLBIVT26/sVqEEnJN80gewYIODK3Rw0A2Oo2RacPejU1JS/EIpNrQa8zH1h3G+XlPDeC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rfX7hfmu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UdGiuvB1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhiq2HXy63qkP4vNCE9YD8sCTbOjznBsWzm3cmpYaxo=;
	b=rfX7hfmuKYB3+w5E/XsDvxRF2SIB4yR+DbaEUmDEwutWJhLQqis5VZ1o9TsZ3AM4qxmwAj
	MNrVh9L4BNJKxEGqTf1vXOpzdss7op7iaFQDwFE/pO0ttxNY0OYzEbxIwPSGy0+4sqy7TK
	w/qX4gWpUaYD7HCC2mxpzAo4SrthYbzYrCCG+Y1rPYWivRgwf4kPFe0GPSdSGHoRbFrD67
	8ZRfY8Oc2MHCnwMHjNqHh2mq8I0GugVzJpTp7qdE9GGqmB3xxS7Rk14b3vvgr+xToEQ4P6
	hP7Cxd2bIAABMl5UjM9CIwdRvi2zJ//6Cl7I5B62VphOlf7YQi7roD4rqYAATA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhiq2HXy63qkP4vNCE9YD8sCTbOjznBsWzm3cmpYaxo=;
	b=UdGiuvB1cbxsAhyeouq3InBW0kOL8bpo5AAdkYzgrixcVqon45LCOY0FnzjNhjfjbK1D5u
	3mfm18+jTzVJmiBQ==
From: "tip-bot2 for Harshit Agarwal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: add READ_ONCE to task_on_rq_queued
Cc: Harshit Agarwal <harshit@nutanix.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241114210812.1836587-1-jon@nutanix.com>
References: <20241114210812.1836587-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808465.412.17164013847284294134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     59297e2093ceced86393a059a4bd36802311f7bb
Gitweb:        https://git.kernel.org/tip/59297e2093ceced86393a059a4bd36802311f7bb
Author:        Harshit Agarwal <harshit@nutanix.com>
AuthorDate:    Thu, 14 Nov 2024 14:08:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:30 +01:00

sched: add READ_ONCE to task_on_rq_queued

task_on_rq_queued read p->on_rq without READ_ONCE, though p->on_rq is
set with WRITE_ONCE in {activate|deactivate}_task and smp_store_release
in __block_task, and also read with READ_ONCE in task_on_rq_migrating.

Make all of these accesses pair together by adding READ_ONCE in the
task_on_rq_queued.

Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20241114210812.1836587-1-jon@nutanix.com
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53..0f6790c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2271,7 +2271,7 @@ static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 
 static inline int task_on_rq_queued(struct task_struct *p)
 {
-	return p->on_rq == TASK_ON_RQ_QUEUED;
+	return READ_ONCE(p->on_rq) == TASK_ON_RQ_QUEUED;
 }
 
 static inline int task_on_rq_migrating(struct task_struct *p)

