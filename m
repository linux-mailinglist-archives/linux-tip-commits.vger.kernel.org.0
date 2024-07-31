Return-Path: <linux-tip-commits+bounces-1893-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD1942CE1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jul 2024 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A89C1F24F84
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jul 2024 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0F1AD40C;
	Wed, 31 Jul 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1p4c5Eo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qSDUNARj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F21AD3E7;
	Wed, 31 Jul 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424038; cv=none; b=SIg1/eMkp6ZAbceqiTfkvTnJYMLNhlIbkswYjshexx/7jqsBrcF2il4hXOY78MmzGBFAJrnZ5lQd3hYphA1eBxkeLWorBqJ0f1+fJYIntOnxmzj3asAP3FzuOuOcJwh316NLltUDo16eflBdINGVtyVEnmfWR78VYXX9JGFuq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424038; c=relaxed/simple;
	bh=SXBXbD7teweDRIff9XckBV218zMH0Sb8grNXnXDayyk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qm7BPpevKWIjDe5t8hRKmVcHYeP650P2w9WWFbcRGEsCUvYpc0oK2h145h0vd70IsUx36XuWLF2CSfI4Eiv4EU/HQDg+rJEf3ihhAXpPLIErYQWkfHgM9juWXLxYt4bp4jRbbNydqhohM0n7+sLu8QS0n+WQjy3u4W9+U1BnYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1p4c5Eo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qSDUNARj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jul 2024 11:07:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722424035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiGph7BckQocC0cj67LRP66JeVmjFc7zHelu5jS4gd4=;
	b=h1p4c5EoiyqXXDGjymJwXby7C7Xt/a+91gAI0jCb+Xjs22/njaexMiLxPoTCOD1BQskX9+
	zP1i9x82hcI0tADgh8hLfNUT5GjSbbn3GGuM5p26GF+DGQgYzaXUO6dRj2wKkjvboY6PqA
	8UNJXEkarZauSkhxCN4DPoeLRyMFSW4eogD0Sa1+2NWsUL5dsvvY0dHqBtkYMR96G4oNA0
	H+6EkX/4yyr4xzRnL2A8xqOdUPpHAi4tXxfy5TQRwW08z+RfE7bRsEkTtU4C6ve3EB9989
	G2cGXOuAHaDK1VvxY6FuERemzdNvkKwTJcmG8FraJy7Mom9d7erVaGNFH14jBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722424035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiGph7BckQocC0cj67LRP66JeVmjFc7zHelu5jS4gd4=;
	b=qSDUNARjcW1dVJIYO7k2kunKy+CJ8W0fmfnQVhzAxUPBcYiGXiYl8TzUTv06Oe+03IngwD
	QxM2YX20m+2MNRCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] jump_label: Fix the fix, brown paper bags galore
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731105557.GY33588@noisy.programming.kicks-ass.net>
References: <20240731105557.GY33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172242403495.2215.11338739604467848579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     224fa3552029a3d14bec7acf72ded8171d551b88
Gitweb:        https://git.kernel.org/tip/224fa3552029a3d14bec7acf72ded8171d551b88
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 Jul 2024 12:43:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 31 Jul 2024 12:57:39 +02:00

jump_label: Fix the fix, brown paper bags galore

Per the example of:

  !atomic_cmpxchg(&key->enabled, 0, 1)

the inverse was written as:

  atomic_cmpxchg(&key->enabled, 1, 0)

except of course, that while !old is only true for old == 0, old is
true for everything except old == 0.

Fix it to read:

  atomic_cmpxchg(&key->enabled, 1, 0) == 1

such that only the 1->0 transition returns true and goes on to disable
the keys.

Fixes: 83ab38ef0a0b ("jump_label: Fix concurrency issues in static_key_slow_dec()")
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Darrick J. Wong <djwong@kernel.org>
Link: https://lkml.kernel.org/r/20240731105557.GY33588@noisy.programming.kicks-ass.net
---
 kernel/jump_label.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 4ad5ed8..6dc76b5 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -236,7 +236,7 @@ void static_key_disable_cpuslocked(struct static_key *key)
 	}
 
 	jump_label_lock();
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
 		jump_label_update(key);
 	jump_label_unlock();
 }
@@ -289,7 +289,7 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 		return;
 
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
 		jump_label_update(key);
 	else
 		WARN_ON_ONCE(!static_key_slow_try_dec(key));

