Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076EC234332
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgGaJWq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:22:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbgGaJWp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:45 -0400
Date:   Fri, 31 Jul 2020 09:22:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cFvb2E1m9hyFpHcx4Th5l18ErPw+dtKZaurVKoaHL4I=;
        b=wd8rwp8Q6sr6z79TekwG9eo9N0w+YWUu52P+1WCmZ2jhR2Ireh2k6hBkqTEGTCPBRNVNCp
        i5seNKiwcsVoWvYd0FzzrI69HHGyAvKliBM3jqtbNd6E6+ncwRGeMuMMGCb6AEloPWMYsY
        Uc5j/tLtTvCC+KNJl+MMkJIUZU7V0m0+JfYplCYsaymIRsVYfSzzVTZ4tL4wthWh0ii/ye
        H2wyxD46DMe6fbBcfdLZQljYTuVANxqyTSIxcHkKKCksK4hgpQrFqWbVPyJ6dB2lCLEkx0
        UWWsAoMvSlIFC9TtXX82aeofBz0z8UFaKOetfhrCqhhPmdcJ7R+JhX1zkPGQvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cFvb2E1m9hyFpHcx4Th5l18ErPw+dtKZaurVKoaHL4I=;
        b=Tc1SDubZTVIVvyM1bK10FJ6tesGarfoFsIHVeSoXn5fsJPYODtcYWRKiVhwZZBJ74NNO0H
        T8mfMb8bimpzUKBw==
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/rcutorture: Replace 0 with false
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736339.4006.7962884624104179721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8f43d5911b38f00dfa46169dcb1feb1e101dd906
Gitweb:        https://git.kernel.org/tip/8f43d5911b38f00dfa46169dcb1feb1e101dd906
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Mon, 01 Jun 2020 19:45:48 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

rcu/rcutorture: Replace 0 with false

Coccinelle reports a warning

WARNING: Assignment of 0/1 to bool variable

The root cause is that the variable lastphase is a bool, but is
initialised with integer 0.  This commit therefore replaces the 0 with
a false.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5911207..37455a1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2185,7 +2185,7 @@ static void rcu_torture_barrier1cb(void *rcu_void)
 static int rcu_torture_barrier_cbs(void *arg)
 {
 	long myid = (long)arg;
-	bool lastphase = 0;
+	bool lastphase = false;
 	bool newphase;
 	struct rcu_head rcu;
 
