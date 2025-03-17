Return-Path: <linux-tip-commits+bounces-4238-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D3BA6442F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 08:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D277E16F4DE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081BA21B1A3;
	Mon, 17 Mar 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zMzSt/td";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNtLhTZh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0421ADBC;
	Mon, 17 Mar 2025 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197653; cv=none; b=JukYwSQh4sye96SvSDgXdKd5rCia6wjh7a1yGl8+Gjsj1aEeu10UBY4VWG3HjWGunJ7WiQ8XcDPR2epkd3GPnTenOX8C9NJSWXKDDC4yxCNe3ExxKDf+E7Jqb0eYAaKE7dogGoEx/QB/BvxH1bXC+8zqFUQ445jUkHq9viHq2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197653; c=relaxed/simple;
	bh=ECZn2rFeGecPDKciALnLake9KKRrIgJ7WvgXlpTSIwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WJgRi3BEDl+DjycUBictYAZb20i6FwzdAIKKIEyETuKA2jtwM0wa3D3CVcQSH4cV2yPvJ8K69/zsjzGkePQ4pzZT+dl5YoI/PLP6EgyeS7OcX7uk4BMAet75MBFBxYI9Dxu2tl6l0GtfJouzr19QHOSo2xL/k6zEsNwZCF/DiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zMzSt/td; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNtLhTZh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 07:47:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742197649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNm/TAd+vlWb/ETxhMQ3JvGiWKRjqyW/hTJfr3QYNc8=;
	b=zMzSt/td2sUngJWU11vJh8w/oaXqPE9L+gcpq5fJdT7WK+DUB2O6wcY0a+4JnKdIHAFiRS
	y4dNtM8SAqc58EUO+cW/iZqnQp4IDzOeKrRUhnaHBtZ4bQ1Mb9Pmku5eWz03GAT5HOzgbb
	N7Rra9qFwhRb7YoMxxJlZaR5P7K9AqW8ViAFxs/0dCWFL0wp9Z1yRvENvpM8ntEnz+gktz
	8QhnZ4RW+6rckK5b2jVhavq0NPuwS7gOceLgc4fdIQOhwSvvPxer4l3fVbo9oFzwICjz31
	b0ElT0eqqGRcy+PC80LXIutxTh37lSEHd8psrP44mTMkJhp9K2r6Rpr3XHp1ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742197649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNm/TAd+vlWb/ETxhMQ3JvGiWKRjqyW/hTJfr3QYNc8=;
	b=pNtLhTZhmi1RvW9peg5trWZytcVUjzyfAJGL/DZP9GQSAU9F/cGOvgY0jOjKVwdcuO2P36
	zM9tqmJPY2IySJDA==
From: "tip-bot2 for Tao Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/ring_buffer: Allow the EPOLLRDNORM flag for poll
Cc: Tao Chen <chen.dylane@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314030036.2543180-1-chen.dylane@linux.dev>
References: <20250314030036.2543180-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174219764114.14745.8810597138506735404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c96fff391c095c11dc87dab35be72dee7d217cde
Gitweb:        https://git.kernel.org/tip/c96fff391c095c11dc87dab35be72dee7d217cde
Author:        Tao Chen <chen.dylane@linux.dev>
AuthorDate:    Fri, 14 Mar 2025 11:00:36 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 17 Mar 2025 08:31:04 +01:00

perf/ring_buffer: Allow the EPOLLRDNORM flag for poll

The poll man page says POLLRDNORM is equivalent to POLLIN. For poll(),
it seems that if user sets pollfd with POLLRDNORM in userspace, perf_poll
will not return until timeout even if perf_output_wakeup called,
whereas POLLIN returns.

Fixes: 76369139ceb9 ("perf: Split up buffer handling from core code")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250314030036.2543180-1-chen.dylane@linux.dev
---
 kernel/events/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 59a52b1..5130b11 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -19,7 +19,7 @@
 
 static void perf_output_wakeup(struct perf_output_handle *handle)
 {
-	atomic_set(&handle->rb->poll, EPOLLIN);
+	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
 
 	handle->event->pending_wakeup = 1;
 

