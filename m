Return-Path: <linux-tip-commits+bounces-3131-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 836339FC16A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79AC1884BAB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7442135BC;
	Tue, 24 Dec 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7W5FbT4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGd8JP7S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C221213236;
	Tue, 24 Dec 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066427; cv=none; b=avMFDMy5Ckp6fYoVfDsZtBu7q5H/Y9K9b4k4pvz1TJuLfi17U4o0WVEUY4mqB6bAo5FVJycmxtDKQ9CfT3V+M4MFa8XQn52Qm0izzlXdQLADSlsD6OShhu+I1Sy7pobLX7qyVCGyldjJH26PKn839/Lk81HYXd91aYtVUA0rvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066427; c=relaxed/simple;
	bh=gBvMBbM3lxvnxQU38K8gDFdRX90vH+tzChwlqLGPC3g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dNgFfnA131U6zXJFvWU28Uj0PoZgEc5rObyaoZahJoUacJ8koDZv5i/lqMFOkaFezr9KAFxz/9IsJnHRCxAi2s/7skawbvRCuLOaLL/eJLn/coU8bRPAKFhbYzmAyU/Q6p9o0iu7+oM/U7BFL2WrR4B/i08z9Xkt3z7obwDHFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7W5FbT4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGd8JP7S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPZFLBphBzj38jtD+JP1f3TYazJyhjf2KOXAO9wC/S4=;
	b=N7W5FbT4JHOWGmsV3fwBlXXtIGPLLvV3OnXI42mVmf2nTpoz9ni6CbCtpJWFzypYF99ZNp
	l2GuMqS4gFuKJx2UZRpZPx4/rquMZsVIf97GANR4iydf+OQm5W81AYqpYSkD2S9PC9buyT
	qDXVKBM064bewPG88ffpmyTaB1jucmOATGPRJd8tUaWlD/kEXn+tENwvAfkElNWRU6o2fz
	2PeKgrty5hBQKVVdXr8kdaiHPxYFUkgF9cEI0E2ss2xbqo5oXOyYnk/hU+5GNpF866ltP9
	8fa+Bq01bWvt2jS+SPpLVVfGCjV/JSfQGcrxIu642T4emxt6qoiDszUgMrsM+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPZFLBphBzj38jtD+JP1f3TYazJyhjf2KOXAO9wC/S4=;
	b=zGd8JP7S/M0zSPFhsDf6wzykjGiVMOb0s94KXjRijDFvwoao7iD9njo1i0JchpDQTqWSbq
	b2amCzSrRsI9xWBw==
From: "tip-bot2 for Carlos Llamas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] lockdep: Document MAX_LOCKDEP_CHAIN_HLOCKS calculation
Cc: Waiman Long <longman@redhat.com>, Huang Ying <ying.huang@intel.com>,
 "J. R. Okajima" <hooanon05g@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241024183631.643450-4-cmllamas@google.com>
References: <20241024183631.643450-4-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642386.399.10857863846814476355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bd7b5ae26618ad2bd6f6264e2cb6c5815d323e75
Gitweb:        https://git.kernel.org/tip/bd7b5ae26618ad2bd6f6264e2cb6c5815d323e75
Author:        Carlos Llamas <cmllamas@google.com>
AuthorDate:    Thu, 24 Oct 2024 18:36:28 
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 15 Dec 2024 11:49:35 -08:00

lockdep: Document MAX_LOCKDEP_CHAIN_HLOCKS calculation

Define a macro AVG_LOCKDEP_CHAIN_DEPTH to document the magic number '5'
used in the calculation of MAX_LOCKDEP_CHAIN_HLOCKS. The number
represents the estimated average depth (number of locks held) of a lock
chain. The calculation of MAX_LOCKDEP_CHAIN_HLOCKS was first added in
commit 443cd507ce7f ("lockdep: add lock_class information to lock_chain
and output it").

Suggested-by: Waiman Long <longman@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: J. R. Okajima <hooanon05g@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Acked-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241024183631.643450-4-cmllamas@google.com
---
 kernel/locking/lockdep_internals.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index bbe9000..20f9ef5 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -119,7 +119,8 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
 
-#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
+#define AVG_LOCKDEP_CHAIN_DEPTH		5
+#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS * AVG_LOCKDEP_CHAIN_DEPTH)
 
 extern struct lock_chain lock_chains[];
 

