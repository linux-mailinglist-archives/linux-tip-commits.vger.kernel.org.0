Return-Path: <linux-tip-commits+bounces-8398-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMqCEAwlr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8398-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:52:44 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A4C240610
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E41F93073A70
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0B426D23;
	Mon,  9 Mar 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xdIimYon";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdbkUiHN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8E41325A;
	Mon,  9 Mar 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085716; cv=none; b=anKIiq4/Bl9tpT/XenLBZXdsz1VVEdpD8v88wGmI1DA5THNqUZatPEYIbbtzuHkWuNGg188v2PrEZ0lRRMuD2g9pwi7Wfevmuqb0z8Z2vhClUWFCJdY1z3d13cq9sYucOyB5D4aiBlJLGusbGEF6HKbdjc98aDy7TdoRQ60EveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085716; c=relaxed/simple;
	bh=bNBeYh8hlj3Qb7V1ghgl/94gPsZS4VPhl/bpNW5o8PQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=spTKu/cErW2sfnSbcrqwVaH8q0D7E/u5wphQ6cseeiBZ73CJxp8R3gch5XWjjGleTo4hcUGQh8B7P7f/0acBFPvm3/1ph2rgkaQmJw4O9Yq4lA8PgAQyG/EmuOW1On99htCzd5cxGG44o/OQ3M/9FTVsC7WIGX6P7/Bg+7peV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xdIimYon; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdbkUiHN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooRpX9JJhlSkbjhTrglL4U4Mi6zf0NE63rGgZDgQWdM=;
	b=xdIimYonEHLgpH/JzWNrVilyw8NMb2BOrg9yBKsxDmtMQAdG9dki7zuaYysYZb3RkUbuVk
	KSt6JJAiyqkV8hf/e4MpYFPtWsqRWTWXQRVLpC4Xid5NrXYn0eq9g6i1AwOYWftq2ALYJX
	zt4Leb7/u+17/lJ3QrtErHAdhvZuOCsXyuMe+HLmjTUDEmufsnIbLXaEQeZBjIIDz9GZHa
	sJL+wom6j+Kus61oV//LZEcMvEMXrL2aRlhzYnDLFpcbfkyJwTy+64FTqAcH8FHvNpHUan
	Fdr+FDU+jbdsg+jA7Txsdm/Kj372zb2yoiIjXE34WlGEO4CjsPK77LcMhjwtEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooRpX9JJhlSkbjhTrglL4U4Mi6zf0NE63rGgZDgQWdM=;
	b=kdbkUiHNcHsBw3orIbTd+Q3bbNGaXnnCZfJdboFv4yj/xvIz+HICwI7lDARxCjMQ5uidHD
	CfsppSohjdIPHXCQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Generify the definitions of
 rust_helper_*_{read,set}*
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-4-boqun@kernel.org>
References: <20260303201701.12204-4-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308571152.1647592.1706217513286639868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B1A4C240610
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8398-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ecc8e9fbaac35c8e5cced26f740f846506c4737b
Gitweb:        https://git.kernel.org/tip/ecc8e9fbaac35c8e5cced26f740f846506c=
4737b
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:51 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:48 +01:00

rust: helpers: Generify the definitions of rust_helper_*_{read,set}*

To support atomic pointers, more {read,set} helpers will be introduced,
hence define macros to generate these helpers to ease the introduction
of the future helpers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260117122243.24404-2-boqun.feng@gmail.com
Link: https://patch.msgid.link/20260303201701.12204-4-boqun@kernel.org
---
 rust/helpers/atomic_ext.c | 53 ++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 7d0c2bd..f471c1f 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -4,45 +4,38 @@
 #include <asm/rwonce.h>
 #include <linux/atomic.h>
=20
-__rust_helper s8 rust_helper_atomic_i8_read(s8 *ptr)
-{
-	return READ_ONCE(*ptr);
-}
-
-__rust_helper s8 rust_helper_atomic_i8_read_acquire(s8 *ptr)
-{
-	return smp_load_acquire(ptr);
-}
-
-__rust_helper s16 rust_helper_atomic_i16_read(s16 *ptr)
-{
-	return READ_ONCE(*ptr);
+#define GEN_READ_HELPER(tname, type)						\
+__rust_helper type rust_helper_atomic_##tname##_read(type *ptr)			\
+{										\
+	return READ_ONCE(*ptr);							\
 }
=20
-__rust_helper s16 rust_helper_atomic_i16_read_acquire(s16 *ptr)
-{
-	return smp_load_acquire(ptr);
+#define GEN_SET_HELPER(tname, type)						\
+__rust_helper void rust_helper_atomic_##tname##_set(type *ptr, type val)	\
+{										\
+	WRITE_ONCE(*ptr, val);							\
 }
=20
-__rust_helper void rust_helper_atomic_i8_set(s8 *ptr, s8 val)
-{
-	WRITE_ONCE(*ptr, val);
+#define GEN_READ_ACQUIRE_HELPER(tname, type)					\
+__rust_helper type rust_helper_atomic_##tname##_read_acquire(type *ptr)		\
+{										\
+	return smp_load_acquire(ptr);						\
 }
=20
-__rust_helper void rust_helper_atomic_i8_set_release(s8 *ptr, s8 val)
-{
-	smp_store_release(ptr, val);
+#define GEN_SET_RELEASE_HELPER(tname, type)					\
+__rust_helper void rust_helper_atomic_##tname##_set_release(type *ptr, type =
val)\
+{										\
+	smp_store_release(ptr, val);						\
 }
=20
-__rust_helper void rust_helper_atomic_i16_set(s16 *ptr, s16 val)
-{
-	WRITE_ONCE(*ptr, val);
-}
+#define GEN_READ_SET_HELPERS(tname, type)					\
+	GEN_READ_HELPER(tname, type)						\
+	GEN_SET_HELPER(tname, type)						\
+	GEN_READ_ACQUIRE_HELPER(tname, type)					\
+	GEN_SET_RELEASE_HELPER(tname, type)					\
=20
-__rust_helper void rust_helper_atomic_i16_set_release(s16 *ptr, s16 val)
-{
-	smp_store_release(ptr, val);
-}
+GEN_READ_SET_HELPERS(i8, s8)
+GEN_READ_SET_HELPERS(i16, s16)
=20
 /*
  * xchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the

