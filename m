Return-Path: <linux-tip-commits+bounces-5960-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A17AEF9EE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 15:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B493A351A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE0F274661;
	Tue,  1 Jul 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSlb+b/n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yaUBwECi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E9223707;
	Tue,  1 Jul 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375588; cv=none; b=Sz2Mq8wrdl0a7AmgeFSoTqUfu9/5EjmrX4oFD1/ck03GEcM31S28uonj2qjPLStHLkK59q9CCpgR8Q6fg4CyfKerWN2VhICMbeiaTke/EvbyjCkubg66RL+1dLudk0nLz8LkMb2qy67mtqtOZpB3V+NZZrABAOfzfb8oUAcDjOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375588; c=relaxed/simple;
	bh=2nY97p2ezv4MKCk3SCoybkwWRea1b+L0nV7u/UCzP1M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZJPyQbEtacF41kM9IjJffSBWqWHVm/kUQPA84ievOlpveK9ZYNkEduklBwwJ2+cm8Em/UbSWM8/luxMJAGjRIxiDegO8/P9te4A9BqIVyXvFPC0qrmo9H+2rDKGSXmXeJO9Aity76EW28UHC0XhwqTx/ckYTnACx5bzumbZR+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KSlb+b/n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yaUBwECi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:13:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751375585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqjibRlqL4DqO6rw9/CRbzEzVjj53CxLkAdcv49MGL4=;
	b=KSlb+b/no60PwW0HNU22ANiQxsW7jecGlxrBa9HImE4a1BQE+eXZV/fnryO4+JBWQBIwso
	S0P7Q4314tKW8iGYErT7yd+xgwXrdRfvejynf65JuXpplN3kEdnlDKbdiQa5ADev5M8QoH
	7EVFPV08Z1DQpzd2G+BHBoiN/xyqZhBY5ygF7mvRe49l2x7/WfXz3mg2cOAi/JZE/CeJpb
	X9JMtD8p1rv129mDo4Nnu4QUyblPjf11Cs6CQOtTkHWn91ijPmm8qhjXyQXz0sByyxVUJ/
	W3eXxychrJiN+2yNxx8lpxt7baphp07aGn/RZmWNOMcW1mB7T7Y+oaDe5NUxvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751375585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqjibRlqL4DqO6rw9/CRbzEzVjj53CxLkAdcv49MGL4=;
	b=yaUBwECi9uclK9g33lNu/hwjmHcptazb2c6/MlsAcoiYQNybAQDZhOaNUQZKMN9lE4S+sx
	paaa7vmca2FVSPDQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Temporary disable FUTEX_PRIVATE_HASH
Cc: Chris Mason <clm@meta.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250630145034.8JnINEaS@linutronix.de>
References: <20250630145034.8JnINEaS@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137558397.406.5841065111175109427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     9a57c3773152a3ff2c35cc8325e088d011c9f83b
Gitweb:        https://git.kernel.org/tip/9a57c3773152a3ff2c35cc8325e088d011c9f83b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 30 Jun 2025 16:50:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jul 2025 15:02:05 +02:00

futex: Temporary disable FUTEX_PRIVATE_HASH

Chris Mason reported a performance regression on big iron. Reports of
this kind were usually reported as part of a micro benchmark but Chris'
test did mimic his real workload. This makes it a real regression.

The root cause is rcuref_get() which is invoked during each futex
operation. If all threads of an application do this simultaneously then
it leads to cache line bouncing and the performance drops.

Disable FUTEX_PRIVATE_HASH entirely for this cycle. The performance
regression will be addressed in the following cycle enabling the option
again.

Closes: https://lore.kernel.org/all/3ad05298-351e-4d61-9972-ca45a0a50e33@meta.com/
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250630145034.8JnINEaS@linutronix.de
---
 init/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f0..666783e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1716,9 +1716,13 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
 
+#
+# marked broken for performance reasons; gives us one more cycle to sort things out.
+#
 config FUTEX_PRIVATE_HASH
 	bool
 	depends on FUTEX && !BASE_SMALL && MMU
+	depends on BROKEN
 	default y
 
 config FUTEX_MPOL

