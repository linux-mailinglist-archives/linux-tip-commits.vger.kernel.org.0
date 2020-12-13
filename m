Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0542D8F99
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbgLMTC1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbgLMTCI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:08 -0500
Date:   Sun, 13 Dec 2020 19:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=epf4G9Jddgjk4g/OHT12CzuI4BSAyetrKZbF4kSUPTI=;
        b=rNQagyZQayIQFms3wlC+uKGKdd75OwC06c7QAY5EVm6xf4z5fetvYaoqQedHmAm+wVP4FP
        qlIt8GFt3igGFxbXk95uEsPXu6gdz6eAqpR4hxUFXt+jkEvEEi1H8kCUu4qa6YbXVVtMjD
        mamOZqTS8ekGu9dl600DGCCQ0jUj6CqD7TebGNgiAq6SCTvyQ3g4Z2sjsbXRXBHgurTVJ3
        1/Rghk9oM5tbU3IE3YVJNqApgVQUxmtOkRJJQOeORfdikJozT9UqakrUBc2G7ABqoSQLuJ
        jJXyhiu70mver0WLVwIHoMI5GYmQse0ZL8/6+bYjVQg6pPNJ3uD3d7iuauYAtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=epf4G9Jddgjk4g/OHT12CzuI4BSAyetrKZbF4kSUPTI=;
        b=VnImJz23FEXzJJcaZ9Ui+m+Bl+RlhCdiEDXBEO+Qm2WCWVl8qc/LIQU2bIWwXn6V0+wfRE
        R9+c7074+wooXjDQ==
From:   "tip-bot2 for Jakub Kicinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] net: Un-hide lockdep_sock_is_held() for !LOCKDEP
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607432.3364.11267550120884748530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d97f3bdf7a1c0346d3a272aa756d16633f0b8b3b
Gitweb:        https://git.kernel.org/tip/d97f3bdf7a1c0346d3a272aa756d16633f0b8b3b
Author:        Jakub Kicinski <kuba@kernel.org>
AuthorDate:    Wed, 16 Sep 2020 11:45:24 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:09:59 -08:00

net: Un-hide lockdep_sock_is_held() for !LOCKDEP

Currently, variables used only within lockdep expressions are flagged
as unused, requiring that these variables' declarations be decorated
with either #ifdef or __maybe_unused.  This results in ugly code.
This commit therefore causes the lockdep_sock_is_held() function to be
visible even when lockdep is not enabled, thus removing the need for
these decorations.  This approach further relies on dead-code elimination
to remove any references to functions or variables that are not available
in non-lockdep kernels.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/net/sock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a5c6ae7..198d548 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1566,13 +1566,11 @@ do {									\
 	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 } while (0)
 
-#ifdef CONFIG_LOCKDEP
 static inline bool lockdep_sock_is_held(const struct sock *sk)
 {
 	return lockdep_is_held(&sk->sk_lock) ||
 	       lockdep_is_held(&sk->sk_lock.slock);
 }
-#endif
 
 void lock_sock_nested(struct sock *sk, int subclass);
 
