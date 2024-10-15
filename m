Return-Path: <linux-tip-commits+bounces-2455-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A557799FB7F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3BF1F22469
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C91D63E5;
	Tue, 15 Oct 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1AEQf2EZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cmWZ3xze"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5A1B0F0E;
	Tue, 15 Oct 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032085; cv=none; b=c2X/zqmeze4oki9GeE9R9vxZ1TNTtzRa8pMvyM+sA062daEC2b2PoHfvLF61zJjoGzViVqW4ZV8Rf+lxDxRg05LSy2TXDrfQbDRCUOSjbnEH4Ci6gflosOXbn/zaJAr+nPhMvpwYTQLsT9zyd6f6q2V0nMpjs3Wu3pgaTlM4nyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032085; c=relaxed/simple;
	bh=9ZcyG1zG7+mTVw0EHJ2WotEnx83gt70dGbPOHDDR8GE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dvmf5ezQM+rzt79OuxruVk2hFI2YqzEB/7fbaVaAd9U8yaSQoWzlJ1h6evyMAszv4F6dolDYAlREXsumIvL80SjjXzAFmQ55D0HEnvXbEHDUWXhUp5jxjsHNUj7eb+DBe0IzM9ekaW9eeDUIjbZwcPmeOU2SXTdxzkDAZlxbYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1AEQf2EZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cmWZ3xze; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce/43GnzvcHMd3RHvDLLL77RzCkVE0bqUbG0ZLbrBvw=;
	b=1AEQf2EZPdHRIVAk6AiPJSfOcnwHLMPQY/kkAJKiFemMD5ZmbXft8txaC8yFRmRRvKb/Lg
	pWharnKAbtWIbQlePK5bNwIC1wbdMSlD2x1j/NT1GKvAjjIqJYF9+HXt3BKI5tOAxrvPIM
	9u7gVYAgI/z0vEijz07F6qcenGoYFd1KRMSmbjc464tY4/sAewMca/wSsmZrgSfoK4w4yy
	ec2bBj6XkYsew/sP/RhrO9eL0zsGdnAYEjPEoNWawgNglF+hDYKGkENTbRwYTPIuFnpJuk
	ejPlKFeVUAnF72Jwl4bG/OnTGuz6DrOn09jvK4HNTNuWnlgaW2QYLUPwXaubzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce/43GnzvcHMd3RHvDLLL77RzCkVE0bqUbG0ZLbrBvw=;
	b=cmWZ3xzenTln1Vm+QN72bevXwIO4/S7RKTTD7w3vs4NShID0CrbENGXHDaIv4EfycIcf52
	YPwcugsNhoSzH1DA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] powerpc/rtas: Use fsleep() to minimize additional
 sleep duration
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-13-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-13-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208039.1442.9651462932013080200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b7f0eb8c9bc8662ca78082e82856fcb0cf16d7c6
Gitweb:        https://git.kernel.org/tip/b7f0eb8c9bc8662ca78082e82856fcb0cf16d7c6
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:48 +02:00

powerpc/rtas: Use fsleep() to minimize additional sleep duration

When commit 38f7b7067dae ("powerpc/rtas: rtas_busy_delay() improvements")
was introduced, documentation about proper usage of sleep related functions
was outdated.

The commit message references the usage of a HZ=100 system. When using a
20ms sleep duration on such a system and therefore using msleep(), the
possible additional slack will be +10ms.

When the system is configured with HZ=100 the granularity of a jiffy and of
a bucket of the lowest timer wheel level is 10ms. To make sure a timer will
not expire early (when queueing of the timer races with an concurrent
update of jiffies), timers are always queued into the next bucket. This is
the reason for the maximal possible slack of 10ms.

fsleep() limits the maximal possible slack to 25% by making threshold
between usleep_range() and msleep() HZ dependent. As soon as the accuracy
of msleep() is sufficient, the less expensive timer list timer based
sleeping function is used instead of the more expensive hrtimer based
usleep_range() function. The udelay() will not be used in this specific
usecase as the lowest sleep length is larger than 1 millisecond.

Use fsleep() directly instead of using an own heuristic for the best
sleeping mechanism to use.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-13-dc8b907cb62f@linutronix.de

---
 arch/powerpc/kernel/rtas.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index f7e86e0..d31c979 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1390,21 +1390,14 @@ bool __ref rtas_busy_delay(int status)
 		 */
 		ms = clamp(ms, 1U, 1000U);
 		/*
-		 * The delay hint is an order-of-magnitude suggestion, not
-		 * a minimum. It is fine, possibly even advantageous, for
-		 * us to pause for less time than hinted. For small values,
-		 * use usleep_range() to ensure we don't sleep much longer
-		 * than actually needed.
-		 *
-		 * See Documentation/timers/timers-howto.rst for
-		 * explanation of the threshold used here. In effect we use
-		 * usleep_range() for 9900 and 9901, msleep() for
-		 * 9902-9905.
+		 * The delay hint is an order-of-magnitude suggestion, not a
+		 * minimum. It is fine, possibly even advantageous, for us to
+		 * pause for less time than hinted. To make sure pause time will
+		 * not be way longer than requested independent of HZ
+		 * configuration, use fsleep(). See fsleep() for details of
+		 * used sleeping functions.
 		 */
-		if (ms <= 20)
-			usleep_range(ms * 100, ms * 1000);
-		else
-			msleep(ms);
+		fsleep(ms * 1000);
 		break;
 	case RTAS_BUSY:
 		ret = true;

