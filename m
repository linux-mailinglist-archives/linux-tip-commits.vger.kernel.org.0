Return-Path: <linux-tip-commits+bounces-5147-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00074AA4A82
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254267B4130
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C225A62E;
	Wed, 30 Apr 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2haY5Bas";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0HacTEh7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93C25A2B8;
	Wed, 30 Apr 2025 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014337; cv=none; b=nsf2p//IQW5XiSL1oYSqgsci4Y3jfSBIt1I9eu3uClyjfidOtiuvfQxF0eDGhajEZnOmq+O9b3Vu/urHKL9odjlGHmN9vrFNNRerhbmQgbKQf3AAW4bRgs4C8SYXvy8gIa5Nr3FRP1KqwnLLIAU2TGVg9/LiwQn/DhIOLoyN/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014337; c=relaxed/simple;
	bh=1IAgzWJojXKyI6XOr+bVsu+/N9Szh9WqZVpIopfqr4k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OODl7obOsn86cjXERp3ARmJ5+TlXBWDIkvRYQND/6FFW6z3dZQU1UUaGM/G+wm8oi7huz/qY2nzl3naMVCjSuZguUJ6VgwjfNes7kszWJPyFNH9y2LKQI2gEPx/I9fipPgnKJYvGU7TyKAWhseWkgW4gzt1mqriLO0FrOWT12K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2haY5Bas; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0HacTEh7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 11:58:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746014334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGEzVPywzg0op/YTXQRK5VQDTr53Qy4sGDk1Fg2bjbA=;
	b=2haY5BasWcfnow93YcY9+aifeRKNHDhWrRTIDXbMvpeIhbdERBcYOx/agFJN913msS1urf
	i6tv2HsECbtMW/WSBgfC+idmphGES1RMkKlXzYUwECchukkbm9FCf+5nyO2fpMLByneh4U
	Ysmhw+R+f0SPR57KzjecS2Vq6nQhtkYDZXYt3rLc2v8PzSRNzZosDqOD9TrQftT28u/OU/
	TBz9dBCR7acHoy8T0aOI2jloXiLqhc5QCAtdP/Z+iO4so16wPf4b0TlcVa+a+WxoRF7zh5
	01RCEG8ipV1fk9Ah2rmP8rxxs097s6eiDJn1woFFO9DlVXrd5KVavMwg3VRALw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746014334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGEzVPywzg0op/YTXQRK5VQDTr53Qy4sGDk1Fg2bjbA=;
	b=0HacTEh7zII6yCfRMEihm+oE1Cem40LoKjac9ZJPFU/eFH/BLjl5tWLHgy3aVRg0zjeZZ3
	ImJ6xvpD8wSAX6CQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Check the X86 leader for
 pebs_counter_event_group
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424134718.311934-3-kan.liang@linux.intel.com>
References: <20250424134718.311934-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174601433295.22196.6721332021957174245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e9988ad7b1744991118ac348a804f9395368a284
Gitweb:        https://git.kernel.org/tip/e9988ad7b1744991118ac348a804f9395368a284
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 24 Apr 2025 06:47:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Apr 2025 14:55:19 +02:00

perf/x86/intel: Check the X86 leader for pebs_counter_event_group

The PEBS counters snapshotting group also requires a group flag in the
leader. The leader must be a X86 event.

Fixes: e02e9b0374c3 ("perf/x86/intel: Support PEBS counters snapshotting")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424134718.311934-3-kan.liang@linux.intel.com
---
 arch/x86/events/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4237c37..46d1205 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -124,7 +124,7 @@ static inline bool is_branch_counters_group(struct perf_event *event)
 
 static inline bool is_pebs_counter_event_group(struct perf_event *event)
 {
-	return event->group_leader->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
+	return check_leader_group(event->group_leader, PERF_X86_EVENT_PEBS_CNTR);
 }
 
 struct amd_nb {

