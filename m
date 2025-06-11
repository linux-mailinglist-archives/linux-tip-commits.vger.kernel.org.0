Return-Path: <linux-tip-commits+bounces-5770-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DC3AD5905
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3071BC177D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6351865FA;
	Wed, 11 Jun 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YxpZXFvc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2ErQNxJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F6D230BFC;
	Wed, 11 Jun 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652762; cv=none; b=IXgqG2jMfNnn8O4iNPg+Pna+LdUiV/4xgbMliEk3ogxb3DZpIwT5fXkjjG3JbukhEa7quKTH1OBJVqWbyuGqv5Iw6iyg8FBjvUCkzE03qd7X16sqID4wbYoCyFp41eEYKEHndiVDUfloKGxd864S5sBB3IT4sa23xfSLEFzI9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652762; c=relaxed/simple;
	bh=NT4yhlGXocscf1t4C1zlD9/UZuoRU9iB1+/1BodA9e8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JgONqmCgSrtJw2R+bvEtpNGlOLFQEJ49N7K5UJJf48lIHwSBK7H//i71IRej95L4/nQXgIOm6B48sZB61Df0Ac6Kzun00WipuAXtZm7s5yVCgXrU8ffYQu7GZB6a4fv5lF1S22e1Lxx0A2RHzYGzdvorIcsyW1GZejZF5UCNk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YxpZXFvc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2ErQNxJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 14:39:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749652757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mj4oYGVkdG1UcUnYYrQDLR7MSud5DamCI5zqztVORf4=;
	b=YxpZXFvcLCZ0inU/DIOiYSpxWKqwmGabZh2VWIeghbdUd+8ibCw/jhXZwTirzU2B2xlHDv
	ckXnli5tm8qKAP+qq019Nlbq55B8vNV++tNJlp7ZvFbAQNXCWp3cUGfjTtcb1ZmN9scv4A
	Y5OXOaRlQFyp4GbrNgaU6LS10SKfEqX5LarYzhPe3cuXD+9N9N51iuZrhDtf5ZKyFPE4Dm
	Sc5DfhCefY/84uNWZc2XaeLI/LFBemtWmRGJWpCr8eMWH45SoEO4g5+p6GFrLUNSqrL08o
	CoK/EnO2nmTeR073b6c+/QL3PSDIWADB5POXHU/IJKIUCw/ls5yNURHh5Zq61w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749652757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mj4oYGVkdG1UcUnYYrQDLR7MSud5DamCI5zqztVORf4=;
	b=C2ErQNxJ38xU4NEcqL7ts5ylv+NG8Kduyygpodx/FwYrwuhYuMTjcl+z6JCOdbjZKXxcuk
	BapDj9C3LW0Q0OAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Allow to resize the private local hash
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602110027.wfqbHgzb@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     703b5f31aee5bda47868c09a3522a78823c1bb77
Gitweb:        https://git.kernel.org/tip/703b5f31aee5bda47868c09a3522a78823c1bb77
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 02 Jun 2025 13:00:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 16:26:44 +02:00

futex: Allow to resize the private local hash

Once the global hash is requested there is no way back to switch back to
the per-task private hash. This is checked at the begin of the function.

It is possible that two threads simultaneously request the global hash
and both pass the initial check and block later on the
mm::futex_hash_lock. In this case the first thread performs the switch
to the global hash. The second thread will also attempt to switch to the
global hash and while doing so, accessing the nonexisting slot 1 of the
struct futex_private_hash.
This has been reported by Yi Lai.

Verify under mm_struct::futex_phash that the global hash is not in use.

Fixes: bd54df5ea7cad ("futex: Allow to resize the private local hash")
Closes: https://lore.kernel.org/all/aDwDw9Aygqo6oAx+@ly-workstation/
Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250602110027.wfqbHgzb@linutronix.de
---
 kernel/futex/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b652d2f..33b3643 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1629,6 +1629,16 @@ again:
 		mm->futex_phash_new = NULL;
 
 		if (fph) {
+			if (cur && !cur->hash_mask) {
+				/*
+				 * If two threads simultaneously request the global
+				 * hash then the first one performs the switch,
+				 * the second one returns here.
+				 */
+				free = fph;
+				mm->futex_phash_new = new;
+				return -EBUSY;
+			}
 			if (cur && !new) {
 				/*
 				 * If we have an existing hash, but do not yet have

