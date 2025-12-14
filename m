Return-Path: <linux-tip-commits+bounces-7663-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AAACBB780
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67DDC300A713
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE2A2BEC32;
	Sun, 14 Dec 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DHriQyOB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hrYygQCd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274129E10C;
	Sun, 14 Dec 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698414; cv=none; b=UFfcCqVhPrYOszlajLsCuX+K/9Rq4xMArzaRKCkUSEVk9OfI3O5bcNPy1T162UmnckgxzDvjdJa7wZc2wqGaeAycGezoGWe2VPSqnwp18YSXmCFxTce+tgb0/yyZlhxbMeVAaTExSN0LAkHbr81P++0uUzF8OdTHldGYeCWIqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698414; c=relaxed/simple;
	bh=0nO/PYDhyDyLjGwn8yYLSluYQW1eyxd9CoP8wmIXDYQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q11menFFDQZHsINN9u8uUkGbJv/yOlsntRM//9/AXPQjf+Usn1qV45uZ6VcgKzK+xjtpe8OcwccEeRMXAAvlo03XHojg3jIFXx/9yhgz4eYNX7uTgkVxnlKJK1LcF4pu8YYrG6zh3baL+JTTTEY0xWNhGys03HNuCgVwi73xsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DHriQyOB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hrYygQCd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698411;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/Grw40EEpKcwbBGvQVRC1HMv2wSegEV554cm1G65XU=;
	b=DHriQyOB7+rxtcw0AGMjMfLcLlRHlShubhbM1zZg6OeFPhgNHfRwfflG73/NTrN/DMDCp3
	cwgB5yEsfZCN4i7LWZrc9IUTj8fYwjWKHtaqNqchTIBiCKRqxBxA57E4pIsC36z4DhOfeF
	L6OtiGHd2kCfqf957/WJD9hWb+gWBPfnaSe5ikB7vKugUVfwjCi01Tr5PsuglGiaTZ5Hgc
	YFxHxrO2RbjCaeJgqF8E5XAGLEje5ZIfpta87NGVdlDFWOZkedWmo7HmmdXuNBnCkQHbch
	dOCzWF0orIsqFAVJuNDPScaoi8lNEUB4URth5lMTS3nVrJE3qkCjHy0xEd6V1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698411;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/Grw40EEpKcwbBGvQVRC1HMv2wSegEV554cm1G65XU=;
	b=hrYygQCd3Yxs1Jenhu7pWRXFsWPPG9DwEUzcuN/TGCaDYyOOsxFlXl9uXEjAYnlhjm9/Om
	XzOVE7wN6tedSVBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] <linux/compiler_types.h>: Add the
 __signed_scalar_typeof() helper
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127154725.413564507@infradead.org>
References: <20251127154725.413564507@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569841006.498.2794868287250554578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     38a68b982dd0b10e3da943f100e034598326eafe
Gitweb:        https://git.kernel.org/tip/38a68b982dd0b10e3da943f100e03459832=
6eafe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 27 Nov 2025 16:39:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

<linux/compiler_types.h>: Add the __signed_scalar_typeof() helper

Define __signed_scalar_typeof() to declare a signed scalar type, leaving
non-scalar types unchanged.

To be used to clean up the scheduler load-balancing code a bit.

[ mingo: Split off this patch from the scheduler patch. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://patch.msgid.link/20251127154725.413564507@infradead.org
---
 include/linux/compiler_types.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1280693..280b4ac 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -586,6 +586,25 @@ struct ftrace_likely_data {
 			 __scalar_type_to_expr_cases(long long),	\
 			 default: (x)))
=20
+/*
+ * __signed_scalar_typeof(x) - Declare a signed scalar type, leaving
+ *			       non-scalar types unchanged.
+ */
+
+#define __scalar_type_to_signed_cases(type)				\
+		unsigned type:	(signed type)0,				\
+		signed type:	(signed type)0
+
+#define __signed_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(signed char)0,				\
+			 __scalar_type_to_signed_cases(char),		\
+			 __scalar_type_to_signed_cases(short),		\
+			 __scalar_type_to_signed_cases(int),		\
+			 __scalar_type_to_signed_cases(long),		\
+			 __scalar_type_to_signed_cases(long long),	\
+			 default: (x)))
+
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
 	(sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=3D sizeof(short) || \

