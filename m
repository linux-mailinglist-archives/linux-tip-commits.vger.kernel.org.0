Return-Path: <linux-tip-commits+bounces-8384-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNtHHxYkr2n6OQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8384-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:48:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CCD2404E9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB231301E7E2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091AE41161D;
	Mon,  9 Mar 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQuJm3sf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oIQD50AS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F374410D36;
	Mon,  9 Mar 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085705; cv=none; b=SuL/761xumcjvuhBjQJ3KCZWSAQFxxbHhpHv7eccsrV9fnlfvjfmCsEuuQvx+PMu71V4+IVB1yWOiu/DdnXyN5pC39AAShYfLx26539yJRtepDfW1gA1mfwGH5N+poLnnXNivugBxHWKaHpuL/jeQBu+uoi4QGDFWBjsv43F72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085705; c=relaxed/simple;
	bh=oCf9zv0MsXhRvrdkh6U5xoxnNMRUpSOCgWHOo3d+btI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hmzuzjHPoOiPNSobLxA3Q9LUlOabnt5wbho1jiRAU/ze8Xqe2olKwx6a8paObpkRdvsFr9ZXZ8Lx15kbs9307R9i2UDuLOYzZMr9L7SZK0NYqTcgEvvy7y4Z91cpgcz33+3z7o1sOJT0Pt+hNGXlK5plwRWsLlXIO/1dbJPjotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQuJm3sf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oIQD50AS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrJ7RB0427WfSMdLkn9WM5RTN3ntqODeYd0qR4sPAtY=;
	b=CQuJm3sfYRQI5FsoSkYWItGVo5MwR+q5am+Hvs6EKYomr05xS1OCaQ2+gYoHQEh/PLPkl3
	ino52pvHUkXL0226ug29jqvq3YnjYPKnaf1PNsBU69BDP4PacoDEbN6bVg1+2h8sjVsCf6
	898n8vGO32p39bsipp2cvB1SL6BMsuOWIynWsRNnChtV3grH9EqcAkYcadytgUA8gT6Ofa
	3ihbkYiCL7vkki0dikSCQtwiYK+D7ROl7Sxy/WODD4onZ3Q9D6S3pun8lVTKDH7B+YF7y3
	bYkSum4cvuaFK7oBcDbjd4bHExKeL7AjiKEfY/GrSYpnX2/nfa5I/1yy+lMXBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrJ7RB0427WfSMdLkn9WM5RTN3ntqODeYd0qR4sPAtY=;
	b=oIQD50ASF0iWwNAX2jy+0C0jZ7eb3ytNQyNnIV/S3p0ASFjXue2YI8kHNeUipqEiSAl6hk
	x64GUtStLJlijqDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] compiler-context-analysys: Add __cond_releases()
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121111213.634625032@infradead.org>
References: <20260121111213.634625032@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308569611.1647592.4359145687298644548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 24CCD2404E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8384-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     07574b8ebaac7927e2355b4f343b03b50e04494c
Gitweb:        https://git.kernel.org/tip/07574b8ebaac7927e2355b4f343b03b50e0=
4494c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 20 Jan 2026 13:40:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:52 +01:00

compiler-context-analysys: Add __cond_releases()

Useful for things like unlock fastpaths, which on success release the
lock.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20260121111213.634625032@infradead.org
---
 include/linux/compiler-context-analysis.h | 32 ++++++++++++++++++++++-
 1 file changed, 32 insertions(+)

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compil=
er-context-analysis.h
index 00c074a..a931757 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -320,6 +320,38 @@ static inline void _context_unsafe_alias(void **p) { }
  */
 #define __releases(...)		__releases_ctx_lock(__VA_ARGS__)
=20
+/*
+ * Clang's analysis does not care precisely about the value, only that it is
+ * either zero or non-zero. So the __cond_acquires() interface might be
+ * misleading if we say that @ret is the value returned if acquired. Instead,
+ * provide symbolic variants which we translate.
+ */
+#define __cond_acquires_impl_not_true(x, ...)     __try_acquires##__VA_ARGS_=
_##_ctx_lock(0, x)
+#define __cond_acquires_impl_not_false(x, ...)    __try_acquires##__VA_ARGS_=
_##_ctx_lock(1, x)
+#define __cond_acquires_impl_not_nonzero(x, ...)  __try_acquires##__VA_ARGS_=
_##_ctx_lock(0, x)
+#define __cond_acquires_impl_not_0(x, ...)        __try_acquires##__VA_ARGS_=
_##_ctx_lock(1, x)
+#define __cond_acquires_impl_not_nonnull(x, ...)  __try_acquires##__VA_ARGS_=
_##_ctx_lock(0, x)
+#define __cond_acquires_impl_not_NULL(x, ...)     __try_acquires##__VA_ARGS_=
_##_ctx_lock(1, x)
+
+/**
+ * __cond_releases() - function attribute, function conditionally
+ *                     releases a context lock exclusively
+ * @ret: abstract value returned by function if context lock releases
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the function conditionally releases the
+ * given context lock instance @x exclusively. The associated context(s) must
+ * be active on entry. The function return value @ret denotes when the conte=
xt
+ * lock is released.
+ *
+ * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
+ *
+ * NOTE: clang does not have a native attribute for this; instead implement
+ *       it as an unconditional release and a conditional acquire for the
+ *       inverted condition -- which is semantically equivalent.
+ */
+#define __cond_releases(ret, x) __releases(x) __cond_acquires_impl_not_##ret=
(x)
+
 /**
  * __acquire() - function to acquire context lock exclusively
  * @x: context lock instance pointer

