Return-Path: <linux-tip-commits+bounces-3866-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3CCA4D735
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F367B3AC661
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18111FF1B6;
	Tue,  4 Mar 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aM3Aw8ta";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBhl7568"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058BC1FE478;
	Tue,  4 Mar 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078625; cv=none; b=N1S2+uEr79jotPJsjwRk4p5FyxVhpLU/NHuBrN8pXXn2roZp77RflRzN28PS9wluXht5moLF8SX6H6JrAXlxuHQccvfaTMzLXJWeUyx+OJHM3Vvvn+ooS/yhxrvkdeu9QJzhh1qxpERfK9eOLi1tmkpyk+6F8VGGWaf2/2Rrbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078625; c=relaxed/simple;
	bh=QRSF+XJKzDhECneQlUDTE6G796MOi2yVh8fcrDBMtA0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nlsRZUI1P80G//QinUTY9TORC4aXy7Hb2J5zxTU1M/NKtxWm54fQthN066q9DewVPLpeMvefCeIGfbOMyP2sf2u4WeqLt9yWD4zCS7ObD+gmAABiJWNgQMrxCjOEhqmS2Q80w/cNwdL5KDeVRY0kexk8JGlKVKqSfyF7vK7rihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aM3Aw8ta; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBhl7568; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UW7Lek6IP0YlI3bq2U3droDHvaOcKZbX/TvbWtqpLy8=;
	b=aM3Aw8taURdXwxMw4nGWhH64l+R9oj7i/F8XkiEbs/kxdnPLNY0u52+iYMEeBrsYHW8VJa
	XiX/6P143wi20WF3adSnqJrSa3VGIZsaaWc+zLHFyLmOls7u6UqnzCEiparSlLNl1JTgvZ
	t7HlJ87wX6YKLrFmVsot3wQEa6gQ4xnwZDffAVliX5f1azDWxOuaDc/VV8hLojQ4ujoFQ6
	wXQ0frMLoyeABpB0OX7bHfpqkUA2DdkMPJ1KfJ2MyG4D0ViFiSSwBP8BB0nR3dLRTVE4u9
	u1m8+rcvcbjVR4nktgh6uL90Ot4TRJ1WTTrybIfOgROEewWYEmO1uhd6axRPrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UW7Lek6IP0YlI3bq2U3droDHvaOcKZbX/TvbWtqpLy8=;
	b=TBhl7568tt/j543Ws7hg+LkJYVO0ea7emkTOMkrfsmWZk4DTYQ9fW6AtGiCErxwFrnZSBI
	5FB+feEOA8pCQSCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Introduce perf_free_addr_filters()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.868460518@infradead.org>
References: <20241104135518.868460518@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862209.14745.6405590973060949822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     adc38b4ca1ed25ed2f1300e4d87c483bf51bfd50
Gitweb:        https://git.kernel.org/tip/adc38b4ca1ed25ed2f1300e4d87c483bf51bfd50
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:42:55 +01:00

perf/core: Introduce perf_free_addr_filters()

Replace _free_event()'s use of perf_addr_filters_splice()s use with an
explicit perf_free_addr_filters() with the explicit propery that it is
able to be called a second time without ill effect.

Most notable, referencing event->pmu must be avoided when there are no
filters left (from eg a previous call).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135518.868460518@infradead.org
---
 kernel/events/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0c7015f..525c64e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5339,8 +5339,7 @@ static bool exclusive_event_installable(struct perf_event *event,
 	return true;
 }
 
-static void perf_addr_filters_splice(struct perf_event *event,
-				       struct list_head *head);
+static void perf_free_addr_filters(struct perf_event *event);
 
 static void perf_pending_task_sync(struct perf_event *event)
 {
@@ -5439,7 +5438,7 @@ static void _free_event(struct perf_event *event)
 	}
 
 	perf_event_free_bpf_prog(event);
-	perf_addr_filters_splice(event, NULL);
+	perf_free_addr_filters(event);
 
 	__free_event(event);
 }
@@ -11004,6 +11003,17 @@ static void perf_addr_filters_splice(struct perf_event *event,
 	free_filters_list(&list);
 }
 
+static void perf_free_addr_filters(struct perf_event *event)
+{
+	/*
+	 * Used during free paths, there is no concurrency.
+	 */
+	if (list_empty(&event->addr_filters.list))
+		return;
+
+	perf_addr_filters_splice(event, NULL);
+}
+
 /*
  * Scan through mm's vmas and see if one of them matches the
  * @filter; if so, adjust filter's address range.

