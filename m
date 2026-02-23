Return-Path: <linux-tip-commits+bounces-8219-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OVPMr4snGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8219-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:32:30 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855B174EF7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478B6303277F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF835B649;
	Mon, 23 Feb 2026 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wRGlGRw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r6OdwEwj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C2344D91;
	Mon, 23 Feb 2026 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842313; cv=none; b=Dw/d4cHf+nkGpBMpdS7pRGhY/TBXEBtCfX+GpKwf3C7S4t4BP5mz75vcIe0hNyb2C1n4Z5YKtuSUwH+ty+oCodBj7VqULVYiurgadGRxwEgbDjpdAaO+DEO1QCFKm7TAV6374YFzi8+O/jX97ZCDW95l8dCyb+UJb8TU85TA+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842313; c=relaxed/simple;
	bh=juhHEt6wxADvwsDDpRAPIKM7Bmg1da1gpAjT3suoKDY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PefricMY5hkKO4Loz639I6Zcq4o3BBlhGajdKiibJQST5Y8ZJekfG3NYWuuFalCrhs55zFUTUAUsTo3AFRpJiyEydR0GmkGey8gXBmTA3xSXgki3ND1h/TRP8lQQKXvqI5uHxOCFPepMrWH8DOIKAdwymoY1FMYVp1TnzRGJUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4wRGlGRw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r6OdwEwj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842310;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLf7xuvSwFUgJGNgSIqR4OAPTDZZCIFwwT5G15B+jAc=;
	b=4wRGlGRwLNilGbeYFRMT0T/Yig6s/Wk8Q1+uT8JXYxU2i/O7/a7qG0awK3t3J4KdcaYZu4
	LJbsHk+x8zc8jQ/yzNJZ+ULJouFNtLeNS9uHDBMBf0+F0WyU1DZdVlpLN0X+YwzLyUBB6g
	QQoreAfnbDdc9WBrpK/yC86gE194qq8wXMTJrAOpsBn8oOp/4x1IQjTReXB7lUznKkQOm0
	zhHtZgueUl+eYfXCm4NxsHj+HMfkGtdm2H9/Qh0LPfFj98zEkjoWcLTGE5JnzKfd+Bpydd
	L6fePvAdIlFVuIgFFY8uDfSL7F4odjlsdhPJIRlJPC/mMzzT4zKK5Hu4Rub22A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842310;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLf7xuvSwFUgJGNgSIqR4OAPTDZZCIFwwT5G15B+jAc=;
	b=r6OdwEwjbOQLnr+UgJhfsgLFJ0uL9ELUZ6W7SQlRLDzQfo9WqhSr6cJ6giNXDzFUi0L1il
	RsREjMjT00eCyWCw==
From: "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/mutex: Add killable flavor to guard definitions
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260217191512.1180151-4-dave@stgolabs.net>
References: <20260217191512.1180151-4-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184230434.1647592.15445846598842585113.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8219-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,stgolabs.net:email,linutronix.de:dkim,vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 3855B174EF7
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     50214dc4382055352fb1d7b9779550dabf5059e5
Gitweb:        https://git.kernel.org/tip/50214dc4382055352fb1d7b9779550dabf5=
059e5
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Tue, 17 Feb 2026 11:15:12 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:16 +01:00

locking/mutex: Add killable flavor to guard definitions

The mutex guard family defines _try and _intr variants but is missing
the killable one.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260217191512.1180151-4-dave@stgolabs.net
---
 include/linux/mutex.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index f57d2a9..2f648ee 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -253,6 +253,7 @@ extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struc=
t mutex *lock) __cond_a
 DEFINE_LOCK_GUARD_1(mutex, struct mutex, mutex_lock(_T->lock), mutex_unlock(=
_T->lock))
 DEFINE_LOCK_GUARD_1_COND(mutex, _try, mutex_trylock(_T->lock))
 DEFINE_LOCK_GUARD_1_COND(mutex, _intr, mutex_lock_interruptible(_T->lock), _=
RET =3D=3D 0)
+DEFINE_LOCK_GUARD_1_COND(mutex, _kill, mutex_lock_killable(_T->lock), _RET =
=3D=3D 0)
 DEFINE_LOCK_GUARD_1(mutex_init, struct mutex, mutex_init(_T->lock), /* */)
=20
 DECLARE_LOCK_GUARD_1_ATTRS(mutex,	__acquires(_T), __releases(*(struct mutex =
**)_T))
@@ -261,6 +262,8 @@ DECLARE_LOCK_GUARD_1_ATTRS(mutex_try,	__acquires(_T), __r=
eleases(*(struct mutex=20
 #define class_mutex_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_try, _=
T)
 DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr,	__acquires(_T), __releases(*(struct m=
utex **)_T))
 #define class_mutex_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_intr,=
 _T)
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_kill,	__acquires(_T), __releases(*(struct m=
utex **)_T))
+#define class_mutex_kill_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_kill,=
 _T)
 DECLARE_LOCK_GUARD_1_ATTRS(mutex_init,	__acquires(_T), __releases(*(struct m=
utex **)_T))
 #define class_mutex_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_init,=
 _T)
=20

