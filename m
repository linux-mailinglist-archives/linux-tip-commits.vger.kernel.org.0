Return-Path: <linux-tip-commits+bounces-5757-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38708AD4FBB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022031892058
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667325E816;
	Wed, 11 Jun 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcW10xGj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uJcTFpdl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991E226534;
	Wed, 11 Jun 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634175; cv=none; b=TjydJizMIR86pRKIlSH7TfgVc39pnV/EzxkuFGzFo3db7K/9w02gm+9I6OOPT1tIW1rT45wWSQyqwEKTqorHONUZA/dBvMuwe9npWOA3OmQtnCe5ntiFDWqOnQj1T0FIBLnRjdbPwuykeI9P/9cKgx7RcQe3PCq5Yfj86738qJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634175; c=relaxed/simple;
	bh=G87f5dihg3b3dtgiBzyUYSxdXVs4tomSjlxBBZQx1EE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HXEAtTg1j3i/WFY5EIfgRwpCTpXiFBE4g0J9dd0uRePOye0hXpYOGNgC+sclf8kooO3r3rEpxE0wnqthO3ZIFU+ysY3+Y1vabNYN7EsyR2cfP8ImxHL+sX5XIZuY+mL7oisb4L/3h2jc7Rn21qC3TgMDxZYOES26GkGQA2ORvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcW10xGj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uJcTFpdl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:29:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5OIp3gwUpjwX0QcjQQFBBA4mrxxVGtIGDoR7tjWYgs=;
	b=tcW10xGjcomWyU2zg7osoIzKCRDMZPFh3sJFL6gaFAQIB5GQxie/MUAUWzTOw7NwrwP3w1
	BeSRE97xRL39eYqh/hliPc7+Exs+se4aGC2b/PwzX82mBrFa/n1bDFjkRnlqshhUuDBNzm
	WGRY4RP1iISMpKRtya7CU4O94AEyRjWrUxeNA0fk0b++FKX16ilAS2q99i9VkMhwHDRPNw
	Qw1ss/Oa+0h+NYb0iXdi5SX/YijdPmKiIhQ/v966jMxTuSPRSyfOJCNgYnkYsoe2xFd2mE
	H9LJ7pRRmsoDSbkde172HeIJqaJTUAJgCCnkK6tuZHlZg0B4365vzZCp4YThxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5OIp3gwUpjwX0QcjQQFBBA4mrxxVGtIGDoR7tjWYgs=;
	b=uJcTFpdlXdAoHqajpnIPMVN4bbJPTwoYJXi7mNrMiQxs7kAU2SxyXUhiIhRwOkGz5bg2R0
	ZXnxjwJ6/JatV+DA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Add comment to enum perf_event_state
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Leo Yan <leo.yan@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250604135801.GK38114@noisy.programming.kicks-ass.net>
References: <20250604135801.GK38114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963417100.406.5429001330664490562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     49b393af3130c7712c7e8f215f4126c9a8060fa6
Gitweb:        https://git.kernel.org/tip/49b393af3130c7712c7e8f215f4126c9a8060fa6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 04 Jun 2025 10:21:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:53 +02:00

perf: Add comment to enum perf_event_state

Better describe the event states.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Link: https://lkml.kernel.org/r/20250604135801.GK38114@noisy.programming.kicks-ass.net
---
 include/linux/perf_event.h | 42 +++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 52dc7cf..ec9d960 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -635,8 +635,46 @@ struct perf_addr_filter_range {
 	unsigned long			size;
 };
 
-/**
- * enum perf_event_state - the states of an event:
+/*
+ * The normal states are:
+ *
+ *            ACTIVE    --.
+ *               ^        |
+ *               |        |
+ *       sched_{in,out}() |
+ *               |        |
+ *               v        |
+ *      ,---> INACTIVE  --+ <-.
+ *      |                 |   |
+ *      |                {dis,en}able()
+ *   sched_in()           |   |
+ *      |       OFF    <--' --+
+ *      |                     |
+ *      `--->  ERROR    ------'
+ *
+ * That is:
+ *
+ * sched_in:       INACTIVE          -> {ACTIVE,ERROR}
+ * sched_out:      ACTIVE            -> INACTIVE
+ * disable:        {ACTIVE,INACTIVE} -> OFF
+ * enable:         {OFF,ERROR}       -> INACTIVE
+ *
+ * Where {OFF,ERROR} are disabled states.
+ *
+ * Then we have the {EXIT,REVOKED,DEAD} states which are various shades of
+ * defunct events:
+ *
+ *  - EXIT means task that the even was assigned to died, but child events
+ *    still live, and further children can still be created. But the event
+ *    itself will never be active again. It can only transition to
+ *    {REVOKED,DEAD};
+ *
+ *  - REVOKED means the PMU the event was associated with is gone; all
+ *    functionality is stopped but the event is still alive. Can only
+ *    transition to DEAD;
+ *
+ *  - DEAD event really is DYING tearing down state and freeing bits.
+ *
  */
 enum perf_event_state {
 	PERF_EVENT_STATE_DEAD		= -5,

