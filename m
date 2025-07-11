Return-Path: <linux-tip-commits+bounces-6099-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D9FB023C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 20:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CBA3A89F2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FEF2F433F;
	Fri, 11 Jul 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xoHFkKwH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MH5t5HLk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B12ED842;
	Fri, 11 Jul 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258820; cv=none; b=MGdPddBCLnyawIq5WoA7cXiHBjWPL2Y7Xp05NUtFKVJWROjHibOs1ItK8Siv2iJrmzVkQwO0M43QgTMjYQ+HjfzzcmiGgx6zVFwRgvu2hxlRmSyIS6UY+ZXwsPr1Y1/v0uk20ifeAEfp1jXT/NTM4rtdsQjYjkDUNIf8M0EaIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258820; c=relaxed/simple;
	bh=e9gvB+O8OZX2NBE3c8IIviSfcPt6c/aJQ1RUn5Y+KyU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XEa7jw15vWNc4SsrfwYibjy8sbyuIw4lFxUYmxN5hVZapSWjXAMUQeRRmFyUIOwL9bQKhtIMqzDGBzU5m7+C4FQ9YEkL2dTIcOp/6R45IWe/7am8fV79QUn6LEMcUsdRy9DUAzmxoedDUYaRk5T/7YyMz1ohLfNtrdgEvQhes8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xoHFkKwH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MH5t5HLk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 18:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752258816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QMbdFy6PykNM1UlKfaVoOBth9l9nxWZJFD/SHcrsoQ=;
	b=xoHFkKwH5KPQa7AAqDk+uuRmNEIo6f1e5lpGsF8W2t8PQ2S24BEFspKzLznYChPVLnLXqO
	RCARafLYuu8pF3lSDFZSBfsSHUqjgdIBacW5WL5cyYbc1g4nMq/QDXZf/mFGbmtxUcY7XG
	DIfmRnOlOY6Fod1ByO+lkZkSFA2ZPqkKzjsr/l+dOAd+Wqq2GgVKyk7LL08EjGJuJP5BL+
	jHdRvlcfSsgj2fcBBfy+tmIrYVnpWoVJZGcTQurgjJ6313y6kEn6um+x/56CLovVcXdfNZ
	coRxdiFp+M1AYQDvgp9Y65Skqq2RhIz5WTeEvNUwGsRHIkhus+TPyAW0lC5O3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752258816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QMbdFy6PykNM1UlKfaVoOBth9l9nxWZJFD/SHcrsoQ=;
	b=MH5t5HLkm+GF8qLXO/egCijtc4QWwc93t7eilNZM+BquoKlqDad2WCB/q5FVfbkvnAs3w3
	mUyBGXqm5DYlbFCw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Make futex_private_hash_get() static
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710110011.384614-4-bigeasy@linutronix.de>
References: <20250710110011.384614-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225881557.406.17935036464523466062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     fb3c553da7fa9991f9b1436d91dbb78c7477c86a
Gitweb:        https://git.kernel.org/tip/fb3c553da7fa9991f9b1436d91dbb78c7477c86a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 10 Jul 2025 13:00:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Jul 2025 16:02:00 +02:00

futex: Make futex_private_hash_get() static

futex_private_hash_get() is not used outside if its compilation unit.
Make it static.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250710110011.384614-4-bigeasy@linutronix.de
---
 kernel/futex/core.c  | 2 +-
 kernel/futex/futex.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1dcb4c8..1981574 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -143,7 +143,7 @@ static inline bool futex_key_is_private(union futex_key *key)
 	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
 }
 
-bool futex_private_hash_get(struct futex_private_hash *fph)
+static bool futex_private_hash_get(struct futex_private_hash *fph)
 {
 	if (fph->immutable)
 		return true;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index fcd1617..c74eac5 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -228,14 +228,12 @@ extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 
 extern struct futex_private_hash *futex_private_hash(void);
-extern bool futex_private_hash_get(struct futex_private_hash *fph);
 extern void futex_private_hash_put(struct futex_private_hash *fph);
 
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
 static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
 static inline struct futex_private_hash *futex_private_hash(void) { return NULL; }
-static inline bool futex_private_hash_get(void) { return false; }
 static inline void futex_private_hash_put(struct futex_private_hash *fph) { }
 #endif
 

