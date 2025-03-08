Return-Path: <linux-tip-commits+bounces-4069-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1919A5769A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC3D165435
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892B12CD96;
	Sat,  8 Mar 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ql1/axWf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7wSkLcpz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540784E1C;
	Sat,  8 Mar 2025 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392498; cv=none; b=jFnDXZ5E7Q6QVOXdbRdmiG4HC5BsIOAgC0lXOJbpwUNVDHerxCId+q2FE6/owHEIbnkbpM8ng8ANyZvGgGJ1yAMu52Z6qTRcJVUHc3sI6oD1KxJw1uMoGhqaptI5bxj/f9x8gDAct6p/2Ldxq+US/xNSJnS6f8ID1mgqLhMyyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392498; c=relaxed/simple;
	bh=HdmSHcx2wzpHaeQvo8RfP82XOwo3n+e2XZjt5FpDBi8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JHvLtdlKRyvwZLatt7vQ+1FwQnpWNYohkUVT3ouQXpjth2fc/peDAsPSaYDifk+dSi3tGyBa8QX9eBrcpFhQMBJs/gk8iqBeP8Rz6nQbXsz6RP3OZduQsz5iBdwwDrXu64ve0zcGfb3FQU3IHX+IDVEcFlX6GquTKgDayKCGBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ql1/axWf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7wSkLcpz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bF3yqIcpkk+pl8kAXpCbTpieac0WewbNoMKXtQLXspg=;
	b=Ql1/axWfZfS49N66M+rve9jj+n9SQ8ElX4lKnyQWXwQRAkJoQyQrNl4Aovr9KI1vDMy+Jh
	6g9ljP2aHnQwJ0shGvrzwNCBaJTpIuWQz16Gko1XpdgYCDxiOA6UFzwNtmYo2S2+eneNpa
	28bx9D5kzkupnSLXrKv/uSveYPaJn/M1FKPfmt/gdPzFywdsq0PszLDhm8errZlzQRnJxf
	SYAvTCEzzDFiYjAQcAjy+H/jkHMHBKZRzCHBFKze3v/yP9r4ITKapTXzQD4l3pUmQQ0pOf
	hiWucAinr012WIPcj8aS+6FXcC3MQen9rIkYr+gNabGvKTwHgtTKXin6HRq6qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bF3yqIcpkk+pl8kAXpCbTpieac0WewbNoMKXtQLXspg=;
	b=7wSkLcpzuh+d7nGlybvYbk6df2ztqFk2ai+wujjyiA/hXa/985Z3Fqw0RAZnn7T7j2VFqA
	WtcOqaBauDuccyCg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Use the 'struct' keyword in
 kernel-doc comment
Cc: Randy Dunlap <rdunlap@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-2-boqun.feng@gmail.com>
References: <20250307232717.1759087-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139249399.14745.14674916369094609023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b3c5ec8b79bf6bc49cc4850d0949d712830283d7
Gitweb:        https://git.kernel.org/tip/b3c5ec8b79bf6bc49cc4850d0949d712830283d7
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 07 Mar 2025 15:26:51 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:52:01 +01:00

locking/rtmutex: Use the 'struct' keyword in kernel-doc comment

Add the "struct" keyword to prevent a kernel-doc warning:

  rtmutex_common.h:67: warning: cannot understand function prototype: 'struct rt_wake_q_head '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20250307232717.1759087-2-boqun.feng@gmail.com
---
 kernel/locking/rtmutex_common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c38a2d2..78dd3d8 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -59,8 +59,8 @@ struct rt_mutex_waiter {
 };
 
 /**
- * rt_wake_q_head - Wrapper around regular wake_q_head to support
- *		    "sleeping" spinlocks on RT
+ * struct rt_wake_q_head - Wrapper around regular wake_q_head to support
+ *			   "sleeping" spinlocks on RT
  * @head:		The regular wake_q_head for sleeping lock variants
  * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
  */

