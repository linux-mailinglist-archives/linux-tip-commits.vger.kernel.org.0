Return-Path: <linux-tip-commits+bounces-3590-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13969A3FFB7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 20:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC37D7032D9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20CA24CEEE;
	Fri, 21 Feb 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ICi7wLGS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sq6wCW1j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F85223;
	Fri, 21 Feb 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166142; cv=none; b=knQKEUrUvHNZzi249mCBTQbhPVXLS926l565fxxqopRpCPuXvmx7AYhzWx12jRsKJuYfcjdMH5Qe51imEB61Sa27/c9lfpbRprKU7kJZKW7ppb1ybxE18f1vqfnKBh4ojvVzls8z2gZKQCSXo9iRie9k1xzs0bZqiPJa0i7nbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166142; c=relaxed/simple;
	bh=JMdX7b0m8ihVWXTg3FvLlpCC1MtchNhNmkFw29V3eJU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oba/CMnV52nmr6EbId8b01pB1a0pIwUkD6cNdyxc9KvzOoGUgvhy8eiSnhEa5Of4aGoK0kEpTGs+Fqq0sFtfURlzmlYEHldV0bwPWdM31oif0q64iXdnNt+9heIK0QOA/JyAeTEqNE3VqJBLiEdfOKr4PC3w1YU/0gFi3wXZxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ICi7wLGS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sq6wCW1j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 19:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740166139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dgfrF7MC6Rq6h/hLL8lyJnEamVTuz2s03AY1obJJNQ=;
	b=ICi7wLGSDHK21RP6IS8JTjHn7Axxd5Crmc9NiixSXkRjX34oEQMORBqMdZKuIKQXPxebBW
	FnZ7dAdAX9qvAxNKygzD2UjobxTYuduC1u32hcWSMFgZDvvwwDbP3/EfInIXsr3oIik0K4
	1Lj12MruC10sRwANVW43Fq2YzTtaBr1nz5drgm81bExam+TqsIPM7jOzaF55Dz18u/T4xf
	vLtKpkFhqp5AQa/42jMSNAFpvtr+nb4AL3BWdYeOXJ4AQWmLRJ8GuxMz25B2mBtxT0DaWu
	FllJAAdr9mDoJEKI1ST8pFkEbHllUvtKg4W8tLp0xugV5zVTNj9fIvcG139HHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740166139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dgfrF7MC6Rq6h/hLL8lyJnEamVTuz2s03AY1obJJNQ=;
	b=Sq6wCW1j+BnGxeEOPifo1MB/U8792rlHMncA191bbQaceBILsXx81ULzj6Ne1pnMqUzm/b
	WWsUf9ZLuvRs/VCQ==
From: "tip-bot2 for Yunhui Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Add MUTEX_WARN_ON() into fast path
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250126033243.53069-1-cuiyunhui@bytedance.com>
References: <20250126033243.53069-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174016613836.10177.12534349520958572441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     337369f8ce9e20226402cf139c4f0d3ada7d1705
Gitweb:        https://git.kernel.org/tip/337369f8ce9e20226402cf139c4f0d3ada7d1705
Author:        Yunhui Cui <cuiyunhui@bytedance.com>
AuthorDate:    Sun, 26 Jan 2025 11:32:43 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Feb 2025 20:19:12 +01:00

locking/mutex: Add MUTEX_WARN_ON() into fast path

Scenario: In platform_device_register, the driver misuses struct
device as platform_data, making kmemdup duplicate a device. Accessing
the duplicate may cause list corruption due to its mutex magic or list
holding old content.
It recurs randomly as the first mutex - getting process skips the slow
path and mutex check. Adding MUTEX_WARN_ON(lock->magic!= lock) in
__mutex_trylock_fast() makes it always happen.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250126033243.53069-1-cuiyunhui@bytedance.com
---
 kernel/locking/mutex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index b36f23d..19b636f 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -143,6 +143,8 @@ static __always_inline bool __mutex_trylock_fast(struct mutex *lock)
 	unsigned long curr = (unsigned long)current;
 	unsigned long zero = 0UL;
 
+	MUTEX_WARN_ON(lock->magic != lock);
+
 	if (atomic_long_try_cmpxchg_acquire(&lock->owner, &zero, curr))
 		return true;
 

