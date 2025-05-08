Return-Path: <linux-tip-commits+bounces-5504-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94AAAB01E2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD7C1BA7734
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F00328850C;
	Thu,  8 May 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhshGo1m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vR/GBmYl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770728751C;
	Thu,  8 May 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726876; cv=none; b=WE+PWSzFTESaIMSk14YpzLiCBwvjftnKL09GxRLXdHL6kk9iVH57oj2dbhnwgyEy5glaWY1VwFmzzRRrI4XktSCIRHUBm2Y9qO070vS3WB+hG/+cn9nGkpbRSqLs+7zgTD0fYHTXzdY3dkDGvIJXkNZHLMVU49gPvmLUPLFbDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726876; c=relaxed/simple;
	bh=WCdPHCoivE2+aMkIKGGm3XR7eRTvD42TJNiovr7z4qE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H4MAfn9yx+5UNmgnztTfHvwzehm3ndfC/bcKltBImTSNceQ7LC9pmYmokiqcuAwBvNSp03+TnKavtH6d0CrNp7zTtbvvAMKFAomkMOSbcebHUkxWm7XZtBjvzzFDL5YK2W5Sw7hi07Z2EY4t6YfVBCVy8gyca+SAYS/sfLY6kaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhshGo1m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vR/GBmYl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746726872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=On3L0UWBgupKmXfrySYaiDB41N/dWp/Uvys4jj5LUac=;
	b=AhshGo1mr9yxSGgK2LlLQmmYsJEsJe0qYE6EE3nf3ARXYJnG/zxzNL/pbPelWKMlVKIdQN
	XYxiprwo+Ci/ZqiQiRDSOriyQbPYpqfFfXIRG3/sGhFLEoAz08SerMn/MGsf+Zl7a9lvJ3
	4t0R2SvWPG5QN72ko+6GuchkubdJGWTBqXyc5GrvtM2MeqU//wlWEN84z0RpytElSpVLYh
	TUPPTShEpiQxwHG+fanH0XPSUm8VyPyMtNwFEFVaRdK0IcJnIE+osLLUUZoNkTQk1fahyk
	KiovogePsVfiBasdEgKmbUzbaTberldSkhbNKNP8n5BjPSRnaW4lUokBOUrL2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746726872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=On3L0UWBgupKmXfrySYaiDB41N/dWp/Uvys4jj5LUac=;
	b=vR/GBmYlhRb4Pc5Pg4EcWa9sRs5boHSj6N28IJf02z0gNQ9vDvyURFDfTOJYIHrEHcFSHW
	Q5DYDGco4F5HBhBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] timers: Rename init_timer_key() as timer_init_key()
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250507175338.672442-3-mingo@kernel.org>
References: <20250507175338.672442-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672687198.406.14307092634177417220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e86e43907f945e7f2e48d1c5c9105801ca2b11b7
Gitweb:        https://git.kernel.org/tip/e86e43907f945e7f2e48d1c5c9105801ca2b11b7
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 19:53:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 May 2025 19:49:32 +02:00

timers: Rename init_timer_key() as timer_init_key()

Move this API to the canonical timer_*() namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250507175338.672442-3-mingo@kernel.org

---
 include/linux/timer.h | 8 ++++----
 kernel/time/timer.c   | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 10596d7..0c1c3aa 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -67,7 +67,7 @@
 /*
  * LOCKDEP and DEBUG timer interfaces.
  */
-void init_timer_key(struct timer_list *timer,
+void timer_init_key(struct timer_list *timer,
 		    void (*func)(struct timer_list *), unsigned int flags,
 		    const char *name, struct lock_class_key *key);
 
@@ -83,7 +83,7 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 					   const char *name,
 					   struct lock_class_key *key)
 {
-	init_timer_key(timer, func, flags, name, key);
+	timer_init_key(timer, func, flags, name, key);
 }
 #endif
 
@@ -91,7 +91,7 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 #define __init_timer(_timer, _fn, _flags)				\
 	do {								\
 		static struct lock_class_key __key;			\
-		init_timer_key((_timer), (_fn), (_flags), #_timer, &__key);\
+		timer_init_key((_timer), (_fn), (_flags), #_timer, &__key);\
 	} while (0)
 
 #define __init_timer_on_stack(_timer, _fn, _flags)			\
@@ -102,7 +102,7 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 	} while (0)
 #else
 #define __init_timer(_timer, _fn, _flags)				\
-	init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
+	timer_init_key((_timer), (_fn), (_flags), NULL, NULL)
 #define __init_timer_on_stack(_timer, _fn, _flags)			\
 	init_timer_on_stack_key((_timer), (_fn), (_flags), NULL, NULL)
 #endif
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4d915c0..5efed36 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -904,7 +904,7 @@ static void do_init_timer(struct timer_list *timer,
 }
 
 /**
- * init_timer_key - initialize a timer
+ * timer_init_key - initialize a timer
  * @timer: the timer to be initialized
  * @func: timer callback function
  * @flags: timer flags
@@ -912,17 +912,17 @@ static void do_init_timer(struct timer_list *timer,
  * @key: lockdep class key of the fake lock used for tracking timer
  *       sync lock dependencies
  *
- * init_timer_key() must be done to a timer prior to calling *any* of the
+ * timer_init_key() must be done to a timer prior to calling *any* of the
  * other timer functions.
  */
-void init_timer_key(struct timer_list *timer,
+void timer_init_key(struct timer_list *timer,
 		    void (*func)(struct timer_list *), unsigned int flags,
 		    const char *name, struct lock_class_key *key)
 {
 	debug_init(timer);
 	do_init_timer(timer, func, flags, name, key);
 }
-EXPORT_SYMBOL(init_timer_key);
+EXPORT_SYMBOL(timer_init_key);
 
 static inline void detach_timer(struct timer_list *timer, bool clear_pending)
 {

