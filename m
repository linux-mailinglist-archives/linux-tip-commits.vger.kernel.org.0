Return-Path: <linux-tip-commits+bounces-2902-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BF99DFFE8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE9A161879
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31E1FECB3;
	Mon,  2 Dec 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLpguRQb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kixHT5gk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C531FE459;
	Mon,  2 Dec 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138057; cv=none; b=EwAOaNRWJbqMTAMRsKi9VBle92OpLUofU9pIgR7SIdi8zT9rp0A4EwHqP1oJpRt99NgBdbOiN7eGlcJLra8tUdiemr7O3UyvCuKIaGMYqDyZUfKShOnXgu2CA1l4yGIWqkcRT7vg/u42pjdG9WRXF6zAFd7zz2Of4C7SHW//XLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138057; c=relaxed/simple;
	bh=ILR9jxXM/X/bG/Lf8pzdJNs5w77PE3KPz9cdeRLKaXM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pk4UTEiqB3Kwcz9ivfterR7+6qiQ4JmpCFAJsk2Volfyzw8OmBWtnPGwrgvRudtvtov3jkJXRowZw3R+dbx15Pl1+kcbpdA61gh5LYQY8TKEWxp5ITJGrtzCqdbibZflJG/iu/0gdfFAE2VpXngxZhT+xLGDCU22/rIf9GQgZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLpguRQb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kixHT5gk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7TgK8rr9woJIdwpD8Ss9QEIYokpHNLwZWhgGvUHsxk=;
	b=yLpguRQbwcJy/xBr/Rv8GrdjwGW1j/pw2Q+Gbf4d3emQc3P+susL5m2gawZ31Dgp3G7Y5Z
	GyGb51TiNEdB7MU60SqFax2JMjCh7fFEvwjlcIc6eaJNdYM7nRdh9HKXpT8wfiECPSfU+d
	2zwrbwEJYLflKScDsAan7DO+3naKvlBvoYruU4Q7VSenHxn8I06BZoYl5zgS4Iv0KMeOYJ
	C4/n/SzG+v0FdBcuMG4ML4nzWTX9UoDOlF8I/yomXMxb99gAeYsyyLwLgNI5FtW4VTZgQR
	Tq3Zt9dFU+MmzTJaMeWu6rn1N5lQb3sdRXYg1oWTnhH4hNlyCrpo3HCuic8Kkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7TgK8rr9woJIdwpD8Ss9QEIYokpHNLwZWhgGvUHsxk=;
	b=kixHT5gkwrdAdtm4S/1GrD847WfjmV6ezNptGic6gi32OZx7Q48rO0tQ5mF+ZinXyvO1ob
	q1krdNiQZZLghbDg==
From: "tip-bot2 for Suren Baghdasaryan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] seqlock: add raw_seqcount_try_begin
Cc: Peter Zijlstra <peterz@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241122174416.1367052-1-surenb@google.com>
References: <20241122174416.1367052-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805232.412.4199140261774535165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     96450ead16527cbef559b5bd046182e731228f95
Gitweb:        https://git.kernel.org/tip/96450ead16527cbef559b5bd046182e731228f95
Author:        Suren Baghdasaryan <surenb@google.com>
AuthorDate:    Fri, 22 Nov 2024 09:44:14 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:37 +01:00

seqlock: add raw_seqcount_try_begin

Add raw_seqcount_try_begin() to opens a read critical section of the given
seqcount_t if the counter is even. This enables eliding the critical
section entirely if the counter is odd, instead of doing the speculation
knowing it will fail.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Link: https://lkml.kernel.org/r/20241122174416.1367052-1-surenb@google.com
---
 include/linux/seqlock.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5298765..22c2c48 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -319,6 +319,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 })
 
 /**
+ * raw_seqcount_try_begin() - begin a seqcount_t read critical section
+ *                            w/o lockdep and w/o counter stabilization
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Similar to raw_seqcount_begin(), except it enables eliding the critical
+ * section entirely if odd, instead of doing the speculation knowing it will
+ * fail.
+ *
+ * Useful when counter stabilization is more or less equivalent to taking
+ * the lock and there is a slowpath that does that.
+ *
+ * If true, start will be set to the (even) sequence count read.
+ *
+ * Return: true when a read critical section is started.
+ */
+#define raw_seqcount_try_begin(s, start)				\
+({									\
+	start = raw_read_seqcount(s);					\
+	!(start & 1);							\
+})
+
+/**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants

