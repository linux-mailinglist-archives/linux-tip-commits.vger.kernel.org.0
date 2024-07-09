Return-Path: <linux-tip-commits+bounces-1644-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9392B898
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628BF1F22645
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98315E5B8;
	Tue,  9 Jul 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/RdjH/3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5m8/a5M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC715957D;
	Tue,  9 Jul 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525322; cv=none; b=J/tGQyyqsENL7+DyoecDvZkrOwq4qPC7eIPdfShtLgxF1SN7W3JGPFWSmMdsB4HbBNDIGgnp8Ez7CrR1hfK07g0OUzCIqaKDAqNPWVkKywLpYIbtnsKjRqoDfNQF/iKZStW7D+1BUahwYkSLOh1czO4aNXe8puhpC+dB2dxFhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525322; c=relaxed/simple;
	bh=uwZO1Yv193D32XymoOT8+amnkPaeiup7Ov64sD4oTlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qHPXuWddDwzy9JngLjB0yIF8ldACSC7cUjkLd10MDnmWKZ/dB6NdVCvY4NAhhqeX5yivYsiaqUY8m+8dANw+D1CX3+xLE/muvQXF46wFPVkArQVNynpk/IA0Q99EoLVI2cTKhVSi+pz9OTRjjkx/2UEdVWeOxTojXcwUyxroxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/RdjH/3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5m8/a5M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hC9OhFHYBY6u0/MwKZAhN4M3v/ubHBax2dxV8kEL0vU=;
	b=i/RdjH/36C95tZBIt7upqQykfuzRRjBbN3FGfqC69AudzMiYJK5fXw794hkXdV1fPpdSAS
	oAtEbILqUQ7nOpCYhSMaktfPcCVgQPl54+tFvy/4iAAwfqhYu2fkougf2YyI3hvoF9Fp12
	l//jF0f0iooajWxzgOyA0G0/IQ4N0I92THOuQ6NsZcaO5fOHnk5iMiCaSaGqCKeHb4t67a
	UmLtkjF5QfCwt0ZDo5VncHXcJ4bWIHnB77g3l+BBNug2CWUjoCi3ye1Ne8dn4Sk8mShMTV
	OniZM0d013DekcfzYq7ME5Jb6gHPjmCsBxfzPV7ePZXDcAQ5AINuh9McIfrblw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hC9OhFHYBY6u0/MwKZAhN4M3v/ubHBax2dxV8kEL0vU=;
	b=t5m8/a5M0554BvSpeUV3D2nKQdVfOBGrT4xUSF3eqaXAv8qM4/uOWL1UH+qJEg/g8cU35B
	6z97Xq+ZvdyhBQDQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Move irq_work_queue() where the event is prepared.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240704170424.1466941-2-bigeasy@linutronix.de>
References: <20240704170424.1466941-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531946.2215.8696209749766596463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     058244c683111d44a5de16ac74f19a1754dd7a0c
Gitweb:        https://git.kernel.org/tip/058244c683111d44a5de16ac74f19a1754dd7a0c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Jul 2024 19:03:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:34 +02:00

perf: Move irq_work_queue() where the event is prepared.

Only if perf_event::pending_sigtrap is zero, the irq_work accounted by
increminging perf_event::nr_pending. The member perf_event::pending_addr
might be overwritten by a subsequent event if the signal was not yet
delivered and is expected. The irq_work will not be enqeueued again
because it has a check to be only enqueued once.

Move irq_work_queue() to where the counter is incremented and
perf_event::pending_sigtrap is set to make it more obvious that the
irq_work is scheduled once.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/r/20240704170424.1466941-2-bigeasy@linutronix.de
---
 kernel/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 32c7996..c54da50 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9727,6 +9727,11 @@ static int __perf_event_overflow(struct perf_event *event,
 		if (!event->pending_sigtrap) {
 			event->pending_sigtrap = pending_id;
 			local_inc(&event->ctx->nr_pending);
+
+			event->pending_addr = 0;
+			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
+				event->pending_addr = data->addr;
+			irq_work_queue(&event->pending_irq);
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
@@ -9742,11 +9747,6 @@ static int __perf_event_overflow(struct perf_event *event,
 			 */
 			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
 		}
-
-		event->pending_addr = 0;
-		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
-			event->pending_addr = data->addr;
-		irq_work_queue(&event->pending_irq);
 	}
 
 	READ_ONCE(event->overflow_handler)(event, data, regs);

