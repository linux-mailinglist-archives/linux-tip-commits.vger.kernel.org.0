Return-Path: <linux-tip-commits+bounces-6277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD0B29F1C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AA017ACEB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE730FF22;
	Mon, 18 Aug 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LestEIg4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yir7DDiI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DD2C2378;
	Mon, 18 Aug 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512607; cv=none; b=l/k6NdRuQlhyw7p+2jXKjgFVuVpbnZNEGNumo5l8aOgmYMEYuDPuBF673rtWVTuO0H6Hy5PcMkRo/wCun55fOGeGsaVPeyMgBquxdXIB/ZpdM76CjEps6wYNfSMv5yOmMdkiowAEkNSdq4YEGm+5puxq9fhX9jigCodmk1LfHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512607; c=relaxed/simple;
	bh=ZpDjX3xzOP83YLMoWPCI46ORIH5pzJqGiE03qdVwWzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jNq+Qqo/6J3nKIAk+yh4Ra1g9PEwAqZfxqix/ZXlc7/OiWY1RJa0ruYwkdHwRUAyr+tirshW2CQ5b7Snp/usciCXjF6WPL3cLHnl5n1doyHRQxz7vEfMlnpf/4mOxIqRDUtd6fb1g8pgq5A+6KHT8GbGM30MIgVXaDUbdRtrSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LestEIg4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yir7DDiI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGN7c0TaFt7K2wgZrBYzalGZWu6xkfFU3eLWhGZl/7I=;
	b=LestEIg4B56BPbtJwuftj2+UAEenFI9aaSFy6E1zSTQMkod6A23/yelZDsmy07o0n+v0Sz
	3QYGRZLtTWUvaLQzhnuvWauPJmC7j4r2FUg/UDTxq81OyTPiHOeB2+IrTMnDYTaEci63up
	Lf6Qnh0098BAJiQuM4BL88d8YpzAX2U38ZzHYdR0prX6VH1nwgj/8WHLITrAy6jkZ1MEBV
	qIWyOPtFFk1AHwqSUK/SMEsA2GvW1K7R8k8XwTDptemsHWo6eXLi+NwgbRkY0/DFN2dUUk
	SD5Bgj2SqZbZlqApfWH0UvlKpkueGAlhTK075J30QuXS8Mgdkb6o5l55dFHlxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGN7c0TaFt7K2wgZrBYzalGZWu6xkfFU3eLWhGZl/7I=;
	b=Yir7DDiIC70mAcelJ121u8eoSNi2waZKhxGgIezBv59QYpHKk+elXE5KoHltAGNzEyXHge
	i7CEzsVRkrJEBRCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Remove redundant condition for AUX buffer size
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104018.424519320@infradead.org>
References: <20250812104018.424519320@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551260332.1420.6289156509216446637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e8c4f6ee8eeed8e02800bed6afb9aa22fc3476a1
Gitweb:        https://git.kernel.org/tip/e8c4f6ee8eeed8e02800bed6afb9aa22fc3=
476a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 12:38:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:12:58 +02:00

perf: Remove redundant condition for AUX buffer size

It is already checked whether the VMA size is the same as
nr_pages * PAGE_SIZE, so later checking both:

      aux_size =3D=3D vma_size && aux_size =3D=3D nr_pages * PAGE_SIZE

is redundant. Remove the vma_size check as nr_pages is what is actually
used in the allocation function. That prepares for splitting out the buffer
allocation into separate functions, so that only nr_pages needs to be
handed in.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104018.424519320@infradead.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8060c28..eea3a7d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7043,7 +7043,7 @@ static int perf_mmap(struct file *file, struct vm_area_=
struct *vma)
 		if (rb_has_aux(rb) && rb->aux_pgoff !=3D vma->vm_pgoff)
 			goto aux_unlock;
=20
-		if (aux_size !=3D vma_size || aux_size !=3D nr_pages * PAGE_SIZE)
+		if (aux_size !=3D nr_pages * PAGE_SIZE)
 			goto aux_unlock;
=20
 		/* already mapped with a different size */

