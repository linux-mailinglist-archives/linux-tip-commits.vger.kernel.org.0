Return-Path: <linux-tip-commits+bounces-7814-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACBECF4AB4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72C5432F4553
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557A348866;
	Mon,  5 Jan 2026 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUCOMEnp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ogbojkj1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF4348894;
	Mon,  5 Jan 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628485; cv=none; b=M3cd+O9m/va/4m7fbwohIc3H4XdzbFkCsGi5oNNc0bIywDwXvWAUUW2PMeMhOuUn7RSWTIj8oZBb9oUKQrmilmEuyapS6kabi+T59W6475qkbQ30JdIXMJhpafJjpvngK4zEJof+6oQginuLNNhgpvRdTM72RDoRLpkxklKbCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628485; c=relaxed/simple;
	bh=AiBX1v9SMXIV9D+SHxTrkHojlWT4vjC5o6ymxOznXig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kgu/cUYNxm8XPyijhVQvWAEPv/aQqXzjlrOPz9C1mJezmMpSNwVpTbvZ8C+aeI0Nc01eraz7mUlsUBsucczhaI+ndr9DlsZJqs00ySEkFW3tYlVD+4rwBPi+levh3bsS2TWmBgwhx9jZVHfOhPOSv6ng0g6+UBtKsXQWAz20uwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUCOMEnp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ogbojkj1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVVqfJRa0yDD9ERxF1Y1g1CUdKuV24mxiwVRghSkKUQ=;
	b=OUCOMEnptCJC/iNenx/P0ka36pkgj6ADnzoxCpU0llE7qHnyoVliFOj9zGEZ3zHniFacTt
	jBjurg8J6nOzCThoSvNiFZoyOAqp0gMGgLk2GRso6uDr0ToqxbYmDT70LRREx3EZ/8+itN
	s+BYcnEA33vZENJg5on5o7RCItXjKWUkSV8nreAkzuYhvWOze68n6AAuEwRB4a9l0OyFg0
	gtD6ZwfldvMuo/P9TmHWaLLOGm15UKrcmU2pFLnOhJVS3OxXCogVScccQ6cS97pB18eCvM
	7ryaPXo2Jc+kHHvqpd4Ninn1pmWWN+VBk/e6fRZ3eWVWVIcAl4MuvX4wIXTT3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVVqfJRa0yDD9ERxF1Y1g1CUdKuV24mxiwVRghSkKUQ=;
	b=Ogbojkj1wDimw/9Y1g880D8NvwtwTmBBXsxYj/kCgxRBMP26aqIzMdnM6h3s85b0B7Ctnw
	nj6fB/DEkmKsrlDQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] lockdep: Annotate lockdep assertions for context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-8-elver@google.com>
References: <20251219154418.3592607-8-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762848090.510.937387794979191168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7c451541743c6c2ef1afc425191f18a23e311019
Gitweb:        https://git.kernel.org/tip/7c451541743c6c2ef1afc425191f18a23e3=
11019
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:39:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:28 +01:00

lockdep: Annotate lockdep assertions for context analysis

Clang's context analysis can be made aware of functions that assert that
locks are held.

Presence of these annotations causes the analysis to assume the context
lock is held after calls to the annotated function, and avoid false
positives with complex control-flow; for example, where not all
control-flow paths in a function require a held lock, and therefore
marking the function with __must_hold(..) is inappropriate.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-8-elver@google.com
---
 include/linux/lockdep.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index dd63410..6215663 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, s=
truct pin_cookie);
 	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
=20
 #define lockdep_assert_held(l)		\
-	lockdep_assert(lockdep_is_held(l) !=3D LOCK_STATE_NOT_HELD)
+	do { lockdep_assert(lockdep_is_held(l) !=3D LOCK_STATE_NOT_HELD); __assume_=
ctx_lock(l); } while (0)
=20
 #define lockdep_assert_not_held(l)	\
 	lockdep_assert(lockdep_is_held(l) !=3D LOCK_STATE_HELD)
=20
 #define lockdep_assert_held_write(l)	\
-	lockdep_assert(lockdep_is_held_type(l, 0))
+	do { lockdep_assert(lockdep_is_held_type(l, 0)); __assume_ctx_lock(l); } wh=
ile (0)
=20
 #define lockdep_assert_held_read(l)	\
-	lockdep_assert(lockdep_is_held_type(l, 1))
+	do { lockdep_assert(lockdep_is_held_type(l, 1)); __assume_shared_ctx_lock(l=
); } while (0)
=20
 #define lockdep_assert_held_once(l)		\
 	lockdep_assert_once(lockdep_is_held(l) !=3D LOCK_STATE_NOT_HELD)
@@ -389,10 +389,10 @@ extern int lockdep_is_held(const void *);
 #define lockdep_assert(c)			do { } while (0)
 #define lockdep_assert_once(c)			do { } while (0)
=20
-#define lockdep_assert_held(l)			do { (void)(l); } while (0)
+#define lockdep_assert_held(l)			__assume_ctx_lock(l)
 #define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
-#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
-#define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)		__assume_ctx_lock(l)
+#define lockdep_assert_held_read(l)		__assume_shared_ctx_lock(l)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 #define lockdep_assert_none_held_once()	do { } while (0)
=20

