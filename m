Return-Path: <linux-tip-commits+bounces-6720-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3E4B9DF49
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 10:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7F919C1905
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0469D26C3AE;
	Thu, 25 Sep 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2zSWHTk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gKjDaGK/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395D25F99B;
	Thu, 25 Sep 2025 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787309; cv=none; b=ARVDD8OltpOwfs+hWHCcUI4ZpTH6XZgzC7+JBaK+OZ+KJa5gQBwuseqyk5NLzYIWesS3/YtEhvxzHySYI9sUB6t1E8lTm8MeNfyDc/dIsH8j2jCr291kW5GPPRiL/kBtk1O38Mbw4oqO8WDFmBPwsXPxo3ECSovsu5X9nkczhUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787309; c=relaxed/simple;
	bh=l7L3JojE1JE0len4yKLI+nX4yD7KeVBuVbnYldPLAus=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C2Uxj0Lq3yi86Jt8Dod0gSj4BK+Fxg6WfilmsXVMMMOYm+cC1gXMB4Jrclj7GU/DvjbG4zqUZ2vHhtvpwOCg47AWFQYeyX+z1XXBj26kWnyV31IhECGgX8zQ7oOwS4SXCdO4+/6kDAu594NxtUaNqtmEHy4hEY3e6JMjZr0jzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2zSWHTk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gKjDaGK/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 08:01:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758787306;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpH/5LvSLl1ZxNlhADXkwOyliIGFJEEqRNVN2TxwGTs=;
	b=C2zSWHTkfhpMivSW5mRdKss/pqayQnEE2wBe908R59/jqgSZ9+Ykt1OGm5H8yvHf6fvOoZ
	CLshwDHIGC4rDQFVOHU9J4V/AVzPb6OpKaC9OuCuRcD+/qVKA8iklGRQlL3YonP9922BmN
	tSRjWhuSmieeUIPZ2Bfidnk4xod0XeqE2uDg0LwW1hIsn58lHMbgz6Ch0D+UEE7UGvVo7O
	9BOshl15p4Hr6zb0ZNJyLCRQJ9r39T+zb+z7G5XE75ZRE1+AZhECYgoL8L5Gj1vADTZYzl
	17xZWHuiYprVsxDp+3MNZDcmGrsnBB5rUK8/vcTJhCQRphQVJjgRWnZzgMXtAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758787306;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpH/5LvSLl1ZxNlhADXkwOyliIGFJEEqRNVN2TxwGTs=;
	b=gKjDaGK/8izS6JpCgmQRfUH0AKNUcp5UG49mClTRhrehLOvQ+u6/0vwhtukDaCFtAZT6HI
	ml3AVLQ4cZ06zKAg==
From: "tip-bot2 for Menglong Dong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rcu: Replace preempt.h with sched.h in
 include/linux/rcupdate.h
Cc: Menglong Dong <dongml2@chinatelecom.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250917060916.462278-3-dongml2@chinatelecom.cn>
References: <20250917060916.462278-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175878730526.709179.17743524184120052104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     88a90315a99a9120cd471bf681515cc77cd7cdb8
Gitweb:        https://git.kernel.org/tip/88a90315a99a9120cd471bf681515cc77cd=
7cdb8
Author:        Menglong Dong <menglong8.dong@gmail.com>
AuthorDate:    Wed, 17 Sep 2025 14:09:14 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Sep 2025 09:57:15 +02:00

rcu: Replace preempt.h with sched.h in include/linux/rcupdate.h

In the next commit, we will move the definition of migrate_enable() and
migrate_disable() to linux/sched.h. However,
migrate_enable/migrate_disable will be used in commit
1b93c03fb319 ("rcu: add rcu_read_lock_dont_migrate()") in bpf-next tree.

In order to fix potential compiling error, replace linux/preempt.h with
linux/sched.h in include/linux/rcupdate.h.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f..8f346c8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -24,7 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/atomic.h>
 #include <linux/irqflags.h>
-#include <linux/preempt.h>
+#include <linux/sched.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
 #include <linux/cleanup.h>

