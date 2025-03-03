Return-Path: <linux-tip-commits+bounces-3812-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D82A4CB5A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12993AF201
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D52356AF;
	Mon,  3 Mar 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9P653Gl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0zPtBW6F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE5233127;
	Mon,  3 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027928; cv=none; b=SbIWe/ojPmerNpg4p5V7EGa5SdAJWoQja80B6NPBFgXrvS1ize/BxsFY5RXUBEfHMnKwmuQa1rihjn0W6wZOltSyuFwQ87l6hHAKcRnTs6tHB7mo/T50PtxyoFjmibiHJ0w1BuOYEQxSq2ZdLjlNlTyNWim9lovtQuFhUF9Oghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027928; c=relaxed/simple;
	bh=P8JjpmBGSMC12xfr/Tt2eGBY7j0RQn0ktBCZKj+30fk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cf1M1C+lGxKlmHXhCoLJpmPanTf4JaWsvCcnemYEJbF7vHO0ZGpwukE1Lc3sCEx/ujHDtRe6IYGyHvwmRcJJyfSS0yu3E+CyFVyoE2NYqJyzGhdj1zmYNWTpKRF+KtvPnyGj74/f4VtqSyjRtIocMADi6QVeWU42sFMRrFNerIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9P653Gl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0zPtBW6F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbDlsPoF7JTnZ1gd9PXAKR4TeHQGnU2C52AmTQNlDyY=;
	b=J9P653GlRYbGkXbbkii437Y3bnMDxaDmUbQ/F/8vgJbiSljR3IPVf11Iv7oQaNkxGKF2W0
	ua7uUXgkAkJUJFLcOa6McR1Oae6mOTqLU8bggxfAOlp7pggVpfRPqgTesgmcqV+1ImsQM0
	o8URgkxcjkt+Zs2XOMIrymJrY+/m+1vFbOEvcvLIeLu6NrFiGBT83IgXHg98s09pkKBGNp
	BGwx//NO+Nr68mtdF7KzYEEapQ0aBZPmC1iHlRBoCVWXfkqqv8DYJrh2DAys/u/0agektE
	vXeQSAwFmKpbz0zFk1ATsPn8/xtQseNWZfe7Ihm99s8ni0d4DwHGUz1dwi/oFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbDlsPoF7JTnZ1gd9PXAKR4TeHQGnU2C52AmTQNlDyY=;
	b=0zPtBW6F4dS2J6dfK0jk2cZ+nNJnbAnvMr6jreT+n5VAzam+ZhKgaS62PjiwzA+6+7I0AM
	0S+niJkyKdJFSTBQ==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/rtmutex: Use struct keyword in kernel-doc comment
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250111063040.910763-1-rdunlap@infradead.org>
References: <20250111063040.910763-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791971.14745.2138427753135317856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5ddd09863c676935c18c8a13f5afb6d9992cbdeb
Gitweb:        https://git.kernel.org/tip/5ddd09863c676935c18c8a13f5afb6d9992cbdeb
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 10 Jan 2025 22:30:40 -08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00

locking/rtmutex: Use struct keyword in kernel-doc comment

Add the "struct" keyword to prevent a kernel-doc warning:

rtmutex_common.h:67: warning: cannot understand function prototype: 'struct rt_wake_q_head '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250111063040.910763-1-rdunlap@infradead.org
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

