Return-Path: <linux-tip-commits+bounces-5466-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62540AAF7E3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A01C06400
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26D4218AA5;
	Thu,  8 May 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kDPDzh+m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+GTBY9L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4220E007;
	Thu,  8 May 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700430; cv=none; b=giLR14uCcukmXVPo73lIBP0cqgt8IzbnDU63uVMXGZFxiV7Bn+XXCNsoZlMLovVt5qVKsQTS0QUDdBwWNdiGtpSZDjt92n9X/SKv6EnZxxtqS3uNUm6ABAx1rzNFGt9ftw81g8WyuNstRqDhQ0eC4ENV4DylMjwN3eghRQGXX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700430; c=relaxed/simple;
	bh=2Dh73QljJYFFGAZ7FHDhX0pzQpsyCy4v1eyRcffYXG8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Y/8vvgnt72jtrrk0T8yItvBiEPFuluvJcqaGWplDSrs3HmhsauloxnHd4Y2WYqVhkGNjSg3cOWPk0FILjjxIsxUhK8U4lo61NukUQiA31nQasqaTjoyKUie301KQ8ilXM8fzSVz+krXNXixEaseECAa+g24H2VFlaI5HwySfBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kDPDzh+m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+GTBY9L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hQPujVOfUpzQLwg6ZPFZrIIeGWWTi1XB7EqS2hsDsWo=;
	b=kDPDzh+mGZT4gbArQN6d5YRoBf6VbIGUSwKml5S7/QKr/kyxz1U/GFuaBy1bxhnUni4dw6
	HJzDAzbGRqsAZBdgrhI6QndzX81wrQSXNxhWy12JB50XKk5eNQDZXJ40ITQD/uCwItfb7V
	5I+IaRN5SnQTSl0gi4f5gcvuLeHj37d57IM8CSnU0szxoTWF8FWCd9rGxrspm5HHjdNrI/
	OW22qG5CluuPTLxJ7d0ckp+GJOLHBbp62YXYATkl6S4TUkfKTaHgfZUyKm3AePDgJLIHo5
	8954Za4F9ZGYuCcrcJWHsBBZOEFX81kAH4iWGIGATraXaY6lt0sO+bUfrtmk5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hQPujVOfUpzQLwg6ZPFZrIIeGWWTi1XB7EqS2hsDsWo=;
	b=p+GTBY9LpRyoG2pDlJ6wZ4iD5buXY1dX8HYYmCSrLJez2FNm3d9wQgFsGe0FCM4u3VY4XQ
	bEILaOGuimojSfAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Build without headers nonsense
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670042648.406.1017155963048464231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     8b4a5c2497fad653bc54ddb037d38eb5bf835857
Gitweb:        https://git.kernel.org/tip/8b4a5c2497fad653bc54ddb037d38eb5bf835857
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 02 May 2025 20:57:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:10 +02:00

selftests/futex: Build without headers nonsense

Make it build without relying on recent headers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/testing/selftests/futex/include/futex2test.h | 18 +++++++++++++-
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index 9d30552..9ee3592 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -8,6 +8,24 @@
 
 #define u64_to_ptr(x) ((void *)(uintptr_t)(x))
 
+#ifndef __NR_futex_waitv
+#define __NR_futex_waitv 449
+struct futex_waitv {
+	__u64 val;
+	__u64 uaddr;
+	__u32 flags;
+	__u32 __reserved;
+};
+#endif
+
+#ifndef FUTEX2_SIZE_U32
+#define FUTEX2_SIZE_U32 0x02
+#endif
+
+#ifndef FUTEX_32
+#define FUTEX_32 FUTEX2_SIZE_U32
+#endif
+
 /**
  * futex_waitv - Wait at multiple futexes, wake on any
  * @waiters:    Array of waiters

