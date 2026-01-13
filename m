Return-Path: <linux-tip-commits+bounces-7945-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9393D1929F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE45930102A5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E438E5E8;
	Tue, 13 Jan 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="btcBNj/n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGW/xJAS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA471DEFE9;
	Tue, 13 Jan 2026 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312051; cv=none; b=Wzrt8Zl0UqekbyGlQDk+/+KikW1ayC27ccWRU95wqHZecLhI6pFiozW1EmpPd0JsxNXXCK0YlS3309E+1HtThu3pWgbjSSRuABUbSCdf3HdNAoaCtYTlujOai0xGA0vu1gG4aCMFzi/gwCpebw0WpAbZXF061H9PrW/Sdf4kXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312051; c=relaxed/simple;
	bh=Pdg/GGVqnh0pappTFIxMGIoieimQ7cHLkJ1ZEjFWaf4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cbuxz34QPtOFAC9IfgjJfys+INcOiDh4qDoefjzX4O4lkI4mz3VLkMYHTCEYpZUM024mHfBwDZ/iQGzZaakt2oc+tDL/tP7siKbqC4xjMnfH8/y+ikn236unUhJJYorEP2z0m2LCAVkH0wD8qW5INmRJybWVuhs0PtoW/1JP6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=btcBNj/n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGW/xJAS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHvwbg29kszb28GNU+V6Q1GU8jUKoz8jt9KvOESEf4Q=;
	b=btcBNj/nbc73kEENRi1uTABVel/kAX/vFkwqcHsfpnnUICGrD0gi3dwAQPj7PMXKQ8Xbd+
	rfPVHaUMCufUfI2qUEdUO4QB5ov88mdGPuaHZwg34zL8LGimGZW8YRo06NP2zswn8omf0y
	hW48DAwK/2EQEfZFvzb3NE8YEGkMeEHX0nEbEZV+bLsVCiSoyk5GzdaUDxxGT5dIqeVkdT
	eL5lppN90J3FcsDWxLSZdKBugJrJK+852uRL54ZhZ1nixMccwdoOjFW6O2eEtfVBs11WXp
	kRZlLLssvYLXILBGmU2mg71nsP7YZJioqR81CeLBi1A/TiauddReb0do/wti1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHvwbg29kszb28GNU+V6Q1GU8jUKoz8jt9KvOESEf4Q=;
	b=lGW/xJASNH6TXEB5y2QzXj59QFGokMBMDY1L3s6CN69OOb2018VT1pN9Hx9s0zQzbMJ8eU
	yn9+MkVTvjYnUUCg==
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
Message-ID: <176831204636.510.1947083696278870066.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     576d8a7a985dde4f51a4561dddc0d8734494d3de
Gitweb:        https://git.kernel.org/tip/576d8a7a985dde4f51a4561dddc0d873449=
4d3de
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 16 Oct 2025 13:51:26 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:46:01 +01:00

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

