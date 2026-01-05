Return-Path: <linux-tip-commits+bounces-7806-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02ACF4941
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E103082EBE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA015346FC6;
	Mon,  5 Jan 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzPv6HwG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+IjV+rW5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954C2346E4C;
	Mon,  5 Jan 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628476; cv=none; b=Qt1ERFglgUACdEGU0EC0kL0OFZCBpLOyouj6cTKlMZGWzIp4hPV5URLHClDMg2Ho+Ga3bDv/F5wPrKa6NEsosVfIcO4ZNA84U3VEBysD4QB5cfWg6PgGSnbWkvj8ymf0y3YR97yFnuORLpH9vZ2jDFa92IVyAX3h03UkGq+/lVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628476; c=relaxed/simple;
	bh=Y4J6onJk3bUuorHYpyol0BeO6rlKTlXR6gzRvxMuo/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TZXttvDL2Uriz5t+7bAUlo+KGEDug5ev3lcf8CtTpuiFJM+bKNS79fbTXXyoNRvLgFpP94Bv+JrfWYqui+I5CBXanHnmaPKjwT7A9j5ARn9NRQmo6+4O2yRpnq5F6JIOZ8nnWRWweWld3ZKRnu724DA5ZqwGVzUqWn/2TiQuwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzPv6HwG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+IjV+rW5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luQJ8vn9MRXpuw90JkGKPSxqb9skTprP5HNzFsgJPI0=;
	b=ZzPv6HwGohZgizWSB4LqogMaSmIN0OjOntRfZ6d9HksS/GlLFBc6HeUNDCF+HQRIoGIGEg
	cEZduCAVXr86RLQGMDj0KzNVJKGc6SNXEV+iD+2L5lzPi2Gk31RpX7aE+/CyQLk4DRvUaT
	qHPfP7aTvThy6faEk/n8KVVZNzky8ELOKwVGgPX/CtAu4PrcrTgfnEz4DZGL3+H8wJsxcD
	Q96dMwP6yzuNSzeVvOnY73CW9jsKtPzKYgPEK4A1kDN0buC/d/fn5rUW2AXC0mX+2FDPQy
	/MBne1eEqx+ml9n4E/ozoMFQW7v5OAVf1Jnj2hn0DyoSyiUURoGbpehTfC636A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luQJ8vn9MRXpuw90JkGKPSxqb9skTprP5HNzFsgJPI0=;
	b=+IjV+rW5emHTVlB3YEgZFJqcYAeW2wTpbo5JM/RHca7iXlgIs44e/wGEwEYXcV251cerEx
	/WnqHrye849+PCAw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kref: Add context-analysis annotations
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Bart Van Assche <bvanassche@acm.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-17-elver@google.com>
References: <20251219154418.3592607-17-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762847139.510.9715015412455701988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5e256db9325e75e9f000ddd64e4f1dbd2a6d8acd
Gitweb:        https://git.kernel.org/tip/5e256db9325e75e9f000ddd64e4f1dbd2a6=
d8acd
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:31 +01:00

kref: Add context-analysis annotations

Mark functions that conditionally acquire the passed lock.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251219154418.3592607-17-elver@google.com
---
 include/linux/kref.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index 88e82ab..9bc6abe 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -81,6 +81,7 @@ static inline int kref_put(struct kref *kref, void (*releas=
e)(struct kref *kref)
 static inline int kref_put_mutex(struct kref *kref,
 				 void (*release)(struct kref *kref),
 				 struct mutex *mutex)
+	__cond_acquires(true, mutex)
 {
 	if (refcount_dec_and_mutex_lock(&kref->refcount, mutex)) {
 		release(kref);
@@ -102,6 +103,7 @@ static inline int kref_put_mutex(struct kref *kref,
 static inline int kref_put_lock(struct kref *kref,
 				void (*release)(struct kref *kref),
 				spinlock_t *lock)
+	__cond_acquires(true, lock)
 {
 	if (refcount_dec_and_lock(&kref->refcount, lock)) {
 		release(kref);

