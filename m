Return-Path: <linux-tip-commits+bounces-5486-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB2AAF815
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471F89E1881
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358E221714;
	Thu,  8 May 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IzePWVWp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="caONFTq3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5E221FA1;
	Thu,  8 May 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700471; cv=none; b=r2gHGrLKkGNkd7TZSiO+AZo88y/sWKttXkhBLSPsbGjaB2tksG+cSTS0gq4eqMOgCO4v5qYQD8YuBWi7QQKA82InihpywQTX37qad3diDrtU1lX/ACrHVwHRthv8VOpvelg9u/o5ak/cxDWBwOw+RsxV/c3erUngcZ1oOnX/g4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700471; c=relaxed/simple;
	bh=5LiML9Ijqi/i3YhbwMzk6qGTWOXAVqGDL+6j0A9oL2I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tAX+l1Y1s5LUzmQzOIgZH4Ra7EQsGai8wD423EWLL/remRn7tHnexTrNTxRG9nNHevX6JN5NYBbTCxgg/BlYkcjStt4GbIEQMkYmwXzVU+xIHXBvrd5UHI2RXsYeaMpJEqgiKbDYAkjSkBhDqDGtsbu54mVzlfkA2dZscW1kGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzePWVWp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=caONFTq3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:34:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDSSoZ0GooGOAcSnrwig99WmPFQ3Q4NQkHSH3X8s1Hw=;
	b=IzePWVWpsi9jG4WUqciAxkVmcqAfDoTWOqdYzn7gzlBWZML4NdUDxE1lOha+fxeglRtTWK
	5Uw+T2RCJSQGukUZPkeW6wejHQ28fD4cbJoF+lGZ6iKA9mqXbOjGebVBtj9EOgUyNue8DN
	2sTAtZLgPG7Chu1XZVp/K1YmbcZkVH6Ja+eZ3I3vuf5o+GGUySAD5x7I1z5P2oUV1zus0n
	R4TEUUgAU30GdZFxWHBswfxjihOBTWzyMjhrkhdkWZRmT3kb2+IkzwXRkdj5CcZ18PNiU+
	J7kpcN4SC4Ts1cjdRhNkXXZFpXED78PcVTuAvtZinNcXBi/TavCHKHF5Cb408A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDSSoZ0GooGOAcSnrwig99WmPFQ3Q4NQkHSH3X8s1Hw=;
	b=caONFTq3kK5t7WBS2qICbxv6OZzb8UwFO3uB5Yn2PFwbeH/v//QR/sbL9zyk7ySVmekyHz
	Cx16JYvGd26b2LDw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix confusing aux iteration
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424161128.29176-5-frederic@kernel.org>
References: <20250424161128.29176-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670046772.406.3650445834841658682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dd0987d6358ef52bac886c5fe8287c12f47a7656
Gitweb:        https://git.kernel.org/tip/dd0987d6358ef52bac886c5fe8287c12f47a7656
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 24 Apr 2025 18:11:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 May 2025 12:40:41 +02:00

perf: Fix confusing aux iteration

While an event tears down all links to it as an aux, the iteration
happens on the event's group leader instead of the group itself.

If the event is a group leader, it has no effect because the event is
also its own group leader. But otherwise there would be a risk to detach
all the siblings events from the wrong group leader.

It just happens to work because each sibling's aux link is tested
against the right event before proceeding. Also the ctx lock is the same
for the events and their group leader so the iteration is safe.

Yet the iteration is confusing. Clarify the actual intent.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424161128.29176-5-frederic@kernel.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e0ca4a8..b846107 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2171,7 +2171,7 @@ static void perf_put_aux_event(struct perf_event *event)
 	 * If the event is an aux_event, tear down all links to
 	 * it from other events.
 	 */
-	for_each_sibling_event(iter, event->group_leader) {
+	for_each_sibling_event(iter, event) {
 		if (iter->aux_event != event)
 			continue;
 

