Return-Path: <linux-tip-commits+bounces-4221-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D075BA61C6C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C7F1889C93
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC51FCF53;
	Fri, 14 Mar 2025 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S8anjwzL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwD6zcSJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062E1EA7C9;
	Fri, 14 Mar 2025 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983835; cv=none; b=khiaKlUxZ65K9uQYMvVsk3sCZLXNnfHSSyUBbHuwrj+ZBm+/KEqB4b4uhHtonA5HRf6aN5P96pqjRvwd/ocjY8BgJNzAAPnCr8fMQ6VpPVECUXGIOahJ1fz6z9ZWRPlHpe8I3dZ0fRVWQYXYGx6MGhHigQ3EUgXIdYlocdm9Iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983835; c=relaxed/simple;
	bh=Wl6b125ok9dFhHW001bHNuoiO4Kpm0pWqB6ehL+76DQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jFtnAOBYtOFwD2QVAiKlNySJQXJ2pIhN6IZYbfiISHUZ/7/kh8GCKgQrVodLQgF4Uikwo/Sr/gy3+NEbwE8l6DqWUwe0qQemDA9E19b5VNCWTizQQC0dtyS5UIfA/1J2jhO5xvgptFEm/9Lv4Hhh9t52VMwqFUCQWLe/aXWSJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S8anjwzL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwD6zcSJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:23:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741983832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOxg2loUtoW3qFC0bd2MjGkpbSDeHKDMgwjdNYfPmjs=;
	b=S8anjwzLi8ITDOxE0gc27akDsU5YG+dr4b7zI3RNauE4N3WDTsNkTcdulG0U3FX2BOx4s2
	QErETP3QryaN3pUH6ztllFT2gDODmYgQi5XjnttfBJ4MOKe7Scd1/eJ0OshLf3YBToP1G9
	SD03Pvuie7nj65VH52TXNQNrHm1jKsRsGX36ClQolEbjZ7fc2WwawzKC5V5Aae4S3l4OXa
	LQ1bVZD6wqGlXloEwMvcxhhItx8IsqAt68KM5cHMAbM96C5L7+/VwzZnLuDKXpsugRsV8K
	PDlZTyo3OUsp4ZlpJqDUXSjHfDONa7eVXPkCFzpdaKYw9py7juIRPv0WYYZuCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741983832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOxg2loUtoW3qFC0bd2MjGkpbSDeHKDMgwjdNYfPmjs=;
	b=cwD6zcSJoyyDCwJgPoXqo4z3wcTN6+F6fnsXZ0ROEk7VkhNF7fBE5D1AdKcmbYqwg3K3ZZ
	vk9F9teVJ2yfyJBg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Remove disable_irq_lockdep()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212103619.2560503-3-bigeasy@linutronix.de>
References: <20250212103619.2560503-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198382972.14745.7464431019949752339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     35e6b537af85d97e0aafd8f2829dfa884a22df20
Gitweb:        https://git.kernel.org/tip/35e6b537af85d97e0aafd8f2829dfa884a22df20
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 12 Feb 2025 11:36:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Mar 2025 21:13:20 +01:00

lockdep: Remove disable_irq_lockdep()

disable_irq_lockdep() has no users, last one was probabaly removed in
   0b7c874348ea1 ("forcedeth: fix unilateral interrupt disabling in netpoll path")

Remove disable_irq_lockdep().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250212103619.2560503-3-bigeasy@linutronix.de
---
 include/linux/interrupt.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a1b1be9..c782a74 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -461,14 +461,6 @@ static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned
 #endif
 }
 
-static inline void disable_irq_lockdep(unsigned int irq)
-{
-	disable_irq(irq);
-#ifdef CONFIG_LOCKDEP
-	local_irq_disable();
-#endif
-}
-
 static inline void enable_irq_lockdep(unsigned int irq)
 {
 #if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)

