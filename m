Return-Path: <linux-tip-commits+bounces-8205-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPQNC2hZhGl92gMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8205-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 09:48:40 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE87F0036
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 09:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83619301CD9B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Feb 2026 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB5316193;
	Thu,  5 Feb 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLMJqMHV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gpQYgw5l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185E155C82;
	Thu,  5 Feb 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281317; cv=none; b=jqIbefisi8+d/ClalJWT9rPAK6KISzglfQ8G2ocn6BhC78kqEzXvRUa05fKxckdzuiHo2DS4iOCbAEjsVvPCWeUudt5tDVnR+I/eZYCQ+F4wPWZ54q41m/hdlK7i67zPbm73vPfNHJvqUoMu2f7pv6ly7KnJBoo9bq3T7/KQiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281317; c=relaxed/simple;
	bh=xHnVTJNHKIoAkfJCjqw08dKqk031d86lsm5GU09RtBs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dFcGuPfFelnTx6JhcUNd77KWkwT98vXX6yAN9596Fm7h1H6haE/9j6YYHDxTXWQo/Iw9dYCc6MCKp3ge5hYpg6BnvVljZ3JF3BVLQD2iqqUb80R7ArR6UhSU/jQu/rw9b0AAItu1QBMNJdr2JkSVN6WF4oF+2R1Fh8WIX+oDIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLMJqMHV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gpQYgw5l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Feb 2026 08:48:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770281315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afBI9DFMZij4F3kMCEOuldyBXnpUiNXXWDcoSyutdB8=;
	b=fLMJqMHVPGJ8ECeHy/VBIL3106iw9XoddtROduOqXThTuVFqu4CG90kopT7dYJ2hSLuJgl
	0I+y0BcfSE8XT1mBe/N5zW4+HoosYkWmBuLjNO/tjJd0pY4RQZaeWIWUuGkZtipmgGQSeL
	MhoB0PGAQeaIpMmocG14FATvZF6V1t1FHDO64drW0hUFOQemrqriOcKXqUct/uOs0KdYH4
	noDS0JXzoKBVIhkeqqKR8TGFWLHf8bhp1ZG0fzywTpITS6xisKJCXNnrX+2Bfn4tz8SxC0
	3hdosJZP9ypkvFHOIMjfkA/hM1FiyE4xJg1by0E5bZ5uqGGfzyu6uhkKbQjdxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770281315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afBI9DFMZij4F3kMCEOuldyBXnpUiNXXWDcoSyutdB8=;
	b=gpQYgw5lQOwHLb/aUy2lbEq3eCkCCYnLyHXOi4VHTNl2+utLCi/bh7V3EEgXlJzBCchpf4
	SRQPyEhPZfw3RLAQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwlock: Fix write_trylock_irqsave() with
 CONFIG_INLINE_WRITE_TRYLOCK
Cc: kernel test robot <lkp@intel.com>, Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Bart Van Assche <bvanassche@acm.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260203225114.3493538-1-elver@google.com>
References: <20260203225114.3493538-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177028131401.2495410.16999054991805392231.tip-bot2@tip-bot2>
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
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8205-lists,linux-tip-commits=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8CE87F0036
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7a562d5d2396c9c78fbbced7ae81bcfcfa0fde3f
Gitweb:        https://git.kernel.org/tip/7a562d5d2396c9c78fbbced7ae81bcfcfa0=
fde3f
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 03 Feb 2026 23:50:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Feb 2026 09:43:48 +01:00

locking/rwlock: Fix write_trylock_irqsave() with CONFIG_INLINE_WRITE_TRYLOCK

Move _raw_write_trylock_irqsave() after the _raw_write_trylock macro to
ensure it uses the inlined version, fixing a linker error when inlining
is enabled. This is the case on s390:

>> ld.lld: error: undefined symbol: _raw_write_trylock
   >>> referenced by rwlock_api_smp.h:48 (include/linux/rwlock_api_smp.h:48)
   >>>               lib/test_context-analysis.o:(test_write_trylock_extra) i=
n archive vmlinux.a
   >>> referenced by rwlock_api_smp.h:48 (include/linux/rwlock_api_smp.h:48)
   >>>               lib/test_context-analysis.o:(test_write_trylock_extra) i=
n archive vmlinux.a

Closes: https://lore.kernel.org/oe-kbuild-all/202602032101.dbxRfsWO-lkp@intel=
.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260203225114.3493538-1-elver@google.com
---
 include/linux/rwlock_api_smp.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index d903b17..61a8526 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -41,16 +41,6 @@ void __lockfunc
 _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
=20
-static inline bool _raw_write_trylock_irqsave(rwlock_t *lock, unsigned long =
*flags)
-	__cond_acquires(true, lock)
-{
-	local_irq_save(*flags);
-	if (_raw_write_trylock(lock))
-		return true;
-	local_irq_restore(*flags);
-	return false;
-}
-
 #ifdef CONFIG_INLINE_READ_LOCK
 #define _raw_read_lock(lock) __raw_read_lock(lock)
 #endif
@@ -147,6 +137,16 @@ static inline int __raw_write_trylock(rwlock_t *lock)
 	return 0;
 }
=20
+static inline bool _raw_write_trylock_irqsave(rwlock_t *lock, unsigned long =
*flags)
+	__cond_acquires(true, lock) __no_context_analysis
+{
+	local_irq_save(*flags);
+	if (_raw_write_trylock(lock))
+		return true;
+	local_irq_restore(*flags);
+	return false;
+}
+
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
  * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are

