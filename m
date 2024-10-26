Return-Path: <linux-tip-commits+bounces-2603-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F79B15F7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B636D1F21F80
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15BA18F2F9;
	Sat, 26 Oct 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ae/+RdSP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g8CQCSrl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAEC17BB07;
	Sat, 26 Oct 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928132; cv=none; b=opODhKtyD0sTb3zsykPv/JwX84Aojt5KShjoq6wM1ZfMEqk39uSNtIRcjFmvjAYv7Yt8XV2yCRZTlk7j+BDjkjTr+f55H3QfdSR0hOjcf+Nw3ug3+s53KCbRklpK6mv/kHZS0L0ZoxQoe0Pw3la5RbPxKBeZAdfyqX1pdrtwW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928132; c=relaxed/simple;
	bh=szgI6it8w7s11T2YCRek0TBqp5NtfCDnqJcl46BJmpA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TxB1mGe19MoYiYY+oNr17NLU+DFHdnzbpu9i4tC+t63Tcv2l+NtdTUzUipVQW5E1KbI7ZzV/ZvXolPrW8iCRwvrbxkWl3i2cPkk+B3Q65hKApjiYVuMSVUNqD5O0ywx6UVn+EXNMceVrUBEcIYu2nbesIob4loHb4+cElyNJ3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ae/+RdSP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g8CQCSrl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 07:35:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729928129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38YUvtNluS+8vcFqG7SG22/jKtn+UL0CBCRCgsE/3mY=;
	b=Ae/+RdSPRl6O925dFz3joZgAjxutyUZuiqZysh8UvBnksTpqEWaIhzngYsn2+f0IncLJ7B
	JaqBZci0hmAWTKoMbo6qf7VyYeXXOA/8pvomVND39JqDFmPsj6gwAnYomCiD0P2nZ8Hn+X
	lpjx8FO4bHG2rbt1aEImlxUVTizKSO6cdIoahjfr7MkgLlgC73mUhsgrAn+baKVqdvxXBj
	EARAZpeGVcjvrAfZOLDkO6+QldiW+1nAKcFxWDemsPN/XF35KoHs5wuaQhVn7fYa5GWOC4
	q/H09WbdFhFdnVyJC9N0RgF4YDjZRlEJY8KKv3YkFYMfLzGFIR9I28oHGmuJMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729928129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38YUvtNluS+8vcFqG7SG22/jKtn+UL0CBCRCgsE/3mY=;
	b=g8CQCSrlMrUHeAc/hSdre0LFxRTruT6sDZbhsWMhGRF5kIxKg51lJL3j8aeLQ9gHvTQ59C
	IZlf46N90cxHAmBA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/osq_lock: Use
 atomic_try_cmpxchg_release() in osq_unlock()
Cc: Uros Bizjak <ubizjak@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001114606.820277-1-ubizjak@gmail.com>
References: <20241001114606.820277-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172992812827.1442.5074326793772242513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0d75e0c420e52b4057a2de274054a5274209a2ae
Gitweb:        https://git.kernel.org/tip/0d75e0c420e52b4057a2de274054a5274209a2ae
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 01 Oct 2024 13:45:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Oct 2024 10:01:50 +02:00

locking/osq_lock: Use atomic_try_cmpxchg_release() in osq_unlock()

Replace this pattern in osq_unlock():

    atomic_cmpxchg(*ptr, old, new) == old

... with the simpler and faster:

    atomic_try_cmpxchg(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag,
so this change saves a compare after the CMPXCHG.  The code
in the fast path of osq_unlock() improves from:

 11b:	31 c9                	xor    %ecx,%ecx
 11d:	8d 50 01             	lea    0x1(%rax),%edx
 120:	89 d0                	mov    %edx,%eax
 122:	f0 0f b1 0f          	lock cmpxchg %ecx,(%rdi)
 126:	39 c2                	cmp    %eax,%edx
 128:	75 05                	jne    12f <...>

to:

 12b:	31 d2                	xor    %edx,%edx
 12d:	83 c0 01             	add    $0x1,%eax
 130:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
 134:	75 05                	jne    13b <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20241001114606.820277-1-ubizjak@gmail.com
---
 kernel/locking/osq_lock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 75a6f61..b4233dc 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -215,8 +215,7 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	/*
 	 * Fast path for the uncontended case.
 	 */
-	if (likely(atomic_cmpxchg_release(&lock->tail, curr,
-					  OSQ_UNLOCKED_VAL) == curr))
+	if (atomic_try_cmpxchg_release(&lock->tail, &curr, OSQ_UNLOCKED_VAL))
 		return;
 
 	/*

