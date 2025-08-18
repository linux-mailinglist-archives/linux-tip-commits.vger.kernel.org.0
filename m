Return-Path: <linux-tip-commits+bounces-6270-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD7B29F02
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04949189B123
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D1258EEA;
	Mon, 18 Aug 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iF1uPOO2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kTwKKAYL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F6258EC6;
	Mon, 18 Aug 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512552; cv=none; b=jtw10q/QZm6MLIeUhO3tv/o0UnO1SP43XL7XM9icrqw66cylOYEKkv5YlHQdeMCEOYTr04XW2NOhOX4QWc/tiVAwkZnToeASIQ4xu+hZT47Y3eBoNxx6/QbPrAHTIKBuOs46mVUTODbFceyafgFBf41pkZNi/WDHnhSrQdwJu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512552; c=relaxed/simple;
	bh=ZvTMeJo+mNYcAgKsZl/ICQtQ10c2OblxXW8ni4MokaM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YySm8a9b/3RlnSQZigv8ooeHUXUEuCIJ0iPhP/q8nx0BChUbGB+ihxcgkyvPg9gci8iaztgqz3OQYYxt55Aahj1ExLfA8ThNe3n12di4nrCSsc7dl12m0HPC8smG0lCTF2+F3IwFjeoF1LgWtIy2tm03+utrBEpBwG08wZg9pwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iF1uPOO2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kTwKKAYL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4thFNGTvGc7jzAbnE4K9Bulg3ybY5Eczs28/Ibbras=;
	b=iF1uPOO2PLd/57e9A0Yq4/nKCbeu92WkLv+0T6RmCZped8eDSqV3Hjg4x5NXAo//FY/0Cs
	XSjmPIILH3BrJJO3eJFCdowl5+BrOie7tSMpjbaBhESAvlEdLJy3AKaWB2NtMhR90/dhmL
	ErscOipsiOVKCIIK/3J2D61eom50bOLXdrvR5+b6dcJ6d1o34o51iqpiPZEgchP6P7NLGs
	FnvbIFVJi4K6H3Fuh4FoHFR7sAXOXRdYZM6452nUEnLmxsk6ZfK9usAIol/5GCZFeNuZ4i
	qWAnoxbwW2RRGL6eWPqGbtUH9EHxFk5hlWp6nbCCU43T+7Hmw02JSQ2j3LrYzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4thFNGTvGc7jzAbnE4K9Bulg3ybY5Eczs28/Ibbras=;
	b=kTwKKAYLJKvGII3mO5PjVhQ1KAbcxfPnAk8xMK/bz/p/ADpuOK9J/fAHYi7hBQq081q8KJ
	p5XXoGhnfqNnleBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use guard() for aux_mutex in perf_mmap()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104019.246250452@infradead.org>
References: <20250812104019.246250452@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551254829.1420.17985179925554402194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b33a51564e3eb6c468979f9f08d9b4ad8451bed7
Gitweb:        https://git.kernel.org/tip/b33a51564e3eb6c468979f9f08d9b4ad845=
1bed7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:13:00 +02:00

perf: Use guard() for aux_mutex in perf_mmap()

After duplicating the common code into the rb/aux branches is it
possible to use a simple guard() for the aux_mutex. Making the aux
branch self-contained.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104019.246250452@infradead.org
---
 kernel/events/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89fb069..236c60a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6975,7 +6975,6 @@ static int perf_mmap(struct file *file, struct vm_area_=
struct *vma)
 	struct perf_event *event =3D file->private_data;
 	unsigned long vma_size, nr_pages;
 	long user_extra =3D 0, extra =3D 0;
-	struct mutex *aux_mutex =3D NULL;
 	struct perf_buffer *rb =3D NULL;
 	int ret, flags =3D 0;
 	mapped_f mapped;
@@ -7100,8 +7099,7 @@ static int perf_mmap(struct file *file, struct vm_area_=
struct *vma)
 		if (!rb)
 			goto unlock;
=20
-		aux_mutex =3D &rb->aux_mutex;
-		mutex_lock(aux_mutex);
+		guard(mutex)(&rb->aux_mutex);
=20
 		aux_offset =3D READ_ONCE(rb->user_page->aux_offset);
 		aux_size =3D READ_ONCE(rb->user_page->aux_size);
@@ -7161,8 +7159,6 @@ aux_success:
 	}
=20
 unlock:
-	if (aux_mutex)
-		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
=20
 	if (ret)

