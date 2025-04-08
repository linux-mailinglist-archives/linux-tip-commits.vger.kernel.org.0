Return-Path: <linux-tip-commits+bounces-4758-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0CBA8156A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FDB887FFD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121CF253F2D;
	Tue,  8 Apr 2025 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJxZbRJZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gr9s7HH5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A182528ED;
	Tue,  8 Apr 2025 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139109; cv=none; b=eQsDIX9h7TvmUbLKS+pXGPebMAJsEDhlRH152JfjXtaz75+MWyYCGaUJU+zpy3CXAqrV81knLmc3/9ZDfHWxL6aZb1ndEwTym1j7Pj46Wn3IxGF6im0/t4+2dNnQ5/8jQ0owwlHo8Ce2RQrD5XJRkPDXkI5DHFNH7+cyC8WQFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139109; c=relaxed/simple;
	bh=/ai1heGd72j5PThisRlYees80ah3AMc9rQi5nwAAwGQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pCUNR1JeFP3qrLmDWpIlXprv/964x0eLlG7FfUtucs2oLmzutF9z7iF3buTX2vqHcKhyd7AakBQaVkd+zPkPTZoVs+QM2pzkjeJryiHCIwdXQpd6E04PdlaaYcg8Xtv6SbzFx2a0393neYY9VowRk0eQSMPfWAPIh84i0GLw8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJxZbRJZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gr9s7HH5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLCwYNFocq6ShE2lDB25ZIRbAWEGo8QgOQcJOT7ZIWA=;
	b=gJxZbRJZwHKBJVIQ/GgOmUIsM+p1tPwLXR84xCaj295YIhyDOWADiqG+TrqcuWGN1NtoxN
	PGuZH7GB6VH8DpOq2rqn5J1VPd+PEg6aoPYBbPF7NYkiPIHPg7Sn1UCpcC2ZSEl34qchT/
	mcKcycAh6Ca4v5vimmiXMVFMZzNsV60kFiubFc/dqJpmRAUb2wDw7zGcizGRUTRHEnLumW
	X4vnitqYOYARjQJbyYxO0NRr/3s6d0d/yt4quZAQQpqd/29iJxO4hQtBdM8CTrn3PZeZSc
	6ZLxOMPEzlpKKUSfM6ZA5iqyFn3U1ZdBNGM9f2ANtBtoJ05H+Vbh3j3Xwdr8mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLCwYNFocq6ShE2lDB25ZIRbAWEGo8QgOQcJOT7ZIWA=;
	b=Gr9s7HH5kp34XAajw21RLVwnNQir2HSLEl6UvOEOtA5FFOHGqfpDgSv0t5Ck7jidSc27Yi
	JbrVbocAiDiWICCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Simplify child event tear-down
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307193305.486326750@infradead.org>
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413910477.31282.11766952801429346476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0a00a43b8c200df5b9ca2b3e1726479b5916264b
Gitweb:        https://git.kernel.org/tip/0a00a43b8c200df5b9ca2b3e1726479b5916264b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 17 Jan 2025 15:25:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:46 +02:00

perf: Simplify child event tear-down

Currently perf_event_release_kernel() will iterate the child events and attempt
tear-down. However, it removes them from the child_list using list_move(),
notably skipping the state management done by perf_child_detach().

Crucially, it fails to clear PERF_ATTACH_CHILD, which opens the door for a
concurrent perf_remove_from_context() to race.

This way child_list management stays fully serialized using child_mutex.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20250307193305.486326750@infradead.org
---
 kernel/events/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a85d63b..3c92b75 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2325,7 +2325,11 @@ static void perf_child_detach(struct perf_event *event)
 	if (WARN_ON_ONCE(!parent_event))
 		return;
 
+	/*
+	 * Can't check this from an IPI, the holder is likey another CPU.
+	 *
 	lockdep_assert_held(&parent_event->child_mutex);
+	 */
 
 	sync_child_event(event);
 	list_del_init(&event->child_list);
@@ -5759,8 +5763,8 @@ again:
 		tmp = list_first_entry_or_null(&event->child_list,
 					       struct perf_event, child_list);
 		if (tmp == child) {
-			perf_remove_from_context(child, DETACH_GROUP);
-			list_move(&child->child_list, &free_list);
+			perf_remove_from_context(child, DETACH_GROUP | DETACH_CHILD);
+			list_add(&child->child_list, &free_list);
 		} else {
 			var = &ctx->refcount;
 		}

