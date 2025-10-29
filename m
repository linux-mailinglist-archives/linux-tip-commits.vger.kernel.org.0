Return-Path: <linux-tip-commits+bounces-7043-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4246C196BB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 116FB56056D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F4232F740;
	Wed, 29 Oct 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzK6pvJW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWJnVfpM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF332D7DA;
	Wed, 29 Oct 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730581; cv=none; b=JHRRJuv5+VihbrgyjJBkw/HDq1WDoOAQc6smf6W1B6zMZ+cSwIJY7Tdbdq3ub9fF9HHANsz6z4IuO9z4esL/QHWQe5dMjsF1rr5tjmKMUUi7i4jqETarGwFmkMzx8nHQp8cV05lLGvNuV/+GvXJPe2tsUAq0ZTM7bmRbwLS98og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730581; c=relaxed/simple;
	bh=IcBOqh79LvasS3P/wyVckZ/dtXYvlq2/puKZQ4B5W9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e6Qjcplgr3I8FHGmQ25Bu7YRTgQXt8DNkZsXK9DdGUzDxH3kloPxL6yT1uqHFXVN7cioricgRTtPkMcPRKuW3T3OjSf0w5VFDXEhbRY6qOZyAiI4JYuczht4zwiHBD54OyfR9eg09yN0fzKOc/Dt8ezKh3kdgt/n9cHC70hhFuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzK6pvJW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WWJnVfpM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSSRaJQTPWYVa024KGes5nkqD5mzV0s41nbOhuZrsj8=;
	b=vzK6pvJWKM6WeMZ6mCdXNT+2XvaTaLtWTFWcZ9WGDtXMAV1f2Y12FWQp581APT7/eYhLNW
	qthQ6x8jUi6whg/kFShYbv8H4NCIBayZ5IMUl5o3QWWAIRPZfNos4Fq37o+8GbCMhRoeR9
	XsZSQBWz7pnrdLrdBLJDc3Q9gJBbCjiHq0x6mcw8qkYtBJ8lO0+3gZgnOTbEOQikg7aQ1q
	C65Y7brxnQIUrCEj8CP4E+uisyGo3ghCKZJRjTy2ojSh0J4TMvHPncAaa18MVLEeze1XjE
	k9nYRLQDGsCQ6E6Tlyr1wkffJRvfGe3cW60wTsu1NoUW4UdDs30xu8cTtTiohA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSSRaJQTPWYVa024KGes5nkqD5mzV0s41nbOhuZrsj8=;
	b=WWJnVfpMVc58paMLh8lgqaVZMpPt0UQRGOvEzfC1DNMmAF0xypb/MItav3NN+XGWmy5lL7
	7raw4271m8lt/GCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind: Fix unwind_deferred_request() vs NMI
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080119.005422353@infradead.org>
References: <20250924080119.005422353@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173057702.2601451.1605777240427660255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a38a64712e740d6e9df6940a997a47f5fab7efa2
Gitweb:        https://git.kernel.org/tip/a38a64712e740d6e9df6940a997a47f5fab=
7efa2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 15:47:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:56 +01:00

unwind: Fix unwind_deferred_request() vs NMI

task_work_add(RWA_RESUME) isn't NMI-safe, use TWA_NMI_CURRENT when
used from NMI context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080119.005422353@infradead.org
---
 kernel/unwind/deferred.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index dc6040a..d2cd3a7 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -231,6 +231,7 @@ void unwind_deferred_task_exit(struct task_struct *task)
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info =3D &current->unwind_info;
+	int twa_mode =3D TWA_RESUME;
 	unsigned long old, bits;
 	unsigned long bit;
 	int ret;
@@ -246,8 +247,11 @@ int unwind_deferred_request(struct unwind_work *work, u6=
4 *cookie)
 	 * Trigger a warning to make it obvious that an architecture
 	 * is using this in NMI when it should not be.
 	 */
-	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
-		return -EINVAL;
+	if (in_nmi()) {
+		if (WARN_ON_ONCE(!CAN_USE_IN_NMI))
+			return -EINVAL;
+		twa_mode =3D TWA_NMI_CURRENT;
+	}
=20
 	/* Do not allow cancelled works to request again */
 	bit =3D READ_ONCE(work->bit);
@@ -285,7 +289,7 @@ int unwind_deferred_request(struct unwind_work *work, u64=
 *cookie)
 	}
=20
 	/* The work has been claimed, now schedule it. */
-	ret =3D task_work_add(current, &info->work, TWA_RESUME);
+	ret =3D task_work_add(current, &info->work, twa_mode);
=20
 	if (WARN_ON_ONCE(ret))
 		WRITE_ONCE(info->unwind_mask, 0);

