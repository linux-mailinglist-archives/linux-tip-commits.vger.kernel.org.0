Return-Path: <linux-tip-commits+bounces-2067-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB73955B32
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCAE282515
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B9199BC;
	Sun, 18 Aug 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jo62cSo9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/dctrWk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EE1758B;
	Sun, 18 Aug 2024 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962194; cv=none; b=ocoG9zjdUyZzCzaxsBDTUD1AtTM4gJvFwDiLheU7ZsKuJ0zCRPqA6iJIMLxB515V1/T09vnPQp45/ULMTAJAlQv/eaYmjfQzab8kAOfRGt7wl99vEcysfQnKPVAqsmR2Im1xrsZoybZrsUv1kz7GrOdH55e3iGbQiZvcxDjXYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962194; c=relaxed/simple;
	bh=a+7wni8AydhlhbLert3lv7Jn6yCmYqsldfEHb9HVuQI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JHtof0VBpzmXvTiXIGRQzl9kMh2osN8sDHcjSzbM6edJUG2StLFGRkqP/wxFCiXFLckL1fpuYMHT5hI3tTlFMu6uz4P+HuOtRfmYynhzKw0gm/iSuTDmKumthScj/yjbQy9ftRJQ0hb6z081+9uOXBxClMSRadL0Mb6C0hPU2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jo62cSo9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/dctrWk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZ7YchtHgrTBiEr/R9pO6MrRFwin02gU/WQ8inzOmzI=;
	b=jo62cSo9srkzdjKI8byZj/aepCSrPkulcbXlDcvf9k1M4FaSWiZYl9fB4I6WHHerAg27kF
	lj+Eu39y3t7CiBXU/NLFdP774WDtUQhcbZI7e6PXy/ix0ejAFXj8/5jEKFUfUx66jusv+F
	ieDuQPGdSfV6WB74EWTRvCmvu+vi96NMPx3uq5WhxMdu3++m29mv8Rt6uiZdG70G7TIKNV
	d5anQcVO7lNqDlSU87QDn/GtszPHF9MVIBNt9HqrLCdlKcE/y1F7lCLqNH5CDNhHPYXkTZ
	9b9BhsL5ZTp1DGn3bt/4yQl6l2A9mEd1v8hWetI33PuDK/0et9/8a/+PlX66Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZ7YchtHgrTBiEr/R9pO6MrRFwin02gU/WQ8inzOmzI=;
	b=e/dctrWkpNlacJShUv1x2AbfG8DZ+YgWkZqknDzAjqfBl1NWFALQ5hahbEsTJNSeISp+jL
	0fuFyOigGAwz4oCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Assert {set_next,put_prev}_entity() are
 properly balanced
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105029.486423066@infradead.org>
References: <20240727105029.486423066@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218950.2215.11207658982585895323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e28b5f8bda01720b5ce8456b48cf4b963f9a80a1
Gitweb:        https://git.kernel.org/tip/e28b5f8bda01720b5ce8456b48cf4b963f9a80a1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 May 2024 11:00:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:42 +02:00

sched/fair: Assert {set_next,put_prev}_entity() are properly balanced

Just a little sanity test..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105029.486423066@infradead.org
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 59b00d7..37acd53 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5452,6 +5452,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 
 	update_stats_curr_start(cfs_rq, se);
+	SCHED_WARN_ON(cfs_rq->curr);
 	cfs_rq->curr = se;
 
 	/*
@@ -5513,6 +5514,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
+	SCHED_WARN_ON(cfs_rq->curr != prev);
 	cfs_rq->curr = NULL;
 }
 

