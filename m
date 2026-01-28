Return-Path: <linux-tip-commits+bounces-8136-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM+uMfJoemmB5gEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8136-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:52:18 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A13A84B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A52EA3040FAA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4716376497;
	Wed, 28 Jan 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fSCRac5x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32zeif+j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FF376484;
	Wed, 28 Jan 2026 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629879; cv=none; b=pT6TqRVtZcf0iUf+Rrpb18YKDcqm+hFdP+E7tpTxx4Q6Nxp98F4hg1UitX2rJQHnlBCbsfe21/IGIjpSwMxunHzWBAM5SbrNdL+Vpmf8kep7qt/gFbGRdcLwpS46N0V2jRGP4r7LTBKi6k4b8SDSD7bFuLb3Y6FSjxdlh0aEt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629879; c=relaxed/simple;
	bh=8+wuQByuSs/zlhocxDdq4277t26sSvBf8dUvM/PDsws=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=izVvjCEb8IaP5994Cgw/hqgMXPGksOL0cpN04758rHbXsoESb2pzHPrwrXgwnHXATqAObuEvxLydd8sfnGe2wAxDcMMXwBglejnFakocbFAyNoq0lB8ZSIoeFNOdrtQVsqeYyHnFgyj7dyjD1wd+GkNTjYCTcJiFYaVjf1leQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fSCRac5x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32zeif+j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 19:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769629876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNWVnDts6rd2IWsOVMcpfQpGdB03jqdvRzqnYvk3ZkE=;
	b=fSCRac5xxazMd1Qj+EFUYAmvN8A7I87G/FdZ7oj9xLO6wgGtjQFNzB61SvDqVyztepCM/n
	ueVIsWNyFeP6eCpztGWOPpIXQ8f5342yv3UYJ08gvsQwtuQeGhqcIZKiFI2a/ahOi/bxxO
	UDdyIzcCWt+miDjpyOyZiKH+FaFkFaJ99E6MN78Vz8ii2Oho/7eGv1/klhFp28fGuPMxJF
	ruhrCG36PSolSovkS/KCcpHIVydFwAkH5iL6Hq5KiFVORrmm1oiijGv7BzoDZDJLi9MJb1
	NfAfSJiKoeDYwNYnShwyu2xR5Hn/8NAPXRSigoUDMKv6vopx9xoxqKtUZK+axw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769629876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNWVnDts6rd2IWsOVMcpfQpGdB03jqdvRzqnYvk3ZkE=;
	b=32zeif+jmoHmtEz4bY/q23Cr5N3lI2I0zQuop6Nq0yGAD4CCUtHSXN4qH3ryV0D68rVsoB
	992wlwF0XSnkRPCw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cleanup: Make __DEFINE_LOCK_GUARD handle commas
 in initializers
Cc: kernel test robot <lkp@intel.com>, Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260119094029.1344361-2-elver@google.com>
References: <20260119094029.1344361-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176962987569.2495410.4252123660824990120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-8136-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,infradead.org:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 68A13A84B2
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3b9ed30344a866f6f96896b3ce64303b9074682b
Gitweb:        https://git.kernel.org/tip/3b9ed30344a866f6f96896b3ce64303b907=
4682b
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 19 Jan 2026 10:05:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 20:45:24 +01:00

cleanup: Make __DEFINE_LOCK_GUARD handle commas in initializers

Initialization macros can expand to structure initializers containing
commas, which when used as a "lock" function resulted in errors such as:

>> include/linux/spinlock.h:582:56: error: too many arguments provided to fun=
ction-like macro invocation
     582 | DEFINE_LOCK_GUARD_1(raw_spinlock_init, raw_spinlock_t, raw_spin_lo=
ck_init(_T->lock), /* */)
         |                                                        ^
   include/linux/spinlock.h:113:17: note: expanded from macro 'raw_spin_lock_=
init'
     113 |         do { *(lock) =3D __RAW_SPIN_LOCK_UNLOCKED(lock); } while (=
0)
         |                        ^
   include/linux/spinlock_types_raw.h:70:19: note: expanded from macro '__RAW=
_SPIN_LOCK_UNLOCKED'
      70 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^
   include/linux/spinlock_types_raw.h:67:34: note: expanded from macro '__RAW=
_SPIN_LOCK_INITIALIZER'
      67 |         RAW_SPIN_DEP_MAP_INIT(lockname) }
         |                                         ^
   include/linux/cleanup.h:496:9: note: macro '__DEFINE_LOCK_GUARD_1' defined=
 here
     496 | #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)                =
      \
         |         ^
   include/linux/spinlock.h:582:1: note: parentheses are required around macr=
o argument containing braced initializer list
     582 | DEFINE_LOCK_GUARD_1(raw_spinlock_init, raw_spinlock_t, raw_spin_lo=
ck_init(_T->lock), /* */)
         | ^
         |                                                        (
   include/linux/cleanup.h:558:60: note: expanded from macro 'DEFINE_LOCK_GUA=
RD_1'
     558 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)         =
      \
         |                                                                   =
      ^

Make __DEFINE_LOCK_GUARD_0 and __DEFINE_LOCK_GUARD_1 variadic so that
__VA_ARGS__ captures everything.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260119094029.1344361-2-elver@google.com
---
 include/linux/cleanup.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ee6df68..dbc4162 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -493,22 +493,22 @@ static __always_inline void class_##_name##_destructor(=
class_##_name##_t *_T) \
 									\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
=20
-#define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
+#define __DEFINE_LOCK_GUARD_1(_name, _type, ...)			\
 static __always_inline class_##_name##_t class_##_name##_constructor(_type *=
l) \
 	__no_context_analysis						\
 {									\
 	class_##_name##_t _t =3D { .lock =3D l }, *_T =3D &_t;		\
-	_lock;								\
+	__VA_ARGS__;							\
 	return _t;							\
 }
=20
-#define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
+#define __DEFINE_LOCK_GUARD_0(_name, ...)				\
 static __always_inline class_##_name##_t class_##_name##_constructor(void) \
 	__no_context_analysis						\
 {									\
 	class_##_name##_t _t =3D { .lock =3D (void*)1 },			\
 			 *_T __maybe_unused =3D &_t;			\
-	_lock;								\
+	__VA_ARGS__;							\
 	return _t;							\
 }
=20

