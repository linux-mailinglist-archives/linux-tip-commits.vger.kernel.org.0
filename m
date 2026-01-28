Return-Path: <linux-tip-commits+bounces-8125-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JTkH8TMeWmOzgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8125-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:45:56 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B199E523
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C8B630055A9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74233396E6;
	Wed, 28 Jan 2026 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uomgF4Ml";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJA+qzbW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC33337BBB;
	Wed, 28 Jan 2026 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589952; cv=none; b=H+uZqSog2SwgSdghGkyUf+3cp9ffaLUpikC757H5kXA/I5crt9zJtfQs/n279fauHo4eRKM262gMfRHk/PSOtsCK7xJUpNneanqQzjhR5TgSBvXf22iIab1PgmbwIXHFDvHh8e0rrkhj7CaX9puDaPfrh32/ZEtrsx8t8jc8jpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589952; c=relaxed/simple;
	bh=H81BVafx2ZgQ6LDx2m7750qbX2guyiJ2ZKXkJ4Ko69Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lHLgRv2YJCk5A3DkoIsfmTdEtwxHZC85ykU6OGI9tOF5ITBSWd60tXcLRIFLW2FW7/6bAAB9+Iz1hw1ZeL4Yo82wMq4Q59QsolOoJXxVL2ZeMWt/IkK6AhM40oAV54NSuUxtzcjje7bWCJUhGH6rq0VoO/C5pQBAuaiOo+1cMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uomgF4Ml; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJA+qzbW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 08:45:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769589949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5to7yTRdCPkzRD/V+xQJ2CJq9SpzFyV8JdKFQzrGcQ=;
	b=uomgF4MlqvFgGdfrL5luYXiuhZON/sTymjAch8cFCFVrTx4Yxns0+KNBVFL1+9LDMhvXSG
	FIv1U79fOAm0IjaWQdWTKYwSzJ9FhPvWPy5LQYiLgNih4SvW7kG60h6Mc8W4fxVRiQK1X+
	zT1t3IpYTTzp9wgMkawg+8jhRqpQ65s19UiTau/EdsAKR2GZG2DAuBnjTqBategwVRakLW
	dK7fOTTfj11OhJM55WFz82f68o7T4QfcZ3VkFcyr8smqYfpmvYhZRmL5z8iS8UJtFdHysa
	SUH7piGO6YEaC98TXkg8FvpKD/mZOQGkQrBe/25JnJZaepR8fuVemzF1za8ZcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769589949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5to7yTRdCPkzRD/V+xQJ2CJq9SpzFyV8JdKFQzrGcQ=;
	b=wJA+qzbWit2cTfdBkHz5OAPvJsSnSF+4h23sMVVt2pVfsM0y8/qyPnQg5UGzTOmDA6WhvK
	Gdb2Edyk3WIJNvAA==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: fix scoped_seqlock_read kernel-doc
Cc: Randy Dunlap <rdunlap@infradead.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260123183749.3997533-1-rdunlap@infradead.org>
References: <20260123183749.3997533-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176958994816.510.12923551068141443083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,infradead.org:email,vger.kernel.org:replyto];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8125-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 19B199E523
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f88a31308db6a856229150039b0f56d59696ed31
Gitweb:        https://git.kernel.org/tip/f88a31308db6a856229150039b0f56d5969=
6ed31
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 23 Jan 2026 10:37:49 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 09:36:54 +01:00

seqlock: fix scoped_seqlock_read kernel-doc

Eliminate all kernel-doc warnings in seqlock.h:

- correct the macro to have "()" immediately following the macro name
- don't include the macro parameters in the short description (first line)
- make the parameter names in the comments match the actual macro
  parameter names.
- use "::" for the Example

WARNING: include/linux/seqlock.h:1341 This comment starts with '/**', but isn=
't a kernel-doc comment.
 * scoped_seqlock_read (lock, ss_state) - execute the read side critical
Documentation/locking/seqlock:242: include/linux/seqlock.h:1351: WARNING:
  Definition list ends without a blank line; unexpected unindent. [docutils]
Warning: include/linux/seqlock.h:1357 function parameter '_seqlock' not descr=
ibed in 'scoped_seqlock_read'
Warning: include/linux/seqlock.h:1357 function parameter '_target' not descri=
bed in 'scoped_seqlock_read'

Fixes: cc39f3872c08 ("seqlock: Introduce scoped_seqlock_read()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260123183749.3997533-1-rdunlap@infradead.org
---
 include/linux/seqlock.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 1133209..c00063d 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1339,15 +1339,14 @@ static __always_inline void __scoped_seqlock_cleanup_=
ctx(struct ss_tmp **s)
 	     __scoped_seqlock_next(&_s, _seqlock, _target))
=20
 /**
- * scoped_seqlock_read (lock, ss_state) - execute the read side critical
- *                                        section without manual sequence
- *                                        counter handling or calls to other
- *                                        helpers
- * @lock: pointer to seqlock_t protecting the data
- * @ss_state: one of {ss_lock, ss_lock_irqsave, ss_lockless} indicating
- *            the type of critical read section
- *
- * Example:
+ * scoped_seqlock_read() - execute the read-side critical section
+ *                         without manual sequence counter handling
+ *                         or calls to other helpers
+ * @_seqlock: pointer to seqlock_t protecting the data
+ * @_target: an enum ss_state: one of {ss_lock, ss_lock_irqsave, ss_lockless}
+ *           indicating the type of critical read section
+ *
+ * Example::
  *
  *     scoped_seqlock_read (&lock, ss_lock) {
  *         // read-side critical section

