Return-Path: <linux-tip-commits+bounces-3755-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B04A4ADA7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A1D189556E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA01EA7E8;
	Sat,  1 Mar 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbc3+DGq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mh8+Hfd5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C651E9B0A;
	Sat,  1 Mar 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859657; cv=none; b=u+YFNROnRopB/boZRcv8ATXXFCN7gCQpZ17qYRsRoYjXthjIiLqYQpQQIeCI2Y5lHOZ/GhwFjFiAei+4E3m58bi9kljWn4BUNzQ+HfEKmOS5asZHb9sNelX8SPVs0NAyFwU9JQ1s3sEVGZ38W/AyVAvVRiPuZltmXbKJbHrwiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859657; c=relaxed/simple;
	bh=HRwCFCeXT56dHAaBAJZAahoDn7blg9JqQeL/t7RaZyM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hPN7S7RvCfYAdmgaWhv+BBcx9sjPpBg3D0G6RumNqk2l5Bucs9yp7Ee8w95AhnIrp+DEIJoYHduyuNrEd8C9kLUZVHMNFC0xcI1Gj3Ej7TxoNRfYy5oPZ2ePOQqcHD5Y2QzP9f9OBLSzA08jufVJj6SkEY2HqiSmQTSpk9VhO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbc3+DGq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mh8+Hfd5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1IPykJJI0HbaUCdXfGG6QIROVvFnfChJocvPi2C6kg=;
	b=kbc3+DGqLHmgSn+y0+24zzBS1NUoX8TYO6eS+x2fiEZI2WLWvFWLa3PMnqUo6YNzDlUbe0
	tZpvYRZfDAImuJUSxKyUcEVwNOSFhXkoQBhtWDc5SpLksoFNQQ+o9as1Dp3/D3ycRA37jh
	Uzwz2fBqgbNDjWK+K+yp4IVOBVZfrPpUASSbIgTH5/lVbTNvzAzyVUVKkKhLAjVHqslsz4
	Q3jCyIHtGp22zL7LnQ7mgwyI+qO3dF2uOjZ0eQwTwNWUOaPn2PxSm2/zs81qneaO+JnZDM
	YB6Cgg6zemRFAWQbYNaFgqbshgtni3tCx7LPGZLVO4ulrw8u+X3ovFVThgQ7bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1IPykJJI0HbaUCdXfGG6QIROVvFnfChJocvPi2C6kg=;
	b=mh8+Hfd5cYefIvzdl9vEIvvwO+jRuQDKCDQEAp3EL+TBDtl5XHDq/YM5a/uu5qwZ5qnVou
	AqwYm3YnWk9tgEDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Introduce perf_free_addr_filters()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.868460518@infradead.org>
References: <20241104135518.868460518@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965200.10177.7481359939626568558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8e140c656746ef14d34be68d56f1a1047991a8be
Gitweb:        https://git.kernel.org/tip/8e140c656746ef14d34be68d56f1a1047991a8be
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 20:02:51 +01:00

perf/core: Introduce perf_free_addr_filters()

Replace _free_event()'s use of perf_addr_filters_splice()s use with an
explicit perf_free_addr_filters() with the explicit propery that it is
able to be called a second time without ill effect.

Most notable, referencing event->pmu must be avoided when there are no
filters left (from eg a previous call).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

