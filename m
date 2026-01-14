Return-Path: <linux-tip-commits+bounces-7976-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75336D1CFA3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 09:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3CAA30242A7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E0937418A;
	Wed, 14 Jan 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDDcC497";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7zk27Lzr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31C2BE652;
	Wed, 14 Jan 2026 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377689; cv=none; b=jZID+KmGpYIdJgPwtWSv/F880rSIrJ0IODb0pjBB47jaRlcZZAF9Gt266r/2+zp8Lt3G49tu5QbYZBMhP77uPSbWvr4YNxe8J5OP1915vsPN5HUlefmimKvefeWLTpKQ1x8udAJQVmm+KDyDYbg5z4GOYeA10hcNu+m+J/cm2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377689; c=relaxed/simple;
	bh=MvgYkKn9kLcuXnLnGdMg0bL1qLSW/RH3pfivi57O1RI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ulqayuv/hJM9QCH9L0T/UoSdiAj2Js+xPFB6tsH4wgXwa4MrbhTyEbmPC8TyWbk4hN8h9zVrypCq3Vfr57aFk1L+/FfKCxmo3KBJp2+QdLjLHcsXxOz07V0IVULqJf2dNZQygRXzdBQrD5rZIzOU3OKEoOX/v924xDJNM2t+tM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDDcC497; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7zk27Lzr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 08:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768377679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRa3URuVSBawOpSS5/mXEeDwUQ+6GlxXXUnOMjJCsjc=;
	b=EDDcC497h88hb9R4h9MO9zPZFBjdP3ILI1YSQhD4sYq8sCXZy996CRaeu3AMP9IBlHxuq1
	d7LVNjf7UrvFo8JsE7Ezuu5quKwGBlUF10ItbgDW8lFBgCA+nWUps/vfT3fWFHkHY+5TKl
	Z1zh8EvICqi524ggr14zQTLYthP0yFku/aJjqIrbmh0T28sDlpaaXzONfoF3J5pSGoUX+/
	OEpuOYsuTMUMRxW4adbjJ8RMdqGE2l2thg9uQp/tL9B7vI1Xl8ggTHmM+lgmgoNGzLmK2e
	SaH/LzKY1fuWDlKFzzTiFbbDNPTMcBK0XskbtcrzVvuaNFrY9jKA3dEuD4+bDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768377679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRa3URuVSBawOpSS5/mXEeDwUQ+6GlxXXUnOMjJCsjc=;
	b=7zk27LzrNKaWGcuo1/+WVpAzKqpILg33UnJDGZADnJBcWRwMjWThUjuRm0/+WlIQcg/AH1
	DXmTkxTs6RuWRJAQ==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] tools headers: Remove unneeded ignoring of
 warnings in unaligned.h
Cc: Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251016205126.2882625-5-irogers@google.com>
References: <20251016205126.2882625-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176837767357.510.6365695284606950515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     10a62a0611f5544d209446acfde5beb7b27773c7
Gitweb:        https://git.kernel.org/tip/10a62a0611f5544d209446acfde5beb7b27=
773c7
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 16 Oct 2025 13:51:26 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 14 Jan 2026 08:56:41 +01:00

tools headers: Remove unneeded ignoring of warnings in unaligned.h

Now that get/put_unaligned() use memcpy() the -Wpacked and -Wattributes
warnings don't need disabling anymore.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251016205126.2882625-5-irogers@google.com
---
 tools/include/linux/unaligned.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/unaligned.h b/tools/include/linux/unaligned.h
index 395a446..d51ddaf 100644
--- a/tools/include/linux/unaligned.h
+++ b/tools/include/linux/unaligned.h
@@ -6,9 +6,6 @@
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wpacked"
-#pragma GCC diagnostic ignored "-Wattributes"
 #include <vdso/unaligned.h>
=20
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
@@ -143,6 +140,5 @@ static inline u64 get_unaligned_be48(const void *p)
 {
 	return __get_unaligned_be48(p);
 }
-#pragma GCC diagnostic pop
=20
 #endif /* __LINUX_UNALIGNED_H */

