Return-Path: <linux-tip-commits+bounces-3130-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A4D9FC169
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E527A020C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45A2135B2;
	Tue, 24 Dec 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06o9tDoy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IPESH7F7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD521322A;
	Tue, 24 Dec 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066427; cv=none; b=NoqNImHKBmIiE2XY4cYBaRh4UCswIVyjfiqqv7OvxVKbDG/KkewHcxVFsOBE2QwGsMP4DisY1KarR5TsfNecTIFdhvDsUmCvfcZEf4zmYY5reY1+7AVxWtvYiP7dac9GprPZe2GQI5duBj1Nv6jkdIGjkhQdd2yLJawsIgQMP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066427; c=relaxed/simple;
	bh=gclidnDckY8UrXHKyFvptKvkdxNniAmYptblxnCPkKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bwSN4E4pk7P8ywyebBXDuqPMuwZoZrp/3681fKAt1V4g7LnICQ56pX03e6GeodFZwrGGFiaaE1ZWroCe2dQaAsOaLIIbqcthFWU+3bUcCslGZgl++lG3LEpZ8KmzaNvEW977HTzCjwDKYzoxqxsT21WUVbitslAsFv+fp/9oUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06o9tDoy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IPESH7F7; arc=none smtp.client-ip=193.142.43.55
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
	bh=ltU3fxBhXzxZYaK9a2hrEh6xu40NgZ3WyFLkhtisV2w=;
	b=06o9tDoy2DOtJa1pr5q6NV1Ls5saN6TuZPM2A5A9f/oyqVpvGZCsMHXrysyP1noN+dVOhU
	5O2Yfvy5DreFga2+DyeAI6MMotvY4GWmbXI+oxMdoJKgEUrpD5mGAqUgnQ+WtkT5sHiM1b
	z9xFtESuWsp6Dce8CL4IiDFkoxp2LAMyTJnFdYBwmNHTzmDcHZpDtRcN5ZRvr1yTy3O3ed
	vieOHSTD+hFYkJZmvpHTZis7YDoSfykEy3WIeUy4pqpBRh6MUAjgtNnFavX0+xY1TtOBAZ
	X8GkB6aL9M5Soj1R9uiqRQWiRjwMG6EYMua6Pvm6mmqrbY8YLlCEqwKzIHSbzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltU3fxBhXzxZYaK9a2hrEh6xu40NgZ3WyFLkhtisV2w=;
	b=IPESH7F7r8zRpSW7K7g9FQDer5B2ZWteJr9CME0RTZml4KgEoHQ1AXQJIbd885aewqzNRc
	WHAnyaLodjrQAHAA==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] lockdep: Mark chain_hlock_class_idx() with __maybe_unused
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241209170810.1485183-1-andriy.shevchenko@linux.intel.com>
References: <20241209170810.1485183-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642348.399.12120028725569106884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8148fa2e022bae29f21bb9a2c4cc796334fd372b
Gitweb:        https://git.kernel.org/tip/8148fa2e022bae29f21bb9a2c4cc796334fd372b
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 09 Dec 2024 19:08:10 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 19 Dec 2024 13:57:53 -08:00

lockdep: Mark chain_hlock_class_idx() with __maybe_unused

When chain_hlock_class_idx() is unused, it prevents kernel builds with
clang, `make W=1` and CONFIG_WERROR=y, CONFIG_LOCKDEP=y and
CONFIG_PROVE_LOCKING=n:

kernel/locking/lockdep.c:435:28: error: unused function 'chain_hlock_class_idx' [-Werror,-Wunused-function]

Fix this by marking it with __maybe_unused.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

[Boqun: add more config information of the error]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241209170810.1485183-1-andriy.shevchenko@linux.intel.com
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2d8ec03..fe04a21 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -430,7 +430,7 @@ static inline u16 hlock_id(struct held_lock *hlock)
 	return (hlock->class_idx | (hlock->read << MAX_LOCKDEP_KEYS_BITS));
 }
 
-static inline unsigned int chain_hlock_class_idx(u16 hlock_id)
+static inline __maybe_unused unsigned int chain_hlock_class_idx(u16 hlock_id)
 {
 	return hlock_id & (MAX_LOCKDEP_KEYS - 1);
 }

