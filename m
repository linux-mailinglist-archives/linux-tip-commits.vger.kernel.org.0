Return-Path: <linux-tip-commits+bounces-8263-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKCTKufJommy5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8263-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:56:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C681C25B1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1EC0303CEF4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBD407586;
	Sat, 28 Feb 2026 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtoKHHXf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0egrlmpi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BD423A7A;
	Sat, 28 Feb 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276197; cv=none; b=JkdCjbMy748wuLOAo2ftiKeISi+LujEK+De1b6T4Tj82E/bPiEmUNHgcfH8QRQX0y/xnYKiibvh6JTYYhMpOaSEwj/PEIHWEhAN+K45mzZ80/UEW6ApKyeBSUUcBZzg6OPiswBx6YW1MY8E+1CdYm/2QcWVSD9fATwUugVoKSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276197; c=relaxed/simple;
	bh=ygMNiJZuRmAHn3JufW+SoUmNtYElCUtyhsYOuCEVAwE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Sy2SzLP8rML14alKFssl1LGJoCzM+FMTDCbaF/Zwx3am2caByYbVPu4E7r4wJGyki5I9agYITjTvamRuMXfM+ygc036ZYpdXG3mzRmJ1ipCgC5FdJHcbFArLig/fA4CNW8o2GCtl+z4a0/437Z2UVle2lYKMSimdoHePvhdu9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtoKHHXf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0egrlmpi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QUl6XLj0yTt5KlJt5IqxA+6Yd2T7Z4qIIfZBx2bqdM=;
	b=mtoKHHXf3+g48Y5NlpH1xTmTbSzFVXCuysWxZznJiWZhyZfXGLg8FI1oYuU3S9S2ZknaDf
	uN9JdyhgkDagdiupOHGtOQJirwsMEQ9K3lBEZEsCGqqWlpkxnigZ2hILMohqh7e+Sdh5nU
	lSLnbcpTcvz0/ObvMoQMA3QuMpH6IQsMyX3yLrxsbGKyxxGPC3mugUH+aPrvN3n1uwzx9E
	TprJmoEzC/cSteWUB/yFjO/qgDAjHrVydPVNtU8YYDkQFgyJSCzKGSfj/wIC0JR6fxuYem
	1UU5q2EnysMENKvvGWADooAFHisFTUSqtziLs7kNvnJTYl3ysd+tXLsbpKA6RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QUl6XLj0yTt5KlJt5IqxA+6Yd2T7Z4qIIfZBx2bqdM=;
	b=0egrlmpiXhtBW33++smgnR1N0Ea2WVoogiWbud2YyeriPb91WElMyYsZe7SRxf+7eP90mx
	L0RwqpipzsVIOyCA==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] ww-mutex: Fix the ww_acquire_ctx function annotations
Cc: Bart Van Assche <bvanassche@acm.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260225183244.4035378-4-bvanassche@acm.org>
References: <20260225183244.4035378-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227618699.1647592.15529820261216474369.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8263-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: E9C681C25B1
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3dcef70e41ab13483803c536ddea8d5f1803ee25
Gitweb:        https://git.kernel.org/tip/3dcef70e41ab13483803c536ddea8d5f180=
3ee25
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Wed, 25 Feb 2026 10:32:43 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:20 +01:00

ww-mutex: Fix the ww_acquire_ctx function annotations

The ww_acquire_done() call is optional. Reflect this in the annotations of
ww_acquire_done().

Fixes: 47907461e4f6 ("locking/ww_mutex: Support Clang's context analysis")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Acked-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20260225183244.4035378-4-bvanassche@acm.org
---
 include/linux/ww_mutex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 85b1fff..0c95ead 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -181,7 +181,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx =
*ctx,
  * data structures.
  */
 static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
-	__releases(ctx) __acquires_shared(ctx) __no_context_analysis
+	__must_hold(ctx)
 {
 #ifdef DEBUG_WW_MUTEXES
 	lockdep_assert_held(ctx);
@@ -199,7 +199,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx =
*ctx)
  * mutexes have been released with ww_mutex_unlock.
  */
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
-	__releases_shared(ctx) __no_context_analysis
+	__releases(ctx) __no_context_analysis
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);

