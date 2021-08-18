Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8193EFE65
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhHRH7T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbhHRH7S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1746C0613D9;
        Wed, 18 Aug 2021 00:58:44 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tL7ilnMcafR2TdlMARRRZ25N+SuHBzsOaOUoCz8gR+w=;
        b=Jo8olBoJbM2s32anIHcSj+0wXaOBfrzqBwS6Gv2XXbcHivPvSsnhMXvFljnMsr9OXeD945
        NYUO44r5ogr7Fr7RKNaDuXzviXqV3BCSGWOUpCZfgFqE9B3bU1OHJqPQAetsuEGZlOVRWq
        KCHpa+VIQJ6iCher+9Dvw8QaneEVLxLkyTs5Jfccjh54vKJ4fHQ1zElX9yOf/OnFK5V1yG
        oe2Qrnfp1Syh3zE3K+hfe/BXU2XlpnC2YuaFZMkXrw5DnB7FYUwskOZTjg2Vxhwypei5E4
        sr4IBtnsdq9hwrWR8cp87NEpvskVDETdMvwecpKDNVMa0F57wOfboUEv8FmhXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tL7ilnMcafR2TdlMARRRZ25N+SuHBzsOaOUoCz8gR+w=;
        b=z6HYF8ct4WyNkKe25fZSPFfsa6Dn821O8yDDZPOrdNFWk2X8QUAhFIrnMG8lDbg8nr256T
        VM2iKAGp4W2v3KDg==
From:   "tip-bot2 for Manfred Spraul" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] tools/memory-model: Heuristics using data_race()
 must handle all values
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352050.25758.2288409516337030768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     f92975d76d537c06a2118f9c3c63432c0f7c7a88
Gitweb:        https://git.kernel.org/tip/f92975d76d537c06a2118f9c3c63432c0f7c7a88
Author:        Manfred Spraul <manfred@colorfullife.com>
AuthorDate:    Fri, 14 May 2021 11:40:06 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 27 Jul 2021 11:48:55 -07:00

tools/memory-model: Heuristics using data_race() must handle all values

Data loaded for use by some sorts of heuristics can tolerate the
occasional erroneous value.  In this case the loads may use data_race()
to give the compiler full freedom to optimize while also informing KCSAN
of the intent.  However, for this to work, the heuristic needs to be
able to tolerate any erroneous value that could possibly arise.  This
commit therefore adds a paragraph spelling this out.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/access-marking.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index d96fe20..82a4899 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -126,6 +126,11 @@ consistent errors, which in turn are quite capable of breaking heuristics.
 Therefore use of data_race() should be limited to cases where some other
 code (such as a barrier() call) will force the occasional reload.
 
+Note that this use case requires that the heuristic be able to handle
+any possible error.  In contrast, if the heuristics might be fatally
+confused by one or more of the possible erroneous values, use READ_ONCE()
+instead of data_race().
+
 In theory, plain C-language loads can also be used for this use case.
 However, in practice this will have the disadvantage of causing KCSAN
 to generate false positives because KCSAN will have no way of knowing
