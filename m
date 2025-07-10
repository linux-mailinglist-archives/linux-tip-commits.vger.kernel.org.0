Return-Path: <linux-tip-commits+bounces-6062-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B1AB00255
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8254E5660AF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8402D97A6;
	Thu, 10 Jul 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j//CGCzS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LAECRqwF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936227F749;
	Thu, 10 Jul 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151600; cv=none; b=hnWKgGNB7e8ekhJ/xN4ZJoKsquJ0Es2aHV+zKfpD7rlanQmXXCoDhcJ6mGBufrvZWkKXv0wV1rjLxP8Wjc5Qf5S7EZHPMmllzEAEFXoNvUxnUrB9d9x43sWdYAlDvpiT1eWmcqedosiy4TJ96EPg9RG16BZ7Vu4w6or2bKOfyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151600; c=relaxed/simple;
	bh=zif47Pn6sH2KyXbV7CiGiPXij+tFz0RcGLQfcF7u24Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SEc5IJc0TgTzTZJnKonjnC3oIf56xoDZnhQHY4U7HyMk7Vnog6mdbJB7jlcEIQhFu5ecHeDoy+Fc+1gdXUKD7X/eQ1fAqX/DilVTgPfMQU4Y8BuztvuMC/Y+SkmKhumfkSLFHQSieO4Gi9U/zujnGKQhAKdHgAOADBN/i9FLnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j//CGCzS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LAECRqwF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KGZbylvutMLQXvGgnsKV5Bka4av9rjsp2bWRrj1VeY=;
	b=j//CGCzSGQw51Dd1ljyo1ZNAGxw59FCFhs7DgOZKGsUORVlH3kB3J19O5SwUkrqeurRiRl
	bE5EfX1efISK7YXqc1huV3ZYMA727IVUba55KIP18QvxdiDl83oJZGFPe1QuwMZbKtqr3N
	u5+DjIBw0A49xnNpyQ54d+Jf9uBfjltCEMFJrE69kzePxNsXh2KoAXRvh1P1MlBRyaZVl8
	shdGfGg6U4BX32/ChO5SdCdR4P+FJo3XdvgDOfLUUZ0efDu3BrGPxWzWxxLKhmCPe+4dYH
	Ie6w3s0XY/0cpfLJqBqtXOae4og2a0hUAaVCy6482gmQB/Z0mctNoX0gLzuNRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KGZbylvutMLQXvGgnsKV5Bka4av9rjsp2bWRrj1VeY=;
	b=LAECRqwFt86+JgW/oOS8QaeP6htF/TeF9Txz1AsuDJ29UizWamNpNeb3kgdXfS2si7/h9B
	JRwIJ9ln4l39lSBw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use protect_slice() instead of direct
 comparison
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Dhaval Giani (AMD)" <dhaval@gianis.ca>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250708165630.1948751-2-vincent.guittot@linaro.org>
References: <20250708165630.1948751-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159543.406.15190067202942866809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9cdb4fe20cd239c848b5c3f5753d83a9443ba329
Gitweb:        https://git.kernel.org/tip/9cdb4fe20cd239c848b5c3f5753d83a9443ba329
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 08 Jul 2025 18:56:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:22 +02:00

sched/fair: Use protect_slice() instead of direct comparison

Replace the test by the relevant protect_slice() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dhaval Giani (AMD) <dhaval@gianis.ca>
Link: https://lkml.kernel.org/r/20250708165630.1948751-2-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a1350c5..43fe5c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1161,7 +1161,7 @@ static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity 
 	if (!sched_feat(PREEMPT_SHORT))
 		return false;
 
-	if (curr->vlag == curr->deadline)
+	if (protect_slice(curr))
 		return false;
 
 	return !entity_eligible(cfs_rq, curr);

