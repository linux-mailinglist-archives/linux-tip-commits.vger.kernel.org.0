Return-Path: <linux-tip-commits+bounces-2604-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1A89B15F8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03661C20E75
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE21190463;
	Sat, 26 Oct 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V1yUNvca";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZLava0cV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51140179204;
	Sat, 26 Oct 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928132; cv=none; b=sj+bax7BsteSxdlojJE1HKhIGM9UYyPGmAuNU4cELqjcgMkhfysbhYFBK2OnpGsbCZeYmTHejNpG09B8dwTQjqU6GJZuWl5Ptf4KYQwbxskFjwMe3CnyNngtnxuCFOhs4uJQIGxG+iQCz59lHP6cQbeamYf2YPErAUPcwpfCNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928132; c=relaxed/simple;
	bh=yKbgmPJALJVqk9b5lnQPMywuVUjihGHdXCWy+Cxriw8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZY+f9nb1/u13yZ2keqFx7oYidR/M7VpGjvgxrt2d5d6sn1CwZfQDAbyHRZIy34VFtJM4J79r+Hhr/EljzhvBmWOIpQCl8kMintWvKkgdL7P+Z7FSSNF8rvvLnuxMVq8AnV4+zsCxQ5HuVXzSKuw14COx8Y5G59QfJvxglulQV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V1yUNvca; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZLava0cV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 07:35:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729928128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82NpQvp3vevPmrsSgRUoSs/TgBNXzJNw6GvY69HALMk=;
	b=V1yUNvcahM5nagX+vcgJy3A+uV+0LJLeb56NFQ8rIyR+Celm73BnvdWAegj4jYDhC++v9x
	hjNCnJCm1EsGwEgHq/6nqbOLBxItFSMNRsHO0/LSS0vg9M9X3BH3dWPypIU+TgNVMVwz2R
	n0X77QPe3zT37JEIBI7aZd2aqbpoQc80JIAZXt/XESK8PR0jfk9Ev6uv/29fCxdJsuU1Y+
	lcrvKXVDrmOvMq1Q+T0RYFl5SWoFwEX4Q0TJxVqKjEant4qq6610Nyl+zLhxDtdhps4L41
	WXEGmN4wy03MyWqv/Ur2vp3m81bt/SVFViU5nG7o9qoarmrvYrbxV82sw8xBBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729928128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82NpQvp3vevPmrsSgRUoSs/TgBNXzJNw6GvY69HALMk=;
	b=ZLava0cVB3rCWpZTNnGtsxXExAKi16tZaZrsgnKNazH6TIvrGRhxRgKWZlZ8hrR4oUZ9ZH
	uKL6uAKbx4gwNuBw==
From: "tip-bot2 for Przemek Kitszel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cleanup: Adjust scoped_guard() macros to avoid
 potential warning
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241018113823.171256-1-przemyslaw.kitszel@intel.com>
References: <20241018113823.171256-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172992812755.1442.8016932069806878868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fcc22ac5baf06dd17193de44b60dbceea6461983
Gitweb:        https://git.kernel.org/tip/fcc22ac5baf06dd17193de44b60dbceea6461983
Author:        Przemek Kitszel <przemyslaw.kitszel@intel.com>
AuthorDate:    Fri, 18 Oct 2024 13:38:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Oct 2024 10:01:50 +02:00

cleanup: Adjust scoped_guard() macros to avoid potential warning

Change scoped_guard() and scoped_cond_guard() macros to make reasoning
about them easier for static analysis tools (smatch, compiler
diagnostics), especially to enable them to tell if the given usage of
scoped_guard() is with a conditional lock class (interruptible-locks,
try-locks) or not (like simple mutex_lock()).

Add compile-time error if scoped_cond_guard() is used for non-conditional
lock class.

Beyond easier tooling and a little shrink reported by bloat-o-meter
this patch enables developer to write code like:

int foo(struct my_drv *adapter)
{
	scoped_guard(spinlock, &adapter->some_spinlock)
		return adapter->spinlock_protected_var;
}

Current scoped_guard() implementation does not support that,
due to compiler complaining:
error: control reaches end of non-void function [-Werror=return-type]

Technical stuff about the change:
scoped_guard() macro uses common idiom of using "for" statement to declare
a scoped variable. Unfortunately, current logic is too hard for compiler
diagnostics to be sure that there is exactly one loop step; fix that.

To make any loop so trivial that there is no above warning, it must not
depend on any non-const variable to tell if there are more steps. There is
no obvious solution for that in C, but one could use the compound
statement expression with "goto" jumping past the "loop", effectively
leaving only the subscope part of the loop semantics.

More impl details:
one more level of macro indirection is now needed to avoid duplicating
label names;
I didn't spot any other place that is using the
"for (...; goto label) if (0) label: break;" idiom, so it's not packed for
reuse beyond scoped_guard() family, what makes actual macros code cleaner.

There was also a need to introduce const true/false variable per lock
class, it is used to aid compiler diagnostics reasoning about "exactly
1 step" loops (note that converting that to function would undo the whole
benefit).

Big thanks to Andy Shevchenko for help on this patch, both internal and
public, ranging from whitespace/formatting, through commit message
clarifications, general improvements, ending with presenting alternative
approaches - all despite not even liking the idea.

Big thanks to Dmitry Torokhov for the idea of compile-time check for
scoped_cond_guard() (to use it only with conditional locsk), and general
improvements for the patch.

Big thanks to David Lechner for idea to cover also scoped_cond_guard().

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lkml.kernel.org/r/20241018113823.171256-1-przemyslaw.kitszel@intel.com
---
 include/linux/cleanup.h | 52 ++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 518bd1f..0cc66f8 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -285,14 +285,20 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *      similar to scoped_guard(), except it does fail when the lock
  *      acquire fails.
  *
+ *      Only for conditional locks.
  */
 
+#define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
+static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
+
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return (void *)(__force unsigned long)*_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
@@ -303,17 +309,40 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __is_cond_ptr(_name) class_##_name##_is_conditional
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-
-#define scoped_cond_guard(_name, _fail, args...) \
-	for (CLASS(_name, scope)(args), \
-	     *done = NULL; !done; done = (void *)1) \
-		if (!__guard_ptr(_name)(&scope)) _fail; \
-		else
-
+/*
+ * Helper macro for scoped_guard().
+ *
+ * Note that the "!__is_cond_ptr(_name)" part of the condition ensures that
+ * compiler would be sure that for the unconditional locks the body of the
+ * loop (caller-provided code glued to the else clause) could not be skipped.
+ * It is needed because the other part - "__guard_ptr(_name)(&scope)" - is too
+ * hard to deduce (even if could be proven true for unconditional locks).
+ */
+#define __scoped_guard(_name, _label, args...)				\
+	for (CLASS(_name, scope)(args);					\
+	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
+	     ({ goto _label; }))					\
+		if (0) {						\
+_label:									\
+			break;						\
+		} else
+
+#define scoped_guard(_name, args...)	\
+	__scoped_guard(_name, __UNIQUE_ID(label), args)
+
+#define __scoped_cond_guard(_name, _fail, _label, args...)		\
+	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
+		if (!__guard_ptr(_name)(&scope)) {			\
+			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
+			_fail;						\
+_label:									\
+			break;						\
+		} else
+
+#define scoped_cond_guard(_name, _fail, args...)	\
+	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a
@@ -369,14 +398,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
 }
 
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
 
 #define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+__DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
 #define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
 		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\

