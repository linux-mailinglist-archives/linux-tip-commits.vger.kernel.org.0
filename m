Return-Path: <linux-tip-commits+bounces-2901-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21A9DFFE7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B144F281A30
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1361FDE1B;
	Mon,  2 Dec 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rnxj/7ZC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g5OLfERr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BF51FE457;
	Mon,  2 Dec 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138057; cv=none; b=b9hCBT3rmSZFrJ4ghgMyi1lb838JTowA8ocsyO6ZAW6UCgU6CXFOyO71pyyGv5DS7aOjkuhiWqUPiL+oTp+WUgD+m28korgqQ59KvlZQjWVgh3BEGjXmp2q+6fOlCnxAr9DfDq2sOOiLC89dBoz/qMv2Rtqe1o6GYZuF30CgUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138057; c=relaxed/simple;
	bh=lzt7pPTKstXABGSHYLlvoYXNiLgwkp28UxzoNRsFC30=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BDEnO2Fg7cBtp8THqylEGzfZ4LWiWHpFaBDfldS6SH2vzxH4kK9mp7YQeYCOQ4LQdipnFBHp4RJ8+PeuwfPGljjHAwEqYgfxLmxOvSQPD4wuUgwliNlnJJur5VmIdXf89S1mM6G3vGYYZqgEHAy7BQ1v0FJCeJ2eHwcHZOb6BXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rnxj/7ZC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g5OLfERr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A3VEs4wkFp4I/3zQzXL88mNejwAvy7W2xqIc3udvh5Q=;
	b=Rnxj/7ZCWe7PbuiZOlU0XsREQTM3W7qEeQ9wTlxpC4dA/Tv98fqDRiMaT9SgNruOIWiDWq
	E7yK4D7ARQNM9gnpAk9oYurZ01DQ6WzU8/clWceF2ctqfZOOvkG+s8bL2uvR4XOhmq/88Q
	gVdCoylf+UNwHlsZi8nKq2eyfrbIm8tfGzFXG/+RGpaBFdhxYyn8L2PHKKCM1ZSQihUP7x
	PLn4cBCgAdNTSGM1wr4kmgdBUox8mnNWQYGlLyY9ixku52rtnH6lkeOaOZU+u1A5BHIN6F
	7WPR4mfSoAN5ibNJrZGtJ9jVQ2tL74X3IJLgO9fzLb9BB0N4tXpJY3p496SaBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A3VEs4wkFp4I/3zQzXL88mNejwAvy7W2xqIc3udvh5Q=;
	b=g5OLfERrKYW5O9IChl/XVlXj9H6LYBNNrSQORfF3nvYdvitTKdW6hnDvaocRvokyAvv0wD
	WrijzJFPYe9YZRDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] mm/gup: Use raw_seqcount_try_begin()
Cc: David Hildenbrand <david@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805159.412.6588100615473123377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7528585290a1a1d4e0fb4b72261eb2d8c85de2d7
Gitweb:        https://git.kernel.org/tip/7528585290a1a1d4e0fb4b72261eb2d8c85de2d7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 22 Nov 2024 12:47:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:37 +01:00

mm/gup: Use raw_seqcount_try_begin()

David pointed out that gup_fast() does exactly what the new
raw_seqcount_try_begin() does -- use it.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 746070a..81ffbd8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3351,8 +3351,7 @@ static unsigned long gup_fast(unsigned long start, unsigned long end,
 		return 0;
 
 	if (gup_flags & FOLL_PIN) {
-		seq = raw_read_seqcount(&current->mm->write_protect_seq);
-		if (seq & 1)
+		if (!raw_seqcount_try_begin(&current->mm->write_protect_seq, seq))
 			return 0;
 	}
 

