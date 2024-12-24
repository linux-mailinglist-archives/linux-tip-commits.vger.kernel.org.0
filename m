Return-Path: <linux-tip-commits+bounces-3133-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7C89FC16C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE8C165A37
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFED2135C9;
	Tue, 24 Dec 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eacJNjEt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HXAU0Upj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE821323F;
	Tue, 24 Dec 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066428; cv=none; b=IUom5QpOJWyPA0W2+CSdhM5+Q2LECMlE4pbd41nl8aFW2MUGv2v2RWUD90R6NA5F4WEmvDO8O8kHF7SoLjvSqBKztpBQFF81c7NtQ0sa68QL2PoUJHmy+35pP7b4Gvn/aXTpR95TXQL2c0hQQA+fUY/8beo752hkDEbrttPfXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066428; c=relaxed/simple;
	bh=6Etm16hPqcVCrrD59O2PJ5FNAYPiylhkr4xGjYwqJBc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CXHNEcoKzCBfdo4Z0B7ZPyF0UYQ82eR/l2fDQK0jR27r62mcFhHJma//G6aJ5xEctzCNeoDShk9rTzYDVQXPT7+qMMtnk6f+HlRs3F8Y/mbowqo3hxiJxr9+/ftdptNPuSqxdZ+1UFxzSUuf/mw422t7yXipIUUfhDD2usTM0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eacJNjEt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HXAU0Upj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpgJz5I4+EYD1KDvRuLL7C3mI5i+SauTXXasZTv40sc=;
	b=eacJNjEtqQYXOxsusVyQM695YkXaasWCBaFhfgafoaQIGsDVm8xg1o8zXNykS72/SQqfCK
	9OiQbzcjylrh54Tp3UoUGDs9Us4xRWB73l4aW9/ghQygZF1NZ0GSIhpsIZA1nTM7jaIJs1
	RY2Say6X70Uwv9F84VhgWKMwvK3lWPh77g51DOM5OvZzmVQ9AUa5wHyTM1iBYvK7KhL0xz
	R11yF5vKeClruoVSnn56LRDcvWrxmsZhjLBrOnxhKHx8ot+qgTUvHouPa72MwMYsRZ7ZHk
	Ak9irRIF3cI553ntiwCLiz3sEu06Q6UpMtRQd6dHSusUggfOHbRFCtP+Fsaotg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpgJz5I4+EYD1KDvRuLL7C3mI5i+SauTXXasZTv40sc=;
	b=HXAU0UpjudwFpx2y/XD+3Wbg20vhYjqTylTW+NAD0EPZk9G0xvBhXrRjaCuivaDMbMRx1a
	uv018fmEUcr5nuAw==
From: "tip-bot2 for Carlos Llamas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Clarify size for LOCKDEP_*_BITS configs
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241024183631.643450-3-cmllamas@google.com>
References: <20241024183631.643450-3-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642427.399.15194752914482242671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     88a79e88a97cb9309bb48a472be2bf1316d40adc
Gitweb:        https://git.kernel.org/tip/88a79e88a97cb9309bb48a472be2bf1316d40adc
Author:        Carlos Llamas <cmllamas@google.com>
AuthorDate:    Thu, 24 Oct 2024 18:36:27 
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 15 Dec 2024 11:49:35 -08:00

lockdep: Clarify size for LOCKDEP_*_BITS configs

The LOCKDEP_*_BITS configs control the size of internal structures used
by lockdep. The size is calculated as a power of two of the configured
value (e.g. 16 => 64KB). Update these descriptions to more accurately
reflect this, as "Bitsize" can be misleading.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241024183631.643450-3-cmllamas@google.com
---
 lib/Kconfig.debug | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7635b36..cf2a41d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1502,7 +1502,7 @@ config LOCKDEP_SMALL
 	bool
 
 config LOCKDEP_BITS
-	int "Bitsize for MAX_LOCKDEP_ENTRIES"
+	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 24
 	default 15
@@ -1510,7 +1510,7 @@ config LOCKDEP_BITS
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
 
 config LOCKDEP_CHAINS_BITS
-	int "Bitsize for MAX_LOCKDEP_CHAINS"
+	int "Size for MAX_LOCKDEP_CHAINS (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 21
 	default 16
@@ -1518,7 +1518,7 @@ config LOCKDEP_CHAINS_BITS
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
 
 config LOCKDEP_STACK_TRACE_BITS
-	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
+	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 26
 	default 19
@@ -1526,7 +1526,7 @@ config LOCKDEP_STACK_TRACE_BITS
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
 
 config LOCKDEP_STACK_TRACE_HASH_BITS
-	int "Bitsize for STACK_TRACE_HASH_SIZE"
+	int "Size for STACK_TRACE_HASH_SIZE (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 26
 	default 14
@@ -1534,7 +1534,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
 
 config LOCKDEP_CIRCULAR_QUEUE_BITS
-	int "Bitsize for elements in circular_queue struct"
+	int "Size for elements in circular_queue struct (as Nth power of 2)"
 	depends on LOCKDEP
 	range 10 26
 	default 12

