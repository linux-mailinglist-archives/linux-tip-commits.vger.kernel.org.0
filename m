Return-Path: <linux-tip-commits+bounces-7830-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D0DD02264
	for <lists+linux-tip-commits@lfdr.de>; Thu, 08 Jan 2026 11:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36A483046FA4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jan 2026 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49B3C1986;
	Thu,  8 Jan 2026 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6xdp4nV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fEJb5wrt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25C39A7F7;
	Thu,  8 Jan 2026 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868080; cv=none; b=B5E1CFXdTgBVT9KIWAkGuPgCgThvX1Km24vESmqQhSXreZn8feEIm/qWc17vrXMG6zja69QFCn5yNVEonEYVkcSuhOZtAoeW8L6gqOeLRQjiq7hOFClHWBDtM1XVpVZQJUTY4WSrxOfvvo9NaqRbboDyNV4ZQfBS5gKgf8eSB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868080; c=relaxed/simple;
	bh=rRCcEJGzNxRCGQXprZ4iQ8jnIyHqTsPOEwk2b4RGd4Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mmGKJfhDS/afk71x/YH8saE6wjvo/ClBXxRJCaa2xxC+PoDAE4MNpWQUs/GyrcPmLnYM3mDiDgly8Lq4i7lfzs1sQ3XSHOt+/6Ho+8Yf8zs1Go6kX7CZFovpVSyT36a9sAMAqdDdZd3hOP7T0A4rvtJBN4K3OxdQoPHa9lwyhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6xdp4nV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fEJb5wrt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Jan 2026 10:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767868075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=B9622df2OPTXTIpITPRD+i99QtXUASVxntNG2o8RvA4=;
	b=u6xdp4nVCExAn5FZdyfrWqPzxMH5uSEUftghnH72Zy00FeEywL4vsgVIl9uhqMl2M1RfOb
	1SPbLxruRl203AWvD3m641TNB2S0B/LKT9xWw0sDD137WsY2vhEma9Q0BXzKmgOm75zbKd
	XoDO5GEoyfru8InfTHkZWvvClm9yBGRJ2zAnEOUJtoYwODa4/AMf2IuaOSsjapJmWwm7yy
	X5y96zOHHTzL0QXrRE05/auOST++lW9W/dnlJIjE58UhkqI6A2w0ayAeXDNxOMPYKAAyVc
	kB5NiWVY3XOEQp7mWvd5g+eyW652mc1JKKF6tAbmhGBARkmqoS0uTNaGDpe7ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767868075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=B9622df2OPTXTIpITPRD+i99QtXUASVxntNG2o8RvA4=;
	b=fEJb5wrtbraaxSpK6TaRirXb96EMSfMa3IEqJBs4wfgTErqYg2LgJeXRxMW0s6S1XqCB16
	Xm7Re+KPGdUNAjDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local_lock: Include more missing headers
Cc: Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176786807434.510.5032264498912378215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a45026cef17d1080c985adf28234d6c8475ad66f
Gitweb:        https://git.kernel.org/tip/a45026cef17d1080c985adf28234d6c8475=
ad66f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 08 Jan 2026 11:14:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Jan 2026 11:21:57 +01:00

locking/local_lock: Include more missing headers

Ingo reported PREEMPT_RT=3Dy builds fail building
lib/test_context-analysis.c.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/local_lock_internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_i=
nternal.h
index e8c4803..7843ab9 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -233,6 +233,7 @@ do {								\
=20
 #else /* !CONFIG_PREEMPT_RT */
=20
+#include <linux/sched.h>
 #include <linux/spinlock.h>
=20
 /*

