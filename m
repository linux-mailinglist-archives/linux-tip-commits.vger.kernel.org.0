Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF222CD3CE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbgLCKgh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 05:36:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40044 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbgLCKg3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:29 -0500
Date:   Thu, 03 Dec 2020 10:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606991745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rna0B90N/h2bYrP3o3itAIfub8/ycWxk6K5Qbfw2CTg=;
        b=ZTHRxaFd4M/QK8cHkI9klUVp2FPs7OvAWcA13wTw0AmwvX7KD2kv05gPm57t8k3F9NTpP6
        z+ARYMliwyQrzwhe6MnE0klDuwZktxSwgiUmf3SHFHFiSCg/Pxr1nSv3zc2+K6AM3TPTtW
        LcpeTl0BKBhQyoFrm9rbqqc8XPTaWzA8D08jSr09ezSR1YjX75f0CeKbd0cRdSxm9PZ9qh
        TzLEaZH48ZVugqJeK3DizimwhCajzH4b4kW36/7zO8U8akOpgoD4H2C4uOLvO0YdudoiwX
        oHR8VGdpFFBxBx0szPF33TZ0qgy5Uf4RZUXGAEdty8ldfy5EirXp7/w/kTwXAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606991745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rna0B90N/h2bYrP3o3itAIfub8/ycWxk6K5Qbfw2CTg=;
        b=Aiw3U4JeBR8mGRjJ9sKPgDckYP0IRV5z/y4zQDgM1yaLGBikhdEw8EUeaWvsnTxG7Gn931
        z/yQk/2c5+DDpIDg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: avoid -Wshadow warnings
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201026165044.3722931-1-arnd@kernel.org>
References: <20201026165044.3722931-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <160699174492.3364.14811197115462423469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a07c45312f06e288417049208c344ad76074627d
Gitweb:        https://git.kernel.org/tip/a07c45312f06e288417049208c344ad76074627d
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 26 Oct 2020 17:50:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 11:20:50 +01:00

seqlock: avoid -Wshadow warnings

When building with W=2, there is a flood of warnings about the seqlock
macros shadowing local variables:

  19806 linux/seqlock.h:331:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]
     48 linux/seqlock.h:348:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]
      8 linux/seqlock.h:379:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]

Prefix the local variables to make the warning useful elsewhere again.

Fixes: 52ac39e5db51 ("seqlock: seqcount_t: Implement all read APIs as statement expressions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201026165044.3722931-1-arnd@kernel.org
---
 include/linux/seqlock.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index cbfc78b..8d85524 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -328,13 +328,13 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define __read_seqcount_begin(s)					\
 ({									\
-	unsigned seq;							\
+	unsigned __seq;							\
 									\
-	while ((seq = __seqcount_sequence(s)) & 1)			\
+	while ((__seq = __seqcount_sequence(s)) & 1)			\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
@@ -345,10 +345,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount_begin(s)					\
 ({									\
-	unsigned seq = __read_seqcount_begin(s);			\
+	unsigned _seq = __read_seqcount_begin(s);			\
 									\
 	smp_rmb();							\
-	seq;								\
+	_seq;								\
 })
 
 /**
@@ -376,11 +376,11 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned seq = __seqcount_sequence(s);				\
+	unsigned __seq = __seqcount_sequence(s);			\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
