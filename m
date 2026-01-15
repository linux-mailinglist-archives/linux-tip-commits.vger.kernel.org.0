Return-Path: <linux-tip-commits+bounces-8028-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70885D28D6A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC731301BCD6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6F332BF5D;
	Thu, 15 Jan 2026 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWiG271H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1iEyagQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DF331A56;
	Thu, 15 Jan 2026 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513464; cv=none; b=bPI7DDTb9BjdjjMb5R6Qg9IOnwC5JhVVuGbsNvanVXBaJRLTrIrkZoQzgJujxwKxBGP4p3MBnYHJQIJLSUm1jXCe+wCN8qGZ3gdwUfQHLJxCzg1qfYYOGvWICGnr08S4NraIU6v0+ibyiJU/HZlQLqBczqwI9ZJwNEfWJeDSGW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513464; c=relaxed/simple;
	bh=kAnruVn1EbD7mB1pRSvU+bihZyor8EKUOMfPyjSRQXw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X0KZ4P4qgj/iunoJRcu2atQHg6MvS+WKiF8K7Jcx3HgaeZQyzxy1QQrxTEPKfcSUpcXBOAk5ltU6mCpaOAsmXJfmhTiVshlu4xcREPq6zeLtuIMlXumeIMaJqCT9cuwR0wpMlXe9DfV3HWEJkc7NBfu88q0i4K9hsgpUhMcnGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SWiG271H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1iEyagQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513461;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxiOdCy55Xejd+ER58no+0u6D5McXD3QN2zbl/JM80Q=;
	b=SWiG271HAEaoa39IaKkAqSCeEdC0HUaJeB+kh+9q8COgLtc7dlmyIjW8GXq9CtUaJM53Ta
	EPuNDXiZE6lp834nPnkK0WT535pZwxQSy6Lt99VvUvwuBBEfX+oaODruxkz+97VIZVwVEC
	YPMH0B6NGfqVlAn4mSK1jZuKm8m8h5QYopvkJSeeOArxOJz7amBuVoqnAqZcjnBpOUU8ae
	RWDtROfQK8tthiZvMmhw0QPNrur81uoqDCemuRTX54HpZOb+SHG1Mkk051eoKXmCX6d56+
	5JX4evg2A+BTGkE0UYOOkL9LN6r7TZRWhApveR7RqtZLwIYw3tAgtTiHWSkgEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513461;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxiOdCy55Xejd+ER58no+0u6D5McXD3QN2zbl/JM80Q=;
	b=m1iEyagQObnAWPLWRcp0v3MdfGJ/CrXKUfwWw2ZqEy8/zw8DVfe7wwN7NHmRU/wHUpUV2r
	iEs9Omo1gYUdpDBQ==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Fix build for modules using set_tsk_need_resched()
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260112140413.362202-1-gmonaco@redhat.com>
References: <20260112140413.362202-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851345987.510.6507406232761244840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8d737320166bd145af70a3133a9964b00ca81cba
Gitweb:        https://git.kernel.org/tip/8d737320166bd145af70a3133a9964b00ca=
81cba
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Mon, 12 Jan 2026 15:04:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 22:41:26 +01:00

sched: Fix build for modules using set_tsk_need_resched()

Commit adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
added a tracepoint to the need_resched action that can be triggered also
by set_tsk_need_resched.
This function was previously accessible from out-of-tree modules but
it's no longer available because the __trace_set_need_resched() symbol
is not exported (together with the tracepoint itself, which was exported
in a separate patch) and building such modules fails.

Export __trace_set_need_resched to modules to fix those build issues.

Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://patch.msgid.link/20260112140413.362202-1-gmonaco@redhat.com
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b033f97..3cca012 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1139,6 +1139,7 @@ void __trace_set_need_resched(struct task_struct *curr,=
 int tif)
 {
 	trace_sched_set_need_resched_tp(curr, smp_processor_id(), tif);
 }
+EXPORT_SYMBOL_GPL(__trace_set_need_resched);
=20
 void resched_curr(struct rq *rq)
 {

