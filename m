Return-Path: <linux-tip-commits+bounces-5762-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471D1AD4FC5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E763A6315
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5B2609D5;
	Wed, 11 Jun 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QXuRvhVx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nmzVXNfx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D882609C3;
	Wed, 11 Jun 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634197; cv=none; b=WwHe0e9A9xe/QnOfrbjanv1oI09qIrmfOK+ESr//j70YZ1qqWKZNzljCI5wQY1881yvSHlno4AzxNQjur2Xb6dHn02WsaSNVz5EfJbCXj357Lzl0r1J4xCA46cOtVDQakmkXP7T+zxiGnZTLdmwdyvVvAZRJcYl/9Fjy1EF55vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634197; c=relaxed/simple;
	bh=gAzWgWMLoT0T8dX68alb3ximX7AgSKuXzotXGxbh87c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=juWeHFcoFydFmqH/bShafj2w5SeLWL8wHB+HHAqeg0T4YKg36mqmzCScOma8rjX0qKwhPtU3SCorxp5UyLBOQSPnTeAeS8bEt2iA7dh9/bXLAVU5ZanwRFy7AgUEbmMEfhtqp9zHzfJrmmmG2GO1mbX9fGZUyRW9BZYffu6q4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QXuRvhVx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nmzVXNfx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:29:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0Kg/KrYeYA8hi51Nezx87FojRexWsnojaAA2zC7nbE=;
	b=QXuRvhVxEqLr6/Irzs+z/NOTMK4RnPk7oXf7FhcNYB+gFAj6laqLSq8c18iImWyrdv+z8X
	eYL1hygI5fP2OC8T16/B+8+ZJQQosYWRkzHQdAaBV7ueJaXPYIlxjIaWFjqP7tU8GgzjnA
	fK9tWAcsCy/R5Dp0FBKgt9MiJNsHGd7VbwTV1NAz9S6lKjpcJ+CHDZMjyODXDFq/GNPTCW
	0o3e1E+0RAQsgSKep6u9NIt+s+batfJ6pFBzwdn0hcnKx1RljriI7d4RA8MSV/YKUDyA31
	qwHwhwwt+zsMiSXiRbvizTR42vRXidBjk27OJZhzlxVmv9yLpSeGDRvPaVep+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0Kg/KrYeYA8hi51Nezx87FojRexWsnojaAA2zC7nbE=;
	b=nmzVXNfxXw8oS5BBoHTV+cWUOyeCnfkzBzyZfIwKdwKyzdfiK9ZaPZVjKL/NST2v1IMDK1
	9c9nqpwhJe2qTqDQ==
From: "tip-bot2 for wang wei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Correct the comment in place_entity
Cc: wang wei <a929244872@163.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250605152931.22804-1-a929244872@163.com>
References: <20250605152931.22804-1-a929244872@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963419385.406.17059157095269535592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b01f2d9597250e9c4011cb78d8d46287deaa6a69
Gitweb:        https://git.kernel.org/tip/b01f2d9597250e9c4011cb78d8d46287deaa6a69
Author:        wang wei <a929244872@163.com>
AuthorDate:    Thu, 05 Jun 2025 23:29:31 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 11:20:53 +02:00

sched/eevdf: Correct the comment in place_entity

Correct "l" to "vl_i".

Signed-off-by: wang wei <a929244872@163.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250605152931.22804-1-a929244872@163.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5..83157de 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5253,7 +5253,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
 		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
 		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
-		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
+		 *      = (V*(W + w_i) - w_i*vl_i) / (W + w_i)
 		 *      = V - w_i*vl_i / (W + w_i)
 		 *
 		 * And the actual lag after adding an entity with vl_i is:

