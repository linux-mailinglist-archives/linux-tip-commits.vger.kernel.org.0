Return-Path: <linux-tip-commits+bounces-3016-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D119E7F83
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Dec 2024 11:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1CA18841FB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Dec 2024 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E748585628;
	Sat,  7 Dec 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lkMAKX69";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FuDPFn9t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263B45005;
	Sat,  7 Dec 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733566953; cv=none; b=hY8WbZDjOM5bkzR7JyC53lCiMwFvTbE6JJSLuA8QxxMhTzb7A4Cg34HsVL1Fbh00ShusfBJfcfwh+tJyr8U6o0A6z71N8p1TvKeyiu1GANPBaWE6zy9hiLhJOAevCDSg7BeEn9wCbdxmjrZVabAYyZHA97sO0JMkFinRS++Nr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733566953; c=relaxed/simple;
	bh=6/qpALPRAbF2ViFqQVp1nllHqbIKxT4N+e3TReLbNmQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JBs74ML9nhiW3WIjVWxi0PYuhggAMqrq9nJY8k4GwdCHSDDPuBXHviFOb/8wkmfvdEpl8wfYDMTiiaoEJ2KaGsTYUrp4/M5zE4jL0IgIF+Rf+7WWb4wLtc5WWZ75SQoNtiqWqkdhw4CSshCLwG5xBs1rHEPQV793+SG9rJnZaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lkMAKX69; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FuDPFn9t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 07 Dec 2024 10:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733566949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyLpaxN16yDyJgFyO7TPaMmLC/GQAQhj+MAXbbHNbZY=;
	b=lkMAKX69LmIfI0BsP6m/VtfF8sG3/b6vD6K9VXGLCpc9JI1Pv9AkWttI3olXwU+iwiyM1A
	1Mp5iov9DUr2Hy6SVbkP1bAPZB2l2sP+RrI/6PrzM4EnMfOm90wn92Dx3EoyBsr1AT0Gix
	ZpOGVrwM8mr3atAJMda2jGJWsSzH2CeAEymzxcNiw2WjSWn+j8SoFAflqc6rDJyj9iZrMJ
	kakI3EkiQUd3VG8603kY3XW8/HB9Y6coHyqB1Zs2YmDGUjWsdbUkUltX4JnG2aQHoXcSVC
	TCELSIdGBkmxIPdK+OyL6rxpTeJnZXnuekwbOxFLu+jwjv6TzuIu6AGDMf1R2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733566949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyLpaxN16yDyJgFyO7TPaMmLC/GQAQhj+MAXbbHNbZY=;
	b=FuDPFn9trerkbA9ei+MjTto0rRb2yHzjjzlwhdhnpI6NI1IqvZNxwjq4NAStL0aSbw0HxI
	OJ2gY9Wh8wA4PYBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] headers/cleanup.h: Remove the if_not_guard() facility
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z1LBnX9TpZLR5Dkf@gmail.com>
References: <Z1LBnX9TpZLR5Dkf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173356694825.412.962172886533779549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     b4d83c8323b0c4a899a996fed919cfe10720d289
Gitweb:        https://git.kernel.org/tip/b4d83c8323b0c4a899a996fed919cfe10720d289
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 06 Dec 2024 10:19:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Dec 2024 11:15:14 +01:00

headers/cleanup.h: Remove the if_not_guard() facility

Linus noticed that the new if_not_guard() definition is fragile:

   "This macro generates actively wrong code if it happens to be inside an
    if-statement or a loop without a block.

    IOW, code like this:

      for (iterate-over-something)
          if_not_guard(a)
              return -BUSY;

    looks like will build fine, but will generate completely incorrect code."

The reason is that the __if_not_guard() macro is multi-statement, so
while most kernel developers expect macros to be simple or at least
compound statements - but for __if_not_guard() it is not so:

 #define __if_not_guard(_name, _id, args...)            \
        BUILD_BUG_ON(!__is_cond_ptr(_name));            \
        CLASS(_name, _id)(args);                        \
        if (!__guard_ptr(_name)(&_id))

To add insult to injury, the placement of the BUILD_BUG_ON() line makes
the macro appear to compile fine, but it will generate incorrect code
as Linus reported, for example if used within iteration or conditional
statements that will use the first statement of a macro as a loop body
or conditional statement body.

[ I'd also like to note that the original submission by David Lechner did
  not contain the BUILD_BUG_ON() line, so it was safer than what we ended
  up committing. Mea culpa. ]

It doesn't appear to be possible to turn this macro into a robust
single or compound statement that could be used in single statements,
due to the necessity to define an auto scope variable with an open
scope and the necessity of it having to expand to a partial 'if'
statement with no body.

Instead of trying to work around this fragility, just remove the
construct before it gets used.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/Z1LBnX9TpZLR5Dkf@gmail.com
---
 include/linux/cleanup.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 966fcc5..ec00e3f 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -273,12 +273,6 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
- * if_not_guard(name, args...) { <error handling> }:
- *	convenience macro for conditional guards that calls the statement that
- *	follows only if the lock was not acquired (typically an error return).
- *
- *	Only for conditional locks.
- *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -350,14 +344,6 @@ _label:									\
 #define scoped_cond_guard(_name, _fail, args...)	\
 	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
 
-#define __if_not_guard(_name, _id, args...)		\
-	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
-	CLASS(_name, _id)(args);			\
-	if (!__guard_ptr(_name)(&_id))
-
-#define if_not_guard(_name, args...) \
-	__if_not_guard(_name, __UNIQUE_ID(guard), args)
-
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a

