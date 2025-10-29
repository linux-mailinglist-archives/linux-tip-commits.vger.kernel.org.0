Return-Path: <linux-tip-commits+bounces-7039-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D460FC19643
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3565F4052C4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24A132BF46;
	Wed, 29 Oct 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1RlXzJZt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9RaVuGyj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F6328B66;
	Wed, 29 Oct 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730577; cv=none; b=LHfKS65WdNG8EuU8RwwPg9hVk71Wz9xKH3DLQhOMxakUY3asFjh/tedkUmE/SPh138wAmb/PO1he5vWc7nmHifrFYgBbvShAZSQSNsMKrKJo7VRnpLF8AdKB5bEqP09Up9JSlF90mopyxxbFXUoPrllCFazlU93UFPCkrzrKR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730577; c=relaxed/simple;
	bh=41QqV4s/qHw/XgvtTokQSrfvwbgvkjU58wKfcR7l6z4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TZD5ycBMoOqW3WJHAgHnZzseTWuHpj3RwJEYUpTnNVsKDgZMcxnu39elfXHGnr77m72A5xBrqvI3wIP0d03j8UN7cxzqhY1emup0IV3EyksW6aZteub72866d+yLUCC+rCskjHs6gMLRVID7yL3rmwAJCFbZML3O6sYVgcZMM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1RlXzJZt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9RaVuGyj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QES50EpqilT49vfQ4aVQM5699fCD2vPnNp1BID3fDyg=;
	b=1RlXzJZtfaDVHASJ0Jc0CQ0YMMc5XiplfeS/XxryVIWEmv/jxI3sepoJr0bSjaLtORgRW8
	whsvcY/kQ7pJVUj4h+F01jkSRD8fucummElaYu7rFKXUe4b78lE4JYlFfZ6dM8cDzfNHI9
	Znvn/zmsMU5VIrBGUt+BVuqDwsHCNcUqFXr/PUnlBwnFQlJXIe3koG8BZSzyUf1g9LQRqL
	FNYOYmQltOigEPAvwoh/IxZDO9/M5SUZO9+c8CaDuK8Rgka6EzZ/eYtmheInxzElMecWxn
	WpWqflmOUP9DRQCeX5szlK7CriVFUtmTFRmG0VdSYCKeF7vTQVqrCJ08yKGzdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QES50EpqilT49vfQ4aVQM5699fCD2vPnNp1BID3fDyg=;
	b=9RaVuGyjCTbbyLoGOaLDgAzJH+KWOxvmJu4VcGuDSYAvdsinFhWDTr74BCpjI8RoICN5T0
	QMTtIdXNNlI7nYAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] unwind: Simplify unwind_user_next_fp() alignment check
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080119.497867836@infradead.org>
References: <20250924080119.497867836@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173057191.2601451.17429694962908519380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5578534e4b92350995a20068f2e6ea3186c62d7f
Gitweb:        https://git.kernel.org/tip/5578534e4b92350995a20068f2e6ea3186c=
62d7f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 23 Sep 2025 13:04:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:57 +01:00

unwind: Simplify unwind_user_next_fp() alignment check

  2^log_2(n) =3D=3D n

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080119.497867836@infradead.org
---
 kernel/unwind/user.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 97a8415..9dcde79 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -19,7 +19,6 @@ static int unwind_user_next_fp(struct unwind_user_state *st=
ate)
 {
 	const struct unwind_user_frame *frame =3D &fp_frame;
 	unsigned long cfa, fp, ra;
-	unsigned int shift;
=20
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
@@ -37,8 +36,7 @@ static int unwind_user_next_fp(struct unwind_user_state *st=
ate)
 		return -EINVAL;
=20
 	/* Make sure that the address is word aligned */
-	shift =3D sizeof(long) =3D=3D 4 ? 2 : 3;
-	if (cfa & ((1 << shift) - 1))
+	if (cfa & (sizeof(long) - 1))
 		return -EINVAL;
=20
 	/* Find the Return Address (RA) */

